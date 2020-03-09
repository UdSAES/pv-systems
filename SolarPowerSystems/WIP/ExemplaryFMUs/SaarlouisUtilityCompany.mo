within SolarPowerSystems.WIP.ExemplaryFMUs;
model SaarlouisUtilityCompany "PV plant on top of the utility company in Saarlouis"
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
    T_cell_ref=plantRecord.T_cell_ref) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance "Direct irradiance in horizontal plane" annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance "Diffuse irradiance in horizontal plane" annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput temperature "The temperature at the plant's site (optional input)" annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  replaceable Records.Data.Location_SWSLS_TH
                                    location constrainedby Records.Base.Location
                                             annotation (choicesAllMatching=true,Placement(transformation(extent={{-48,72},{-32,88}})));
  replaceable Records.Data.PVplant_Saarlouis_SW_South
                                   plantRecord constrainedby Records.Base.PVplant
                                               annotation (choicesAllMatching=true,Placement(transformation(extent={{-18,72},{-2,88}})));
  Modelica.Blocks.Interfaces.RealOutput powerDC "The generated power on the DC side" annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence "The angle of incidence between surface normal and sun beam" annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfSunAboveHorizon "Angle of Sun above horizon" annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Components.SolarPowerPlants.Perez_Danny plantModel1(
    useTemperatureInput=true,
    constWindSpeed=0,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    epochOffset=plantModel.epochOffset,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord1.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord1.panelAzimuth),
    albedo=plantRecord1.environmentAlbedo,
    panelArea=plantRecord1.panelArea,
    plantEfficiency=plantRecord1.plantEfficiency,
    T_cell_ref=plantRecord1.T_cell_ref)
                                       annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  replaceable Records.Data.PVplant_Saarlouis_SW_East
                                   plantRecord1
                                               constrainedby Records.Base.PVplant
                                               annotation (choicesAllMatching=true,Placement(transformation(extent={{-18,-90},{-2,-74}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{64,34},{76,46}})));
  Modelica.Blocks.Interfaces.RealOutput totalEnergyDC "The generated energy on the DC side" annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Math.Add add1
                               annotation (Placement(transformation(extent={{64,14},{76,26}})));
equation
  connect(plantModel.directHorizontalIrradiance, directHorizontalIrradiance) annotation (Line(points={{-10,28},{-60,28},{-60,60},{-100,60}},
                                                                                                                                           color={0,0,127}));
  connect(plantModel.diffuseHorizontalIrradiance, diffuseHorizontalIrradiance) annotation (Line(points={{-10,23},{-40,23},{-40,20},{-100,20}},
                                                                                                                                             color={0,0,127}));
  connect(plantModel.temperature, temperature) annotation (Line(points={{-10,12},{-20,12},{-20,-60},{-100,-60}}, color={0,0,127}));
  connect(directHorizontalIrradiance, plantModel1.directHorizontalIrradiance) annotation (Line(points={{-100,60},{-60,60},{-60,-12},{-10,-12}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, plantModel1.diffuseHorizontalIrradiance) annotation (Line(points={{-100,20},{-40,20},{-40,-17},{-10,-17}}, color={0,0,127}));
  connect(temperature, plantModel1.temperature) annotation (Line(points={{-100,-60},{-20,-60},{-20,-28},{-10,-28}}, color={0,0,127}));

  connect(plantModel.powerDC, add.u1) annotation (Line(points={{10,28},{36,28},{36,43.6},{62.8,43.6}}, color={0,0,127}));
  connect(plantModel1.powerDC, add.u2) annotation (Line(points={{10,-12},{40,-12},{40,36.4},{62.8,36.4}}, color={0,0,127}));
  connect(add.y, powerDC) annotation (Line(points={{76.6,40},{100,40}}, color={0,0,127}));
  connect(plantModel1.angleOfIncidence, angleOfIncidence) annotation (Line(points={{10,-26},{53,-26},{53,-20},{100,-20}}, color={0,0,127}));
  connect(plantModel1.angleOfSunAboveHorizon, angleOfSunAboveHorizon) annotation (Line(points={{10,-28},{52,-28},{52,-40},{100,-40}}, color={0,0,127}));
  connect(add1.y, totalEnergyDC) annotation (Line(points={{76.6,20},{100,20}}, color={0,0,127}));
  connect(plantModel.totalEnergyDC, add1.u1) annotation (Line(points={{10,24},{36,24},{36,23.6},{62.8,23.6}}, color={0,0,127}));
  connect(plantModel1.totalEnergyDC, add1.u2) annotation (Line(points={{10,-16},{52,-16},{52,16.4},{62.8,16.4}}, color={0,0,127}));
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
end SaarlouisUtilityCompany;
