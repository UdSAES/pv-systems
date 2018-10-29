within SolarPowerSystems.Records.Data;
record PVplant_Ashland_15kW
  "Record representing the fifteen kW solar electric array on the roof of police headquarters in Ashland, Oregon"
  extends Base.PVplant(
    panelArea=64*216*1/100,
    plantEfficiency=280/(1000*panelArea/64),
    panelTilt=15,
    panelAzimuth=0);
end PVplant_Ashland_15kW;
