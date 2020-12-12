within SolarPowerSystems.ModelExport.ParameterSets;
record PVplantFromMAT "Read parameters for PV system from external .csv file during model initialization"
  extends SolarPowerSystems.Records.Base.PVplant(
    panelArea=scalar(DataFiles.readMATmatrix(fileName, "panelArea")),
    plantEfficiency=scalar(DataFiles.readMATmatrix(fileName, "plantEfficiency")),
    T_cell_ref=scalar(DataFiles.readMATmatrix(fileName, "T_cell_ref")),
    panelTilt=scalar(DataFiles.readMATmatrix(fileName, "panelTilt")),
    panelAzimuth=scalar(DataFiles.readMATmatrix(fileName, "panelAzimuth")),
    environmentAlbedo=scalar(DataFiles.readMATmatrix(fileName, "environmentAlbedo")),
    nsModule=integer(scalar(DataFiles.readMATmatrix(fileName, "nsModule"))),
    npModule=integer(scalar(DataFiles.readMATmatrix(fileName, "npModule"))));

end PVplantFromMAT;
