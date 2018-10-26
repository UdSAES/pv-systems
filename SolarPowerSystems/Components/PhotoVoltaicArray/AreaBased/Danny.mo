within SolarPowerSystems.Components.PhotoVoltaicArray.AreaBased;
model Danny "TRNSYS Type 835 mode 2 (Danny)"
  extends Interfaces.PhotoVoltaicArray;

  parameter Modelica.SIunits.Area A_PV "The total area of the PV modules";
  parameter Modelica.SIunits.Efficiency eta_ref "Electrical efficiency at reference conditions (gross area)";
  parameter Real a(final unit="m2/W") = -0.0000109 annotation(Dialog(group="Irradiance losses"));
  parameter Real b = -0.047 annotation(Dialog(group="Irradiance losses"));
  parameter Real c = -1.4 annotation(Dialog(group="Irradiance losses"));

  Modelica.SIunits.Power electricalPower "Electrical power output";
  Modelica.SIunits.Irradiance G "Global irradiance on the PV array plane";
  Modelica.SIunits.Efficiency eta_electrical "Overall or total electrical efficiency";
  Modelica.SIunits.Efficiency performanceRatioOverall "Overall instantaneous performance ratio";
  Modelica.SIunits.Efficiency performanceRatioIrradiance "Instantaneous performance ratio due to irradiance losses";

equation
  eta_electrical = eta_ref * performanceRatioOverall;
  electricalPower = eta_electrical * G * A_PV;
  performanceRatioOverall = performanceRatioIrradiance;

  // Irradiance losses
  performanceRatioIrradiance = a*G + b*log(G + 1) + c*((log(G + Modelica.Constants.e))^2 / (G + 1) - 1);

  // Input-Output-Mapping
  G = I_G_normal;
  P_DC = electricalPower;

end Danny;
