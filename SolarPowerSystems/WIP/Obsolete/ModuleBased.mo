within SolarPowerSystems.WIP.Obsolete;
model ModuleBased
  "Calculate the electrical output of a solar array as a function of the direct and diffuse irradiance on a horizontal plane"
  extends Modelica.Icons.Example;
  replaceable parameter Records.Data.Location_UdS location constrainedby Records.Base.Location
                          annotation (Placement(transformation(extent={{-90,70},
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
    annotation (Placement(transformation(extent={{-50,-96},{-70,-76}})));
  replaceable parameter Records.Data.PVplant_TGM_Trina plantRecord
    constrainedby Records.Base.PVplant annotation (Placement(transformation(
          extent={{-90,30},{-70,50}})),__Dymola_choicesAllMatching=true);
  Components.PhotoVoltaicArray.ModuleBased.PhotoVoltaicsLib plantModel(useHeatPort=false, T=plantRecord.moduleTemperature)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-50})), __Dymola_choicesAllMatching=true);
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
  replaceable Obsolete.Simple environmentModel(surfaceAzimuth=plantRecord.panelAzimuth, surfaceTilt=plantRecord.panelTilt)
    constrainedby Interfaces.PlantInEnvironment
    annotation (Placement(transformation(extent={{-10,0},{10,20}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Constant albedo(k=plantRecord.environmentAlbedo)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Math.Add3 add3_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-22})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-26,-86},{-14,-74}})));
  PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
    Placement(transformation(extent={{26,-70},{46,-50}})));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(
    samplePeriod=10,
    VmpRef=plantModel.nsModule*plantModel.moduleData.VmpRef,
    ImpRef=plantModel.npModule*plantModel.moduleData.ImpRef)                                                                                                 annotation (
    Placement(transformation(extent={{6,-96},{26,-76}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundAC annotation (
    Placement(transformation(extent={{54,-100},{74,-80}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(start=0, fixed=true))                                                                                 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={64,-60})));
equation
  timeAsEpoch = time + epochOffset.y;
  ASWDIR_S__ASWDIFD_S.u = timeAsEpoch;
  connect(plantModel.P_DC, totalEnergy.u)
    annotation (Line(points={{0,-60},{0,-86},{-48,-86}},
                                                       color={0,0,127}));
  connect(solarAzimuth.y,environmentModel.solarAzimuth)  annotation (Line(
        points={{51,80.2},{60,80.2},{60,60},{10,60},{10,4}},color={0,0,127}));
  connect(solarZenith.y,environmentModel.solarZenith)  annotation (Line(points={{91,80.2},{96,80.2},{96,58},{10,58},{10,
          8}},                                         color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[1], environmentModel.diffuseHorizontalIrradiance)
    annotation (Line(points={{49,40},{0,40},{0,20}},   color={0,0,127}));
  connect(ASWDIR_S__ASWDIFD_S.y[2], environmentModel.directHorizontalIrradiance)
    annotation (Line(points={{49,40},{6,40},{6,20}},   color={0,0,127}));
  connect(albedo.y, environmentModel.albedo)
    annotation (Line(points={{-29,40},{-20,40},{-20,26},{-6,26},{-6,20}},
                                                        color={0,0,127}));
  connect(environmentModel.diffuseInclinedIrradiance, add3_1.u3)
    annotation (Line(points={{0,0},{-8,0},{-8,-10}},  color={0,0,127}));
  connect(environmentModel.directInclinedIrradiance, add3_1.u2)
    annotation (Line(points={{6,0},{6,-6},{0,-6},{0,-10}},
                                             color={0,0,127}));
  connect(environmentModel.reflectedInclinedIrradiance, add3_1.u1)
    annotation (Line(points={{-6,0},{8,0},{8,-10}},color={0,0,127}));
  connect(add3_1.y, plantModel.I_G_normal)
    annotation (Line(points={{0,-33},{0,-40}}, color={0,0,127}));
  connect(mpTracker.vRef,converter. vDCRef) annotation (
    Line(points={{27,-86},{30,-86},{30,-72}},        color = {0, 0, 127}));
  connect(converter.ac_n,groundAC. pin) annotation (
    Line(points={{46,-70},{46,-80},{64,-80}},        color = {85, 170, 255}));
  connect(groundAC.pin,voltageSource. pin_n) annotation (
    Line(points={{64,-80},{64,-70}},                 color = {85, 170, 255}));
  connect(converter.ac_p,voltageSource. pin_p) annotation (
    Line(points={{46,-50},{46,-40},{64,-40},{64,-50}},             color = {85, 170, 255}));
  connect(plantModel.P_DC, mpTracker.power)
    annotation (Line(points={{0,-60},{0,-86},{4,-86}}, color={0,0,127}));
  connect(ground.p, plantModel.n1)
    annotation (Line(points={{-20,-74},{-20,-50},{-10,-50}}, color={0,0,255}));
  connect(plantModel.p1, converter.dc_p)
    annotation (Line(points={{10,-50},{26,-50}}, color={0,0,255}));
  connect(converter.dc_n, plantModel.n1) annotation (Line(points={{26,-70},{-20,
          -70},{-20,-50},{-10,-50}}, color={0,0,255}));
  connect(plantModel.nv1, plantModel.n1) annotation (Line(points={{5,-60},{6,
          -60},{6,-70},{-20,-70},{-20,-50},{-10,-50}}, color={0,0,255}));
  annotation (Diagram(graphics={Text(
          extent={{70,50},{100,40}},
          lineColor={28,108,200},
          fontSize=12,
          textString="timeAsEpoch"), Text(
          extent={{-94,-78},{-64,-88}},
          lineColor={28,108,200},
          fontSize=12,
          textString="in kWh")}),
          experiment(StopTime=86400, Interval=1),
    __Dymola_Commands(file="Scripts/plotIrradiance.mos" "plotIrradiance"));
end ModuleBased;