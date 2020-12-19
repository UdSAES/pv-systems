within SolarPowerSystems.Interfaces;
partial model PhotoVoltaicArray "Interface for models of PV arrays (total irradiance normal to surface -> power)"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort;
  Modelica.Blocks.Interfaces.RealInput I_G_normal(unit="W/m2", min=0) "Total irradiance normal to module surface"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput P_DC(unit="W") "Generated power across all panels" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle between direct beam and surface normal"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput u(final unit="m/s") "Wind speed in PV plane"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
end PhotoVoltaicArray;
