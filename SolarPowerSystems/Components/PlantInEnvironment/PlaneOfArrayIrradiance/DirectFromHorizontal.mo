within SolarPowerSystems.Components.PlantInEnvironment.PlaneOfArrayIrradiance;
model DirectFromHorizontal "Direct irradiance in tilted plane calculated from direct horizontal irradiance"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput solarZenith(displayUnit="deg", unit="deg")
    "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,60})));
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
  Modelica.SIunits.Angle solarHeight "Height of the sun";

protected
  Real threshold = Modelica.SIunits.Conversions.from_deg(15);
  Real b = directHorizontalIrradiance;
  Real c = directHorizontalIrradiance * cos(angleOfIncidence) / sin(solarHeight);
  Real f = solarHeight / threshold;

equation
  solarHeight = Modelica.SIunits.Conversions.from_deg((90 - solarZenith));
   if (solarHeight <= 0) or (abs(sin(solarHeight)) < threshold) then
     directInclinedIrradiance = max(0, b*(1 - f) + c*(f)); // "slide" from one equation to the other
   else
     directInclinedIrradiance = max(0, c); // equation c is now considered safe to use
   end if;

  // // this should be more correct theoretically, but the implementation above fits the observer behaviour better
  // if (solarHeight <= 0) then
  //   directInclinedIrradiance = 0;
  // elseif (abs(sin(solarHeight)) < threshold) and (solarHeight > 0) then
  //   directInclinedIrradiance = max(0, b*(1 - f) + c*(f)); // "slide" from one equation to the other
  // else
  //   directInclinedIrradiance = max(0, c); // equation c is now safe to use
  // end if;
end DirectFromHorizontal;
