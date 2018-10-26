within SolarPowerSystems.Components.SolarPowerPlants;
model AreaBased
  "Model of a solar power plant that computes the expected power output as a function of the direct and diffuse irradiance on the horizontal plane based on the area and orientation of the plant"
  extends Interfaces.PhotoVoltaicPowerPlant(redeclare PlantInEnvironment.Simple
      inclinationAndShadowing(surfaceTilt=Modelica.SIunits.Conversions.from_deg(
          panelTilt), surfaceAzimuth=Modelica.SIunits.Conversions.from_deg(
          panelAzimuth)), redeclare PhotoVoltaicArray.AreaBased.Lukas
      plantIrradianceNormal(
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
end AreaBased;
