within SolarPowerSystems.Validation;
model UO_SRML_Ashland2_201810_Danny
  "A 15kW-peak PV array installed in Ashland, OR; data provided by UO, SRML; comparison of area-based models w/wo environment model"
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.None_Danny None_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    constTemperature(displayUnit="K") = 287.7,
    epochOffset=epochOffset.k,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo)      annotation (Placement(transformation(extent={{-10,24},{10,44}})));
  Records.Data.Location_Ashland                     location "TGM Vienna"
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord "TGM Trina"
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Math.Add absoluteErrorPowerDC(k1=-1) annotation (Placement(transformation(extent={{30,26},{50,46}})));
  Components.SolarPowerPlants.Perez_Danny Perez_Danny(
    constTemperature(displayUnit="K") = 287.7,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    epochOffset=epochOffset.k,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    panelArea=plantRecord.panelArea,
    plantEfficiency=0.92*plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo)
                   annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-94,-22},{-48,24}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-70,30},{-58,42}})));
equation
  connect(None_Danny.powerDC, absoluteErrorPowerDC.u1)
    annotation (Line(points={{10,42},{28,42}},                 color={0,0,127}));
  connect(measurementDataAshland.globalIrradiancePOA, None_Danny.directHorizontalIrradiance)
    annotation (Line(points={{-48,1},{-42,1},{-42,2},{-22,2},{-22,42},{-10,42}}, color={0,0,127}));
  connect(measurementDataAshland.powerDCsystem2, totalEnergyMeasuredDC.u)
    annotation (Line(points={{-48,-8.2},{-44,-8.2},{-44,-8},{-40,-8},{-40,-80},{-12,-80}}, color={0,0,127}));
  connect(measurementDataAshland.powerDCsystem2, absoluteErrorPowerDC.u2)
    annotation (Line(points={{-48,-8.2},{-44,-8.2},{-44,-8},{20,-8},{20,30},{28,30}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-57.4,36},{-34,36},{-34,37},{-10,37}},
                                                   color={0,0,127}));
  connect(measurementDataAshland.ambientTemperature, None_Danny.temperature)
    annotation (Line(points={{-48,-17.4},{-40,-17.4},{-40,-18},{-28,-18},{-28,26},{-10,26}}, color={0,0,127}));
  connect(measurementDataAshland.windSpeed, None_Danny.windSpeed)
    annotation (Line(points={{-48,-12.8},{-40,-12.8},{-40,-12},{-30,-12},{-30,31},{-10,31}}, color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, Perez_Danny.directHorizontalIrradiance)
    annotation (Line(points={{-48,14.8},{-42,14.8},{-42,16},{-32,16},{-32,-32},{-8,-32}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, Perez_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-48,10.2},{-42,10.2},{-42,10},{-34,10},{-34,-37},{-8,-37}}, color={0,0,127}));
  connect(measurementDataAshland.windSpeed, Perez_Danny.windSpeed)
    annotation (Line(points={{-48,-12.8},{-40,-12.8},{-40,-12},{-30,-12},{-30,-43},{-8,-43}}, color={0,0,127}));
  connect(measurementDataAshland.ambientTemperature, Perez_Danny.temperature)
    annotation (Line(points={{-48,-17.4},{-36,-17.4},{-36,-48},{-8,-48}}, color={0,0,127}));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=60.00012), __Dymola_Commands(file="Scripts/plot_Validation_UO_SRML_Ashland2_201810_Danny.mos" "plotResult"));
end UO_SRML_Ashland2_201810_Danny;
