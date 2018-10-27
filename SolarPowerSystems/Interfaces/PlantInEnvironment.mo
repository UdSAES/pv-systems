within SolarPowerSystems.Interfaces;
partial model PlantInEnvironment
  "Accounts for inclination/orientation of a PV plant in its environment"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle";
  parameter Modelica.SIunits.Angle arrayAzimuth "Azimuth angle of array (O° equals south, positive towards east)";

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
  Components.SolarPosition.AngleOfIncidence
                                 angleOfIncidenceAsBlock(arrayTilt=arrayTilt, arrayAzimuth=arrayAzimuth) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-40})));
equation
  connect(solarZenith, angleOfIncidenceAsBlock.solarZenith)
    annotation (Line(points={{100,-20},{70,-20},{70,-36},{50,-36}}, color={0,0,127}));
  connect(solarAzimuth, angleOfIncidenceAsBlock.solarAzimuth)
    annotation (Line(points={{100,-60},{70,-60},{70,-44},{50,-44}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{30,-40},{-100,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PlantInEnvironment;
