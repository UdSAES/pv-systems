within SolarPowerSystems.Functions;
block angleOfIncidenceAsBlock
  "SI2SO block that applies angleOfIncidence()"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle surfaceTilt "Surface tilt angle in degrees";
  parameter Modelica.SIunits.Angle surfaceAzimuth "Azimuth angle of surface in degrees";

  Modelica.Blocks.Interfaces.RealInput zenith "Solar zenith angle" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput azimuth "Solar azimuth angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence
    "Angle of incidence between surface normal and sun beam" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
equation
  angleOfIncidence = SolarPowerSystems.Functions.angleOfIncidence(
    zenith,
    azimuth,
    surfaceTilt,
    surfaceAzimuth);
end angleOfIncidenceAsBlock;
