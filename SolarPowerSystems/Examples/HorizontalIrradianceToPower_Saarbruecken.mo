within SolarPowerSystems.Examples;
model HorizontalIrradianceToPower_Saarbruecken
  "A fictive 15kWp power plant located in Saarbruecken, Germany on 2018-11-07 (perfectly sunny day)"
  import ModelicaServices;
  extends Modelica.Icons.Example;

  Records.Data.Location_UdS                         location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);
  Records.Data.PVplant_Saarbruecken_15kWp          plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1542412800)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    tableName="saarbruecken",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/20181117_t_2m_aswdir_s_aswdifd_s_saarbruecken_60min.txt"),
    columns=2:4) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=startTime.k)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Components.SolarPowerPlants.Perez_Danny plantModel(
    epochOffset=startTime.k,
    useTemperatureInput=true,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth))
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));

equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(inputData.y[1],plantModel. temperature)
    annotation (Line(points={{-29,0},{-20,0},{-20,-8},{-12,-8}}, color={0,0,127}));
  connect(inputData.y[3],plantModel. diffuseHorizontalIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,3},{-12,3}}, color={0,0,127}));
  connect(inputData.y[2],plantModel. directHorizontalIrradiance)
    annotation (Line(points={{-29,0},{-20,0},{-20,8},{-12,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end HorizontalIrradianceToPower_Saarbruecken;
