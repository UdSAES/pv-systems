within SolarPowerSystems.WIP.FunctionalTests;
model Lukas
  "Calculate the expected power output of a solar array as a function of the global horizontal irradiance and the panel area"
  extends Modelica.Icons.Example;
  replaceable parameter Records.Data.Location_UdS location constrainedby Records.Base.Location
                          annotation (Placement(transformation(extent={{-90,70},
            {-70,90}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Constant       epochOffset(k=1356998400)
    "The time at the start of the simulation as Epoch in s"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
Components.SolarPowerPlants.Lukas solarPlant(
  latitude=location.latitude,
  longitude=location.longitude,
  simu_start_epochs=epochOffset.k,
  height_above_sealevel=location.elevation,
  panel_area=plant.panelArea,
  overall_efficiency=plant.plantEfficiency,
  temp_eta=plant.temp_eta,
  panel_azimuth=plant.panelAzimuth,
  panel_slope=plant.panelTilt,
  surface_albedo=plant.environmentAlbedo,
  module_temperature=plant.moduleTemperature)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Tables.CombiTable1Ds ASWDIR_S__ASWDIFD_S(
    tableOnFile=true,
    tableName="tab1",
    columns={2,3},
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/DHI_GHI_SB_ensheim.txt"))
    "NWP DWD (COSMO-D2)"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Real timeAsEpoch;
  Modelica.Blocks.Continuous.Integrator totalEnergy(k=3.6e-6)
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  replaceable parameter Records.Data.PVplant_TGM_Trina plant constrainedby Records.Base.PVplant
                         annotation (Placement(transformation(extent={{-10,70},
            {10,90}})), __Dymola_choicesAllMatching=true);
equation
  timeAsEpoch = time + epochOffset.y;
  ASWDIR_S__ASWDIFD_S.u = timeAsEpoch;
  connect(ASWDIR_S__ASWDIFD_S.y[2], solarPlant.GHI) annotation (Line(points={{-39,
          0},{-30,0},{-30,8},{-10,8}}, color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[1], solarPlant.DHI) annotation (Line(points={{-39,
          0},{-30,0},{-30,-8},{-9.8,-8}}, color={0,0,127}));
  connect(solarPlant.P, totalEnergy.u) annotation (Line(points={{11.3,7.1},{30,
          7.1},{30,0},{50,0}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-94,8},{-64,-2}},
          lineColor={28,108,200},
          fontSize=12,
          textString="timeAsEpoch"), Text(
          extent={{68,8},{98,-2}},
          lineColor={28,108,200},
          fontSize=12,
          textString="in kWh")}));
end Lukas;
