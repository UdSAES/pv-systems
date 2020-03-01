within SolarPowerSystems.Validation;
model HorizontalIrradianceToPower_Ashland
  "Comparison simulation versus measurements: from horizontal irradiance to power, using the 15kW plant in Ashland"
  extends Modelica.Icons.Example;
  Components.SolarPowerPlants.Perez_Danny Perez_Danny(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    constTemperature(displayUnit="K") = 287.7,
    epochOffset=startTime.k,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    plantEfficiency=plantRecord.plantEfficiency)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Records.Data.Location_Ashland                     location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Continuous.Integrator totalEnergyMeasuredDC(k=3.6e-6, y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-6,-46},{6,-34}})));
  Modelica.Blocks.Sources.IntegerConstant startTime(k=972198000)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Utilities.MeasurementDataAshland measurementDataAshland(epochOffset=startTime.k, fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/200010_ashland.txt"))
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));

  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{40,-10},
            {60,10}})));
  Modelica.Blocks.Interfaces.RealOutput residual(unit="W", displayUnit="kW")
                                                 "Simulated value minus measured value"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(measurementDataAshland.validationData, validationData)
    annotation (Line(
      points={{-68,0},{-50,0}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.windSpeed, Perez_Danny.windSpeed) annotation (Line(
      points={{-49,97,0,03},{-49,97,-3},{-10,-3}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.ambientTemperature, Perez_Danny.temperature)
    annotation (Line(
      points={{-49,97,0,03},{-49,97,-8},{-10,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.powerDC, totalEnergyMeasuredDC.u)
    annotation (Line(
      points={{-49,97,0,03},{-49,97,-40},{-7,2,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(Perez_Danny.powerDC, feedback.u1)
    annotation (Line(points={{10,8},{30,8},{30,0},{42,0}}, color={0,0,127}));
  connect(validationData.powerDC, feedback.u2) annotation (Line(
      points={{-49,97,0,03},{-49,97,-20},{50,-20},{50,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(feedback.y, residual) annotation (Line(points={{59,0},{100,0}},   color={0,0,127}));
  connect(validationData.diffuseHorizontalIrradiance, Perez_Danny.diffuseHorizontalIrradiance)
    annotation (Line(
      points={{-49,97,0,03},{-50,0,03},{-50,3},{-10,3}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData.directHorizontalIrradiance, Perez_Danny.directHorizontalIrradiance)
    annotation (Line(
      points={{-49,97,0,03},{-49,97,8},{-10,8}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=300),      __Dymola_Commands(file=
          "Scripts/plot_Validation_HorizontalIrradianceToPower_Ashland.mos"
        "plotResult", file=
          "Scripts/plot_Validation_HorizontalIrradianceToPower_Ashland_OverviewUsingDesignetzColours.mos"
        "plotOverviewUsingDesignetzColours"));
end HorizontalIrradianceToPower_Ashland;
