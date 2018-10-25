within SolarPowerSystems.WIP;
model AreaBasedNoInclination
  "Model of a solar power plant that computes the expected power output as a function of the global irradiance normal to the PV array based on its area"
  extends Interfaces.PhotoVoltaicPowerPlant(
                                 redeclare Components.PlantInEnvironment.None inclinationAndShadowing(
        surfaceTilt=Modelica.SIunits.Conversions.from_deg(panelTilt),
        surfaceAzimuth=Modelica.SIunits.Conversions.from_deg(panelAzimuth)),
                          redeclare
      Components.PhotoVoltaicArray.AreaBased.AreaBased plantIrradianceNormal(
      panel_area=panelArea,
      overall_efficiency=plantEfficiency,
      temp_eta=temperatureCoefficient,
      useHeatPort=useTemperatureInput,
      T=fixedTemperature.T));

  parameter Modelica.SIunits.Area panelArea "Overall surface area of all panels (combined)" annotation(Dialog(group="PV Plant"));
  parameter Modelica.SIunits.Efficiency plantEfficiency = 0.2 "Overall plant efficiency" annotation(Dialog(group="PV Plant"));
  parameter Modelica.SIunits.Efficiency temperatureCoefficient=0
    "Temperature coefficient representing decreasing performance with increasing temperature" annotation(Dialog(group="PV Modules"));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
end AreaBasedNoInclination;
