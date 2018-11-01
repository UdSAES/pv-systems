within SolarPowerSystems.Interfaces;
expandable connector ValidationData "Bus for abstracting data sources for validation"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Irradiance globalHorizontalIrradiance "Global horizontal irradiance";
  Modelica.SIunits.Irradiance directHorizontalIrradiance "Direct horizontal irradiance";
  Modelica.SIunits.Irradiance diffuseHorizontalIrradiance "Diffuse horizontal irradiance";
  Modelica.SIunits.Irradiance directNormalIrradiance "Direct normal irradiance";
  Modelica.SIunits.Irradiance globalIrradiancePOA "Global irradiance in plane of array";
  Modelica.SIunits.Power powerDC "Power at the DC side";
  Modelica.SIunits.ReactivePower powerAC "Power at the AC side";
  Modelica.SIunits.Velocity windSpeed "Wind speed in m/s";
  Modelica.SIunits.Temp_K ambientTemperature "Ambient temperature in K";
end ValidationData;
