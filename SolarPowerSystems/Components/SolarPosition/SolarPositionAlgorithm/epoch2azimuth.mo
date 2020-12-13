within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm;
function epoch2azimuth
  "Convert epoch to solar azimuth (topocentric azimuth angle (eastward from north))"
  input Real epoch;
  input Real latitude;
  input Real longitude;
  input Real height_above_sealevel;
  output Real azimuth(unit="deg");

external"C" azimuth = Mext_epoch2azi(
            epoch,
            latitude,
            longitude,
            height_above_sealevel);
  annotation (Include="#include \"m_ext_functions.c\"", IncludeDirectory="modelica://SolarPowerSystems/Resources/Include");

end epoch2azimuth;
