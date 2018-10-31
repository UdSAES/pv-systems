within SolarPowerSystems.WIP.Obsolete;
model HorizontalToInclinedDirect
  "Model for testing the transformation of direct irradiance on a horizontal plane to an arbitrarily oriented one"
  extends Modelica.Icons.Example;
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=startTime.k)
    annotation (Placement(transformation(extent={{-90,-32},{-26,32}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=startTime.k) annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=startTime.k) annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
  Records.Data.Location_Ashland location annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1540191600)
    annotation (Placement(transformation(extent={{-90,46},{-70,66}})));
  Modelica.Blocks.Sources.Constant c1(k=Modelica.SIunits.Conversions.from_deg(15)) "arrayTilt"
    annotation (Placement(transformation(extent={{-90,-58},{-70,-38}})));
  Modelica.Blocks.Sources.Constant c2(k=Modelica.SIunits.Conversions.from_deg(0)) "arrayAzimuth"
    annotation (Placement(transformation(extent={{-90,-88},{-70,-68}})));

  Components.PlantInEnvironment.PlaneOfArrayIrradiance.DirectFromHorizontal directFromHorizontal
    annotation (Placement(transformation(extent={{70,56},{90,76}})));
  Components.PlantInEnvironment.PlaneOfArrayIrradiance.DirectFromNormal directFromNormal
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Components.SolarPosition.AngleOfIncidence angleOfIncidence(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,60})));
  Modelica.SIunits.Angle sunrise = Modelica.SIunits.Conversions.from_deg(90) "Solar zenith angle at sunrise";
  Real QAresidual "Solar QA residual indicating whether the measured values of DNI, GHI and DHI are consistent";
//   Real QAresidualReindlEtAl_1 "Solar QA residual for estimation using Reindl et al decomposition model 1";

//   WIP.DirectNormalIrradianceEstimation.ReindlEtAl_1 reindlEtAl_1
//     annotation (Placement(transformation(extent={{-8,-66},{12,-46}})));
//   Modelica.Blocks.Sources.Constant extraterrestrialRadiation(k=1367, y(unit="W/m2"))
//     annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
equation
  QAresidual = measurementDataAshland.diffuseHorizontalIrradiance
    + measurementDataAshland.directNormalIrradiance*cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y))
    - measurementDataAshland.globalHorizontalIrradiance;
//   QAresidualReindlEtAl_1 = measurementDataAshland.diffuseHorizontalIrradiance
//     + reindlEtAl_1.directNormalIrradiance*cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y))
//     - measurementDataAshland.globalHorizontalIrradiance;

  connect(solarAzimuth.y, angleOfIncidence.solarAzimuth)
    annotation (Line(points={{-39,54.2},{-19.5,54.2},{-19.5,56},{-10,56}}, color={0,0,127}));
  connect(solarZenith.y, angleOfIncidence.solarZenith)
    annotation (Line(points={{-39,78.2},{-20.5,78.2},{-20.5,64},{-10,64}}, color={0,0,127}));
  connect(solarZenith.y, directFromHorizontal.solarZenith)
    annotation (Line(points={{-39,78.2},{40,78.2},{40,72},{70,72}}, color={0,0,127}));
  connect(angleOfIncidence.angleOfIncidence, directFromHorizontal.angleOfIncidence)
    annotation (Line(points={{10,60},{70,60}}, color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, directFromHorizontal.directHorizontalIrradiance)
    annotation (Line(points={{-26,19.2},{50,19.2},{50,66},{70,66}}, color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, directFromNormal.HDirNor)
    annotation (Line(points={{-26,6.4},{20,6.4},{20,6},{68,6}}, color={0,0,127}));
  connect(angleOfIncidence.angleOfIncidence, directFromNormal.incAng)
    annotation (Line(points={{10,60},{20,60},{20,-6},{68,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=18000, StopTime=75600),
    __Dymola_Commands(file="Scripts/plot_Validation_HorizontalToInclined.mos" "plotResult"));
end HorizontalToInclinedDirect;
