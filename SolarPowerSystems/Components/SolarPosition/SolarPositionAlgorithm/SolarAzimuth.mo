within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm;
model SolarAzimuth "Block to calculate topocentric azimuth angle (eastward from north) / degrees"
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
  y = SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.epoch2azimuth(
            epoch_time,
            latitude,
            longitude,
            height_above_sealevel);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-10,90},{10,70}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid,
          textString="N"),
        Text(
          extent={{70,10},{90,-10}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid,
          textString="E"),
        Text(
          extent={{-10,-70},{10,-90}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid,
          textString="S"),
        Text(
          extent={{-90,10},{-70,-10}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid,
          textString="W"),
        Line(
          points={{0,38},{12,38},{24,32},{36,18},{40,0},{38,-14},{30,-24}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Polygon(
          points={{32,-18},{30,-24},{36,-22},{32,-18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{32,-34},{48,-46}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,223,6},
          fillPattern=FillPattern.Solid,
          textString="+")}),                                     Diagram(coordinateSystem(preserveAspectRatio=false)));
end SolarAzimuth;
