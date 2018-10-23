within SolarPowerSystems.Examples;
model SolarArrayFromNormalIrradiance
  "Calculate the electrical output of a (concentrated) solar array as a function of the global irradiance normal to the panel surface"
  extends Modelica.Icons.Example;
  replaceable parameter Records.Data.Location_UdS location constrainedby
    Records.Base.Location annotation (Placement(transformation(extent={{-90,70},
            {-70,90}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Constant       epochOffset(k=1356998400)
    "The time at the start of the simulation as Epoch in s"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Tables.CombiTable1Ds ASWDIR_S__ASWDIFD_S(
    tableOnFile=true,
    tableName="tab1",
    columns={2,3},
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/DHI_GHI_SB_ensheim.txt"))
    "NWP DWD (COSMO-D2)"
    annotation (Placement(transformation(extent={{70,30},{50,50}})));

  Real timeAsEpoch;
  Modelica.Blocks.Continuous.Integrator totalEnergy(k=3.6e-6)
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  replaceable parameter Records.Data.PVplant_TGM_Trina plantRecord
    constrainedby Records.Base.PVplant annotation (Placement(transformation(
          extent={{-90,30},{-70,50}})),__Dymola_choicesAllMatching=true);
  replaceable Components.SolarPowerPlant.AreaBased.AreaBased plantModel(
    panel_area=plantRecord.panelArea,
    overall_efficiency=plantRecord.plantEfficiency,
    temp_eta=plantRecord.temp_eta,
    module_temperature=plantRecord.moduleTemperature) constrainedby
    Interfaces.PlantIrradianceNormal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-50})), __Dymola_choicesAllMatching=true);
  Components.SolarPosition.SolarAzimuth solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Components.SolarPosition.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  replaceable Components.PlantInEnvironment.Simple environmentModel(
      panel_azimuth=plantRecord.panelAzimuth, panel_slope=plantRecord.panelTilt)
    constrainedby Interfaces.PlantInEnvironment annotation (Placement(
        transformation(extent={{-10,0},{10,20}})), __Dymola_choicesAllMatching=
        true);
  Modelica.Blocks.Sources.Constant albedo(k=plantRecord.environmentAlbedo)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Math.Add3 add3_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-22})));
equation
  timeAsEpoch = time + epochOffset.y;
  ASWDIR_S__ASWDIFD_S.u = timeAsEpoch;
  connect(plantModel.P_DC, totalEnergy.u)
    annotation (Line(points={{0,-60},{0,-80},{8,-80}}, color={0,0,127}));
  connect(solarAzimuth.y, environmentModel.azimuthOfSun) annotation (Line(
        points={{51,80.2},{60,80.2},{60,60},{3,60},{3,20}}, color={0,0,127}));
  connect(solarZenith.y, environmentModel.zenithOfSun) annotation (Line(points=
          {{91,80.2},{96,80.2},{96,58},{7,58},{7,20}}, color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[2], environmentModel.I_diff_horizontal)
    annotation (Line(points={{49,40},{-8.2,40},{-8.2,20}},  color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[1], environmentModel.I_dir_horizontal)
    annotation (Line(points={{49,40},{-5,40},{-5,20}},  color={0,0,127}));
  connect(albedo.y, environmentModel.albedo)
    annotation (Line(points={{-29,40},{-20,40},{-20,26},{-2,26},{-2,20}},
                                                        color={0,0,127}));
  connect(environmentModel.I_diff_inclined, add3_1.u3)
    annotation (Line(points={{-6,0},{-8,0},{-8,-10}}, color={0,0,127}));
  connect(environmentModel.I_dir_inclined, add3_1.u2)
    annotation (Line(points={{0,0},{0,-10}}, color={0,0,127}));
  connect(environmentModel.I_refl_inclined, add3_1.u1)
    annotation (Line(points={{6,0},{8,0},{8,-10}}, color={0,0,127}));
  connect(add3_1.y, plantModel.I_G_normal)
    annotation (Line(points={{0,-33},{0,-40}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{70,50},{100,40}},
          lineColor={28,108,200},
          fontSize=12,
          textString="timeAsEpoch"), Text(
          extent={{26,-72},{56,-82}},
          lineColor={28,108,200},
          fontSize=12,
          textString="in kWh")}));
end SolarArrayFromNormalIrradiance;
