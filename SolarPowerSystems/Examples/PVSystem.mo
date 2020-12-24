within SolarPowerSystems.Examples;
model PVSystem
  "A fictive PV power plant located in Saarbruecken, Germany at the beginning of July 2018"
  import ModelicaServices;
  extends Modelica.Icons.Example;

  Components.IrradianceTemperatureWindSpeed2Power PhotoVoltaicSystem(
    redeclare Records.Data.Location1 location,
    redeclare Records.Data.PVplant1 plantRecord,
    redeclare Components.SolarPowerPlants.Perez_EfficiencyIrradianceArea plantModel,
    epochOffset=startTime.k) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1530403200)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    tableName="data",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/20180606T0000--20180706T2359+0000_uds-campus.txt"),
    columns=2:5) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=startTime.k)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inputData.y[1], PhotoVoltaicSystem.directIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,8},{-10,8}}, color={0,0,127}));
  connect(inputData.y[2], PhotoVoltaicSystem.diffuseIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,3},{-10,3}}, color={0,0,127}));
  connect(inputData.y[4], PhotoVoltaicSystem.windSpeed)
    annotation (Line(points={{-29,0},{-20,0},{-20,-4},{-10,-4}}, color={0,0,127}));
  connect(inputData.y[3], PhotoVoltaicSystem.temperature)
    annotation (Line(points={{-29,0},{-20,0},{-20,-8},{-10,-8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=18000,
      StopTime=64800,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="Scripts/plot_Examples_PVSystem.mos" "plotResult"),
    Documentation(info="<html>
<p>Full PV system model that estimates the system behaviour based on diffuse and direct irradiance in the horizontal plane, air temperature and wind speed at the site.</p>
<p>For conversion to POA irradiance, the model by Perez is used; calculation of the power output is done using the efficiency factor model <a href=\"modelica://SolarPowerSystems.Components.PhotoVoltaicArray.ModuleOutputDC.EfficiencyIrradianceArea\">SolarPowerSystems.Components.PhotoVoltaicArray.ModuleOutputDC.EfficiencyIrradianceArea</a>.</p>
<p>As input data, weather forecasts for the location of the campus of Saarland university from 2018-06-06 to 2018-07-06 (summer solstice +/- 15 days) are provided as <span style=\"font-family: monospace;\">SolarPowerSystems.Resources.20180606T0000--20180706T2359+0000_uds-campus.txt</span>. The parameter values for the PV plant are made up, meaning that the simulation results do not represent a real system.</p>
<p><br>Use the default simulation parameters to simulate 2018-07-01--2018-07-03; then use the provided plot script (Commands &gt; plotResult) to get an overview of key quantities. Extend the simulation period and/or change the value of the <span style=\"font-family: monospace;\">startTime</span>-block to investigate additional days.</p>
</html>"));
end PVSystem;
