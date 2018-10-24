within SolarPowerSystems.Records.Data;
record PVplant_TGM_Trina "The smaller PV plant on the roof of TGM in Vienna"
  extends Base.PVplant(
    panelArea=1.650*0.992*8,
    plantEfficiency=0.141,
    panelAzimuth=0,
    panelTilt=10);
end PVplant_TGM_Trina;
