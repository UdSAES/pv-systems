within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.UnitTests;
model SolarPositionVsIrradiance
  "A comparison of the solar position models in this library to the irradiance model of the `PhotoVoltaics`-library"
  Modelica.SIunits.Angle z0 = Modelica.SIunits.Conversions.from_deg(90);
  Modelica.SIunits.Angle south = Modelica.SIunits.Conversions.from_deg(180);
  Modelica.SIunits.Angle altitudeOfSun;
  PhotoVoltaics.Sources.Irradiance.Irradiance irradiance(
    startDay=18,
    startMonth=10,
    startYear=2018,
    longitude=location.longitude*Modelica.Constants.pi/180,
    latitude=location.latitude*Modelica.Constants.pi/180)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  replaceable parameter SolarPowerSystems.Records.Data.Location_UdS location
    constrainedby SolarPowerSystems.Records.Data.Location_UdS annotation (
      Placement(transformation(extent={{-10,70},{10,90}})),
      __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Constant       epochOffset(k=1539817200)
    "The time at the start of the simulation as Epoch in s"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth
    solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    simu_start_epochs=epochOffset.k,
    height_above_sealevel=location.elevation)
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.SolarZenith
    solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    simu_start_epochs=epochOffset.k,
    height_above_sealevel=location.elevation)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
equation
  altitudeOfSun = Modelica.SIunits.Conversions.from_deg(90 - solarZenith.y);
  annotation ();
end SolarPositionVsIrradiance;