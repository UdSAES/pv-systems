within SolarPowerSystems.WIP;
model AngleOfIncidence "A model for proofing the angleOfIncidence-model"
  Components.SolarPosition.AngleOfIncidence angleOfIncidence(arrayTilt=0.26179938779915, arrayAzimuth=-1.5707963267949)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,0})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
equation
  connect(solarZenith.y, angleOfIncidence.solarZenith)
    annotation (Line(points={{-49,20.2},{-10.5,20.2},{-10.5,4},{30,4}}, color={0,0,127}));
  connect(solarAzimuth.y, angleOfIncidence.solarAzimuth)
    annotation (Line(points={{-49,-19.8},{-9.5,-19.8},{-9.5,-4},{30,-4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end AngleOfIncidence;
