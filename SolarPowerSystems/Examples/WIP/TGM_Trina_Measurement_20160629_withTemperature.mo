within SolarPowerSystems.Examples.WIP;
model TGM_Trina_Measurement_20160629_withTemperature
  "Measured irradiance model on 2016-06-29; Trina modules at TGM building in Vienna, Austria"
  extends Modelica.Icons.Example;
  parameter Integer nsModule = 8 "Number of series connected modules";
  parameter Integer npModule = 1 "Number of parallel connected modules";
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://PhotoVoltaics/Resources/WeatherData/TGM_Trina_20160629.txt") "File name";
  parameter String csvFileName = Modelica.Utilities.Files.loadResource("modelica://PhotoVoltaics/TGM_Trina_Measurement_20160629_power.csv");
  Modelica.SIunits.Irradiance irradiance=inputData.y[1] "Measured irradiance";
  Modelica.SIunits.Power powerAC=inputData.y[2] "Measured AC power";
  Modelica.SIunits.Voltage VAC=inputData.y[3] "Measured AC voltage";
  Modelica.SIunits.Current IAC=inputData.y[4] "Measured AC current";
  Modelica.SIunits.Power powerDC=inputData.y[5] "Measured DC power";
  Modelica.SIunits.Voltage VDC=inputData.y[6] "Measured DC voltage";
  Modelica.SIunits.Current IDC=inputData.y[7] "Measured DC current";
  Modelica.SIunits.Temperature T1=inputData.y[8] "Temperature of ambient";
  Modelica.SIunits.Temperature T2=inputData.y[9] "Temperature of PV modules";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin={-32,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
    Placement(transformation(extent={{20,60},{40,80}})));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(
    samplePeriod=10,
    VmpRef=nsModule*plantModelModuleBased.moduleData.VmpRef,
    ImpRef=npModule*plantModelModuleBased.moduleData.ImpRef)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundAC annotation (
    Placement(transformation(extent={{70,30},{90,50}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(f = 50, V = 230, phi = 0,
    gamma(start=0, fixed=true))                                                                                 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={80,70})));
  Modelica.Blocks.Sources.CombiTimeTable inputData(
    tableOnFile=true,
    tableName="trina",
    fileName=fileName,
    columns=2:10)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Components.SolarPowerPlant.ModuleBased.ModuleBased plantModelModuleBased(
    nsModule=nsModule,
    npModule=npModule,
    redeclare PhotoVoltaics.Records.TSM_230_PC05 moduleData,
    useHeatPort=true)                                        annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,70})));
  Components.SolarPowerPlant.AreaBased.AreaBased plantModelAreaBased(
      overall_efficiency=0.141, panel_area=1.650*0.992*8,
    useHeatPort=false)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-60})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,40})));
equation
  connect(mpTracker.vRef, converter.vDCRef) annotation (
    Line(points={{21,30},{24,30},{24,58}},           color = {0, 0, 127}));
  connect(converter.ac_n, groundAC.pin) annotation (
    Line(points={{40,60},{40,50},{80,50}},           color = {85, 170, 255}));
  connect(groundAC.pin, voltageSource.pin_n) annotation (
    Line(points={{80,50},{80,60}},                   color = {85, 170, 255}));
  connect(converter.ac_p, voltageSource.pin_p) annotation (
    Line(points={{40,80},{40,90},{80,90},{80,80}},                 color = {85, 170, 255}));
  connect(ground.p, converter.dc_n) annotation (
    Line(points={{-32,50},{20,50},{20,60}},           color = {0, 0, 255}));
  connect(inputData.y[1], plantModelModuleBased.I_G_normal) annotation (Line(
        points={{-69,0},{-60,0},{-60,70},{-42,70}}, color={0,0,127}));
  connect(plantModelModuleBased.n1, ground.p)
    annotation (Line(points={{-32,60},{-32,50}}, color={0,0,255}));
  connect(plantModelModuleBased.p1, converter.dc_p) annotation (Line(points={{-32,80},
          {-32,90},{20,90},{20,80}},         color={0,0,255}));
  connect(plantModelModuleBased.nv1, converter.dc_n) annotation (Line(points={{-22,75},
          {-20,75},{-20,50},{20,50},{20,60}},         color={0,0,255}));
  connect(plantModelModuleBased.P_DC, mpTracker.power) annotation (Line(points={{-22,70},
          {-16,70},{-16,30},{-2,30}},           color={0,0,127}));
  connect(inputData.y[1], plantModelAreaBased.I_G_normal) annotation (Line(
        points={{-69,0},{-60,0},{-60,-60},{-10,-60}}, color={0,0,127}));
  connect(inputData.y[8], prescribedTemperature.T) annotation (Line(points={{
          -69,0},{-66,0},{-66,20},{-80,20},{-80,28}}, color={0,0,127}));
  connect(prescribedTemperature.port, plantModelModuleBased.heatPort)
    annotation (Line(points={{-80,50},{-80,56},{-22,56},{-22,60}}, color={191,0,
          0}));
  connect(prescribedTemperature.port, plantModelAreaBased.heatPort) annotation
    (Line(points={{-80,50},{-80,56},{-22,56},{-22,-74},{10,-74},{10,-70}},
        color={191,0,0}));
  annotation (
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-08,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions = "<html>
</html>",
        info="<html>
<p>This example uses measured irradiance data to supply the photovoltaic modules.</p>
</html>"),
    __Dymola_Commands(file="Scripts/plotResults.mos" "plotResults"));
end TGM_Trina_Measurement_20160629_withTemperature;
