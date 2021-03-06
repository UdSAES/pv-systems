within SolarPowerSystems.Components;
model Irradiance2Power
  "Overall model calculating the PV output based on supplied irradiance. Constant ambient temperature and constant wind speed is assumed."
  extends SolarPowerSystems.Icons.PVSystem;

  parameter Integer epochOffset "The time at the start of the simulation as Epoch in s";
  parameter Modelica.SIunits.Efficiency constInverterEfficiency=1 "Constant overall efficiency of the DC-AC converter";
  parameter Modelica.SIunits.Temperature constTemperature=293.15 "Fixed environment temperature";
  parameter Modelica.SIunits.Velocity constWindSpeed=1 "Fixed wind speed value";

  replaceable parameter Records.Base.Location location annotation (choicesAllMatching=true,Dialog(group="Parameter Sets"),Placement(transformation(extent={{-50,48},{-30,68}})));
  replaceable parameter Records.Base.PVplant plantRecord annotation (
    choicesAllMatching=true,
    Dialog(group="Parameter Sets"),
    Placement(transformation(extent={{-10,48},{10,68}})));

  replaceable Interfaces.PhotoVoltaicPowerPlant plantModel constrainedby Interfaces.PhotoVoltaicPowerPlant(
    epochOffset=epochOffset,
    k=constInverterEfficiency,
    useTemperatureInput=false,
    constTemperature=constTemperature,
    constWindSpeed=constWindSpeed,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    albedo=plantRecord.environmentAlbedo,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref) annotation (
    choicesAllMatching=true,
    Dialog(group="Model Selection"),
    Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput directIrradiance(unit="W/m2") "Direct irradiance"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput diffuseIrradiance(unit="W/m2") "Diffuse irradiance "
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") "The generated power"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));

  Modelica.Blocks.Interfaces.RealOutput energy(unit="kW.h") "The generated energy"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfSunAboveHorizon(unit="deg") "Angle of Sun above horizon"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(unit="rad", displayUnit="deg")
    "The angle of incidence between surface normal and sun beam"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
equation
  connect(plantModel.directHorizontalIrradiance, directIrradiance)
    annotation (Line(points={{-10,8},{-60,8},{-60,80},{-100,80}}, color={0,0,127}));
  connect(plantModel.diffuseHorizontalIrradiance, diffuseIrradiance)
    annotation (Line(points={{-10,3},{-64,3},{-64,30},{-100,30}}, color={0,0,127}));
  connect(plantModel.powerDC, power) annotation (Line(points={{10,8},{40,8},{40,80},{100,80}}, color={0,0,127}));
  connect(plantModel.totalEnergyDC, energy) annotation (Line(points={{10,4},{44,4},{44,40},{100,40}}, color={0,0,127}));
  connect(plantModel.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{10,-4},{44,-4},{44,-40},{100,-40}}, color={0,0,127}));
  connect(plantModel.angleOfSunAboveHorizon, angleOfSunAboveHorizon)
    annotation (Line(points={{10,-8},{40,-8},{40,-80},{100,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Irradiance2Power;
