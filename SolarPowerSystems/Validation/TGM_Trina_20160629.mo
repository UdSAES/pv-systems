within SolarPowerSystems.Validation;
model TGM_Trina_20160629
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.None_Danny None_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    useTemperatureInput=false,
    useAlbedoInput=false,
    useWindSpeedInput=false,
    constTemperature(displayUnit="K") = 287.7,
    epochOffset=epochOffset.k)                 annotation (Placement(transformation(extent={{-10,24},{10,44}})));
  Modelica.Blocks.Sources.CombiTimeTable inputData(
    tableOnFile=true,
    tableName="trina",
    columns=2:10,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/TGM_Trina_20160629.txt"))
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Records.Data.Location_TGMVienna                   location "TGM Vienna"
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  SolarPowerSystems.Records.Data.PVplant_TGM_Trina plantRecord "TGM Trina"
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Math.Add absoluteErrorPowerDC(k1=-1) annotation (Placement(transformation(extent={{30,26},{50,46}})));
  Components.SolarPowerPlants.None_PhotoVoltaicsLib None_PhotoVoltaicsLib(
    useTemperatureInput=false,
    useAlbedoInput=false,
    useWindSpeedInput=false,
    constTemperature(displayUnit="K") = 287.7,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    epochOffset=epochOffset.k)
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1466899200)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
equation
  connect(inputData.y[1], None_Danny.directHorizontalIrradiance)
    annotation (Line(points={{-69,40},{-10,40}}, color={0,0,127}));
  connect(None_Danny.powerDC, absoluteErrorPowerDC.u1)
    annotation (Line(points={{10,42},{28,42}},                 color={0,0,127}));
  connect(inputData.y[5], absoluteErrorPowerDC.u2)
    annotation (Line(points={{-69,40},{-60,40},{-60,20},{20,20},{20,30},{28,30}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69,0},{-56,0},{-56,36},{-10,36}}, color={0,0,127}));
  connect(inputData.y[1], None_PhotoVoltaicsLib.directHorizontalIrradiance)
    annotation (Line(points={{-69,40},{-60,40},{-60,-34},{-10,-34}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance.y, None_PhotoVoltaicsLib.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69,0},{-56,0},{-56,-38},{-10,-38}}, color={0,0,127}));
  connect(inputData.y[5], totalEnergyMeasuredDC.u)
    annotation (Line(points={{-69,40},{-60,40},{-60,-80},{-12,-80}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=60),Diagram(graphics={Text(
          extent={{-76,46},{-24,44}},
          lineColor={28,108,200},
          textString="TGM_Trina_20160629.txt")}),
    __Dymola_Commands(file="Scripts/plotOverview_TGM_Trina_20160629.mos" "plotOverview_TGM_Trina_20160629"));
end TGM_Trina_20160629;
