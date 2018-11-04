within SolarPowerSystems.Validation;
model QAresidual
  "Calculate the QA residual as an indication of how reliable the measured irradiance values are"
  extends Modelica.Icons.Example;
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
  Records.Data.Location_Ashland location annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-90,46},{-70,66}})));

  Real QAresidual "Solar QA residual indicating whether the measured values of DNI, GHI and DHI are consistent";
  Real globalHorizontalIrradianceFromDNIandDHI "GHI calculated from DHI, DNI, and solarZenith";

equation
  QAresidual = measurementDataAshland.validationData.diffuseHorizontalIrradiance
    + measurementDataAshland.validationData.directNormalIrradiance*cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y))
    - measurementDataAshland.validationData.globalHorizontalIrradiance;
  globalHorizontalIrradianceFromDNIandDHI = measurementDataAshland.validationData.diffuseHorizontalIrradiance
    + measurementDataAshland.validationData.directNormalIrradiance*cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y));
  annotation (experiment(
      StartTime=18000,
      StopTime=75600,
      __Dymola_NumberOfIntervals=5000), __Dymola_Commands(file="Scripts/plot_Validation_QAresidual.mos" "plotResult"));
end QAresidual;
