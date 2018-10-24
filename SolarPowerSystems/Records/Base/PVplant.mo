within SolarPowerSystems.Records.Base;
partial record PVplant
  "The parameters of the overall solar power plant (=a specific installation)"
  extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;
  parameter SI.Area panelArea "Overall surface area of all panels (combined)";
  parameter SI.Efficiency plantEfficiency = 0.2 "Overall efficiency";
  parameter SI.Efficiency temp_eta = 0 "??";
  parameter Real panelTilt(unit="deg", min = 0, max = 90) "Surface tilt in degree (Horizontal equals 0°, vertical equals 90°)" annotation(Dialog(group="PV Plant"));
  parameter Real panelAzimuth(unit="deg", min = -180, max = 180) "Surface azimuth in degree (South equals 0°, positive towards east)" annotation(Dialog(group="PV Plant"));
  parameter Real environmentAlbedo = 0.2 "Albedo for isotropic estimation of irradiance by reflection";
  parameter SI.Temp_C moduleTemperature = 25 "Module temperature in degC";
end PVplant;
