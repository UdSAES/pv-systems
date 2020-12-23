within SolarPowerSystems.Icons;
block AngleOfIncidence "Icon indicating the angle of incidence on the tilted plane"
  extends Modelica.Blocks.Icons.Block;

  annotation (preferredView="icon", Icon(graphics={
        Line(
          points={{-40,-80},{80,-42}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,18},{-60,-6}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-42,22},{-24,4}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-38,40},{-12,40}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-44,58},{-26,72}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-60,62},{-60,86}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-76,58},{-92,76}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-84,40},{-90,40}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-78,26},{-90,14}},
          color={255,223,6},
          thickness=0.5),
        Ellipse(
          extent={{-76,56},{-46,26}},
          lineColor={255,223,6},
          lineThickness=0.5,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid),
        Line(points={{42,36}}, color={0,0,0}),
        Line(points={{36,-56},{10,26}}, color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{20,-6},{8,-8},{-2,-18}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{0,-14},{-2,-18},{2,-16},{0,-14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,0},{36,-56}},
          color={255,223,6},
          thickness=0.5,
          pattern=LinePattern.Dash)}));
end AngleOfIncidence;
