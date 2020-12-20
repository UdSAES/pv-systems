within SolarPowerSystems.Components.PlantInEnvironment.PlaneOfArrayIrradiance;
model DirectFromHorizontal
  "Direct irradiance in tilted plane calculated from direct horizontal irradiance"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput solarZenith(displayUnit="deg", unit="deg") "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,60})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2")
    "Direct irradiance in horizontal plane" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(unit="rad", displayUnit="deg")
    "Direct irradiance in horizontal plane" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealOutput directInclinedIrradiance(unit="W/m2")
    "Direct irradiance on inclined surface" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.SIunits.Angle solarHeight "Height of the sun";

protected
  Real threshold=Modelica.SIunits.Conversions.from_deg(15);
  Real b=directHorizontalIrradiance;
  Real c=directHorizontalIrradiance*cos(angleOfIncidence)/sin(solarHeight);
  Real f=solarHeight/threshold;

equation
  solarHeight = Modelica.SIunits.Conversions.from_deg((90 - solarZenith));
  if (solarHeight <= 0) or (abs(sin(solarHeight)) < threshold) then
    directInclinedIrradiance = max(0, b*(1 - f) + c*(f));
    // "slide" from one equation to the other
  else
    directInclinedIrradiance = max(0, c);
    // equation c is now considered safe to use
  end if;
  annotation (Diagram(graphics={Text(
          extent={{2,74},{96,56}},
          lineColor={28,108,200},
          textString="Non-graphical implementation (see text layer)")}), Documentation(info="<html>
<p>Since the direct irradiance in the plane of array needs to be calculated from the direct <i>horizontal</i> irradiance (direct normal irradiance typically not available and massively complicated to estimate), a workaround for avoiding the unphysical spikes caused by the division of the cosine of the solar zenith angle around 90&deg; by the sine of the solar height around 0&deg; needs to be found. Because the direct irradiance in an inclined plane is always greater than or equal to the direct horizontal irradiance, it was decided to &quot;slide&quot; from equality to the actual equation.</p>
</html>"));
end DirectFromHorizontal;
