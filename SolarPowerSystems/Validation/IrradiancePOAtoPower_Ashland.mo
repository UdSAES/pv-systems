within SolarPowerSystems.Validation;
model IrradiancePOAtoPower_Ashland
  "Comparison area-based vs. diode-eq.-based model using data from 15kW-plant in Ashland, OR"
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
  Records.Data.Location_Ashland                     location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{14,-72},{26,-60}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-88,34},{-70,52}})));
//   Utilities.errorMetrics errorMetricsEnergy(f=1/(60*5))
//     annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
//   Utilities.errorMetrics errorMetricsPower(f=1/(60*5))
//     annotation (Placement(transformation(extent={{50,-16},{70,-36}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  Components.SolarPowerPlants.None_PhotoVoltaicsLib None_PhotoVoltaicsLib(
    epochOffset=epochOffset.k,
    useTemperatureInput=true,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    albedo=plantRecord.environmentAlbedo,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    redeclare Records.Data.Module_ASE300DGF50_270W moduleData,
    nsModule=plantRecord.nsModule,
    npModule=plantRecord.npModule)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69.1,43},{-10,43}}, color={0,0,127}));
//   connect(totalEnergyMeasuredDC.y, errorMetricsEnergy.measuredValue)
//     annotation (Line(points={{26.6,-66},{50,-66}},                 color={0,0,127}));
  connect(measurementDataAshland.validationData, validationData)
    annotation (Line(
      points={{-68,0},{-50,0}},
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
  connect(validationData.globalIrradiancePOA, None_Danny.directHorizontalIrradiance)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,48},{-10,48}},
      color={255,204,51},
      thickness=0.5));
  connect(diffuseHorizontalIrradiance.y, None_PhotoVoltaicsLib.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69.1,43},{-60,43},{-60,-37},{-10,-37}}, color={0,0,127}));
  connect(validationData.globalIrradiancePOA, None_PhotoVoltaicsLib.directHorizontalIrradiance)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-32},{-10,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.ambientTemperature, None_PhotoVoltaicsLib.temperature) annotation (Line(
      points={{-49.97,0.03},{-50,0.03},{-50,-48},{-10,-48}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.powerDC, totalEnergyMeasuredDC.u)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,-66},{12.8,-66}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=60.00012), __Dymola_Commands(file="Scripts/plot_Validation_IrradiancePOAtoPower.mos" "plotResult"));
end IrradiancePOAtoPower_Ashland;
