within SolarPowerSystems.Functions;
function angleOfIncidence
  "Calculate the angle of incidence between surface normal and sun beam"
  input Real solarZenithAngle(final unit="rad", displayUnit="deg") "Solar zenith angle";
  input Real solarAzimuth(final unit="rad", displayUnit="deg") "Solar azimuth angle";
  input Real arrayTilt(final unit="rad", displayUnit="deg") "Array tilt";
  input Real arrayAzimuth(final unit="rad", displayUnit="deg") "Array azimuth";
  output Real angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle of incidence between surface normal and sun beam";
algorithm
    angleOfIncidence := acos( cos(arrayTilt)*cos(solarZenithAngle)
                                + sin(arrayTilt)*sin(solarZenithAngle)
                                * cos(solarAzimuth - Modelica.Constants.pi + arrayAzimuth));

  annotation (Documentation(info="<html>
<p>compare <a href=\"https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/plane-of-array-poa-irradiance/calculating-poa-irradiance/angle-of-incidence/\">Calculating POA Irradiance -- Angle of Incidence</a>, but note that a different convention for the arrayAzimuth-angle is used</p>
</html>"));
end angleOfIncidence;
