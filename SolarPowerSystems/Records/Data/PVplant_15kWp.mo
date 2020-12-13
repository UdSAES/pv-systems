within SolarPowerSystems.Records.Data;
record PVplant_15kWp "Fictive PV plant used throughout examples and unit tests"
  extends Base.PVplant(
    panelTilt=30,
    panelAzimuth=0,
    panelArea=64*216*1/100,
    T_cell_ref=25);
end PVplant_15kWp;
