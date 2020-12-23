within SolarPowerSystems.Icons;
model PVModule "Icon for a photovoltaic array or module"
  extends Modelica.Blocks.Icons.Block;

  annotation (preferredView="icon", Icon(graphics={
        Rectangle(
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          extent={{-76,76},{76,-76}},
          fillColor={85,85,255}),
        Line(points={{-80,0},{80,0}}, color={255,255,255}),
        Rectangle(extent={{-84,84},{84,-84}}, lineColor={0,0,0}),
        Polygon(
          points={{-84,76},{-76,84},{-68,76},{-76,68},{-84,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-24,76},{-24,-76}}, color={255,255,255}),
        Polygon(
          points={{-8,76},{0,84},{8,76},{0,68},{-8,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,76},{76,84},{84,76},{76,68},{68,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,0},{76,8},{84,0},{76,-8},{68,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,-76},{76,-68},{84,-76},{76,-84},{68,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-84,-76},{-76,-68},{-68,-76},{-76,-84},{-84,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-54,76},{-54,-76}}, color={255,255,255}),
        Polygon(
          points={{-84,0},{-76,8},{-68,0},{-76,-8},{-84,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-8,0},{0,8},{8,0},{0,-8},{-8,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-8,-76},{0,-68},{8,-76},{0,-84},{-8,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{0,76},{0,-76}}, color={255,255,255}),
        Line(points={{24,76},{24,-76}}, color={255,255,255}),
        Line(points={{54,76},{54,-76}}, color={255,255,255})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PVModule;
