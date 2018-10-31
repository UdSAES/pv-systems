within SolarPowerSystems.Validation;
model HorizontalToInclined
  "Model for testing the transformation of irradiance on a horizontal plane to an arbitrarily oriented one"
  extends Modelica.Icons.Example;
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-88,-32},{-24,32}})));
  WIP.IsotropicFromNormal isotropicFromNormal(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,-10})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k) annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Records.Data.Location_Ashland location annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-90,46},{-70,66}})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropicFromNormal(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{66,-18},{82,-2}})));
  Components.PlantInEnvironment.Isotropic isotropic(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={48,-40})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropic(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{66,-48},{82,-32}})));
  Components.PlantInEnvironment.Perez perez(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(extent={{-18,-84},{2,-64}})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAPerez(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{12,-98},{22,-88}})));
  Modelica.Blocks.Sources.Constant c1(k=Modelica.SIunits.Conversions.from_deg(15))
    annotation (Placement(transformation(extent={{-92,-58},{-72,-38}})));
  Modelica.Blocks.Sources.Constant c2(k=Modelica.SIunits.Conversions.from_deg(0))
    annotation (Placement(transformation(extent={{-92,-90},{-72,-70}})));

  Real errorGlobalIrradiancePOAIsotropic "Measured irradiance in POA compared to calculated one, positive if prediction is larger";
  Real errorGlobalIrradiancePOAIsotropicFromNormal "Measured irradiance in POA compared to calculated one based on DNI";
  Real errorGlobalIrradiancePOAPerez "Measured irradiance in POA compared to calculated one, positive if prediction is larger";
equation
  errorGlobalIrradiancePOAIsotropic =globalIrradiancePOAIsotropic.y - measurementDataAshland.globalIrradiancePOA;
  errorGlobalIrradiancePOAIsotropicFromNormal =globalIrradiancePOAIsotropicFromNormal.y - measurementDataAshland.globalIrradiancePOA;
  errorGlobalIrradiancePOAPerez =globalIrradiancePOAPerez.y - measurementDataAshland.globalIrradiancePOA;

  connect(measurementDataAshland.directHorizontalIrradiance, isotropicFromNormal.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{-2,19.2},{-2,-4},{38,-4}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropicFromNormal.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,-10},{38,-10}},
                                                                    color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, isotropicFromNormal.directNormalIrradiance)
    annotation (Line(points={{-24,6.4},{-24,6},{44,6},{44,0}},              color={0,0,127}));
  connect(solarAzimuth.y, isotropicFromNormal.solarAzimuth)
    annotation (Line(points={{-39,78.2},{54,78.2},{54,0}}, color={0,0,127}));
  connect(solarZenith.y, isotropicFromNormal.solarZenith)
    annotation (Line(points={{-39,56.2},{50,56.2},{50,0}}, color={0,0,127}));
  connect(isotropicFromNormal.directInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u1)
    annotation (Line(points={{58,-4},{64,-4},{64,-3.6},{64.4,-3.6}}, color={0,0,127}));
  connect(isotropicFromNormal.reflectedInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u3)
    annotation (Line(points={{58,-16},{64,-16},{64,-16.4},{64.4,-16.4}},
                                                                 color={0,0,127}));
  connect(isotropicFromNormal.diffuseInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u2)
    annotation (Line(points={{58,-10},{64.4,-10}},
                                                 color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, isotropic.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{-2,19.2},{-2,-46},{38,-46}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropic.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,-40},{38,-40}},                 color={0,0,127}));
  connect(isotropic.reflectedInclinedIrradiance, globalIrradiancePOAIsotropic.u1)
    annotation (Line(points={{58,-34},{66,-34},{66,-33.6},{64.4,-33.6}}, color={0,0,127}));
  connect(isotropic.diffuseInclinedIrradiance, globalIrradiancePOAIsotropic.u2)
    annotation (Line(points={{58,-40},{64.4,-40}}, color={0,0,127}));
  connect(isotropic.directInclinedIrradiance, globalIrradiancePOAIsotropic.u3)
    annotation (Line(points={{58,-46},{64,-46},{64,-46.4},{64.4,-46.4}}, color={0,0,127}));
  connect(solarZenith.y, isotropic.solarZenith)
    annotation (Line(points={{-39,56.2},{94,56.2},{94,-76},{50,-76},{50,-50}},           color={0,0,127}));
  connect(solarAzimuth.y, isotropic.solarAzimuth)
    annotation (Line(points={{-39,78.2},{96,78.2},{96,-80},{54,-80},{54,-50}},  color={0,0,127}));
  connect(perez.solarAzimuth, isotropic.solarAzimuth)
    annotation (Line(points={{2,-80},{54,-80},{54,-50}},                   color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, perez.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{-2,19.2},{-2,-64}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, perez.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,-64}}, color={0,0,127}));
  connect(perez.directInclinedIrradiance,globalIrradiancePOAPerez. u1)
    annotation (Line(points={{-2,-84},{-2,-88},{11,-88},{11,-89}}, color={0,0,127}));
  connect(perez.diffuseInclinedIrradiance,globalIrradiancePOAPerez. u2)
    annotation (Line(points={{-8,-84},{-8,-93},{11,-93}}, color={0,0,127}));
  connect(perez.reflectedInclinedIrradiance,globalIrradiancePOAPerez. u3)
    annotation (Line(points={{-14,-84},{-14,-97},{11,-97}}, color={0,0,127}));
  connect(solarZenith.y, perez.solarZenith)
    annotation (Line(points={{-39,56.2},{94,56.2},{94,-76},{2,-76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=18000, StopTime=75600),
    __Dymola_Commands(file="Scripts/plot_Validation_HorizontalToInclined.mos" "plotResult"));
end HorizontalToInclined;
