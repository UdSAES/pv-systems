within SolarPowerSystems.Functions;
block angleOfIncidenceAsBlock
  "SI2SO block that applies angleOfIncidence()"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle";
  parameter Modelica.SIunits.Angle arrayAzimuth "Azimuth angle of array";

  Modelica.Blocks.Interfaces.RealInput solarZenith(final unit="rad", displayUnit="deg") "Solar zenith angle" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput solarAzimuth(final unit="rad", displayUnit="deg") "Solar azimuth angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle of incidence between surface normal and sun beam" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
equation
  angleOfIncidence = SolarPowerSystems.Functions.angleOfIncidence(
    solarZenith,
    solarAzimuth,
    arrayTilt,
    arrayAzimuth);
end angleOfIncidenceAsBlock;
