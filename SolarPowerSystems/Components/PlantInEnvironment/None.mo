within SolarPowerSystems.Components.PlantInEnvironment;
model None "Pass through: no inclination, no azimuth, no shadows"
  extends Interfaces.PlantInEnvironment;
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-60})));
  Functions.angleOfIncidenceAsBlock angleOfIncidenceAsBlock(arrayTilt=arrayTilt, arrayAzimuth=arrayAzimuth)
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-40})));
equation
  connect(const.y, reflectedInclinedIrradiance) annotation (Line(points={{-60,-71},{-60,-100}}, color={0,0,127}));
  connect(directHorizontalIrradiance, directInclinedIrradiance)
    annotation (Line(points={{60,100},{60,0},{60,0},{60,-100}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, diffuseInclinedIrradiance)
    annotation (Line(points={{0,100},{0,0},{0,0},{0,-100}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{30,-40},{-100,-40}}, color={0,0,127}));
  connect(solarZenith, angleOfIncidenceAsBlock.solarZenith)
    annotation (Line(points={{100,-20},{66,-20},{66,-36},{50,-36}}, color={0,0,127}));
  connect(solarAzimuth, angleOfIncidenceAsBlock.solarAzimuth)
    annotation (Line(points={{100,-60},{66,-60},{66,-44},{50,-44}}, color={0,0,127}));
end None;
