within SolarPowerSystems.WIP.FunctionalTests;
model HorizontalIrradianceToPower_SaarlouisTownhall
  "The PV array on top of the town hall in Saarlouis, from 2019-01-21--24"
  import ModelicaServices;
  extends Modelica.Icons.Example;

  ModelExport.ParameterSets.LocationFromMat location(fileName=SolarPowerSystems.ModelExport.Directory.dataFolder + "Location/" + "swsls-th.mat") annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);
  ModelExport.ParameterSets.PVplantFromMAT plantRecord(fileName=SolarPowerSystems.ModelExport.Directory.dataFolder + "PVplant/" + "swsls-th.mat") annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.IntegerConstant startTime(k=1550707200)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    columns=2:4,
    fileName=SolarPowerSystems.ModelExport.Directory.dataFolder + "20190221-24_swsls-th_weather-forecasts.txt",
    tableName="data")
                 annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

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
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    albedo=plantRecord.environmentAlbedo)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));

  Modelica.Blocks.Tables.CombiTable1Ds referenceData(
    tableOnFile=true,
    columns={2},
    fileName=SolarPowerSystems.ModelExport.Directory.dataFolder + "20190221-24_swsls-th_pv_systems-data.txt",
    tableName="data")
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));

  Utilities.ErrorMetrics errorMetrics(f=1/(24*3600))
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(inputData.y[2], plantModel.directHorizontalIrradiance) annotation (
      Line(points={{-29,0},{-20,0},{-20,8},{-12,8}}, color={0,0,127}));
  connect(inputData.y[1], plantModel.diffuseHorizontalIrradiance) annotation (
      Line(points={{-29,0},{-20,0},{-20,3},{-12,3}}, color={0,0,127}));
  connect(inputData.y[3], plantModel.temperature) annotation (Line(points={{-29,
          0},{-20,0},{-20,-8},{-12,-8}}, color={0,0,127}));
  connect(timeAsEpoch.y, referenceData.u) annotation (Line(points={{-69,0},{-60,
          0},{-60,-30},{-52,-30}}, color={0,0,127}));
  connect(plantModel.powerDC, errorMetrics.simulatedValue)
    annotation (Line(points={{8,8},{30,8},{30,6},{50,6}}, color={0,0,127}));
  connect(referenceData.y[1], errorMetrics.measuredValue) annotation (Line(
        points={{-29,-30},{30,-30},{30,-6},{50,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=345600, Interval=900),
    __Dymola_Commands(file=
          "Scripts/plot_WIP_HorizonatlIrradianceToPower_SaarlouisTownhall.mos"
        "plotResult"));
end HorizontalIrradianceToPower_SaarlouisTownhall;
