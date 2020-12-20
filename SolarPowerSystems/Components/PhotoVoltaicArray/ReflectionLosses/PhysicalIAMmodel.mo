within SolarPowerSystems.Components.PhotoVoltaicArray.ReflectionLosses;
model PhysicalIAMmodel
  "Physical model for incident angle modifier by De Soto et al., 2006 (corrected version)"

  parameter Modelica.SIunits.RefractiveIndex n=1.526 "Refraction index of the cover glass";
  parameter Real K(unit="1/m") = 4 "Glazing extinction coefficient";
  parameter Modelica.SIunits.Length L=0.002 "Glazing thickness";

  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle between direct beam and surface normal"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput incidenceAngleModifier(min=0, max=1)
    "Incident angle modifier for a given angle"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.Angle angleOfRefraction "Angle of refraction";
  Real tauTheta "Transmittance at angle theta";
  Real tauZero "Transmittance when normal to the sun";

protected
  Real k1 "Helper variable 1";
  Real k2 "Helper variable 2";
  Real a1=angleOfRefraction - angleOfIncidence;
  Real a2=angleOfRefraction + angleOfIncidence;

equation
  angleOfRefraction = asin(1/n*sin(angleOfIncidence));
  // Snell's law
  incidenceAngleModifier = max(0, (tauTheta/tauZero));

  // Work around division by 0 for angleOfIncidence == 0
  if (abs(angleOfIncidence) < Modelica.Constants.eps) then
    tauTheta = tauZero;
  else
    tauTheta = exp((-K*L)/cos(angleOfRefraction))*k1;
  end if;

  k1 = (1 - 0.5*((sin(a1)^2)/(sin(a2)^2) + (tan(a1)^2)/(tan(a2)^2)));

  tauZero = exp(-K*L)*k2;
  k2 = 1 - ((1 - n)/(1 + n))^2;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-60,48},{-60,-88},{80,-88}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,40},{-20,40},{20,36},{48,20},{62,-4},{70,-50},{74,-88}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          extent={{64,-92},{78,-98}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="90°"),
        Text(
          extent={{-66,-92},{-52,-98}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="0°"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          lineColor={0,0,255})}),                                   Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The incident angle-dependent reflection losses are modelled by the corrected version of the physical incident angle modifier model presented by the PVPerformance Modeling Collaborative at <a href=\"https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/shading-soiling-and-reflection-losses/incident-angle-reflection-losses/physical-model-of-iam\">https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/shading-soiling-and-reflection-losses/incident-angle-reflection-losses/physical-model-of-iam</a>, originally published by De Soto et al. (2006). The parameter values listed on the page are set as default values.</p>
<p><br>Simulate the <span style=\"font-family: monospace;\">PhysicalIAM</span>-model in the <span style=\"font-family: monospace;\">Examples</span>-subpackage and run the corresponding plot script to verify the behaviour of the model.</p>
</html>"));
end PhysicalIAMmodel;
