within SolarPowerSystems.WIP;
model HorizontalToInclined
  "Model for testing the transformation of irradiance on a horizontal plane to an arbitrarily oriented one"
  Utilities.MeasurementDataAshland measurementDataAshland
    annotation (Placement(transformation(extent={{-88,-32},{-24,32}})));
  Components.PlantInEnvironment.Isotropic isotropic(                            arrayAzimuth=0, arrayTilt=
        0.26179938779915)
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
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1540598400)
    annotation (Placement(transformation(extent={{-90,46},{-70,66}})));
  Modelica.Blocks.Sources.Constant fixedAlbedo(final k=0.2)
    annotation (Placement(transformation(extent={{60,-24},{52,-16}})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOA(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{78,4},{94,20}})));
  Modelica.Blocks.Math.Cos cos
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-6,72})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-26,74})));
  Modelica.Blocks.Math.Add GHI
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-44,78})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={20,60})));
equation
  connect(measurementDataAshland.directHorizontalIrradiance, isotropic.directHorizontalIrradiance)
    annotation (Line(points={{-24,19.2},{10,19.2},{10,18},{50,18}},
                                                                  color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, isotropic.diffuseHorizontalIrradiance)
    annotation (Line(points={{-24,12.8},{10,12.8},{10,12},{50,12}},
                                                                  color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, isotropic.directNormalIrradiance)
    annotation (Line(points={{-24,6.4},{-16,6.4},{-16,26},{56,26},{56,22}}, color={0,0,127}));
  connect(solarAzimuth.y, isotropic.solarAzimuth)
    annotation (Line(points={{51,80.2},{66,80.2},{66,22}}, color={0,0,127}));
  connect(solarZenith.y, isotropic.solarZenith)
    annotation (Line(points={{51,58.2},{62,58.2},{62,22}}, color={0,0,127}));
  connect(fixedAlbedo.y, isotropic.albedo)
    annotation (Line(points={{51.6,-20},{40,-20},{40,6},{50,6}},   color={0,0,127}));
  connect(isotropic.directInclinedIrradiance, globalIrradiancePOA.u1)
    annotation (Line(points={{70,18},{76,18},{76,18.4},{76.4,18.4}}, color={0,0,127}));
  connect(isotropic.reflectedInclinedIrradiance, globalIrradiancePOA.u3)
    annotation (Line(points={{70,6},{76,6},{76,5.6},{76.4,5.6}}, color={0,0,127}));
  connect(measurementDataAshland.directNormalIrradiance, product.u1)
    annotation (Line(points={{-24,6.4},{-16,6.4},{-16,76.4},{-21.2,76.4}}, color={0,0,127}));
  connect(cos.y, product.u2) annotation (Line(points={{-10.4,72},{-18,72},{-18,71.6},{-21.2,71.6}}, color={0,0,127}));
  connect(product.y, GHI.u1) annotation (Line(points={{-30.4,74},{-34,74},{-34,73.2},{-34.4,73.2}}, color={0,0,127}));
  connect(measurementDataAshland.diffuseHorizontalIrradiance, GHI.u2)
    annotation (Line(points={{-24,12.8},{10,12.8},{10,82.8},{-34.4,82.8}}, color={0,0,127}));
  connect(solarZenith.y, from_deg.u)
    annotation (Line(points={{51,58.2},{52,58.2},{52,58},{54,58},{54,44},{20,44},{20,55.2}}, color={0,0,127}));
  connect(from_deg.y, cos.u) annotation (Line(points={{20,64.4},{20,72},{-1.2,72}}, color={0,0,127}));
  connect(isotropic.diffuseInclinedIrradiance, globalIrradiancePOA.u2)
    annotation (Line(points={{70,12},{76.4,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HorizontalToInclined;
