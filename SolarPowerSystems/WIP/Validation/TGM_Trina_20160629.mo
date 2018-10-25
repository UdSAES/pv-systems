within SolarPowerSystems.WIP.Validation;
model TGM_Trina_20160629
  extends Modelica.Icons.Example;
  SolarPowerSystems.Components.SolarPowerPlants.AreaBased
    solarPowerPlantAreaBased(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelTilt=plantRecord.panelTilt,
    panelAzimuth=plantRecord.panelAzimuth,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    temperatureCoefficient=0,
    epochOffset=1466899200,
    Albedo=0.2,
    T=298.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable inputData(
    tableOnFile=true,
    tableName="trina",
    columns=2:10,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/TGM_Trina_20160629.txt"))
    annotation (Placement(transformation(extent={{-90,-6},{-70,14}})));
  Modelica.Blocks.Sources.Constant I_diff_horizontal(k=0)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  SolarPowerSystems.Records.Data.Location_TGMVienna location "TGM Vienna"
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  SolarPowerSystems.Records.Data.PVplant_TGM_Trina plantRecord "TGM Trina"
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})));
equation
  connect(I_diff_horizontal.y, solarPowerPlantAreaBased.I_diff_horizontal)
    annotation (Line(points={{-69,-30},{-40,-30},{-40,0},{-10,0}}, color={0,0,127}));
  connect(inputData.y[1], solarPowerPlantAreaBased.I_dir_horizontal)
    annotation (Line(points={{-69,4},{-10,4}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=1));
end TGM_Trina_20160629;
