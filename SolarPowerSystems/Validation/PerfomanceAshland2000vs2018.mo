within SolarPowerSystems.Validation;
model PerfomanceAshland2000vs2018
  "Comparison residuals irradiance POA to power using data from 2000 and 2018; 15kW-plant in Ashland, OR"
  extends Modelica.Icons.Example;

  constant Integer startDate2000 = 972198000;
  constant Integer startDate2018 = 1540191600;

  Components.SolarPowerPlants.None_Danny None_Danny2000(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    constTemperature(displayUnit="K") = 287.7,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    plantEfficiency=plantRecord.plantEfficiency,
    epochOffset=startDate2000)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Records.Data.Location_Ashland                     location
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})), choicesAllMatching=true);

  Records.Data.PVplant_Ashland_15kW                plantRecord
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})), __Dymola_choicesAllMatching=true);
  Utilities.MeasurementDataAshland measurementDataAshland2000(fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/200010_ashland.txt"),
      epochOffset=startDate2000)
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
  Modelica.Blocks.Sources.Constant diffuseHorizontalIrradiance(k=0)
    annotation (Placement(transformation(extent={{-86,-6},{-74,6}})));
  Interfaces.ValidationData validationData2000
    annotation (Placement(transformation(extent={{-62,36},{-50,48}})));
  Modelica.Blocks.Math.Feedback feedback2000
    annotation (Placement(transformation(extent={{40,38},{60,58}})));
  Modelica.Blocks.Interfaces.RealOutput residual2000
    "Simulated value minus measured value"
    annotation (Placement(transformation(extent={{90,38},{110,58}})));
  Components.SolarPowerPlants.None_Danny None_Danny2018(
    latitude=location.latitude,
    longitude=location.longitude,
    elevation=location.elevation,
    panelArea=plantRecord.panelArea,
    arrayTilt=Modelica.SIunits.Conversions.from_deg(plantRecord.panelTilt),
    arrayAzimuth=Modelica.SIunits.Conversions.from_deg(plantRecord.panelAzimuth),
    constTemperature(displayUnit="K") = 287.7,
    useTemperatureInput=true,
    useWindSpeedInput=true,
    T_cell_ref=plantRecord.T_cell_ref,
    albedo=plantRecord.environmentAlbedo,
    plantEfficiency=plantRecord.plantEfficiency,
    epochOffset=startDate2018)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

  Utilities.MeasurementDataAshland measurementDataAshland2018(fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/201810_ashland.txt"),
      epochOffset=startDate2018)
    annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
  Modelica.Blocks.Math.Feedback feedback2018
    annotation (Placement(transformation(extent={{40,-42},{60,-22}})));
  Interfaces.ValidationData validationDat2018
    annotation (Placement(transformation(extent={{-62,-44},{-50,-32}})));
  Modelica.Blocks.Interfaces.RealOutput residual2018
    "Simulated value minus measured value"
    annotation (Placement(transformation(extent={{90,-42},{110,-22}})));
  Modelica.Blocks.Continuous.Integrator measuredEnergy2000(
    y_start=0,
    k=3.6e-6,
    y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-4,12},{4,20}})));
  Modelica.Blocks.Continuous.Integrator measuredEnergy2018(
    y_start=0,
    k=3.6e-6,
    y(unit="kW.h"))
    annotation (Placement(transformation(extent={{-4,-20},{4,-12}})));
equation
  connect(diffuseHorizontalIrradiance.y, None_Danny2000.diffuseHorizontalIrradiance)
    annotation (Line(points={{-73.4,0},{-40,0},{-40,43},{-10,43}}, color={0,0,127}));
  connect(measurementDataAshland2000.validationData, validationData2000)
    annotation (Line(
      points={{-72,42},{-56,42}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData2000.windSpeed, None_Danny2000.windSpeed) annotation (
      Line(
      points={{-55.97,42.03},{-55.97,37},{-10,37}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData2000.ambientTemperature, None_Danny2000.temperature)
    annotation (Line(
      points={{-55.97,42.03},{-55.97,32},{-10,32}},
      color={255,204,51},
      thickness=0.5));
  connect(validationData2000.globalIrradiancePOA, None_Danny2000.directHorizontalIrradiance)
    annotation (Line(
      points={{-55.97,42.03},{-55.97,48},{-10,48}},
      color={255,204,51},
      thickness=0.5));
  connect(None_Danny2000.powerDC, feedback2000.u1)
    annotation (Line(points={{10,48},{42,48}}, color={0,0,127}));
  connect(validationData2000.powerDC, feedback2000.u2) annotation (Line(
      points={{-55.97,42.03},{-55.97,26},{50,26},{50,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(feedback2000.y, residual2000)
    annotation (Line(points={{59,48},{100,48}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance.y, None_Danny2018.diffuseHorizontalIrradiance)
    annotation (Line(points={{-73.4,0},{-40,0},{-40,-37},{-10,-37}}, color={0,0,
          127}));
  connect(measurementDataAshland2018.validationData, validationDat2018)
    annotation (Line(
      points={{-72,-38},{-56,-38}},
      color={255,204,51},
      thickness=0.5));
  connect(validationDat2018.windSpeed, None_Danny2018.windSpeed) annotation (
      Line(
      points={{-55.97,-37.97},{-55.97,-43},{-10,-43}},
      color={255,204,51},
      thickness=0.5));
  connect(validationDat2018.ambientTemperature, None_Danny2018.temperature)
    annotation (Line(
      points={{-55.97,-37.97},{-55.97,-48},{-10,-48}},
      color={255,204,51},
      thickness=0.5));
  connect(validationDat2018.globalIrradiancePOA, None_Danny2018.directHorizontalIrradiance)
    annotation (Line(
      points={{-55.97,-37.97},{-55.97,-32},{-10,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(None_Danny2018.powerDC, feedback2018.u1)
    annotation (Line(points={{10,-32},{42,-32}}, color={0,0,127}));
  connect(validationDat2018.powerDC, feedback2018.u2) annotation (Line(
      points={{-55.97,-37.97},{-55.97,-54},{50,-54},{50,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(feedback2018.y, residual2018)
    annotation (Line(points={{59,-32},{100,-32}}, color={0,0,127}));
  connect(validationData2000.powerDC, measuredEnergy2000.u) annotation (Line(
      points={{-55.97,42.03},{-55.97,16},{-4.8,16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(validationDat2018.powerDC, measuredEnergy2018.u) annotation (Line(
      points={{-55.97,-37.97},{-55.97,-16},{-4.8,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(
      StartTime=18000,
      StopTime=176400,
      Interval=300),      __Dymola_Commands(file=
          "Scripts/plot_Validation_PerformanceAshland2000vs2018.mos"
        "plotResult"));
end PerfomanceAshland2000vs2018;
