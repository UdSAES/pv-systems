within SolarPowerSystems.Components.PhotoVoltaicArray.ModuleBased;
model PhotoVoltaicsLib "Module-based PV plant model (PhotoVoltaics-Lib)"
  extends Interfaces.PhotoVoltaicArray;

  PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric
    simplePlantSymmetric(
    useHeatPort=useHeatPort,
    T=T,
    useConstantIrradiance=false,
    moduleData=moduleData,
    shadow=0,
    nsModule=nsModule,
    npModule=npModule)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  parameter Integer nsModule=1 "Number of series connected modules";
  parameter Integer npModule=1 "Number of parallel connected modules";

  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv1
      "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  replaceable parameter PhotoVoltaics.Records.ModuleData moduleData
    constrainedby PhotoVoltaics.Records.ModuleData annotation (Placement(
        transformation(extent={{50,52},{70,72}})), __Dymola_choicesAllMatching=
        true);
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
                "Negative pin"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(I_G_normal, simplePlantSymmetric.variableIrradiance)
    annotation (Line(points={{0,100},{0,12}}, color={0,0,127}));
  connect(powerSensor.pc, powerSensor.pv)
    annotation (Line(points={{40,0},{40,10},{50,10}}, color={0,0,255}));
  connect(powerSensor.power, P_DC) annotation (Line(points={{42,-11},{42,-20},{0,
          -20},{0,-100}}, color={0,0,127}));
  connect(powerSensor.nv, nv1)
    annotation (Line(points={{50,-10},{50,-100}}, color={0,0,255}));
  connect(simplePlantSymmetric.n, n1)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(simplePlantSymmetric.p, powerSensor.pc)
    annotation (Line(points={{10,0},{40,0}}, color={0,0,255}));
  connect(powerSensor.nc, p1)
    annotation (Line(points={{60,0},{100,0}}, color={0,0,255}));
end PhotoVoltaicsLib;
