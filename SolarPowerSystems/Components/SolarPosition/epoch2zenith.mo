within SolarPowerSystems.Components.SolarPosition;
function epoch2zenith
  "Convert epoch to solar zenith (topocentric zenith angle)"
  input Real epoch;
  input Real latitude;
  input Real longitude;
  input Real height_above_sealevel;
  output Real zenith(unit = "deg");

  external "C" zenith = Mext_epoch2zenith(epoch, latitude, longitude, height_above_sealevel);
  annotation(Include = "#include \"m_ext_functions.c\"", IncludeDirectory=
        "modelica://SolarPowerSystems/Resources/Include");

end epoch2zenith;
