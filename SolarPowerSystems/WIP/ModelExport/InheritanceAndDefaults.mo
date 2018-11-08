within SolarPowerSystems.WIP.ModelExport;
model InheritanceAndDefaults
  "Horizontal irradiance to power using the model of Perez and the modified model of Danny"
  extends Components.SolarPowerPlants.Perez_Danny(
  epochOffset = 1541673059,
  latitude = 49.2553,
  longitude = 7.0405,
  elevation = 273,
  arrayTilt = 0,
  arrayAzimuth = 0,
  panelArea = 1,
  T_cell_ref = 25);
end InheritanceAndDefaults;
