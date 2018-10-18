within SolarPowerSystems.Records.Base;
partial record PVplant
  "The parameters of the overall solar power plant (=a specific installation)"
  extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;
  parameter SI.Area panelArea "Overall surface area of all panels (combined)";
  parameter SI.Efficiency plantEfficiency = 0.2 "Overall efficiency";
  parameter SI.Efficiency temp_eta = 0 "??";
  parameter SI.Angle panelAzimuth "Surface azimuth in rad (South equals 0, positive towards east)";
  parameter SI.Angle panelTilt "Surface tilt in rad (horizontal equals 0, vertical equals pi/2)";
  parameter Real environmentAlbedo = 0.2 "Albedo for isotropic estimation of irradiance by reflection";
  parameter SI.Temp_C moduleTemperature = 25 "Module temperature in degC";
end PVplant;
