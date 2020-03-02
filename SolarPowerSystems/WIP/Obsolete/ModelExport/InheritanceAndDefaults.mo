within SolarPowerSystems.WIP.Obsolete.ModelExport;
model InheritanceAndDefaults "Horizontal irradiance to power using the model of Perez and the modified model of Danny"
  extends Components.SolarPowerPlants.Perez_Danny(
  epochOffset = 1542412800,
  useTemperatureInput = true,
  latitude = 49.2553,
  longitude = 7.0405,
  elevation = 273,
  arrayTilt = data.panelTilt,
  arrayAzimuth = data.panelAzimuth,
  panelArea = data.panelArea,
  T_cell_ref = 25);                                      // angles in rad here!!!
  SolarPowerSystems.ModelExport.ParameterSets.PVplantFromTxt data annotation (Placement(transformation(extent={{20,74},{40,94}})));
end InheritanceAndDefaults;
