within SolarPowerSystems.WIP.ModelExport;
model InheritanceAndDefaults
  "Horizontal irradiance to power using the model of Perez and the modified model of Danny"
  extends Components.SolarPowerPlants.Perez_Danny(
  epochOffset = 1542412800,
  useTemperatureInput = true,
  latitude = 49.2553,
  longitude = 7.0405,
  elevation = 273,
  arrayTilt = Modelica.SIunits.Conversions.from_deg(30),
  arrayAzimuth = 0,
  panelArea = 64*216*1/100,
  T_cell_ref = 25);                                      // angles in rad here!!!
end InheritanceAndDefaults;
