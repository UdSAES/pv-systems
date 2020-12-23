within SolarPowerSystems.Interfaces;
partial model PlantInEnvironment "Interface for models accounting for inclination/orientation of a PV plant in its environment"
  extends SolarPowerSystems.Icons.AngleOfIncidence;

  parameter Modelica.SIunits.Angle arrayTilt(min=0, max=90)
    "Array tilt in degree (horizontal equals 0°, vertical equals 90°)";
  parameter Modelica.SIunits.Angle arrayAzimuth(min=-180, max=180)
    "Array azimuth in degree (South equals 0°, positive towards west)";
  parameter Real albedo(
    min=0,
    max=1) = 0.2 "Ground reflectance/Albedo";


  Modelica.Blocks.Interfaces.RealInput diffuseHorizontalIrradiance(unit="W/m2")
    "Diffuse irradiance in horizontal plane" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput directHorizontalIrradiance(unit="W/m2")
    "Direct irradiance in horizontal plane" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,100})));
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
  Modelica.Blocks.Interfaces.RealInput solarAzimuth(unit="deg", displayUnit="deg") "The azimuth angle of the sun"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-60})));
  Modelica.Blocks.Interfaces.RealInput solarZenith(unit="deg", displayUnit="deg") "The zenith angle of the sun"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-20})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(unit="rad", displayUnit="deg")
    "The angle of incidence between surface normal and sun beam" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-40})));
  Components.SolarPosition.AngleOfIncidence angleOfIncidenceAsBlock(arrayTilt=arrayTilt, arrayAzimuth=arrayAzimuth)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-40})));
equation
  connect(solarZenith, angleOfIncidenceAsBlock.solarZenith)
    annotation (Line(points={{100,-20},{76,-20},{76,-36},{50,-36}}, color={0,0,127}));
  connect(solarAzimuth, angleOfIncidenceAsBlock.solarAzimuth)
    annotation (Line(points={{100,-60},{76,-60},{76,-44},{50,-44}}, color={0,0,127}));
  connect(angleOfIncidenceAsBlock.angleOfIncidence, angleOfIncidence)
    annotation (Line(points={{30,-40},{-100,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PlantInEnvironment;
