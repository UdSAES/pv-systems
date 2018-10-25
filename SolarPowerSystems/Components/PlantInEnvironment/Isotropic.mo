within SolarPowerSystems.Components.PlantInEnvironment;
model Isotropic
  "Transform horizontal irradiance to normal of arbitrarily oriented surface using the `Buildings`-library"
  extends Interfaces.PlantInEnvironment;
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.DiffuseIsotropic
    diffuse(til=surfaceTilt, rho=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.DirectTiltedSurface
    direct annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Modelica.Blocks.Math.Add I_G_horizontal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-66,40})));
  Functions.angleOfIncidenceAsBlock angleOfIncidenceAsBlock(surfaceTilt=
        surfaceTilt, surfaceAzimuth=surfaceAzimuth) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={34,38})));

equation
  direct.HDirNor = noEvent(max(0, (I_dir_horizontal)))/noEvent(max(cos(zenithOfSun), 0.1));
  connect(I_diff_horizontal, I_G_horizontal.u2) annotation (Line(points={{-50,100},
          {-50,60},{-72,60},{-72,52}}, color={0,0,127}));
  connect(I_dir_horizontal, I_G_horizontal.u1) annotation (Line(points={{-20,100},
          {-20,60},{-60,60},{-60,52}}, color={0,0,127}));
  connect(I_G_horizontal.y, diffuse.HGloHor) annotation (Line(points={{-66,29},{
          -66,20},{-36,20},{-36,12}}, color={0,0,127}));
  connect(I_dir_horizontal, diffuse.HDifHor) annotation (Line(points={{-20,100},
          {-20,22},{-44,22},{-44,12}}, color={0,0,127}));
  connect(direct.HDirTil, I_dir_inclined) annotation (Line(points={{40,-11},{40,
          -40},{0,-40},{0,-100}}, color={0,0,127}));
  connect(diffuse.HSkyDifTil, I_diff_inclined) annotation (Line(points={{-36,-11},
          {-36,-60},{-60,-60},{-60,-100}}, color={0,0,127}));
  connect(diffuse.HGroDifTil, I_refl_inclined) annotation (Line(points={{-44,-11},
          {-44,-20},{60,-20},{60,-100}}, color={0,0,127}));
  connect(azimuthOfSun, angleOfIncidenceAsBlock.azimuth)
    annotation (Line(points={{30,100},{30,48}}, color={0,0,127}));
  connect(zenithOfSun, angleOfIncidenceAsBlock.zenith) annotation (Line(points={
          {70,100},{70,60},{38,60},{38,48}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, direct.incAng)
    annotation (Line(points={{34,28},{34,12}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-42,72},{20,78}},
          lineColor={28,108,200},
          textString="Variability 'albedo' higher than parameter
=> __not used__"), Text(
          extent={{44,20},{92,14}},
          lineColor={28,108,200},
          textString="connected on text layer")}));
end Isotropic;
