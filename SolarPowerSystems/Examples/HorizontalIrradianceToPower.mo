within SolarPowerSystems.Examples;
model HorizontalIrradianceToPower
  "A fictive 15kWp power plant located in Saarbruecken, Germany on 2018-11-07 (perfectly sunny day)"
  import ModelicaServices;
  extends Modelica.Icons.Example;

  Components.IrradianceTemperature2Power PhotoVoltaicSystem(
    redeclare Records.Data.Location_UdS location,
    redeclare Records.Data.PVplant_15kWp plantRecord,
    redeclare Components.SolarPowerPlants.Perez_EfficiencyIrradianceArea plantModel,
    epochOffset=startTime.k) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1542412800)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    tableName="saarbruecken",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/20181117_t_2m_aswdir_s_aswdifd_s_saarbruecken_60min.txt"),
    columns=2:4) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=startTime.k)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inputData.y[1], PhotoVoltaicSystem.temperature)
    annotation (Line(points={{-29,0},{-18,0},{-18,-3},{-10,-3}}, color={0,0,127}));
  connect(inputData.y[2], PhotoVoltaicSystem.directIrradiance)
    annotation (Line(points={{-29,0},{-18,0},{-18,8},{-10,8}}, color={0,0,127}));
  connect(inputData.y[3], PhotoVoltaicSystem.diffuseIrradiance)
    annotation (Line(points={{-29,0},{-18,0},{-18,3},{-10,3}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=18000,
      StopTime=64800,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="Scripts/plot_Examples_HorizontalIrradianceToPower.mos" "plotResult"));
end HorizontalIrradianceToPower;
