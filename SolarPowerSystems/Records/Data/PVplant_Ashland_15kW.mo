within SolarPowerSystems.Records.Data;
record PVplant_Ashland_15kW
  "Record representing the 15kW PV array on the roof of police department in Ashland, OR"
  extends Base.PVplant(
    panelArea=64*216*1/100,
    plantEfficiency=280/(1000*panelArea/64),
    panelTilt=15,
    panelAzimuth=0,
    T_cell_ref=25);
end PVplant_Ashland_15kW;
