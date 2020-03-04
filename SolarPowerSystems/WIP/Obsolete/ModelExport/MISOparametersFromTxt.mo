within SolarPowerSystems.WIP.Obsolete.ModelExport;
model MISOparametersFromTxt "Multiple input, single output FMU parameterized from external .txt-files"

  parameter Integer epochOffset = 1550707200 "The time at the start of the simulation as Epoch in s, default 2019-02-21T00:00Z";
  parameter String recordPVplant = SolarPowerSystems.ModelExport.Directory.dataFolder + "PVplant/" + "swsls-th.txt";
  parameter String recordLocation = SolarPowerSystems.ModelExport.Directory.dataFolder + "Location/" + "swsls-th.txt";

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
    epochOffset=epochOffset)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  SolarPowerSystems.ModelExport.ParameterSets.PVplantFromTxt plantRecord(fileName=recordPVplant) annotation (Placement(transformation(extent={{-10,72},{10,92}})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance
    "Direct irradiance in horizontal plane"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance
    "Diffuse irradiance in horizontal plane"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput temperature
    "The temperature at the plant's site"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Blocks.Interfaces.RealOutput powerDC
    "The generated power on the DC side"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  SolarPowerSystems.ModelExport.ParameterSets.LocationFromMat location(fileName=recordLocation) annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
equation
  connect(plantModel.directHorizontalIrradiance, directHorizontalIrradiance)
    annotation (Line(points={{-10,8},{-56,8},{-56,80},{-100,80}}, color={0,0,127}));
  connect(plantModel.diffuseHorizontalIrradiance, diffuseHorizontalIrradiance)
    annotation (Line(points={{-10,3},{-60,3},{-60,40},{-100,40}}, color={0,0,127}));
  connect(plantModel.temperature, temperature) annotation (Line(points={{-10,-8},
          {-56,-8},{-56,-80},{-100,-80}}, color={0,0,127}));
  connect(plantModel.powerDC, powerDC) annotation (Line(points={{10,8},{56,8},{56,
          80},{100,80}}, color={0,0,127}));
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
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Line(points = {{0, 76}, {0, -76}}, color = {255, 255, 255}), Line(points = {{24, 76}, {24, -76}}, color = {255, 255, 255}), Line(points = {{54, 76}, {54, -76}}, color = {255, 255, 255})},coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MISOparametersFromTxt;
