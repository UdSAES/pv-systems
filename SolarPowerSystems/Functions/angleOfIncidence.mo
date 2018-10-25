within SolarPowerSystems.Functions;
function angleOfIncidence
  "Calculate the angle of incidence between solar beam and surface normal"
  input Real zenith( unit="rad", displayUnit="deg") "Solar zenith angle";
  input Real azimuth( unit="rad", displayUnit="deg") "Solar azimuth angle";
  input Real panel_slope( unit="rad", displayUnit="deg") "Panel slope (tilt)";
  input Real panel_azimuth(unit="rad", displayUnit="deg") "Panel azimuth";
  output Real angle_of_incidence(unit="rad", displayUnit="deg")
    "Angle of incidence between panel normal and sun beam";
algorithm
    angle_of_incidence := acos( cos(panel_slope)*cos(zenith)
                                + sin(panel_slope)*sin(zenith)
                                * cos(azimuth - Modelica.Constants.pi + panel_azimuth));

  annotation (Documentation(info="<html>
<p>compare <a href=\"https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/plane-of-array-poa-irradiance/calculating-poa-irradiance/angle-of-incidence/\">Calculating POA Irradiance -- Angle of Incidence</a>, but note that a different convention for the azimuth angle of the sun is used</p>
</html>"));
end angleOfIncidence;
