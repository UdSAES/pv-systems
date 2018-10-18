within SolarPowerSystems.Records.Data;
record PVplant_TGM_Trina "The smaller PV plant on the roof of TGM in Vienna"
  extends Base.PVplant(
    panelArea=10,
    panelAzimuth=Modelica.SIunits.Conversions.from_deg(0),
    panelTilt=Modelica.SIunits.Conversions.from_deg(0));
                    // value actually unknown!!
end PVplant_TGM_Trina;
