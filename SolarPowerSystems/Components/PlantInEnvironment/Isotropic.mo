within SolarPowerSystems.Components.PlantInEnvironment;
model Isotropic
  "Transform horizontal irradiance to normal of arbitrarily oriented surface using an isotropic model"
  extends SolarPowerSystems.Interfaces.PlantInEnvironment;
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.DiffuseIsotropic diffuse(til=arrayTilt, rho=albedo)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-4,0})));
  PlaneOfArrayIrradiance.DirectFromHorizontal direct annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,0})));
  Modelica.Blocks.Math.Add globalHorizontalIrradiance annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,48})));

equation
  connect(globalHorizontalIrradiance.y, diffuse.HGloHor)
    annotation (Line(points={{6,37},{6,34},{1.77636e-15,34},{1.77636e-15,12}}, color={0,0,127}));
  connect(diffuse.HSkyDifTil, diffuseInclinedIrradiance)
    annotation (Line(points={{-2.22045e-15,-11},{-2.22045e-15,-20},{0,-20},{0,-100}}, color={0,0,127}));
  connect(diffuse.HGroDifTil, reflectedInclinedIrradiance)
    annotation (Line(points={{-8,-11},{-8,-74},{-60,-74},{-60,-100}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, diffuse.HDifHor)
    annotation (Line(points={{0,100},{0,66},{-8,66},{-8,12}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, globalHorizontalIrradiance.u2)
    annotation (Line(points={{0,100},{0,66},{1.77636e-15,66},{1.77636e-15,60}}, color={0,0,127}));
  connect(directHorizontalIrradiance, globalHorizontalIrradiance.u1)
    annotation (Line(points={{60,100},{60,66},{12,66},{12,60}}, color={0,0,127}));
  connect(direct.directInclinedIrradiance, directInclinedIrradiance)
    annotation (Line(points={{60,-10},{60,-100},{60,-100}}, color={0,0,127}));
  connect(directHorizontalIrradiance, direct.directHorizontalIrradiance)
    annotation (Line(points={{60,100},{60,20},{60,20},{60,10}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{30,-40},{-100,-40}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, direct.angleOfIncidence)
    annotation (Line(points={{30,-40},{24,-40},{24,16},{54,16},{54,10}}, color={0,0,127}));
  connect(solarZenith, direct.solarZenith)
    annotation (Line(points={{100,-20},{76,-20},{76,16},{66,16},{66,10}}, color={0,0,127}));
end Isotropic;
