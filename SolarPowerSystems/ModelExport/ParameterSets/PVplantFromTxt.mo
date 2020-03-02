within SolarPowerSystems.ModelExport.ParameterSets;
record PVplantFromTxt "Read parameters for PV system from external .txt-file during model initialization"
  extends Records.Base.PVplant(
    panelArea=Modelica.Utilities.Examples.readRealParameter(fileName, "panelArea"),
    plantEfficiency=Modelica.Utilities.Examples.readRealParameter(fileName, "plantEfficiency"),
    T_cell_ref=Modelica.Utilities.Examples.readRealParameter(fileName, "T_cell_ref"),
    panelTilt=Modelica.Utilities.Examples.readRealParameter(fileName, "panelTilt"),
    panelAzimuth=Modelica.Utilities.Examples.readRealParameter(fileName, "panelAzimuth"),
    environmentAlbedo=Modelica.Utilities.Examples.readRealParameter(fileName, "environmentAlbedo"),
    nsModule=integer(Modelica.Utilities.Examples.readRealParameter(fileName, "nsModule")),
    npModule=integer(Modelica.Utilities.Examples.readRealParameter(fileName, "npModule")));

end PVplantFromTxt;
