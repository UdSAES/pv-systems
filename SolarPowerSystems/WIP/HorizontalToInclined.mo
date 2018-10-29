within SolarPowerSystems.WIP;
model HorizontalToInclined
  "Model for testing the transformation of irradiance on a horizontal plane to an arbitrarily oriented one"
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-88,-32},{-24,32}})));
  Obsolete.IsotropicFromNormal isotropicFromNormal(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,12})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k) annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{30,48},{50,68}})));
  Records.Data.Location_Ashland location annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540191600)
    annotation (Placement(transformation(extent={{-90,46},{-70,66}})));
  Modelica.Blocks.Sources.Constant fixedAlbedo(final k=0.2)
    annotation (Placement(transformation(extent={{60,-24},{52,-16}})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropicFromNormal(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{78,4},{94,20}})));
  Modelica.Blocks.Math.Cos cosine
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-6,72})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-26,74})));
  Modelica.Blocks.Math.Add globalHorizontalFromDNIandDHI
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-44,78})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={20,60})));
  Real QAresidual "Solar QA residual indicating whether the measured values of DNI, GHI and DHI are consistent";
//    Real DNIfromDirectIrradiance "DNI calculated from direct horizontal irradiance and solar zenith angle";
  Real errorGlobalIrradiancePOAIsotropic "Measured irradiance in POA compared to calculated one, positive if prediction is larger";

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
  Modelica.Blocks.Math.Add3 globalIrradiancePOAperez(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{12,-98},{22,-88}})));
  Modelica.Blocks.Sources.Constant c1(k=Modelica.SIunits.Conversions.from_deg(15))
    annotation (Placement(transformation(extent={{-74,-60},{-54,-40}})));
  Modelica.Blocks.Sources.Constant c2(k=Modelica.SIunits.Conversions.from_deg(0))
    annotation (Placement(transformation(extent={{-74,-92},{-54,-72}})));
equation
//   DNIfromDirectIrradiance =  measurementDataAshland.directHorizontalIrradiance / max(0.1, cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y)));
  QAresidual = measurementDataAshland.diffuseHorizontalIrradiance
     + measurementDataAshland.directNormalIrradiance*cos(Modelica.SIunits.Conversions.from_deg(solarZenith.y))
     - measurementDataAshland.globalHorizontalIrradiance;
  errorGlobalIrradiancePOAIsotropic =globalIrradiancePOAIsotropic.y - measurementDataAshland.globalIrradiancePOA;
  connect(measurementDataAshland.directHorizontalIrradiance, isotropicFromNormal.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{10,19.2},{10,18},{50,18}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropicFromNormal.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{10,12.8},{10,12},{50,12}}, color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, isotropicFromNormal.directNormalIrradiance)
    annotation (Line(points={{-24,6.4},{-16,6.4},{-16,26},{56,26},{56,22}}, color={0,0,127}));
  connect(solarAzimuth.y, isotropicFromNormal.solarAzimuth)
    annotation (Line(points={{51,80.2},{66,80.2},{66,22}}, color={0,0,127}));
  connect(solarZenith.y, isotropicFromNormal.solarZenith)
    annotation (Line(points={{51,58.2},{62,58.2},{62,22}}, color={0,0,127}));
  connect(fixedAlbedo.y, isotropicFromNormal.albedo)
    annotation (Line(points={{51.6,-20},{40,-20},{40,6},{50,6}}, color={0,0,127}));
  connect(isotropicFromNormal.directInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u1)
    annotation (Line(points={{70,18},{76,18},{76,18.4},{76.4,18.4}}, color={0,0,127}));
  connect(isotropicFromNormal.reflectedInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u3)
    annotation (Line(points={{70,6},{76,6},{76,5.6},{76.4,5.6}}, color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, product.u1)
    annotation (Line(points={{-24,6.4},{-16,6.4},{-16,76.4},{-21.2,76.4}}, color={0,0,127}));
  connect(cosine.y, product.u2)
    annotation (Line(points={{-10.4,72},{-18,72},{-18,71.6},{-21.2,71.6}}, color={0,0,127}));
  connect(product.y, globalHorizontalFromDNIandDHI.u1)
    annotation (Line(points={{-30.4,74},{-34,74},{-34,73.2},{-34.4,73.2}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, globalHorizontalFromDNIandDHI.u2)
    annotation (Line(points={{-24,12.8},{10,12.8},{10,82.8},{-34.4,82.8}}, color={0,0,127}));
  connect(solarZenith.y, from_deg.u)
    annotation (Line(points={{51,58.2},{52,58.2},{52,58},{54,58},{54,44},{20,44},{20,55.2}}, color={0,0,127}));
  connect(from_deg.y, cosine.u) annotation (Line(points={{20,64.4},{20,72},{-1.2,72}}, color={0,0,127}));
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
    annotation (Line(points={{51,58.2},{110,58.2},{110,-82},{60,-82},{60,-70},{62,-70}}, color={0,0,127}));
  connect(solarAzimuth.y, isotropic.solarAzimuth)
    annotation (Line(points={{51,80.2},{120,80.2},{120,-78},{66,-78},{66,-70}}, color={0,0,127}));
  connect(perez.solarZenith, isotropic.solarZenith)
    annotation (Line(points={{2,-76},{60,-76},{60,-70},{62,-70}}, color={0,0,127}));
  connect(perez.solarAzimuth, isotropic.solarAzimuth)
    annotation (Line(points={{2,-80},{36,-80},{36,-78},{66,-78},{66,-70}}, color={0,0,127}));
  connect(fixedAlbedo.y, perez.albedo) annotation (Line(points={{51.6,-20},{-14,-20},{-14,-64}}, color={0,0,127}));
  connect(measurementDataAshland.directHorizontalIrradiance, perez.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{-2,19.2},{-2,-64}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, perez.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{-8,12.8},{-8,-64}}, color={0,0,127}));
  connect(perez.directInclinedIrradiance, globalIrradiancePOAperez.u1)
    annotation (Line(points={{-2,-84},{-2,-90},{11,-90},{11,-89}}, color={0,0,127}));
  connect(perez.diffuseInclinedIrradiance, globalIrradiancePOAperez.u2)
    annotation (Line(points={{-8,-84},{-8,-93},{11,-93}}, color={0,0,127}));
  connect(perez.reflectedInclinedIrradiance, globalIrradiancePOAperez.u3)
    annotation (Line(points={{-14,-84},{-14,-97},{11,-97}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=18000, StopTime=75600),
    __Dymola_Commands(file="Scripts/compareHorizontalToInclined.mos" "compareHorizontalToInclined"));
end HorizontalToInclined;
