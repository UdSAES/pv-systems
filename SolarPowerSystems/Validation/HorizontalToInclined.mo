within SolarPowerSystems.Validation;
model HorizontalToInclined
  "Model for testing the transformation of irradiance on a horizontal plane to an arbitrarily oriented one"
  extends Modelica.Icons.Example;
  Components.PlantInEnvironment.IsotropicFromDNI isotropicFromDNI(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
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
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{32,32},{48,48}})));
  Components.PlantInEnvironment.Isotropic isotropic(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAIsotropic(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{32,-8},{48,8}})));
  Components.PlantInEnvironment.Perez perez(arrayTilt=c1.k, arrayAzimuth=c2.k)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Modelica.Blocks.Math.Add3 globalIrradiancePOAPerez(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{32,-48},{48,-32}})));
  Modelica.Blocks.Sources.Constant c1(k=Modelica.SIunits.Conversions.from_deg(15))
    "Array tilt angle in rad"
    annotation (Placement(transformation(extent={{-92,-58},{-72,-38}})));
  Modelica.Blocks.Sources.Constant c2(k=Modelica.SIunits.Conversions.from_deg(0))
    "Array azimuth angle in rad"
    annotation (Placement(transformation(extent={{-92,-90},{-72,-70}})));

  Real errorGlobalIrradiancePOAIsotropic "Measured irradiance in POA compared to calculated one, positive if prediction is larger";
  Real errorGlobalIrradiancePOAIsotropicFromNormal "Measured irradiance in POA compared to calculated one based on DNI";
  Real errorGlobalIrradiancePOAPerez "Measured irradiance in POA compared to calculated one, positive if prediction is larger";
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=epochOffset.k)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-36,-6},{-24,6}})));
equation
  errorGlobalIrradiancePOAIsotropic =globalIrradiancePOAIsotropic.y - measurementDataAshland.validationData.globalIrradiancePOA;
  errorGlobalIrradiancePOAIsotropicFromNormal =globalIrradiancePOAIsotropicFromNormal.y - measurementDataAshland.validationData.globalIrradiancePOA;
  errorGlobalIrradiancePOAPerez =globalIrradiancePOAPerez.y - measurementDataAshland.validationData.globalIrradiancePOA;

  connect(solarAzimuth.y, isotropicFromDNI.solarAzimuth)
    annotation (Line(points={{-39,78.2},{6,78.2},{6,50}}, color={0,0,127}));
  connect(solarZenith.y, isotropicFromDNI.solarZenith)
    annotation (Line(points={{-39,56.2},{2,56.2},{2,50}}, color={0,0,127}));
  connect(isotropicFromDNI.directInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u1)
    annotation (Line(points={{10,46},{30,46},{30,46.4},{30.4,46.4}}, color={0,0,127}));
  connect(isotropicFromDNI.reflectedInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u3)
    annotation (Line(points={{10,34},{30,34},{30,33.6},{30.4,33.6}}, color={0,0,127}));
  connect(isotropicFromDNI.diffuseInclinedIrradiance, globalIrradiancePOAIsotropicFromNormal.u2)
    annotation (Line(points={{10,40},{30.4,40}}, color={0,0,127}));
  connect(measurementDataAshland.validationData, validationData)
    annotation (Line(
      points={{-70,0},{-30,0}},
      color={255,204,51},
      thickness=0.5));
  connect(globalIrradiancePOAIsotropic.u1, isotropic.directInclinedIrradiance)
    annotation (Line(points={{30.4,6.4},{20.2,6.4},{20.2,6},{10,6}}, color={0,0,127}));
  connect(isotropic.diffuseInclinedIrradiance, globalIrradiancePOAIsotropic.u2)
    annotation (Line(points={{10,0},{30.4,0}}, color={0,0,127}));
  connect(isotropic.reflectedInclinedIrradiance, globalIrradiancePOAIsotropic.u3)
    annotation (Line(points={{10,-6},{20,-6},{20,-6.4},{30.4,-6.4}}, color={0,0,127}));
  connect(perez.directInclinedIrradiance, globalIrradiancePOAPerez.u1)
    annotation (Line(points={{10,-34},{20,-34},{20,-33.6},{30.4,-33.6}}, color={0,0,127}));
  connect(perez.diffuseInclinedIrradiance, globalIrradiancePOAPerez.u2)
    annotation (Line(points={{10,-40},{30.4,-40}}, color={0,0,127}));
  connect(perez.reflectedInclinedIrradiance, globalIrradiancePOAPerez.u3)
    annotation (Line(points={{10,-46},{20,-46},{20,-46.4},{30.4,-46.4}}, color={0,0,127}));
  connect(solarAzimuth.y, isotropic.solarAzimuth)
    annotation (Line(points={{-39,78.2},{72,78.2},{72,20},{6,20},{6,10}}, color={0,0,127}));
  connect(solarAzimuth.y, perez.solarAzimuth)
    annotation (Line(points={{-39,78.2},{72,78.2},{72,-20},{6,-20},{6,-30}}, color={0,0,127}));
  connect(solarZenith.y, isotropic.solarZenith)
    annotation (Line(points={{-39,56.2},{60,56.2},{60,22},{2,22},{2,10}}, color={0,0,127}));
  connect(solarZenith.y, perez.solarZenith)
    annotation (Line(points={{-39,56.2},{60,56.2},{60,-18},{2,-18},{2,-30}}, color={0,0,127}));
  connect(validationData.diffuseHorizontalIrradiance, isotropicFromDNI.diffuseHorizontalIrradiance)
    annotation (Line(
      points={{-29.97,0.03},{-29.97,40},{-10,40}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directHorizontalIrradiance, isotropic.directHorizontalIrradiance)
    annotation (Line(
      points={{-29.97,0.03},{-29.97,6},{-10,6}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.diffuseHorizontalIrradiance, isotropic.diffuseHorizontalIrradiance) annotation (Line(
      points={{-29.97,0.03},{-20,0.03},{-20,0},{-10,0}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directHorizontalIrradiance, perez.directHorizontalIrradiance) annotation (Line(
      points={{-29.97,0.03},{-29.97,-32},{-30,-32},{-30,-34},{-10,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.diffuseHorizontalIrradiance, perez.diffuseHorizontalIrradiance)
    annotation (Line(
      points={{-29.97,0.03},{-29.97,-40},{-10,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directNormalIrradiance, isotropicFromDNI.directNormalIrradiance) annotation (Line(
      points={{-29.97,0.03},{-29.97,54},{-4,54},{-4,50}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directHorizontalIrradiance, isotropicFromDNI.directHorizontalIrradiance)
    annotation (Line(
      points={{-29.97,0.03},{-29.97,46},{-10,46}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=18000, StopTime=75600),
    __Dymola_Commands(file="Scripts/plot_Validation_HorizontalToInclined.mos" "plotResult"));
end HorizontalToInclined;
