within SolarPowerSystems.Components.PhotoVoltaicArray.ModuleOutputDC.EquivalentCircuitModels;
model PhotoVoltaicsLib "Model for using the simple symmetric plant model provided in the PhotoVoltaics-library"
  extends Interfaces.PhotoVoltaicArray;

  PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric simplePlantSymmetric(
    T=T,
    useConstantIrradiance=false,
    shadow=0,
    nsModule=nsModule,
    npModule=npModule,
    useHeatPort=true,
    moduleData=moduleData) annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  parameter Integer nsModule=1 "Number of series connected modules";
  parameter Integer npModule=1 "Number of parallel connected modules";

  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv1 "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative pin"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  parameter PhotoVoltaics.Records.ModuleData moduleData "Module parameters";
equation
  connect(I_G_normal, simplePlantSymmetric.variableIrradiance)
    annotation (Line(points={{0,100},{0,12}}, color={0,0,127}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{40,0},{40,10},{50,10}}, color={0,0,255}));
  connect(powerSensor.power, P_DC)
    annotation (Line(points={{40,-11},{40,-20},{0,-20},{0,-100}}, color={0,0,127}));
  connect(powerSensor.nv, nv1) annotation (Line(points={{50,-10},{50,-100}}, color={0,0,255}));
  connect(simplePlantSymmetric.n, n1) annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(simplePlantSymmetric.p, powerSensor.pc) annotation (Line(points={{10,0},{40,0}}, color={0,0,255}));
  connect(powerSensor.nc, p1) annotation (Line(points={{60,0},{100,0}}, color={0,0,255}));
  connect(internalHeatPort, simplePlantSymmetric.heatPort)
    annotation (Line(points={{-100,-80},{-100,-16},{10,-16},{10,-10}}, color={191,0,0}));
end PhotoVoltaicsLib;
