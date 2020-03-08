within SolarPowerSystems.Records.Data;
record PVplant_Saarlouis_TH
  "PV system on top of the town hall in Saarlouis"
  extends Base.PVplant(
    panelArea=0.156*0.156*60*156,
    plantEfficiency=0.17,
    panelAzimuth=47,
    panelTilt=28,
    T_cell_ref=25,
    nsModule=6,
    npModule=26);
end PVplant_Saarlouis_TH;
