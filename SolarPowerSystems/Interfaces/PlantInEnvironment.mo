within SolarPowerSystems.Interfaces;
partial model PlantInEnvironment
  "Accounts for inclination/orientation of a PV plant in its environment"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle surfaceTilt "Surface tilt angle in rad";
  parameter Modelica.SIunits.Angle surfaceAzimuth
    "Azimuth angle of surface in rad";
  Modelica.Blocks.Interfaces.RealInput I_diff_horizontal(unit="W/m2")
    "Diffuse irradiance in horizontal plane" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-50,100})));
  Modelica.Blocks.Interfaces.RealInput I_dir_horizontal(unit="W/m2")
    "Direct irradiance in horizontal plane" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealInput albedo
    "The albedo of the plant's surroundings" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealOutput I_diff_inclined(unit="W/m2")
    "Diffuse irradiance on arbitrarily oriented surface" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-100})));
  Modelica.Blocks.Interfaces.RealOutput I_dir_inclined(unit="W/m2")
    "Direct irradiance on arbitrarily oriented surface" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealOutput I_refl_inclined(unit="W/m2")
    "Irradiance due to reflection on arbitrarily oriented surface" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-100})));
  Modelica.Blocks.Interfaces.RealInput azimuthOfSun
    "The azimuth angle of the sun" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={30,100})));
  Modelica.Blocks.Interfaces.RealInput zenithOfSun
    "The zenith angle of the sun" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={70,100})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PlantInEnvironment;
