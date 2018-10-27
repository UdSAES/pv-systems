within SolarPowerSystems.Records.Data;
record Module_ASE300DGF50_270W "Schott ASE-300-DGF/50 module, values for 280W from datasheet"
  extends PhotoVoltaics.Records.ModuleData(
    moduleName = "ASE-300-DGF/50_270W",
    TRef = Modelica.SIunits.Conversions.from_degC(25),
    irradianceRef = 1000,
    VocRef = 61.9,
    IscRef = 6.2,
    VmpRef = 49.6,
    ImpRef = 5.7,
    alphaIsc = + 0.10/100,
    alphaVoc = - 0.38/100,
    ns = 216,
    nb = 12);
end Module_ASE300DGF50_270W;
