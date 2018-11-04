within SolarPowerSystems.Records.Data;
record PVplant_TGM_Trina "The larger PV plant on the roof of TGM in Vienna"
  extends Base.PVplant(
    panelArea=1.650*0.992*8,
    plantEfficiency=0.141,
    panelAzimuth=0,
    panelTilt=10,
    T_cell_ref=25,
    nsModule=8,
    npModule=1);
end PVplant_TGM_Trina;
