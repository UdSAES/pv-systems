within SolarPowerSystems.WIP.FunctionalTests;
model HorizontalIrradianceToPower_Ashland15kWp "The PV array on top of the police station in Ashland/OR"
  import ModelicaServices;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.IntegerConstant startTime(k=978336000)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Tables.CombiTable1Ds inputData(
    tableOnFile=true,
    columns=2:4,
    tableName="data",
    fileName="/home/modelica/current_simulation/data/20010101--06_srml-ashland-15kWp_weather-data.txt")
                 annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=startTime.k)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Modelica.Blocks.Tables.CombiTable1Ds referenceData(
    tableOnFile=true,
    columns={2},
    tableName="data",
    fileName="/home/modelica/current_simulation/data/20010101--06_srml-ashland-15kWp_pv_systems-data.txt")
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));

  Utilities.ErrorMetrics errorMetrics(f=1/(24*3600))
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Components.SolarPowerPlants.Perez_Danny plantModel(
    epochOffset=startTime.k,
    useTemperatureInput=true,
    constWindSpeed=0,
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth(displayUnit="deg") = Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    albedo=plantRecord.environmentAlbedo,
    panelArea=plantRecord.panelArea,
    plantEfficiency=plantRecord.plantEfficiency,
    T_cell_ref=plantRecord.T_cell_ref) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Records.Data.PVplant_Ashland_15kW plantRecord annotation (Placement(transformation(extent={{-50,72},{-30,92}})));
  Records.Data.Location_Ashland location annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
equation
  connect(timeAsEpoch.y, inputData.u) annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(timeAsEpoch.y, referenceData.u) annotation (Line(points={{-69,0},{-60,
          0},{-60,-30},{-52,-30}}, color={0,0,127}));
  connect(referenceData.y[1], errorMetrics.measuredValue) annotation (Line(
        points={{-29,-30},{30,-30},{30,-6},{50,-6}}, color={0,0,127}));
  connect(inputData.y[3], plantModel.temperature) annotation (Line(points={{-29,0},{-18,0},{-18,-8},{-10,-8}}, color={0,0,127}));
  connect(plantModel.powerDC, errorMetrics.simulatedValue) annotation (Line(points={{10,8},{30,8},{30,6},{50,6}}, color={0,0,127}));
  connect(inputData.y[1], plantModel.directHorizontalIrradiance) annotation (Line(points={{-29,0},{-18,0},{-18,8},{-10,8}}, color={0,0,127}));
  connect(inputData.y[2], plantModel.diffuseHorizontalIrradiance) annotation (Line(points={{-29,0},{-18,0},{-18,3},{-10,3}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=345600, Interval=300),
    __Dymola_Commands(file=
          "Scripts/plot_WIP_HorizonatlIrradianceToPower_SaarlouisTownhall.mos"
        "plotOverview", file="Scripts/plot_WIP_HorizontalIrradianceToPower_Ashland15kWp.mos" "plotDetailed"));
end HorizontalIrradianceToPower_Ashland15kWp;
