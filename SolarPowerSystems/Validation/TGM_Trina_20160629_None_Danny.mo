within SolarPowerSystems.Validation;
model TGM_Trina_20160629_None_Danny
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.None_Danny None_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    epochOffset=1466899200,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    useTemperatureInput=false,
    useAlbedoInput=false,
    useWindSpeedInput=false,
    constTemperature(displayUnit="K") = 287.7) annotation (Placement(transformation(extent={{-10,24},{10,44}})));
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
  Modelica.Blocks.Math.Variance variance annotation (Placement(transformation(extent={{70,30},{90,50}})));
  Modelica.Blocks.Math.StandardDeviation standardDeviation
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Blocks.Math.Add absoluteErrorPowerDC(k1=-1) annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
equation
  connect(inputData.y[1], None_Danny.directHorizontalIrradiance)
    annotation (Line(points={{-69,40},{-10,40}}, color={0,0,127}));
  connect(None_Danny.powerDC, absoluteErrorPowerDC.u1)
    annotation (Line(points={{10,42},{18,42},{18,46},{28,46}}, color={0,0,127}));
  connect(inputData.y[5], absoluteErrorPowerDC.u2)
    annotation (Line(points={{-69,40},{-60,40},{-60,20},{20,20},{20,34},{28,34}}, color={0,0,127}));
  connect(absoluteErrorPowerDC.y, variance.u) annotation (Line(points={{51,40},{68,40}}, color={0,0,127}));
  connect(absoluteErrorPowerDC.y, standardDeviation.u)
    annotation (Line(points={{51,40},{60,40},{60,10},{68,10}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69,0},{-56,0},{-56,36},{-10,36}}, color={0,0,127}));
  connect(inputData.y[5], totalEnergyMeasuredDC.u)
    annotation (Line(points={{-69,40},{-60,40},{-60,-80},{-12,-80}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=1), Diagram(graphics={Text(
          extent={{-76,46},{-24,44}},
          lineColor={28,108,200},
          textString="TGM_Trina_20160629.txt")}),
    __Dymola_Commands(file="Scripts/plotOverview_TGM_Trina_20160629.mos" "plotOverview_TGM_Trina_20160629"));
end TGM_Trina_20160629_None_Danny;
