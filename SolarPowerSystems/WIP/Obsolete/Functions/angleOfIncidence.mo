within SolarPowerSystems.WIP.Obsolete.Functions;
function angleOfIncidence
  "Calculate the angle of incidence between surface normal and sun beam"
  input Real solarZenith(unit="rad", displayUnit="deg") "Solar zenith angle";
  input Real solarAzimuth(unit="rad", displayUnit="deg") "Solar azimuth angle";
  input Real arrayTilt(unit="rad", displayUnit="deg") "Array tilt";
  input Real arrayAzimuth(unit="rad", displayUnit="deg") "Array azimuth";
protected
  Modelica.SIunits.Angle arrayAzimuthSolarCS "Array azimuth in the same coordinate system as the sun's position";
  Modelica.SIunits.Angle solarHeight "Height of the sun";
public
  output Real angleOfIncidence(unit="rad", displayUnit="deg") "Angle of incidence between surface normal and sun beam";
algorithm
    arrayAzimuthSolarCS := arrayAzimuth + Modelica.Constants.pi;
    solarHeight := Modelica.Constants.pi/2 - solarZenith;
    angleOfIncidence := acos( sin(solarHeight)*cos(arrayTilt)
                                - cos(solarHeight)*sin(arrayTilt)
                                * cos(solarAzimuth - arrayAzimuthSolarCS));

  annotation (Documentation(info="<html>
<p>compare <a href=\"https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/plane-of-array-poa-irradiance/calculating-poa-irradiance/angle-of-incidence/\">Calculating POA Irradiance -- Angle of Incidence</a>, but note that a different convention for the arrayAzimuth-angle is used</p>
</html>"));
end angleOfIncidence;
