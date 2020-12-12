within SolarPowerSystems.Interfaces;
partial model PhotoVoltaicPowerPlant
  "Interface to be used by models to be exported as FMU in order to use it within MSaaS"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer epochOffset "The time at the start of the simulation as Epoch in s";
  parameter Boolean useTemperatureInput = false "=true, if environment temperature is provided" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Temperature constTemperature=293.15
    "Fixed environment temperature if useTemperatureInput = false"
    annotation(Dialog(enable=not useTemperatureInput));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=constTemperature) if not useTemperatureInput
    annotation (Placement(transformation(extent={{-64,-70},{-56,-62}})));

  parameter Boolean useWindSpeedInput = false "=true, if wind speed is provided" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Velocity constWindSpeed=1 "Fixed wind speed value if useWindSpeedInput = false" annotation(Dialog(enable=not useWindSpeedInput));
  Modelica.Blocks.Sources.Constant fixedWindSpeed(y(unit="m/s"), final k=constWindSpeed) if not useWindSpeedInput annotation (Placement(transformation(extent={{-64,-44},
            {-56,-36}})));

  parameter Real latitude(unit = "deg", min = -90, max = 90)
    "Latitude in decimal degrees" annotation(Dialog(group="Location"));
  parameter Real longitude(unit = "deg", min = -180, max = 180)
    "Longitude in decimal degrees" annotation(Dialog(group="Location"));
  parameter Real elevation(unit = "m", min = 0, max = 8848)
    "Height above sea level (elevation) in metres" annotation(Dialog(group="Location"));
  parameter Modelica.SIunits.Angle arrayTilt(min = 0, max = 90) "Array tilt in degree (horizontal equals 0°, vertical equals 90°)" annotation(Dialog(group="PV Plant"));
  parameter Modelica.SIunits.Angle arrayAzimuth(min = -180, max = 180) "Array azimuth in degree (South equals 0°, positive towards east)" annotation(Dialog(group="PV Plant"));
  parameter Real albedo=0.2 "Ground reflectance/Albedo" annotation(Dialog(group="PV Plant"));

  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance(unit="W/m2") "Diffuse irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,30})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2") "Direct irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,80})));
  Modelica.Blocks.Interfaces.RealInput temperature(unit="K") if useTemperatureInput "The temperature at the plant's site (optional input)"
                                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-80})));
  Modelica.Blocks.Interfaces.RealOutput powerDC(unit="W") "The generated power on the DC side"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput totalEnergyDC(unit="kW.h") "The generated energy on the DC side"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  replaceable           PlantInEnvironment inclinationAndShadowing(arrayTilt=arrayTilt, arrayAzimuth=arrayAzimuth,
    albedo=albedo)                                                 constrainedby PlantInEnvironment
                       "Select model to account for inclination and shadowing"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,0})), __Dymola_choicesAllMatching=true, Dialog(group="PV Plant", enable=false));
  Modelica.Blocks.Math.Add3 globalIrradiance(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface" annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  replaceable PhotoVoltaicArray plantIrradianceNormal(useHeatPort=true)
                                                      constrainedby PhotoVoltaicArray
                      "Select model of photovoltaic modules" annotation (
    Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,0})),
    __Dymola_choicesAllMatching=true,
    Dialog(group="PV Modules", enable=false));
  Modelica.Blocks.Continuous.Integrator integrator(k=3.6e-6)
    annotation (Placement(transformation(extent={{64,30},{84,50}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    latitude=latitude,
    longitude=longitude,
    height_above_sealevel=elevation,
    simu_start_epochs=epochOffset)
    annotation (Placement(transformation(extent={{-60,72},{-40,92}})));
  Components.SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    latitude=latitude,
    longitude=longitude,
    height_above_sealevel=elevation,
    simu_start_epochs=epochOffset)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    environmentTemperature if useTemperatureInput "The temperature of the surrounding air"
    annotation (Placement(transformation(extent={{-64,-84},{-56,-76}})));

  Modelica.Blocks.Interfaces.RealInput windSpeed if useWindSpeedInput
    "The wind speed at the plant's site (optional input)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-30})));

  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-64,36},{-56,44}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-64,-4},{-56,4}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-56,16},{-64,24}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1) annotation (Placement(transformation(extent={{76,-84},{84,-76}})));
  Modelica.Blocks.Sources.Constant transformFactor(k=90) "Factor to make angle positive iff sun is above horizon" annotation (Placement(transformation(extent={{54,-92},{62,-84}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfSunAboveHorizon(unit="deg") "Angle of Sun above horizon" annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(unit="rad", displayUnit="deg") "The angle of incidence between surface normal and sun beam" annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
    annotation (Placement(transformation(extent={{-44,-84},{-36,-76}})));

equation
  connect(totalEnergyDC, integrator.y)
    annotation (Line(points={{100,40},{85,40}}, color={0,0,127}));
  connect(plantIrradianceNormal.P_DC, powerDC) annotation (Line(points={{42,-4.44089e-16},
          {46,-4.44089e-16},{46,0},{50,0},{50,80},{100,80}}, color={0,0,127}));
  connect(plantIrradianceNormal.P_DC, integrator.u) annotation (Line(points={{42,
          -4.44089e-16},{46,-4.44089e-16},{46,0},{50,0},{50,40},{62,40}}, color=
         {0,0,127}));
  connect(globalIrradiance.y, plantIrradianceNormal.I_G_normal)
    annotation (Line(points={{8.8,0},{22,0}}, color={0,0,127}));
  connect(solarAzimuth.y,inclinationAndShadowing.solarAzimuth)  annotation (
      Line(points={{-39,82.2},{-26,82.2},{-26,10}},        color={0,0,127}));
  connect(solarZenith.y,inclinationAndShadowing.solarZenith)  annotation (Line(
        points={{-39,60.2},{-30,60.2},{-30,10}},        color={0,0,127}));
  connect(temperature, environmentTemperature.T)
    annotation (Line(points={{-100,-80},{-64.8,-80}},
                                                    color={0,0,127}));
  connect(environmentTemperature.port, internalHeatPort)
    annotation (Line(points={{-56,-80},{-40,-80}}, color={191,0,0}));
  connect(fixedTemperature.port, internalHeatPort)
    annotation (Line(points={{-56,-66},{-40,-66},{-40,-80}}, color={191,0,0}));
  connect(inclinationAndShadowing.directInclinedIrradiance, globalIrradiance.u1)
    annotation (Line(points={{-22,6},{-22,6.4},{-9.6,6.4}}, color={0,0,127}));
  connect(inclinationAndShadowing.diffuseInclinedIrradiance, globalIrradiance.u2)
    annotation (Line(points={{-22,0},{-9.6,0}}, color={0,0,127}));
  connect(inclinationAndShadowing.reflectedInclinedIrradiance, globalIrradiance.u3)
    annotation (Line(points={{-22,-6},{-22,-6.4},{-9.6,-6.4}}, color={0,0,127}));
  connect(inclinationAndShadowing.angleOfIncidence, plantIrradianceNormal.angleOfIncidence)
    annotation (Line(points={{-28,-10},{-28,-18},{25,-18},{25,-10}}, color={0,0,127}));
  connect(fixedWindSpeed.y, plantIrradianceNormal.u)
    annotation (Line(points={{-55.6,-40},{29,-40},{29,-10}}, color={0,0,127}));
  connect(windSpeed, plantIrradianceNormal.u) annotation (Line(points={{-100,-30},{29,-30},{29,-10}}, color={0,0,127}));
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(const.y, max.u2) annotation (Line(points={{-64.4,20},{-68,20},{-68,
          37.6},{-64.8,37.6}}, color={0,0,127}));
  connect(const.y, max1.u1) annotation (Line(points={{-64.4,20},{-68,20},{-68,
          2.4},{-64.8,2.4}}, color={0,0,127}));
  connect(max.y, inclinationAndShadowing.directHorizontalIrradiance)
    annotation (Line(points={{-55.6,40},{-50,40},{-50,6},{-42,6}}, color={0,0,
          127}));
  connect(max1.y, inclinationAndShadowing.diffuseHorizontalIrradiance)
    annotation (Line(points={{-55.6,0},{-42,0}}, color={0,0,127}));
  connect(diffuseHorizontalIrradiance, max1.u2) annotation (Line(points={{-100,
          30},{-72,30},{-72,-2.4},{-64.8,-2.4}}, color={0,0,127}));
  connect(directHorizontalIrradiance, max.u1) annotation (Line(points={{-100,80},
          {-68,80},{-68,42.4},{-64.8,42.4}}, color={0,0,127}));
  connect(solarZenith.y, add.u1) annotation (Line(points={{-39,60.2},{56,60.2},{56,-77.6},{75.2,-77.6}}, color={0,0,127}));
  connect(transformFactor.y, add.u2) annotation (Line(points={{62.4,-88},{68,-88},{68,-82.4},{75.2,-82.4}}, color={0,0,127}));
  connect(add.y, angleOfSunAboveHorizon) annotation (Line(points={{84.4,-80},{100,-80}}, color={0,0,127}));
  connect(inclinationAndShadowing.angleOfIncidence, angleOfIncidence) annotation (Line(points={{-28,-10},{-28,-18},{50,-18},{50,-60},{100,-60}}, color={0,0,127}));
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
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None), Line(points = {{0, 76}, {0, -76}}, color = {255, 255, 255}), Line(points = {{24, 76}, {24, -76}}, color = {255, 255, 255}), Line(points = {{54, 76}, {54, -76}}, color = {255, 255, 255})}));
end PhotoVoltaicPowerPlant;
