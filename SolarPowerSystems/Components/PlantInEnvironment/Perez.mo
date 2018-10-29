within SolarPowerSystems.Components.PlantInEnvironment;
model Perez "Transform horizontal irradiance to normal of arbitrarily oriented surface using the model by Perez"
  extends SolarPowerSystems.Interfaces.PlantInEnvironment;
  PlaneOfArrayIrradiance.DirectFromHorizontal
    direct(arrayTilt=arrayTilt)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,0})));
  Modelica.Blocks.Math.Add globalHorizontalIrradiance
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={8,56})));

  PlaneOfArrayIrradiance.DiffusePerez diffusePerez(til=arrayTilt, rho=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-4,-18})));
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.BrighteningCoefficient briCoe
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-20,20})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{44,-24},{36,-16}})));
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.SkyClearness skyCle
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-20,40})));
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.SkyBrightness skyBri
    annotation (Placement(transformation(extent={{-56,26},{-44,14}})));
  Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.RelativeAirMass relAirMas
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=90,
        origin={-61,9})));
equation
//   direct.HDirNor =noEvent(max(0, (directHorizontalIrradiance)))/noEvent(max(cos(solarZenith), 0.1));
  connect(diffuseHorizontalIrradiance, globalHorizontalIrradiance.u2)
    annotation (Line(points={{0,100},{0,66},{4.4,66},{4.4,63.2}},               color={0,0,127}));
  connect(directHorizontalIrradiance, globalHorizontalIrradiance.u1)
    annotation (Line(points={{60,100},{60,66},{11.6,66},{11.6,63.2}},
                                                                color={0,0,127}));
  connect(direct.directInclinedIrradiance, directInclinedIrradiance)
    annotation (Line(points={{60,-10},{60,-100},{60,-100}}, color={0,0,127}));
  connect(directHorizontalIrradiance, direct.directHorizontalIrradiance)
    annotation (Line(points={{60,100},{60,20},{60,20},{60,10}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{30,-40},{-100,-40}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, direct.angleOfIncidence)
    annotation (Line(points={{30,-40},{24,-40},{24,16},{54,16},{54,10}}, color={0,0,127}));
  connect(globalHorizontalIrradiance.y, diffusePerez.HGloHor)
    annotation (Line(points={{8,49.4},{8,44},{4,44},{4,-6}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, diffusePerez.HDifHor)
    annotation (Line(points={{0,100},{0,40},{1,40},{1,-6}}, color={0,0,127}));
  connect(briCoe.F1, diffusePerez.briCof1) annotation (Line(points={{-13.4,22.4},{-2,22.4},{-2,-6}}, color={0,0,127}));
  connect(briCoe.F2, diffusePerez.briCof2) annotation (Line(points={{-13.4,17.6},{-5,17.6},{-5,-6}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, diffusePerez.incAng)
    annotation (Line(points={{30,-40},{-16,-40},{-16,-2},{-11,-2},{-11,-6}}, color={0,0,127}));
  connect(solarZenith, from_deg.u) annotation (Line(points={{100,-20},{44.8,-20}}, color={0,0,127}));
  connect(from_deg.y, diffusePerez.zen)
    annotation (Line(points={{35.6,-20},{20,-20},{20,0},{-8,0},{-8,-6}}, color={0,0,127}));
  connect(from_deg.y, briCoe.zen)
    annotation (Line(points={{35.6,-20},{20,-20},{20,0},{-32,0},{-32,16.4},{-27.2,16.4}}, color={0,0,127}));
  connect(globalHorizontalIrradiance.y, skyCle.HGloHor)
    annotation (Line(points={{8,49.4},{8,43.6},{-12.8,43.6}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, skyCle.HDifHor)
    annotation (Line(points={{0,100},{0,40},{-12.8,40}}, color={0,0,127}));
  connect(from_deg.y, skyCle.zen)
    annotation (Line(points={{35.6,-20},{20,-20},{20,36.4},{-12.8,36.4}}, color={0,0,127}));
  connect(skyCle.skyCle, briCoe.skyCle)
    annotation (Line(points={{-26.6,40},{-32,40},{-32,23.6},{-27.2,23.6}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, skyBri.HDifHor)
    annotation (Line(points={{0,100},{0,66},{-60,66},{-60,22.4},{-57.2,22.4}}, color={0,0,127}));
  connect(relAirMas.relAirMas, skyBri.relAirMas)
    annotation (Line(points={{-61,12.3},{-61,17.6},{-57.2,17.6}}, color={0,0,127}));
  connect(from_deg.y, relAirMas.zen)
    annotation (Line(points={{35.6,-20},{20,-20},{20,0},{-61,0},{-61,5.4}}, color={0,0,127}));
  connect(diffusePerez.HSkyDifTil, diffuseInclinedIrradiance)
    annotation (Line(points={{-2.22045e-15,-29},{-2.22045e-15,-100},{0,-100}}, color={0,0,127}));
  connect(diffusePerez.HGroDifTil, reflectedInclinedIrradiance)
    annotation (Line(points={{-8,-29},{-8,-60},{-60,-60},{-60,-100}}, color={0,0,127}));
  connect(skyBri.skyBri, briCoe.skyBri) annotation (Line(points={{-43.4,20},{-27.2,20}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-94,70},{-32,76}},
          lineColor={28,108,200},
          textString="Variability 'albedo' higher than parameter
=> __not used__")}));
end Perez;
