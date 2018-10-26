within SolarPowerSystems.Interfaces;
partial model PlantInEnvironment
  "Accounts for inclination/orientation of a PV plant in its environment"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle in rad";
  parameter Modelica.SIunits.Angle arrayAzimuth "Azimuth angle of array in rad";

  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance(unit="W/m2")
    "Diffuse irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2") "Direct irradiance in horizontal plane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,100})));
  Modelica.Blocks.Interfaces.RealInput albedo
    "The albedo of the plant's surroundings" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Blocks.Interfaces.RealOutput diffuseInclinedIrradiance(unit="W/m2")
    "Diffuse irradiance on arbitrarily oriented surface" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealOutput directInclinedIrradiance(unit="W/m2")
    "Direct irradiance on arbitrarily oriented surface" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-100})));
  Modelica.Blocks.Interfaces.RealOutput reflectedInclinedIrradiance(unit="W/m2")
    "Irradiance due to reflection on arbitrarily oriented surface" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-100})));
  Modelica.Blocks.Interfaces.RealInput solarAzimuth "The azimuth angle of the sun" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-60})));
  Modelica.Blocks.Interfaces.RealInput solarZenith "The zenith angle of the sun" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-20})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence "The angle of incidence between surface normal and sun beam"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-40})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PlantInEnvironment;
