within SolarPowerSystems.Components.PhotoVoltaicArray.ReflectionLosses;
model PhysicalIAMmodel
  "Physical model for incident angle modifier by De Soto et al., 2006 (corrected version)"

  parameter Modelica.SIunits.RefractiveIndex n = 1.526 "Refraction index of the cover glass";
  parameter Real K(unit="1/m") = 4 "Glazing extinction coefficient";
  parameter Modelica.SIunits.Length L = 0.002 "Glazing thickness";

  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle between direct beam and surface normal" annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput incidenceAngleModifier(min=0, max=1)
    "Incident angle modifier for a given angle" annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.Angle angleOfRefraction "Angle of refraction";
  Real tauTheta "Transmittance at angle theta";
  Real tauZero "Transmittance when normal to the sun";

protected
  Real k1 "Helper variable 1";
  Real k2 "Helper variable 2";
  Real a1 = angleOfRefraction - angleOfIncidence;
  Real a2 = angleOfRefraction + angleOfIncidence;

equation
  angleOfRefraction = asin(1/n * sin(angleOfIncidence));  // Snell's law
  incidenceAngleModifier = max(0, (tauTheta / tauZero));

  // Work around division by 0 for angleOfIncidence == 0
  if (abs(angleOfIncidence) < Modelica.Constants.eps) then
    tauTheta = tauZero;
  else
    tauTheta = exp( (-K*L)/cos(angleOfRefraction))  * k1;
  end if;

  k1 =( 1 - 0.5*(( sin(a1)^2)/(sin(a2)^2) + (tan(a1)^2)/(tan(a2)^2)));

  tauZero = exp(-K*L) * k2;
  k2 = 1 - ( (1-n)/(1+n))^2;

annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PhysicalIAMmodel;
