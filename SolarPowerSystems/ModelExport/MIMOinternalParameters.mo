within SolarPowerSystems.ModelExport;
model MIMOinternalParameters "Multiple input, multiple output model parameterized internally from records"
  Components.SolarPowerPlants.Perez_Danny plantModel(
    useTemperatureInput=true,
    constWindSpeed=0,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    epochOffset=1550707200,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    albedo=plantRecord.environmentAlbedo,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance "Direct irradiance in horizontal plane" annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance "Diffuse irradiance in horizontal plane" annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput temperature "The temperature at the plant's site (optional input)" annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  replaceable Records.Base.Location location annotation (choicesAllMatching=true,Placement(transformation(extent={{-48,72},{-32,88}})));
  replaceable Records.Base.PVplant plantRecord annotation (choicesAllMatching=true,Placement(transformation(extent={{-18,72},{-2,88}})));
  Modelica.Blocks.Interfaces.RealOutput powerDC "The generated power on the DC side" annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput totalEnergyDC "The generated energy on the DC side" annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence "The angle of incidence between surface normal and sun beam" annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfSunAboveHorizon "Angle of Sun above horizon" annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
equation
  connect(plantModel.directHorizontalIrradiance, directHorizontalIrradiance) annotation (Line(points={{-12,8},{-60,8},{-60,60},{-100,60}}, color={0,0,127}));
  connect(plantModel.diffuseHorizontalIrradiance, diffuseHorizontalIrradiance) annotation (Line(points={{-12,3},{-64,3},{-64,20},{-100,20}}, color={0,0,127}));
  connect(plantModel.temperature, temperature) annotation (Line(points={{-12,-8},{-60,-8},{-60,-60},{-100,-60}}, color={0,0,127}));
  connect(plantModel.powerDC, powerDC) annotation (Line(points={{8,8},{60,8},{60,40},{100,40}}, color={0,0,127}));
  connect(plantModel.totalEnergyDC, totalEnergyDC) annotation (Line(points={{8,4},{64,4},{64,20},{100,20}}, color={0,0,127}));
  connect(plantModel.angleOfIncidence, angleOfIncidence) annotation (Line(points={{8,-6},{64,-6},{64,-20},{100,-20}}, color={0,0,127}));
  connect(plantModel.angleOfSunAboveHorizon, angleOfSunAboveHorizon) annotation (Line(points={{8,-8},{60,-8},{60,-40},{100,-40}}, color={0,0,127}));
  annotation (Icon(graphics={
                     Rectangle(lineColor = {0, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-76, 76}, {76, -76}}, fillColor = {85, 85, 255}), Line(points = {{-80, 0}, {80, 0}}, color = {255, 255, 255}), Rectangle(extent = {{-84, 84}, {84, -84}}, lineColor = {0, 0, 0}), Polygon(points = {{-84, 76}, {-76, 84}, {-68, 76}, {-76, 68}, {-84, 76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-24, 76}, {-24, -76}}, color = {255, 255, 255}), Polygon(points = {{-8, 76}, {0, 84}, {8, 76}, {0, 68}, {-8, 76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{68, 76}, {76, 84}, {84, 76}, {76, 68}, {68, 76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{68, 0}, {76, 8}, {84, 0}, {76, -8}, {68, 0}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{68, -76}, {76, -68}, {84, -76}, {76, -84}, {68, -76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{-84, -76}, {-76, -68}, {-68, -76}, {-76, -84}, {-84, -76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-54, 76}, {-54, -76}}, color = {255, 255, 255}), Polygon(points = {{-84, 0}, {-76, 8}, {-68, 0}, {-76, -8}, {-84, 0}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{-8, 0}, {0, 8}, {8, 0}, {0, -8}, {-8, 0}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{-8, -76}, {0, -68}, {8, -76}, {0, -84}, {-8, -76}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Line(points = {{0, 76}, {0, -76}}, color = {255, 255, 255}), Line(points = {{24, 76}, {24, -76}}, color = {255, 255, 255}), Line(points = {{54, 76}, {54, -76}}, color = {255, 255, 255})},coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end MIMOinternalParameters;
