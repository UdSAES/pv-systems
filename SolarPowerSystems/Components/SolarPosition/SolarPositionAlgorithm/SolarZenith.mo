within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm;
model SolarZenith "topocentric zenith angle [degrees]"
  parameter Real latitude(unit = "deg", min = 47.0, max = 56.0) = 49.26
    "pos north of entity";
  parameter Real longitude(unit = "deg", min = 5.0, max = 16.0) = 7.04
    "pos east of entity";
  parameter Real height_above_sealevel(unit = "m", min = 0, max = 4000) = 230
    "height above seelevel of entity";
  parameter Real simu_start_epochs(unit="s", min = 0) = 1388534400
    "offset between simulation time and unix time (epochs), default 01/01/2014";
  Real epoch_time;

Modelica.Blocks.Interfaces.RealOutput y(unit = "deg")
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));

equation
  epoch_time = time + simu_start_epochs;
  y =
    SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.epoch2zenith(
    epoch_time,
    latitude,
    longitude,
    height_above_sealevel);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end SolarZenith;
