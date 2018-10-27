within SolarPowerSystems.WIP.Obsolete.Functions.UnitTests;
model test_getAngleOfIncidence
  import CONV = Modelica.SIunits.Conversions;
  // some orientions
  parameter Real zenith[:] =      {90,     90,     90,     45,     45,    45,    45,   45,   0,    30};
  parameter Real azimuth[:] =     {90,    180,    270,     90,    180,   190,   270,   135,  45,   135};
  parameter Real panel_slope[:] = {90,     90,     90,      0,      0,     0,     0,   45,   0,    60};
  parameter Real panel_azimuth[:]={90,      0,    -90,      0,     45,    60,    90,   45,   0,    45};
  parameter Real expected[:] =    {0,       0,      0,     45,     45,    45,    45,   0,    0,    30};

  Real angle_of_incidence[size(expected, 1)];

equation
  for i in 1:size(expected, 1) loop
      angle_of_incidence[i] =CONV.to_deg(angleOfIncidence(
      CONV.from_deg(zenith[i]),
      CONV.from_deg(azimuth[i]),
      CONV.from_deg(panel_slope[i]),
      CONV.from_deg(panel_azimuth[i])));
  end for;

  XogenyTest.assertValues(actual=angle_of_incidence[:], expected=expected, eps=1e-4);
    annotation (Placement(transformation(extent={{40,0},{60,20}})),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_getAngleOfIncidence;
