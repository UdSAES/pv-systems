within SolarPowerSystems.Components.SolarPosition;
block AngleOfIncidence "SI2SO block that calculates the angle between sun beam and surface normal"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle";
  parameter Modelica.SIunits.Angle arrayAzimuth "Azimuth angle of array";

  Modelica.Blocks.Interfaces.RealInput solarZenith(unit="deg", displayUnit="deg") "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput solarAzimuth(unit="deg", displayUnit="deg") "Solar azimuth angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(unit="rad", displayUnit="deg")
    "Angle of incidence between surface normal and sun beam" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.SIunits.Angle arrayAzimuthSolarCS "Array azimuth in the same coordinate system as the sun's position";
  Modelica.SIunits.Angle solarHeight=Modelica.SIunits.Conversions.from_deg(90 - solarZenith) "Height of the sun";
protected
  Modelica.SIunits.Angle angleOfIncidenceFullCircle;

equation
  arrayAzimuthSolarCS = arrayAzimuth + Modelica.Constants.pi;
  angleOfIncidenceFullCircle = acos(cos(Modelica.SIunits.Conversions.from_deg(solarZenith))*cos(arrayTilt) + sin(
    Modelica.SIunits.Conversions.from_deg(solarZenith))*sin(arrayTilt)*cos(Modelica.SIunits.Conversions.from_deg(
    solarAzimuth) - arrayAzimuthSolarCS));

  if (angleOfIncidenceFullCircle > -2*Modelica.Constants.pi and angleOfIncidenceFullCircle < -3*Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle + 2*Modelica.Constants.pi;
  elseif (angleOfIncidenceFullCircle < 2*Modelica.Constants.pi and angleOfIncidenceFullCircle > 3*Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle - 2*Modelica.Constants.pi;
  elseif (angleOfIncidenceFullCircle < Modelica.Constants.pi/2 and angleOfIncidenceFullCircle > -Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle;
  else
    angleOfIncidence = angleOfIncidenceFullCircle;
  end if;

  annotation (Icon(graphics={
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
        Line(points={{36,-56},{10,26}}, color={0,0,0}),
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
