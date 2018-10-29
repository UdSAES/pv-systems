within SolarPowerSystems.Components.PlantInEnvironment.PlaneOfArrayIrradiance;
model DirectFromHorizontal "Direct irradiance in tilted plane calculated from direct horizontal irradiance"

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle";

  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2") "Direct irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(unit="rad", displayUnit="deg")
                                                                    "Direct irradiance in horizontal plane" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealOutput directInclinedIrradiance(unit="W/m2") "Direct irradiance on inclined surface"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  directInclinedIrradiance = directHorizontalIrradiance * cos(arrayTilt) / sin(angleOfIncidence);
  annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}));
end DirectFromHorizontal;
