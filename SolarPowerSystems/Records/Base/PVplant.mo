within SolarPowerSystems.Records.Base;
partial record PVplant
  "The parameters of the overall solar power plant (=a specific installation)"
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  parameter String fileName = "noFile" "Filepath to external file storing actual data";

  parameter SI.Area panelArea "Overall surface area of all panels (combined)";
  parameter SI.Efficiency plantEfficiency = 0.2 "Overall efficiency";
  parameter SI.Temp_C T_cell_ref "PV cell temperature at reference conditions (usually STC)";
  parameter Real panelTilt(unit="deg", min = 0, max = 90) "Surface tilt in degree (Horizontal equals 0°, vertical equals 90°)";
  parameter Real panelAzimuth(unit="deg", min = -180, max = 180) "Surface azimuth in degree (South equals 0°, positive towards east)";
  parameter Real environmentAlbedo(min=0, max=1) = 0.2 "Albedo for isotropic estimation of irradiance by reflection";
  parameter Integer nsModule = 1 "Number of series connected modules";
  parameter Integer npModule = 1 "Number of parallel connected modules";
end PVplant;
