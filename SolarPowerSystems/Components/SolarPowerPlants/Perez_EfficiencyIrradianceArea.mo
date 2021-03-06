within SolarPowerSystems.Components.SolarPowerPlants;
model Perez_EfficiencyIrradianceArea
  "Anisotropic conversion horizontal to POA irradiance (Perez); efficiency factor model"
  extends Interfaces.PhotoVoltaicPowerPlant(
    redeclare Components.PlantInEnvironment.Perez inclinationAndShadowing(arrayTilt=arrayTilt, arrayAzimuth=
          arrayAzimuth),
    redeclare PhotoVoltaicArray.ModuleOutputDC.EfficiencyIrradianceArea plantIrradianceNormal(
      useHeatPort=true,
      A_PV=panelArea,
      eta_ref=plantEfficiency,
      T_cell_ref=T_cell_ref),
    solarAzimuth(simu_start_epochs=epochOffset),
    solarZenith(simu_start_epochs=epochOffset));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(inclinationAndShadowing.angleOfIncidence, plantIrradianceNormal.angleOfIncidence)
    annotation (Line(points={{-28,-10},{-28,-18},{25,-18},{25,-10}}, color={0,0,127}));
  connect(fixedWindSpeed.y, plantIrradianceNormal.u)
    annotation (Line(points={{-55.6,-40},{29,-40},{29,-10}}, color={0,0,127}));
  connect(windSpeed, plantIrradianceNormal.u)
    annotation (Line(points={{-100,-30},{29,-30},{29,-10}}, color={0,0,127}));

end Perez_EfficiencyIrradianceArea;
