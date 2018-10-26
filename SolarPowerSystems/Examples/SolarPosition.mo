within SolarPowerSystems.Examples;
model SolarPosition
  "Calculate the position of the sun w.r.t to a position on earth for a given time"
  extends Modelica.Icons.Example;
  replaceable parameter Records.Data.Location_UdS location constrainedby Records.Base.Location
                          annotation (Placement(transformation(extent={{-90,70},
            {-70,90}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Constant       epochOffset(k=1539817200)
    "The time at the start of the simulation as Epoch in s"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth
    solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    simu_start_epochs=epochOffset.k,
    height_above_sealevel=location.elevation)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.SolarZenith
    solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    simu_start_epochs=epochOffset.k,
    height_above_sealevel=location.elevation)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
end SolarPosition;
