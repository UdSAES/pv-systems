within SolarPowerSystems.Components.PlantInEnvironment;
model None "Pass through: no inclination, no azimuth, no shadows"
  extends Interfaces.PlantInEnvironment;
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-60})));
equation
  connect(const.y, I_refl_inclined)
    annotation (Line(points={{51,-60},{60,-60},{60,-100}}, color={0,0,127}));
  connect(I_dir_horizontal, I_dir_inclined) annotation (Line(points={{-20,100},
          {-20,0},{0,0},{0,-100}}, color={0,0,127}));
  connect(I_diff_horizontal, I_diff_inclined) annotation (Line(points={{-50,100},
          {-50,0},{-60,0},{-60,-100}}, color={0,0,127}));
end None;
