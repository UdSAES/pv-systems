within SolarPowerSystems.Components.SolarPowerPlants;
model None_PhotoVoltaicsLib
  "Model of a solar power plant that computes the electrical output as a function of the global irradiance on the plant based on a diode model and plant orientation"
  extends Interfaces.PhotoVoltaicPowerPlant(redeclare Components.PlantInEnvironment.None inclinationAndShadowing(
        arrayTilt=arrayTilt, arrayAzimuth=arrayAzimuth), redeclare
      Components.PhotoVoltaicArray.ModuleBased.PhotoVoltaicsLib plantIrradianceNormal(
      useHeatPort=true,
      moduleData=moduleData,
      T=298.15,
      nsModule=nsModule,
      npModule=npModule));

  //    Modelica.Blocks.Interfaces.RealOutput powerAC
  //      "The generated power on the AC side"
  //      annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  //    Modelica.Blocks.Interfaces.RealOutput totalEnergyAC
  //      "The generated energy on the AC side"
  //      annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  //   Modelica.Blocks.Continuous.Integrator integrator1(k=3.6e-6)
  //     annotation (Placement(transformation(extent={{64,-90},{84,-70}})));
  PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(start=0, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundAC
    annotation (Placement(transformation(extent={{80,-38},{100,-18}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(visible=true, transformation(
        origin={34,-24},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(
    samplePeriod=10,
    VmpRef=plantIrradianceNormal.nsModule*plantIrradianceNormal.moduleData.VmpRef,
    ImpRef=plantIrradianceNormal.npModule*plantIrradianceNormal.moduleData.ImpRef) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={58,-40})));
  replaceable parameter PhotoVoltaics.Records.ModuleData moduleData constrainedby PhotoVoltaics.Records.ModuleData
                                     annotation (
    Placement(transformation(extent={{10,72},{30,92}})),
    Dialog(group="PV Modules"),
    __Dymola_choicesAllMatching=true);
  parameter Integer nsModule=64 "Number of series connected modules" annotation (Dialog(group="PV Plant"));
  parameter Integer npModule=1 "Number of parallel connected modules" annotation (Dialog(group="PV Plant"));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(plantIrradianceNormal.p1, converter.dc_p)
    annotation (Line(points={{32,10},{32,18},{60,18},{60,10}}, color={0,0,255}));
  connect(converter.dc_n, plantIrradianceNormal.n1)
    annotation (Line(points={{60,-10},{60,-18},{32,-18},{32,-10}}, color={0,0,255}));
  connect(converter.ac_p, voltageSource.pin_p)
    annotation (Line(points={{80,10},{80,18},{90,18},{90,10}}, color={85,170,255}));
  connect(voltageSource.pin_n, groundAC.pin) annotation (Line(points={{90,-10},{90,-18}}, color={85,170,255}));
  connect(converter.ac_n, groundAC.pin)
    annotation (Line(points={{80,-10},{80,-18},{90,-18}}, color={85,170,255}));
  connect(converter.dc_n, ground.p) annotation (Line(points={{60,-10},{60,-18},{34,-18}}, color={0,0,255}));
  connect(plantIrradianceNormal.nv1, plantIrradianceNormal.n1)
    annotation (Line(points={{42,5},{46,5},{46,-18},{32,-18},{32,-10}}, color={0,0,255}));
  connect(plantIrradianceNormal.P_DC, mpTracker.power)
    annotation (Line(points={{42,0},{50,0},{50,-40},{53.2,-40}}, color={0,0,127}));
  connect(mpTracker.vRef, converter.vDCRef)
    annotation (Line(points={{62.4,-40},{64,-40},{64,-12}}, color={0,0,127}));
end None_PhotoVoltaicsLib;
