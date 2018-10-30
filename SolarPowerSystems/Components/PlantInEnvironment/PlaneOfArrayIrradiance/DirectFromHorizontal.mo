within SolarPowerSystems.Components.PlantInEnvironment.PlaneOfArrayIrradiance;
model DirectFromHorizontal "Direct irradiance in tilted plane calculated from direct horizontal irradiance"

  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2") "Direct irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(unit="rad", displayUnit="deg")
    "Direct irradiance in horizontal plane"                                                                 annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealOutput directInclinedIrradiance(unit="W/m2") "Direct irradiance on inclined surface"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.SIunits.Angle solarHeight = Modelica.SIunits.Conversions.from_deg(max(10, (90 - solarZenith))) "Height of the sun";

  Modelica.Blocks.Interfaces.RealInput solarZenith(displayUnit="deg", unit="deg")
    "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,60})));
equation
  directInclinedIrradiance = noEvent(max(0, directHorizontalIrradiance * cos(angleOfIncidence) / sin(solarHeight)));
  annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}));
end DirectFromHorizontal;
