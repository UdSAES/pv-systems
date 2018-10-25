within SolarPowerSystems.Interfaces;
partial model exportAsFMU
  "Interface to be used by models to be exported as FMU in order to use it within MSaaS"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer epochOffset "The time at the start of the simulation as Epoch in s";
  parameter Boolean useTemperatureInput = false "=true, if environment temperature is provided" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Temperature T=293.15
    "Fixed environment temperature if useTemperatureInput = false"
    annotation(Dialog(enable=not useTemperatureInput));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=T) if not useTemperatureInput
    annotation (Placement(transformation(extent={{-70,-64},{-54,-48}})));
  parameter Boolean useAlbedoInput = false "=true, if environment albedo is provided" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Real Albedo=0.2 "Fixed albedo value if useAlbedoInput = false"
    annotation(Dialog(enable=not useAlbedoInput));
  Modelica.Blocks.Sources.Constant fixedAlbedo(k=Albedo) if not useAlbedoInput
    annotation (Placement(transformation(extent={{-12,-48},{-28,-32}})));

  parameter Real latitude(unit = "deg", min = -90, max = 90)
    "Latitude in decimal degrees" annotation(Dialog(group="Location"));
  parameter Real longitude(unit = "deg", min = -180, max = 180)
    "Longitude in decimal degrees" annotation(Dialog(group="Location"));
  parameter Real elevation(unit = "m", min = 0, max = 8848)
    "Height above sea level (elevation) in metres" annotation(Dialog(group="Location"));
  parameter Real panelTilt(unit="deg", min = 0, max = 90) "Surface tilt in degree (Horizontal equals 0°, vertical equals 90°)" annotation(Dialog(group="PV Plant"));
  parameter Real panelAzimuth(unit="deg", min = -180, max = 180) "Surface azimuth in degree (South equals 0°, positive towards east)" annotation(Dialog(group="PV Plant"));

//   parameter Modelica.SIunits.Area panelArea "Overall surface area of all panels (combined)" annotation(Dialog(group="PV Modules"));
//   parameter Modelica.SIunits.Efficiency plantEfficiency = 0.2 "Overall efficiency" annotation(Dialog(group="PV Modules"));

  Modelica.Blocks.Interfaces.RealInput I_diff_horizontal(unit="W/m2")
    "Diffuse irradiance in horizontal plane" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));

  Modelica.Blocks.Interfaces.RealInput I_dir_horizontal(unit="W/m2")
    "Direct irradiance in horizontal plane" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput albedo if useAlbedoInput
    "The albedo of the plant's surroundings" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-40})));
  Modelica.Blocks.Interfaces.RealInput temperature(unit="K") if useTemperatureInput
    "The temperature at the plant's site (optional input)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-80})));
  Modelica.Blocks.Interfaces.RealOutput powerDC(unit="W")
    "The generated power on the DC side"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
//   Modelica.Blocks.Interfaces.RealOutput powerAC
//     "The generated power on the AC side"
//     annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealOutput totalEnergyDC(unit="W.s")
    "The generated energy on the DC side"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
//   Modelica.Blocks.Interfaces.RealOutput totalEnergyAC
//     "The generated energy on the AC side"
//     annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  replaceable           PlantInEnvironment inclinationAndShadowing(surfaceTilt=
        Modelica.SIunits.Conversions.from_deg(panelTilt), surfaceAzimuth=
        Modelica.SIunits.Conversions.from_deg(panelAzimuth)) constrainedby
    PlantInEnvironment "Select model to account for inclination and shadowing"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,0})), __Dymola_choicesAllMatching=true, Dialog(group="PV Plant", enable=false));
  Modelica.Blocks.Math.Add3 I_G_normal(
    k1=1,
    k2=1,
    k3=1) "Global irradiance normal to panel surface"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  replaceable PlantIrradianceNormal plantIrradianceNormal constrainedby
    PlantIrradianceNormal "Select model of photovoltaic modules"                                annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,0})), __Dymola_choicesAllMatching=true, Dialog(group="PV Modules", enable=false));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{64,30},{84,50}})));
  Components.SolarPosition.SolarAzimuth solarAzimuth(
    latitude=latitude,
    longitude=longitude,
    height_above_sealevel=elevation,
    simu_start_epochs=epochOffset)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Components.SolarPosition.SolarZenith solarZenith(
    latitude=latitude,
    longitude=longitude,
    height_above_sealevel=elevation,
    simu_start_epochs=epochOffset)
    annotation (Placement(transformation(extent={{-90,74},{-70,94}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    environmentTemperature if useTemperatureInput "The temperature of the surrounding air"
    annotation (Placement(transformation(extent={{-70,-88},{-54,-72}})));

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
  connect(I_G_normal.y, plantIrradianceNormal.I_G_normal)
    annotation (Line(points={{11,0},{22,0}}, color={0,0,127}));
  connect(inclinationAndShadowing.I_refl_inclined, I_G_normal.u1)
    annotation (Line(points={{-22,6},{-22,8},{-12,8}}, color={0,0,127}));
  connect(inclinationAndShadowing.I_dir_inclined, I_G_normal.u2)
    annotation (Line(points={{-22,0},{-12,0}}, color={0,0,127}));
  connect(inclinationAndShadowing.I_diff_inclined, I_G_normal.u3)
    annotation (Line(points={{-22,-6},{-22,-8},{-12,-8}}, color={0,0,127}));
  connect(I_diff_horizontal, inclinationAndShadowing.I_diff_horizontal)
    annotation (Line(points={{-100,0},{-62,0},{-62,-5},{-42,-5}}, color={0,0,127}));
  connect(I_dir_horizontal, inclinationAndShadowing.I_dir_horizontal)
    annotation (Line(points={{-100,40},{-60,40},{-60,-2},{-42,-2}}, color={0,0,127}));
  connect(albedo, inclinationAndShadowing.albedo) annotation (Line(points={{-100,
          -40},{-60,-40},{-60,-8},{-42,-8}}, color={0,0,127}));
  connect(solarAzimuth.y, inclinationAndShadowing.azimuthOfSun) annotation (
      Line(points={{-69,60.2},{-58,60.2},{-58,3},{-42,3}}, color={0,0,127}));
  connect(solarZenith.y, inclinationAndShadowing.zenithOfSun) annotation (Line(
        points={{-69,84.2},{-56,84.2},{-56,7},{-42,7}}, color={0,0,127}));
  connect(temperature, environmentTemperature.T)
    annotation (Line(points={{-100,-80},{-71.6,-80}},
                                                    color={0,0,127}));
  connect(environmentTemperature.port, internalHeatPort)
    annotation (Line(points={{-54,-80},{-40,-80}}, color={191,0,0}));
  connect(fixedTemperature.port, internalHeatPort)
    annotation (Line(points={{-54,-56},{-40,-56},{-40,-80}}, color={191,0,0}));
  connect(fixedAlbedo.y, inclinationAndShadowing.albedo) annotation (Line(
        points={{-28.8,-40},{-60,-40},{-60,-8},{-42,-8}}, color={0,0,127}));
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
end exportAsFMU;
