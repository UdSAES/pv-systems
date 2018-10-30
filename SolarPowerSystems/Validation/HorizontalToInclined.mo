within SolarPowerSystems.Validation;
model HorizontalToInclined
  "Model for testing the transformation of irradiance on a horizontal plane to an arbitrarily oriented one"
  extends Modelica.Icons.Example;
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-88,-32},{-24,32}})));
  WIP.Obsolete.IsotropicFromNormal isotropicFromNormal(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,12})));
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
  Modelica.Blocks.Sources.Constant fixedAlbedo(final k=0.2)
    annotation (Placement(transformation(extent={{60,-24},{52,-16}})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropicFromNormal(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{78,4},{94,20}})));
  Components.PlantInEnvironment.Isotropic isotropic(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,-60})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropic(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{80,-68},{96,-52}})));
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
  Real errorGlobalIrradiancePOAPerez "Measured irradiance in POA compared to calculated one, positive if prediction is larger";
equation
  errorGlobalIrradiancePOAIsotropic =globalIrradiancePOAIsotropic.y - measurementDataAshland.globalIrradiancePOA;
  errorGlobalIrradiancePOAPerez =globalIrradiancePOAPerez.y - measurementDataAshland.globalIrradiancePOA;

  connect(measurementDataAshland.directHorizontalIrradiance, isotropicFromNormal.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{10,19.2},{10,18},{50,18}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropicFromNormal.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{10,12.8},{10,12},{50,12}}, color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, isotropicFromNormal.directNormalIrradiance)
    annotation (Line(points={{-24,6.4},{-16,6.4},{-16,26},{56,26},{56,22}}, color={0,0,127}));
  connect(solarAzimuth.y, isotropicFromNormal.solarAzimuth)
    annotation (Line(points={{-39,78.2},{66,78.2},{66,22}},color={0,0,127}));
  connect(solarZenith.y, isotropicFromNormal.solarZenith)
    annotation (Line(points={{-39,56.2},{62,56.2},{62,22}},color={0,0,127}));
  connect(fixedAlbedo.y, isotropicFromNormal.albedo)
    annotation (Line(points={{51.6,-20},{40,-20},{40,6},{50,6}}, color={0,0,127}));
  connect(isotropicFromNormal.directInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u1)
    annotation (Line(points={{70,18},{76,18},{76,18.4},{76.4,18.4}}, color={0,0,127}));
  connect(isotropicFromNormal.reflectedInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u3)
    annotation (Line(points={{70,6},{76,6},{76,5.6},{76.4,5.6}}, color={0,0,127}));
  connect(isotropicFromNormal.diffuseInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u2)
    annotation (Line(points={{70,12},{76.4,12}}, color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, isotropic.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{12,19.2},{12,-66},{50,-66}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropic.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,12},{10,12},{10,-60},{50,-60}}, color={0,0,127}));
  connect(fixedAlbedo.y, isotropic.albedo)
    annotation (Line(points={{51.6,-20},{40,-20},{40,-54},{50,-54}}, color={0,0,127}));
  connect(isotropic.reflectedInclinedIrradiance, globalIrradiancePOAIsotropic.u1)
    annotation (Line(points={{70,-54},{74,-54},{74,-53.6},{78.4,-53.6}}, color={0,0,127}));
  connect(isotropic.diffuseInclinedIrradiance, globalIrradiancePOAIsotropic.u2)
    annotation (Line(points={{70,-60},{78.4,-60}}, color={0,0,127}));
  connect(isotropic.directInclinedIrradiance, globalIrradiancePOAIsotropic.u3)
    annotation (Line(points={{70,-66},{74,-66},{74,-66.4},{78.4,-66.4}}, color={0,0,127}));
  connect(solarZenith.y, isotropic.solarZenith)
    annotation (Line(points={{-39,56.2},{110,56.2},{110,-82},{60,-82},{60,-70},{62,-70}},color={0,0,127}));
  connect(solarAzimuth.y, isotropic.solarAzimuth)
    annotation (Line(points={{-39,78.2},{120,78.2},{120,-78},{66,-78},{66,-70}},color={0,0,127}));
  connect(perez.solarZenith, isotropic.solarZenith)
    annotation (Line(points={{2,-76},{60,-76},{60,-70},{62,-70}}, color={0,0,127}));
  connect(perez.solarAzimuth, isotropic.solarAzimuth)
    annotation (Line(points={{2,-80},{36,-80},{36,-78},{66,-78},{66,-70}}, color={0,0,127}));
  connect(fixedAlbedo.y, perez.albedo) annotation (Line(points={{51.6,-20},{-14,-20},{-14,-64}}, color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, perez.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{-2,19.2},{-2,-64}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, perez.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,-64}}, color={0,0,127}));
  connect(perez.directInclinedIrradiance,globalIrradiancePOAPerez. u1)
    annotation (Line(points={{-2,-84},{-2,-90},{11,-90},{11,-89}}, color={0,0,127}));
  connect(perez.diffuseInclinedIrradiance,globalIrradiancePOAPerez. u2)
    annotation (Line(points={{-8,-84},{-8,-93},{11,-93}}, color={0,0,127}));
  connect(perez.reflectedInclinedIrradiance,globalIrradiancePOAPerez. u3)
    annotation (Line(points={{-14,-84},{-14,-97},{11,-97}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=18000, StopTime=75600),
    __Dymola_Commands(file="Scripts/plot_Validation_HorizontalToInclined.mos" "plotResult"));
end HorizontalToInclined;
