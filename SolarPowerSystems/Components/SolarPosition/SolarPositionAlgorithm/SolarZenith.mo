within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm;
model SolarZenith "Block to calculate topocentric zenith angle / degrees"
  extends Modelica.Blocks.Icons.Block;

  parameter Real latitude(
    unit="deg",
    min=47.0,
    max=56.0) = 49.26 "Position north of entity";
  parameter Real longitude(
    unit="deg",
    min=5.0,
    max=16.0) = 7.04 "Position east of entity";
  parameter Real height_above_sealevel(
    unit="m",
    min=0,
    max=4000) = 230 "Height above sealevel of entity";
  parameter Real simu_start_epochs(
    unit="s",
    min=0) = 1388534400 "Offset between simulation time and unix time (epochs), default 01/01/2014";
  Real epoch_time;

  Modelica.Blocks.Interfaces.RealOutput y(unit="deg")
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));

equation
  epoch_time = time + simu_start_epochs;
  y = SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.epoch2zenith(
            epoch_time,
            latitude,
            longitude,
            height_above_sealevel);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-38,60},{38,60}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-42,42},{26,-26}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-44,78},{-26,92}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-60,82},{-60,92}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-62,38},{-62,-20}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-78,46},{-90,34}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-84,62},{-90,62}},
          color={255,223,6},
          thickness=0.5),
        Ellipse(
          extent={{-76,76},{-46,46}},
          lineColor={255,223,6},
          lineThickness=0.5,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-76,78},{-84,86}},
          color={255,223,6},
          thickness=0.5),
        Line(
          points={{-80,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-90,-80},{88,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-72,-88},{-54,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-32,-88},{-12,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{8,-88},{28,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{48,-88},{68,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{76,-16}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-140,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{80,74},{80,-80}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{80,2},{58,2},{38,-6},{22,-22}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{24,-16},{22,-22},{28,-20},{24,-16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end SolarZenith;
