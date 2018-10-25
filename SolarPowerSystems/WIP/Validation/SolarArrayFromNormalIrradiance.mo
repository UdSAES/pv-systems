within SolarPowerSystems.WIP.Validation;
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
    annotation (Placement(transformation(extent={{70,40},{50,60}})));

  Real timeAsEpoch;
  Modelica.Blocks.Continuous.Integrator totalEnergy(k=3.6e-6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-78})));
  replaceable parameter Records.Data.PVplant_TGM_Trina plantRecord
    constrainedby Records.Base.PVplant annotation (Placement(transformation(
          extent={{-90,40},{-70,60}})),__Dymola_choicesAllMatching=true);
  Components.PhotoVoltaicArray.AreaBased.AreaBased plantModelAreaBased(
    panel_area=plantRecord.panelArea,
    overall_efficiency=plantRecord.plantEfficiency,
    temp_eta=plantRecord.temp_eta,
    module_temperature=plantRecord.moduleTemperature) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-50})), __Dymola_choicesAllMatching=true);
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=location.latitude,
    longitude=location.longitude,
    height_above_sealevel=location.elevation,
    simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  replaceable Components.PlantInEnvironment.Simple environmentModel(
      surfaceAzimuth=plantRecord.panelAzimuth, surfaceTilt=plantRecord.panelTilt)
    constrainedby Interfaces.PlantInEnvironment annotation (Placement(
        transformation(extent={{-10,6},{10,26}})), __Dymola_choicesAllMatching=
        true);
  Modelica.Blocks.Sources.Constant albedo(k=plantRecord.environmentAlbedo)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Math.Add3 add3_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-14})));
  Modelica.Blocks.Continuous.Integrator totalEnergy1(k=3.6e-6)
    annotation (Placement(transformation(extent={{-10,-96},{-30,-76}})));
  Components.PhotoVoltaicArray.ModuleBased.ModuleBased plantModelModuleBased(
    useHeatPort=false,
    T=plantRecord.moduleTemperature,
    redeclare PhotoVoltaics.Records.TSM_230_PC05 moduleData,
    nsModule=8,
    npModule=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-50})), __Dymola_choicesAllMatching=true);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-6,-86},{6,-74}})));
  PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
    Placement(transformation(extent={{46,-70},{66,-50}})));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(
    samplePeriod=10,
    VmpRef=plantModelModuleBased.nsModule*plantModelModuleBased.moduleData.VmpRef,
    ImpRef=plantModelModuleBased.npModule*plantModelModuleBased.moduleData.ImpRef)
    annotation (Placement(transformation(extent={{26,-96},{46,-76}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundAC annotation (
    Placement(transformation(extent={{74,-100},{94,-80}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(start=0, fixed=true))                                                                                 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={84,-60})));
equation
  timeAsEpoch = time + epochOffset.y;
  ASWDIR_S__ASWDIFD_S.u = timeAsEpoch;
  connect(plantModelAreaBased.P_DC, totalEnergy.u)
    annotation (Line(points={{-70,-60},{-70,-66}}, color={0,0,127}));
  connect(solarAzimuth.y, environmentModel.azimuthOfSun) annotation (Line(
        points={{51,80.2},{60,80.2},{60,70},{3,70},{3,26}}, color={0,0,127}));
  connect(solarZenith.y, environmentModel.zenithOfSun) annotation (Line(points={{91,80.2},
          {96,80.2},{96,68},{7,68},{7,26}},            color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[1], environmentModel.I_diff_horizontal)
    annotation (Line(points={{49,50},{-5,50},{-5,26}},      color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[2], environmentModel.I_dir_horizontal)
    annotation (Line(points={{49,50},{-2,50},{-2,26}},  color={0,0,127}));
  connect(albedo.y, environmentModel.albedo)
    annotation (Line(points={{-29,50},{-8,50},{-8,26}}, color={0,0,127}));
  connect(environmentModel.I_dir_inclined, add3_1.u2)
    annotation (Line(points={{0,6},{0,-2},{2.22045e-15,-2}},
                                             color={0,0,127}));
  connect(environmentModel.I_refl_inclined, add3_1.u1)
    annotation (Line(points={{6,6},{8,6},{8,-2}},  color={0,0,127}));
  connect(add3_1.y, plantModelAreaBased.I_G_normal) annotation (Line(points={{
          -2.22045e-15,-25},{-2.22045e-15,-34},{-70,-34},{-70,-40}}, color={0,0,
          127}));
  connect(environmentModel.I_diff_inclined, add3_1.u3)
    annotation (Line(points={{-6,6},{-8,6},{-8,-2}}, color={0,0,127}));
  connect(plantModelModuleBased.P_DC, totalEnergy1.u)
    annotation (Line(points={{20,-60},{20,-86},{-8,-86}}, color={0,0,127}));
  connect(mpTracker.vRef,converter. vDCRef) annotation (
    Line(points={{47,-86},{50,-86},{50,-72}},        color = {0, 0, 127}));
  connect(converter.ac_n,groundAC. pin) annotation (
    Line(points={{66,-70},{66,-80},{84,-80}},        color = {85, 170, 255}));
  connect(groundAC.pin,voltageSource. pin_n) annotation (
    Line(points={{84,-80},{84,-70}},                 color = {85, 170, 255}));
  connect(converter.ac_p,voltageSource. pin_p) annotation (
    Line(points={{66,-50},{66,-40},{84,-40},{84,-50}},             color = {85, 170, 255}));
  connect(plantModelModuleBased.P_DC, mpTracker.power)
    annotation (Line(points={{20,-60},{20,-86},{24,-86}}, color={0,0,127}));
  connect(ground.p, plantModelModuleBased.n1)
    annotation (Line(points={{0,-74},{0,-50},{10,-50}}, color={0,0,255}));
  connect(plantModelModuleBased.p1, converter.dc_p)
    annotation (Line(points={{30,-50},{46,-50}}, color={0,0,255}));
  connect(converter.dc_n, plantModelModuleBased.n1) annotation (Line(points={{
          46,-70},{0,-70},{0,-50},{10,-50}}, color={0,0,255}));
  connect(plantModelModuleBased.nv1, plantModelModuleBased.n1) annotation (Line(
        points={{25,-60},{26,-60},{26,-70},{0,-70},{0,-50},{10,-50}}, color={0,
          0,255}));
  connect(add3_1.y, plantModelModuleBased.I_G_normal) annotation (Line(points={
          {0,-25},{0,-34},{20,-34},{20,-40}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{70,60},{100,50}},
          lineColor={28,108,200},
          fontSize=12,
          textString="timeAsEpoch"), Text(
          extent={{-62,-88},{-32,-98}},
          lineColor={28,108,200},
          fontSize=12,
          textString="in kWh"),      Text(
          extent={{-74,-78},{-44,-88}},
          lineColor={28,108,200},
          fontSize=12,
          textString="in kWh")}),
          experiment(StopTime=86400, Interval=1),
    __Dymola_Commands(file="Scripts/plotIrradiance.mos" "plotIrradiance"));
end SolarArrayFromNormalIrradiance;
