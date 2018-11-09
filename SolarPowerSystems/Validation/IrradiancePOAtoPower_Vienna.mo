within SolarPowerSystems.Validation;
model IrradiancePOAtoPower_Vienna
  "Comparison area-based vs. diode-eq.-based model using data from Trina-plant on the roof of TGM in Vienna/Austria"
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.None_Danny None_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    epochOffset=startTime.k,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    useTemperatureInput=false,
    useWindSpeedInput=false,
    constTemperature(displayUnit="degC"))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Records.Data.Location_TGMVienna                   location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_TGM_Trina                   plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1467158400) "2016-06-29"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataTGM     measurementDataTGM
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-88,34},{-70,52}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  Components.SolarPowerPlants.None_PhotoVoltaicsLib None_PhotoVoltaicsLib(
    epochOffset=startTime.k,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    albedo=plantRecord.environmentAlbedo,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    nsModule=plantRecord.nsModule,
    npModule=plantRecord.npModule,
    redeclare PhotoVoltaics.Records.TSM_230_PC05 moduleData,
    useTemperatureInput=true)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

  Utilities.ErrorMetrics errorMetricsAreaBased(
    f=1/(5*60),
    x0=0,
    residual(y(unit="W", displayUnit="kW")))
    "Error metrics for area-based plant model"
    annotation (Placement(transformation(extent={{48,10},{68,30}})));
  Utilities.ErrorMetrics errorMetricsDiodeBased(
    f=1/(5*60),
    x0=0,
    residual(y(unit="W", displayUnit="kW")))
    "Error metrics for plant model implementing diode equation"
    annotation (Placement(transformation(extent={{48,-10},{68,-30}})));
equation
  connect(diffuseHorizontalIrradiance.y, None_Danny.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69.1,43},{-10,43}}, color={0,0,127}));
  connect(measurementDataTGM.validationData, validationData)
    annotation (Line(
      points={{-68,0},{-50,0}},
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
  connect(validationData.powerDC, totalEnergyMeasuredDC.u)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,0},{-7.2,0}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.T1, None_PhotoVoltaicsLib.temperature) annotation (Line(
      points={{-50,0},{-50,-48},{-10,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(None_Danny.powerDC, errorMetricsAreaBased.simulatedValue) annotation (
     Line(points={{10,48},{30,48},{30,26},{48,26}}, color={0,0,127}));
  connect(None_PhotoVoltaicsLib.powerDC, errorMetricsDiodeBased.simulatedValue)
    annotation (Line(points={{10,-32},{30,-32},{30,-26},{48,-26}}, color={0,0,127}));
  connect(validationData.powerDC, errorMetricsDiodeBased.measuredValue)
    annotation (Line(
      points={{-49.97,0.03},{-50,0.03},{-50,-14},{48,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(validationData.powerDC, errorMetricsAreaBased.measuredValue)
    annotation (Line(
      points={{-49.97,0.03},{-49.97,14},{48,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(
      StartTime=18000,
      StopTime=75600,
      Interval=60.00012), __Dymola_Commands(file="Scripts/plot_Validation_IrradiancePOAtoPower.mos" "plotResult", file=
          "Scripts/plot_Validation_IrradiancePOAtoPower_Vienna.mos" "plotResultsVienna"));
end IrradiancePOAtoPower_Vienna;
