within SolarPowerSystems.WIP.Obsolete;
model Simple "Transform horizontal irradiance to normal of arbitrarily oriented surface, do not account for shadows"
  extends Interfaces.PlantInEnvironment;
  import SI = Modelica.SIunits;

//   parameter SI.Angle surfaceAzimuth = 0 "south equal 0, positive towards east";
//   parameter SI.Angle surfaceTilt = 30 "horizontal equals 0";

  Real azimuth(unit = "rad", displayUnit = "deg") "eastward from north";
  Real zenith(unit = "rad", displayUnit = "deg");

  SI.Irradiance direct_irra_on_panel;
  SI.Irradiance diffuse_irra_on_panel;
  SI.Irradiance ref_irra_on_panel;
SI.Irradiance DNI;

  SI.Angle angle_of_incidence;
  Real surfaceAlbedo;

equation
  // Input mapping
  azimuth = SI.Conversions.from_deg(solarAzimuth);
  zenith = SI.Conversions.from_deg(solarZenith);
  surfaceAlbedo = albedo;

  // Actual equations
  angle_of_incidence =SolarPowerSystems.WIP.Obsolete.Functions.angleOfIncidence(
    zenith,
    azimuth,
    surfaceTilt,
    surfaceAzimuth);

  // DNI (beam), simple workaround to avoid devision by zero
 DNI =noEvent(max(0, (directHorizontalIrradiance)))/noEvent(max(cos(zenith), 0.1));
 direct_irra_on_panel = noEvent(max(0, DNI * cos(angle_of_incidence)));
  // direct_irra_on_panel = noEvent(max(0, I_dir_horizontal * cos(angle_of_incidence) / sin(Modelica.Constants.pi/2 - zenith)));
  diffuse_irra_on_panel =noEvent(max(0, diffuseHorizontalIrradiance*0.5*(1 + cos(surfaceTilt))));
                                                                                              // isotropic, eq. 2.36 on page 67

  ref_irra_on_panel =surfaceAlbedo*(directHorizontalIrradiance + diffuseHorizontalIrradiance)*0.5*(1 - cos(surfaceTilt));

  // Ouput mapping
  directInclinedIrradiance = direct_irra_on_panel;
  diffuseInclinedIrradiance = diffuse_irra_on_panel;
  reflectedInclinedIrradiance = ref_irra_on_panel;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end Simple;
