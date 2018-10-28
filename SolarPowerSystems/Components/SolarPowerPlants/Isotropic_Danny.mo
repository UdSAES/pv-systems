within SolarPowerSystems.Components.SolarPowerPlants;
model Isotropic_Danny
  "Model of a solar power plant that computes the expected power output as a function of the direct and diffuse horizontal irradiance based on the area and orientation of the plant"
  extends Interfaces.PhotoVoltaicPowerPlant(redeclare PlantInEnvironment.Isotropic
                                                                              inclinationAndShadowing(arrayTilt=
          arrayTilt, arrayAzimuth=arrayAzimuth),
                          redeclare PhotoVoltaicArray.AreaBased.Danny
      plantIrradianceNormal(
      useHeatPort=true,
      A_PV=panelArea,
      eta_ref=plantEfficiency,
      T_cell_ref=T_cell_ref));

  parameter Modelica.SIunits.Area panelArea "Overall surface area of all panels (combined)" annotation(Dialog(group="PV Plant"));
  parameter Modelica.SIunits.Efficiency plantEfficiency = 0.2 "Overall plant efficiency" annotation(Dialog(group="PV Plant"));

  parameter Modelica.SIunits.Temp_C T_cell_ref "PV cell temperature at reference conditions (usually STC)" annotation(Dialog(group="PV Modules"));
  Modelica.Blocks.Interfaces.RealInput directNormalIrradiance1 "Direct normal irradiance" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-36,100})));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(inclinationAndShadowing.angleOfIncidence, plantIrradianceNormal.angleOfIncidence)
    annotation (Line(points={{-28,-10},{-28,-18},{25,-18},{25,-10}}, color={0,0,127}));
  connect(fixedWindSpeed.y, plantIrradianceNormal.u)
    annotation (Line(points={{-55.6,-40},{29,-40},{29,-10}}, color={0,0,127}));
  connect(windSpeed, plantIrradianceNormal.u) annotation (Line(points={{-100,-50},{29,-50},{29,-10}}, color={0,0,127}));
  connect(inclinationAndShadowing.directNormalIrradiance, directNormalIrradiance1)
    annotation (Line(points={{-36,10},{-36,100}}, color={0,0,127}));
  annotation (__Dymola_Commands(file="Scripts/plot20181026detailed.mos" "plot20181026detailed"));
end Isotropic_Danny;
