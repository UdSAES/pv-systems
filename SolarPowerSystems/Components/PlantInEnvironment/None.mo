within SolarPowerSystems.Components.PlantInEnvironment;
model None "Pass through: irradiance not modified, but angle of incidence calculated for arbitrary array orientation"
  extends Interfaces.PlantInEnvironment;
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-60})));
equation
  connect(const.y, reflectedInclinedIrradiance) annotation (Line(points={{-60,-71},{-60,-100}}, color={0,0,127}));
  connect(directHorizontalIrradiance, directInclinedIrradiance)
    annotation (Line(points={{60,100},{60,0},{60,0},{60,-100}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, diffuseInclinedIrradiance)
    annotation (Line(points={{0,100},{0,0},{0,0},{0,-100}}, color={0,0,127}));
end None;
