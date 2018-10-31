within SolarPowerSystems.WIP.DirectNormalIrradianceEstimation;
model ReindlEtAl_1 "Decomposition model to estimate DNI from GHI"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealOutput directNormalIrradiance(unit="W/m2")
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput extraterrestrialRadiation(unit="W/m2")
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput globalHorizontalIrradiance(unit="W/m2") "Global irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput solarZenith(displayUnit="deg", unit="deg")
    "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,60})));
  Real kt(min=0, max=1) "Clearness index";
  Real kd "Diffuse fraction";

equation
  kt = globalHorizontalIrradiance / (extraterrestrialRadiation * cos(Modelica.SIunits.Conversions.from_deg(solarZenith)));

  if (kt <= 0.3) then
    kd = 1.02 - 0.248*kt;
  elseif (kt > 0.3) and (kt < 0.78) then
    kd = 1.45 - 1.67*kt;
  else
    kd = 0.147;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ReindlEtAl_1;
