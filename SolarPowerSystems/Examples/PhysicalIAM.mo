within SolarPowerSystems.Examples;
model PhysicalIAM "Unit test for physical IAM model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramp(
    duration=90,
    startTime=0,
    height=360,
    offset=-180) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-46,-6},{-34,6}})));
  SolarPowerSystems.Components.PhotoVoltaicArray.ReflectionLosses.PhysicalIAMmodel physicalIAMmodel
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(ramp.y, from_deg.u) annotation (Line(points={{-59,0},{-47.2,0}}, color={0,0,127}));
  connect(from_deg.y, physicalIAMmodel.angleOfIncidence)
    annotation (Line(points={{-33.4,0},{-10,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>This model implements a physical model of the incidence angle modifier used to account for the incident angle reflection losses as described <a href=\"https://pvpmc.sandia.gov/modeling-steps/1-weather-design-inputs/shading-soiling-and-reflection-losses/incident-angle-reflection-losses/physical-model-of-iam/\">here</a>.</p>
<p>Use the provided plot script  (Commands &gt; plotResult) to verify that the model&apos;s behaviour matches the expectations.</p>
</html>"),
    experiment(StopTime=90),
    __Dymola_Commands(file="Scripts/plot_Examples_PhysicalIAM.mos" "plotResult"));
end PhysicalIAM;
