within SolarPowerSystems.Examples;
model AngleOfIncidence "A model for proofing the angleOfIncidence-model"
  extends Modelica.Icons.Example;

  Components.SolarPosition.AngleOfIncidence angleOfIncidence(arrayTilt=0.5235987755983, arrayAzimuth=-1.5707963267949)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,0})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(simu_start_epochs=epochOffset.k)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Sources.IntegerConstant epochOffset(k=1537667580)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
equation
  connect(solarZenith.y, angleOfIncidence.solarZenith)
    annotation (Line(points={{-49,20.2},{-10.5,20.2},{-10.5,4},{30,4}}, color={0,0,127}));
  connect(solarAzimuth.y, angleOfIncidence.solarAzimuth)
    annotation (Line(points={{-49,-19.8},{-9.5,-19.8},{-9.5,-4},{30,-4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400),
    Documentation(info="<html>
<p>Use this model to verify that the behaviour of the <a href=\"modelica://SolarPowerSystems/Components/SolarPosition/AngleOfIncidence.mo\">AngleOfIncidence</a>-model matches your expectations.</p>
<p>The date is set to the <a href=\"https://en.wikipedia.org/wiki/Equinox\">equinox</a> on September 23, 2018. Consequently, it is expected that, at sunrise (solar zenith angle equals 90&deg;), the angle of incidence equals 60&deg; for a panel that faces east (azimuth of -90&deg;) and is tilted by 30&deg;.</p>
<p>There is a plot script provided (Commands &gt; plotResult).</p>
</html>"),
    __Dymola_Commands(file="Scripts/plot_Examples_AngleOfIncidence.mos" "plotResult"));
end AngleOfIncidence;
