within SolarPowerSystems.ModelExport.ParameterSets;
record LocationFromMat
  extends Records.Base.Location(
    latitude=scalar(DataFiles.readMATmatrix(fileName, "latitude")),
    longitude=scalar(DataFiles.readMATmatrix(fileName,
        "longitude")),
    elevation=scalar(DataFiles.readMATmatrix(fileName,
        "elevation")));

end LocationFromMat;
