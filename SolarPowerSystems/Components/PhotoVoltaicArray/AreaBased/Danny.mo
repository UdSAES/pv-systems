within SolarPowerSystems.Components.PhotoVoltaicArray.AreaBased;
model Danny "TRNSYS Type 835 mode 2, using Faiman-model (Danny)"
  extends Interfaces.PhotoVoltaicArray;

  parameter Modelica.SIunits.Area A_PV "The total area of the PV modules";
  parameter Modelica.SIunits.Efficiency eta_ref "Electrical efficiency at reference conditions (gross area)";
  parameter Real b0 = 0.07 "Constant for IAM" annotation(Dialog(group="Incidence angle losses"));
  parameter Real a(final unit="m2/W") = -0.0000109 "compare Jonas et al. 2018, tab. 2" annotation(Dialog(group="Irradiance losses"));
  parameter Real b = -0.047 "compare Jonas et al. 2018, tab. 2" annotation(Dialog(group="Irradiance losses"));
  parameter Real c = -1.4 "compare Jonas et al. 2018, tab. 2" annotation(Dialog(group="Irradiance losses"));
  parameter Modelica.SIunits.Temp_C T_cell_ref "PV cell temperature at reference conditions (usually STC)" annotation(Dialog(group="Temperature dependency"));
  parameter Real beta(final unit="1/K") = 0.43/100 "Power temperature coefficient" annotation(Dialog(group="Temperature dependency"));
  parameter Real U_0(final unit="W/(m2.K)") = 25 "Coefficient accounting for heating by radiation" annotation(Dialog(group="Temperature dependency"));
  parameter Real U_1(final unit="W.s/(m3.K)") = 6.84 "Coefficient accounting for cooling by wind" annotation(Dialog(group="Temperature dependency"));

  Modelica.SIunits.Power electricalPower "Electrical power output";
  Modelica.SIunits.Irradiance G "Global irradiance on the PV array plane";
  Modelica.SIunits.Efficiency eta_electrical "Overall or total electrical efficiency";
  Modelica.SIunits.Efficiency performanceRatioOverall "Overall instantaneous performance ratio";
  Modelica.SIunits.Efficiency performanceRatioIrradiance "Instantaneous performance ratio due to irradiance losses";
  Modelica.SIunits.Efficiency performanceRatioTemperature "Instantaneous performance ratio to account for temperature dependency";
  Modelica.SIunits.Temp_C T_cell "PV cell temperature";
  Modelica.Blocks.Interfaces.RealInput u(final unit="m/s") "Wind speed in PV plane"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.SIunits.Efficiency performanceRatioIAM "Instantaneous performance ratio due to incidence angle losses";
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(final unit="rad") "Angle between direct beam and surface normal"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
equation
  // Electrical power output and overall efficiency
  eta_electrical = eta_ref * performanceRatioOverall;
  electricalPower = eta_electrical * G * A_PV;
  performanceRatioOverall = performanceRatioIAM * performanceRatioIrradiance * performanceRatioTemperature;

  // Incidence angle losses
  performanceRatioIAM = 1; //1 + b0*(1/cos(angleOfIncidence) - 1); // Division by Zero!!

  // Irradiance losses
  performanceRatioIrradiance = a*G + b*log(G + 1) + c*((log(G + Modelica.Constants.e))^2 / (G + 1) - 1);

  // Temperature dependency
  performanceRatioTemperature = 1 - beta*(T_cell - T_cell_ref);
  T_cell = Modelica.SIunits.Conversions.to_degC(internalHeatPort.T) + G/(U_0 + U_1*u); // Faiman 2008

  // Input-Output-Mapping
  G = I_G_normal;
  P_DC = electricalPower;

end Danny;
