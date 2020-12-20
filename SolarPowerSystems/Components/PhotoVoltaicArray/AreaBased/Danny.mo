within SolarPowerSystems.Components.PhotoVoltaicArray.AreaBased;
model Danny "PV power output as a function of a varying efficiency factor, global POA irradiance and total area"
  extends Interfaces.PhotoVoltaicArray;

  parameter Modelica.SIunits.Area A_PV "The total area of the PV modules";
  parameter Modelica.SIunits.Efficiency eta_ref "Electrical efficiency at reference conditions";
  parameter Real a(final unit="m2/W") = -0.0000109 "Irradiance losses according to Heydenreich et al. (2008, equation 3); parameter a"
    annotation (Dialog(group="Irradiance losses"));
  parameter Real b=-0.047 "Irradiance losses according to Heydenreich et al. (2008, equation 3); parameter b" annotation (Dialog(group="Irradiance losses"));
  parameter Real c=-1.4 "Irradiance losses according to Heydenreich et al. (2008, equation 3); parameter c" annotation (Dialog(group="Irradiance losses"));
  parameter Modelica.SIunits.Temp_C T_cell_ref "PV cell temperature at reference conditions (usually STC)"
    annotation (Dialog(group="Temperature dependency"));
  parameter Real beta(final unit="1/K") = 0.43/100 "Power temperature coefficient"
    annotation (Dialog(group="Temperature dependency"));
  parameter Real U_0(final unit="W/(m2.K)") = 25 "Heat loss coefficient of the PV module"
    annotation (Dialog(group="Temperature dependency"));
  parameter Real U_1(final unit="W.s/(m3.K)") = 6.84 "Wind dependent heat loss coefficient of the PV module"
    annotation (Dialog(group="Temperature dependency"));

  Modelica.SIunits.Power electricalPower "Electrical power output";
  Modelica.SIunits.Irradiance G "Global irradiance on the PV array plane";
  Modelica.SIunits.Efficiency eta_electrical "Overall or total electrical efficiency";
  Modelica.SIunits.Efficiency performanceRatioOverall "Overall instantaneous performance ratio";
  Modelica.SIunits.Efficiency performanceRatioIrradiance
    "Instantaneous performance ratio due to irradiance losses";
  Modelica.SIunits.Efficiency performanceRatioTemperature
    "Instantaneous performance ratio to account for temperature dependency";
  Modelica.SIunits.Temp_C T_cell "PV cell temperature";
  Modelica.SIunits.Efficiency performanceRatioIAM
    "Instantaneous performance ratio due to incidence angle losses";

  ReflectionLosses.PhysicalIAMmodel physicalIAMmodel
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  // Electrical power output and overall efficiency
  eta_electrical = eta_ref*performanceRatioOverall;
  electricalPower = eta_electrical*G*A_PV;
  performanceRatioOverall = performanceRatioIAM*performanceRatioIrradiance*performanceRatioTemperature;

  // Physical IAM model
  performanceRatioIAM = physicalIAMmodel.incidenceAngleModifier;

  // Irradiance losses (Heydenreich et al., 2008)
  performanceRatioIrradiance = a*G + b*log(G + 1) + c*((log(G + Modelica.Constants.e))^2/(G + 1) - 1);

  // Temperature dependency (Faiman (2008, equation 5))
  performanceRatioTemperature = 1 - beta*(T_cell - T_cell_ref);
  T_cell = Modelica.SIunits.Conversions.to_degC(internalHeatPort.T) + G/(U_0 + U_1*u);

  // Input-Output-Mapping
  G = I_G_normal;
  P_DC = electricalPower;

  connect(angleOfIncidence, physicalIAMmodel.angleOfIncidence)
    annotation (Line(points={{-100,70},{-60,70}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{4,74},{98,56}},
          lineColor={28,108,200},
          textString="Non-graphical implementation (see text layer)")}), Documentation(info="<html>
<p><br>This model calculates the power output of a PV array as a function of a varying efficiency factor, global POA irradiance and total area. It is an implementation of the TRNSYS Type 835 PV model by Jonas et al. (2018); with the exception that the ASHRAE IAM model has been replaced by the <a href=\"modelica://SolarPowerSystems.Components.PhotoVoltaicArray.ReflectionLosses.PhysicalIAMmodel\">physical IAM model</a>.</p>
<p>The original implementation of TRNSYS Type 835 in Fortran is available on GitHub via the DOI <a href=\"https://doi.org/10.5281/zenodo.1446414\">10.5281/zenodo.1446414</a>.</p>
<h4>References</h4>
<p>Faiman, D. (2008). Assessing the Outdoor Operating Temperature of Photovoltaic Modules. Progress in Photovoltaics: Research and Applications 16, 307&ndash;315. <a href=\"https://doi.org/10.1002/pip.813
\">doi:10.1002/pip.813</a></p>
<p>Heydenreich, W., M&uuml;ller, B., and Reise, C. (2008). Describing the World with Three Parameters: A new approach to PV Module Power Modelling. 23rd European Photovoltaic Solar Energy Conference and Exhibition, 1-5 September 2008, Valencia, Spain; 2786-2789 <a href=\"https://doi.org/10.4229/23rdeupvsec2008-4do.9.4\">doi:10.4229/23rdeupvsec2008-4do.9.4</a></p>
<p>Jonas, D., Theis, D., and Frey, G. (2018). Implementation and Experimental Validation of a Photovoltaic- thermal (PVT) Collector Model in TRNSYS. In Proceedings of the 12th International Conference on Solar Energy for Buildings and Industry (EuroSun2018) (International Solar Energy Society). <a href=\"https://doi.org/10.18086/eurosun2018.02.16\">doi:10.18086/eurosun2018.02.16</a></p>
<p>Jonas, D., L&auml;mmle, M., Theis, D. Schneider, S. and Frey, G. (2019). Performance modeling of PVT collectors: Implementation, validation and parameter identification approach using TRNSYS. Solar Energy 193, 51-64. <a href=\"https://doi.org/10.1016/j.solener.2019.09.047\">doi:10.1016/j.solener.2019.09.047</a></p>
</html>"));
end Danny;
