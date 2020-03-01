within SolarPowerSystems.Records.Base;
partial record Location
  "A location on the earth expressed as latitude, longitude and elevation"
  extends Modelica.Icons.Record;

  parameter String fileName = "noFile" "Filepath to external file storing actual data";

  parameter Real latitude(unit = "deg", min = -90, max = 90)
    "Latitude in decimal degrees";
  parameter Real longitude(unit = "deg", min = -180, max = 180)
    "Longitude in decimal degrees";
  parameter Real elevation(unit = "m", min = 0, max = 8848)
    "Height above sea level (elevation) in metres";
end Location;
