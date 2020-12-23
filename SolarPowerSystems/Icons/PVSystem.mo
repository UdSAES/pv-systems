within SolarPowerSystems.Icons;
model PVSystem "Icon for overall PV system models including models for the position of the sun/POA conversion"
  extends Modelica.Blocks.Icons.Block;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
      Line(
        points={{-76,44},{-88,32}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-80,60},{-88,60}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-74,78},{-88,92}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-60,80},{-60,92}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-44,76},{-24,92}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-40,60},{-14,60}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-44,44},{-26,26}},
        color={255,223,6},
        thickness=0.5),
      Line(
        points={{-60,40},{-60,16}},
        color={255,223,6},
        thickness=0.5),
      Ellipse(
        extent={{-74,74},{-46,46}},
        lineColor={255,223,6},
        lineThickness=0.5,
        fillColor={255,223,6},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-26,-86},{90,-40}},
        color={28,108,200},
        thickness=1),
        Line(points={{-100,-80},{0,-80}}, color={0,127,255},
          origin={-88,-130},
          rotation=180),
        Line(points={{11,6},{5,10}},       color={0,127,255},
          origin={17,-40},
          rotation=180),
        Line(points={{-63,-82},{-69,-86}}, color={0,127,255},
          origin={-57,-136},
          rotation=180),
        Line(points={{-88,-56},{-18,-56}},color={191,0,0}),
        Line(points={{-26,-52},{-18,-56}},
                                         color={191,0,0}),
        Line(points={{-26,-60},{-18,-56}},
                                         color={191,0,0})}),
                        Diagram(coordinateSystem(preserveAspectRatio=false)));
end PVSystem;
