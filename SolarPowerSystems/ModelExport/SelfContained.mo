within SolarPowerSystems.ModelExport;
model SelfContained
  "No input/output FMU parameterized from external data files -- BC via tables from file"

  parameter Integer epochOffset=1550707200
    "The time at the start of the simulation as Epoch in s, default 2019-02-21T00:00Z";
  parameter String recordPVplant=SolarPowerSystems.ModelExport.Directory.dataFolder + "PVplant/" + "swsls-th.mat";
  parameter String recordLocation=SolarPowerSystems.ModelExport.Directory.dataFolder + "Location/" + "swsls-th.mat";
  parameter String tableBoundaryConditions=SolarPowerSystems.ModelExport.Directory.dataFolder + "20190221-24_swsls-th_weather-forecasts.txt";

  Components.SolarPowerPlants.Perez_Danny plantModel(
    useTemperatureInput=true,
    constWindSpeed=0,
    albedo=plantRecord.environmentAlbedo,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    epochOffset=epochOffset) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ParameterSets.PVplantFromMAT plantRecord(fileName=recordPVplant)
    annotation (Placement(transformation(extent={{-10,72},{10,92}})));
  ParameterSets.LocationFromMat location(fileName=recordLocation)
    annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    columns=2:4,
    fileName=tableBoundaryConditions,
    tableName="data") annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=epochOffset)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(inputData.y[1], plantModel.diffuseHorizontalIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,3},{-10,3}}, color={0,0,127}));
  connect(inputData.y[2], plantModel.directHorizontalIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,8},{-10,8}}, color={0,0,127}));
  connect(inputData.y[3], plantModel.temperature)
    annotation (Line(points={{-29,0},{-20,0},{-20,-8},{-10,-8}}, color={0,0,127}));
  annotation (
    Icon(graphics={
        Rectangle(
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          extent={{-76,76},{76,-76}},
          fillColor={85,85,255}),
        Line(points={{-80,0},{80,0}}, color={255,255,255}),
        Rectangle(extent={{-84,84},{84,-84}}, lineColor={0,0,0}),
        Polygon(
          points={{-84,76},{-76,84},{-68,76},{-76,68},{-84,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-24,76},{-24,-76}}, color={255,255,255}),
        Polygon(
          points={{-8,76},{0,84},{8,76},{0,68},{-8,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,76},{76,84},{84,76},{76,68},{68,76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,0},{76,8},{84,0},{76,-8},{68,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{68,-76},{76,-68},{84,-76},{76,-84},{68,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-84,-76},{-76,-68},{-68,-76},{-76,-84},{-84,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-54,76},{-54,-76}}, color={255,255,255}),
        Polygon(
          points={{-84,0},{-76,8},{-68,0},{-76,-8},{-84,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-8,0},{0,8},{8,0},{0,-8},{-8,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-8,-76},{0,-68},{8,-76},{0,-84},{-8,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{0,76},{0,-76}}, color={255,255,255}),
        Line(points={{24,76},{24,-76}}, color={255,255,255}),
        Line(points={{54,76},{54,-76}}, color={255,255,255})}, coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=345600, Interval=900));
end SelfContained;
