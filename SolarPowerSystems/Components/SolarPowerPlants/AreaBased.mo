within SolarPowerSystems.Components.SolarPowerPlants;
model AreaBased
  "Model of a solar power plant that computes the expected power output as a function of the direct and diffuse irradiance on the horizontal plane based on the area and orientation of the plant"
  extends Interfaces.PhotoVoltaicPowerPlant(redeclare PlantInEnvironment.None inclinationAndShadowing(arrayTilt=
          arrayTilt, arrayAzimuth=arrayAzimuth),
                          redeclare PhotoVoltaicArray.AreaBased.Danny
      plantIrradianceNormal(
      T=fixedTemperature.T,
      useHeatPort=true,
      T_cell_ref=Modelica.SIunits.Conversions.to_degC(fixedTemperature.T),
      A_PV=panelArea,
      eta_ref=plantEfficiency));

  parameter Modelica.SIunits.Area panelArea "Overall surface area of all panels (combined)" annotation(Dialog(group="PV Plant"));
  parameter Modelica.SIunits.Efficiency plantEfficiency = 0.2 "Overall plant efficiency" annotation(Dialog(group="PV Plant"));
//   parameter Modelica.SIunits.Efficiency temperatureCoefficient=0
//     "Temperature coefficient representing decreasing performance with increasing temperature" annotation(Dialog(group="PV Modules"));
  Modelica.Blocks.Sources.Constant fixedWindSpeed(y(unit="m/s"), k=1)
    annotation (Placement(transformation(extent={{16,-50},{24,-42}})));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(inclinationAndShadowing.angleOfIncidence, plantIrradianceNormal.angleOfIncidence)
    annotation (Line(points={{-28,-10},{-28,-18},{26,-18},{26,-10}}, color={0,0,127}));
  connect(fixedWindSpeed.y, plantIrradianceNormal.u)
    annotation (Line(points={{24.4,-46},{32,-46},{32,-10}}, color={0,0,127}));
  annotation (__Dymola_Commands(file="Scripts/plot20181026detailed.mos" "plot20181026detailed"));
end AreaBased;
