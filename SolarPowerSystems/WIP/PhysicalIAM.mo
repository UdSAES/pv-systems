within SolarPowerSystems.WIP;
model PhysicalIAM "Unit test for physical IAM model"
  Modelica.Blocks.Sources.Ramp ramp(
    duration=90,
    startTime=0,
    offset=10,
    height=85) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-46,-6},{-34,6}})));
  SolarPowerSystems.Components.PhotoVoltaicArray.ReflectionLosses.PhysicalIAMmodel physicalIAMmodel
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(ramp.y, from_deg.u) annotation (Line(points={{-59,0},{-47.2,0}}, color={0,0,127}));
  connect(from_deg.y, physicalIAMmodel.angleOfIncidence) annotation (Line(points={{-33.4,0},{-10,0}}, color={0,0,127}));
  annotation ();
end PhysicalIAM;
