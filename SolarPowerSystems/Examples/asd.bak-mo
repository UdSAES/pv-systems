within SolarPowerSystems.Examples;
model asd

  SolarPowerSystems.Components.SolarPowerPlant.AreaBased.AreaBased areaBased(i(start=0))
    annotation (Placement(transformation(extent={{-44,2},{-24,22}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-52,-46},{-32,-26}})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{-88,44},{-68,64}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=100) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
equation
  connect(const.y, areaBased.I_G_normal)
    annotation (Line(points={{-67,54},{-34,54},{-34,22}}, color={0,0,127}));
  connect(areaBased.p, ground.p) annotation (Line(points={{-44,12},{-60,12},{
          -60,-20},{-42,-20},{-42,-26}}, color={0,0,255}));
  connect(areaBased.n, resistor.p) annotation (Line(points={{-24,12},{-12,12},{
          -12,10},{1.77636e-15,10}}, color={0,0,255}));
  connect(resistor.n, ground.p) annotation (Line(points={{0,-10},{0,-20},{-42,
          -20},{-42,-26}}, color={0,0,255}));
  annotation ();
end asd;
