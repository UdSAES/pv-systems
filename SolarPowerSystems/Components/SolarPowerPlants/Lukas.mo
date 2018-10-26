within SolarPowerSystems.Components.SolarPowerPlants;
model Lukas
  "see http://rredc.nrel.gov/solar/glossary/gloss_g.html for definitions of GHI, ...."
  // import FUN = MSaaSModelicaExport.Utilities.Functions;
  import SI = Modelica.SIunits;
  parameter Real latitude(unit = "deg", min = 47.0, max = 56.0) = 49.26
    "pos north of entity";
  parameter Real longitude(unit = "deg", min = 5.0, max = 16.0) = 7.04
    "pos east of entity";
  parameter Real height_above_sealevel(unit = "m", min = 0, max = 4000) = 230
    "height above sealevel of entity";
  parameter Real simu_start_epochs(unit="s", min = 0) = 1388534400
    "offset between simulation time and unix time (epochs), default 01/01/2014";
  Real epoch_time;

  Real azimuth(unit = "rad", displayUnit = "deg") "eastward from north";
  Real zenith(unit = "rad", displayUnit = "deg");

  // parameters of SolarPlant
  parameter SI.Area panel_area = 10;
  parameter SI.Efficiency overall_efficiency = 0.2;
  parameter SI.Efficiency temp_eta = 0;
  parameter SI.Angle panel_azimuth = 0 "south equal 0, positive towards east";
  parameter SI.Angle panel_slope = 30 "horizontal equals 0";
  parameter Real surface_albedo = 0.2;
  parameter SI.Temp_C module_temperature= 25;

  // irradiance
  SI.Irradiance total_irra_on_panel;
  SI.Irradiance direct_irra_on_panel;
  SI.Irradiance diffuse_irra_on_panel;
  SI.Irradiance ref_irra_on_panel;
  SI.Irradiance DNI;

  Real eta_mod;

  //
  SI.Angle angle_of_incidence;

  Modelica.Blocks.Interfaces.RealOutput P(unit= "W") annotation (Placement(transformation(extent={{86,44},
            {126,84}}), iconTransformation(extent={{100,58},{126,84}})));

  Modelica.Blocks.Interfaces.RealInput GHI(unit= "W/m2")
    annotation (Placement(transformation(extent={{-128,52},{-88,92}}),
        iconTransformation(extent={{-112,68},{-88,92}})));
  Modelica.Blocks.Interfaces.RealInput DHI(unit= "W/m2") annotation (Placement(
        transformation(extent={{-126,-110},{-86,-68}}), iconTransformation(
          extent={{-110,-92},{-86,-68}})));

  SolarPosition.SolarPositionAlgorithm.SolarAzimuth solarAzimuth(
    final latitude=latitude,
    final longitude=longitude,
    final height_above_sealevel=height_above_sealevel,
    final simu_start_epochs=simu_start_epochs)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  SolarPosition.SolarPositionAlgorithm.SolarZenith solarZenith(
    final latitude=latitude,
    final longitude=longitude,
    final height_above_sealevel=height_above_sealevel,
    final simu_start_epochs=simu_start_epochs)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Interfaces.RealOutput Zenith(unit="deg") annotation (
      Placement(transformation(extent={{90,-20},{130,20}}),
        iconTransformation(extent={{100,-52},{126,-26}})));
  Modelica.Blocks.Interfaces.RealOutput Azimuth(unit="deg") annotation (
      Placement(transformation(extent={{92,-80},{132,-40}}),
        iconTransformation(extent={{100,-92},{126,-66}})));
equation

  epoch_time = time + simu_start_epochs;

  azimuth = SI.Conversions.from_deg(solarAzimuth.y);
  zenith = SI.Conversions.from_deg(solarZenith.y);

  // use parameter for now
  (1 - (25 - module_temperature)*temp_eta) = eta_mod;

  P = panel_area * overall_efficiency * total_irra_on_panel * eta_mod;

  // DNI (beam), simple workaround to avoid devision by zero
  DNI = noEvent(max(0,(GHI-DHI))) /noEvent(max(cos(zenith), 0.1));
  angle_of_incidence =SolarPowerSystems.Functions.angleOfIncidence(
    zenith,
    azimuth,
    panel_slope,
    panel_azimuth);

  direct_irra_on_panel = noEvent(max(0, DNI * cos(angle_of_incidence)));
  diffuse_irra_on_panel = noEvent(max(0, DHI  * 0.5 * (1 + cos(panel_slope))));

  ref_irra_on_panel = surface_albedo * GHI * 0.5 * (1 - cos(panel_slope));
  total_irra_on_panel = direct_irra_on_panel + diffuse_irra_on_panel + ref_irra_on_panel;

  connect(solarAzimuth.y, Azimuth) annotation (Line(points={{-39,10.2},{26.5,
          10.2},{26.5,-60},{112,-60}}, color={0,0,127}));
  connect(Zenith, solarZenith.y) annotation (Line(points={{110,0},{36,0},{36,
          50.2},{-39,50.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-72,88},{-72,74}},
          lineColor={0,0,0},
          textString="GHI"),
        Text(
          extent={{-68,-72},{-68,-86}},
          lineColor={0,0,0},
          textString="DHI"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Text(
          extent={{80,76},{80,62}},
          lineColor={0,0,0},
          textString="P"),
        Text(
          extent={{72,-30},{72,-44}},
          lineColor={0,0,0},
          textString="Zenith"),
        Text(
          extent={{74,-74},{74,-88}},
          lineColor={0,0,0},
          textString="Azimuth")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end Lukas;
