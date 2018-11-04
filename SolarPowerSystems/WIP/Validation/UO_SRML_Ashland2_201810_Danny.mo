within SolarPowerSystems.WIP.Validation;
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
    albedo=plantRecord.environmentAlbedo)      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Records.Data.Location_Ashland                     location "TGM Vienna"
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord(plantEfficiency=0.65*280/(1000*plantRecord.panelArea/64))
                                                               "TGM Trina"
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
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
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    plantEfficiency=plantRecord.plantEfficiency)
                   annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{14,-72},{26,-60}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-88,34},{-70,52}})));
  Utilities.errorMetrics errorMetricsEnergy(f=1/(60*5))
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Utilities.errorMetrics errorMetricsPower(f=1/(60*5))
    annotation (Placement(transformation(extent={{50,-16},{70,-36}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
equation
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69.1,43},{-10,43}}, color={0,0,127}));
  connect(totalEnergyMeasuredDC.y, errorMetricsEnergy.measuredValue)
    annotation (Line(points={{26.6,-66},{50,-66}},                 color={0,0,127}));
  connect(Perez_Danny.totalEnergyDC, errorMetricsEnergy.simulatedValue)
    annotation (Line(points={{12,-36},{34,-36},{34,-54},{50,-54}}, color={0,0,127}));
  connect(Perez_Danny.powerDC, errorMetricsPower.simulatedValue)
    annotation (Line(points={{12,-32},{50,-32}},                   color={0,0,127}));
  connect(measurementDataAshland.validationData, validationData)
    annotation (Line(
      points={{-68,0},{-50,0}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directHorizontalIrradiance, Perez_Danny.directHorizontalIrradiance)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-32},{-8,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.diffuseHorizontalIrradiance, Perez_Danny.diffuseHorizontalIrradiance)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-37},{-8,-37}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.windSpeed, Perez_Danny.windSpeed)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-43},{-8,-43}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.ambientTemperature, Perez_Danny.temperature)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-48},{-8,-48}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.windSpeed, None_Danny.windSpeed)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,37},{-10,37}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.ambientTemperature, None_Danny.temperature)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,32},{-10,32}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.powerDCsystem2, totalEnergyMeasuredDC.u)
    annotation (Line(
      points={{-50,0},{-50,-66},{12.8,-66}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.powerDCsystem2, errorMetricsPower.measuredValue)
    annotation (Line(
      points={{-50,0},{-50,-20},{50,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.globalIrradiancePOA, None_Danny.directHorizontalIrradiance)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,48},{-10,48}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=60.00012), __Dymola_Commands(file="Scripts/plot_Validation_UO_SRML_Ashland2_201810_Danny.mos" "plotResult"));
end UO_SRML_Ashland2_201810_Danny;
