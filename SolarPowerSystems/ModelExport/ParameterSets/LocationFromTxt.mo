within SolarPowerSystems.ModelExport.ParameterSets;
record LocationFromTxt
  extends SolarPowerSystems.Records.Base.Location(
    latitude=Modelica.Utilities.Examples.readRealParameter(fileName, "latitude"),
    longitude=Modelica.Utilities.Examples.readRealParameter(fileName, "longitude"),
    elevation=Modelica.Utilities.Examples.readRealParameter(fileName, "elevation"));

end LocationFromTxt;
