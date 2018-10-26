within SolarPowerSystems.WIP.Validation;
model TGM_Trina_20160629
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.AreaBased        solarPowerPlantAreaBased(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    epochOffset=1466899200,
    Albedo=0.2,
    T=298.15,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth))
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable inputData(
    tableOnFile=true,
    tableName="trina",
    columns=2:10,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/TGM_Trina_20160629.txt"))
    annotation (Placement(transformation(extent={{-90,-4},{-70,16}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  SolarPowerSystems.Records.Data.Location_TGMVienna location "TGM Vienna"
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  SolarPowerSystems.Records.Data.PVplant_TGM_Trina plantRecord "TGM Trina"
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})));
equation
  connect(diffuseHorizontalIrradiance.y, solarPowerPlantAreaBased.diffuseHorizontalIrradiance)
    annotation (Line(points={{-69,-30},{-40,-30},{-40,2},{-10,2}}, color={0,0,127}));
  connect(inputData.y[1], solarPowerPlantAreaBased.directHorizontalIrradiance)
    annotation (Line(points={{-69,6},{-10,6}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=1));
end TGM_Trina_20160629;
