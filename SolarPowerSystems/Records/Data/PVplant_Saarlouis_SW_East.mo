within SolarPowerSystems.Records.Data;
record PVplant_Saarlouis_SW_East "Holtzendorffer Straße 12, 66740 Saarlouis -- facing east"
  extends Base.PVplant(
    panelArea=0.156*0.156*60*87,
    plantEfficiency=0.17,
    panelAzimuth=45,
    panelTilt=17,
    T_cell_ref=25,
    nsModule=1,
    npModule=87);
end PVplant_Saarlouis_SW_East;
