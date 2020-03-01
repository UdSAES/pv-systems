within SolarPowerSystems.ModelExport.ParameterSets;
record PVplant
  "Read parameters for PV system from external file during model initialization"
  extends Records.Base.PVplant(
    panelArea=Modelica.Utilities.Examples.readRealParameter(file, "panelArea"),
    plantEfficiency=Modelica.Utilities.Examples.readRealParameter(file, "plantEfficiency"),
    T_cell_ref=Modelica.Utilities.Examples.readRealParameter(file, "T_cell_ref"),
    panelTilt=Modelica.Utilities.Examples.readRealParameter(file, "panelTilt"),
    panelAzimuth=Modelica.Utilities.Examples.readRealParameter(file, "panelAzimuth"),
    environmentAlbedo=Modelica.Utilities.Examples.readRealParameter(file, "environmentAlbedo"),
    nsModule=integer(Modelica.Utilities.Examples.readRealParameter(file, "nsModule")),
    npModule=integer(Modelica.Utilities.Examples.readRealParameter(file, "npModule")));

end PVplant;
