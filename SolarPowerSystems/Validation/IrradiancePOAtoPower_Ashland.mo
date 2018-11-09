within SolarPowerSystems.Validation;
model IrradiancePOAtoPower_Ashland
  "Comparison area-based vs. diode-eq.-based model using data from 15kW-plant in Ashland, OR"
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.None_Danny None_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    constTemperature(displayUnit="K") = 287.7,
    epochOffset=startTime.k,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    plantEfficiency=plantRecord.plantEfficiency)
                                          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Records.Data.Location_Ashland                     location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=972198000)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=startTime.k, fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/200010_ashland.txt"))
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-88,34},{-70,52}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  Components.SolarPowerPlants.None_PhotoVoltaicsLib None_PhotoVoltaicsLib(
    epochOffset=startTime.k,
    useTemperatureInput=true,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    albedo=plantRecord.environmentAlbedo,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    redeclare Records.Data.Module_ASE300DGF50_270W moduleData,
    nsModule=plantRecord.nsModule,
    npModule=plantRecord.npModule) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Utilities.ErrorMetrics errorMetricsAreaBased(
    f=1/(5*60),
    x0=0,
    residual(y(unit="W", displayUnit="kW"))) "Error metrics for area-based plant model"
    annotation (Placement(transformation(extent={{48,10},{68,30}})));
  Utilities.ErrorMetrics errorMetricsDiodeBased(
    f=1/(5*60),
    x0=0,
    residual(y(unit="W", displayUnit="kW"))) "Error metrics for plant model implementing diode equation"
    annotation (Placement(transformation(extent={{48,-10},{68,-30}})));
equation
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69.1,43},{-10,43}}, color={0,0,127}));
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
      points={{-49.97,0.03},{-49.97,0},{-7.2,0}},
      color={255,204,51},
      thickness=0.5));
  connect(None_Danny.powerDC, errorMetricsAreaBased.simulatedValue)
    annotation (Line(points={{10,48},{30,48},{30,26},{48,26}}, color={0,0,127}));
  connect(None_PhotoVoltaicsLib.powerDC, errorMetricsDiodeBased.simulatedValue)
    annotation (Line(points={{10,-32},{30,-32},{30,-26},{48,-26}}, color={0,0,127}));
  connect(validationData.powerDC, errorMetricsAreaBased.measuredValue) annotation (Line(
      points={{-49.97,0.03},{-49.97,14},{48,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(validationData.powerDC, errorMetricsDiodeBased.measuredValue) annotation (Line(
      points={{-49.97,0.03},{-49.97,-14},{48,-14},{48,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=60.00012), __Dymola_Commands(file="Scripts/plot_Validation_IrradiancePOAtoPower.mos" "plotResult"));
end IrradiancePOAtoPower_Ashland;