within SolarPowerSystems.WIP.Obsolete;
model TemplateTGM
  "Template for quickly setting up an experiment for validation using the choicesAllMatching-mechanism and the data provided by TGM"
  extends Modelica.Icons.Example;

  replaceable Components.SolarPowerPlants.None_Danny solarPowerPlantAreaBased(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    useTemperatureInput=false,
    useAlbedoInput=false,
    useWindSpeedInput=false,
    epochOffset=epochOffset,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency)
                             constrainedby Interfaces.PhotoVoltaicPowerPlant annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Integer epochOffset=1466899200 "The time at the start of the simulation as Epoch in s";

  Modelica.Blocks.Sources.CombiTimeTable inputData(
    tableOnFile=true,
    tableName="trina",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SolarPowerSystems/Resources/TGM_Trina_20160629.txt"),
    columns=2:10)
    annotation (Placement(transformation(extent={{-90,-4},{-70,16}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  replaceable Records.Data.Location_TGMVienna location constrainedby
    Records.Base.Location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), __Dymola_choicesAllMatching=true);
  replaceable Records.Data.PVplant_TGM_Trina plantRecord constrainedby
    Records.Base.PVplant
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
equation
  connect(diffuseHorizontalIrradiance.y, solarPowerPlantAreaBased.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69,-30},{-40,-30},{-40,3},{-10,3}}, color={0,0,127}));
  connect(inputData.y[1], solarPowerPlantAreaBased.directHorizontalIrradiance)
    annotation (Line(points={{-69,6},{-40,6},{-40,8},{-10,8}},
                                               color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=1));
end TemplateTGM;
