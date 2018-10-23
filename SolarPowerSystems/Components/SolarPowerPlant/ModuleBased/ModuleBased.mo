within SolarPowerSystems.Components.SolarPowerPlant.ModuleBased;
model ModuleBased "Module-based PV plant model (PhotoVoltaics-Lib)"
  extends Interfaces.PlantIrradianceNormal;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=T)
    if                                                                                  not useHeatPort
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  PhotoVoltaics.Components.Diodes.Diode2Module diode(
    final m=m,
    final R=1E8,
    final Bv=moduleData.BvCell,
    final Ibv=moduleData.Ibv,
    final Nbv=moduleData.Nbv,
    final IRef=moduleData.IscRef,
    final alphaI=moduleData.alphaIsc,
    final alphaV=moduleData.alphaVoc,
    final ns=moduleData.ns,
    final VRef=moduleData.VocCellRef,
    final nsModule=nsModule,
    final npModule=npModule,
    final useHeatPort=useHeatPort,
    final T=T,
    final TRef=moduleData.TRef)                                                                                                  annotation (
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  PhotoVoltaics.Sources.Electrical.SignalCurrent signalCurrent(
    final irradianceRef=moduleData.irradianceRef,
    final alphaRef=moduleData.alphaIsc,
    final IRef=npModule*IphRef,
    final useHeatPort=useHeatPort,
    final T=T,
    final TRef=moduleData.TRef)                                                                                                            annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  parameter PhotoVoltaics.Records.ModuleData
                               moduleData "Module parameters" annotation (
    choicesAllMatching = true,
    Placement(transformation(extent = {{60, 60}, {80, 80}})));
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             internalHeatPort
    annotation (Placement(transformation(extent={{-104,-84},{-96,-76}})));
equation
  connect(heatPort,internalHeatPort)  annotation (Line(
      points={{-100,-100},{-100,-80}},
      color={191,0,0}));
  connect(fixedTemperature.port,internalHeatPort)  annotation (Line(
      points={{-80,-80},{-100,-80}},
      color={191,0,0}));
  connect(diode.p,signalCurrent. n) annotation (
    Line(points = {{-10, -30}, {-20, -30}, {-20, 0}, {-10, 0}}, color = {0, 0, 255}));
  connect(signalCurrent.heatPort,internalHeatPort)  annotation (
    Line(points = {{0, -10}, {-100, -10}, {-100, -80}}, color = {191, 0, 0}));
  connect(diode.n,signalCurrent. p) annotation (
    Line(points={{10,-30},{20,-30},{20,0},{15,0},{10,0}},                     color = {0, 0, 255}));
  connect(diode.heatPort,internalHeatPort)  annotation (
    Line(points = {{0, -40}, {-100, -40}, {-100, -80}}, color = {191, 0, 0}));
  connect(p, signalCurrent.n)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(n, signalCurrent.p)
    annotation (Line(points={{100,0},{10,0}}, color={0,0,255}));
  connect(I_G_normal, signalCurrent.irradiance)
    annotation (Line(points={{0,100},{0,7}}, color={0,0,127}));
end ModuleBased;
