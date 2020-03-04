within SolarPowerSystems.Records.Data;
record PVplant_Saarlouis_SW_South "Holtzendorffer Straße 12, 66740 Saarlouis -- facing south"
  extends Base.PVplant(
    panelArea=0.156*0.156*60*268,
    plantEfficiency=0.17,
    panelAzimuth=-8,
    panelTilt=30,
    T_cell_ref=25,
    nsModule=4,
    npModule=67);
end PVplant_Saarlouis_SW_South;
