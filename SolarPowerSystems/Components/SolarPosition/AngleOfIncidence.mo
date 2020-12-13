within SolarPowerSystems.Components.SolarPosition;
block AngleOfIncidence "SI2SO block that calculates the angle between sun beam and surface normal"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle arrayTilt "Array tilt angle";
  parameter Modelica.SIunits.Angle arrayAzimuth "Azimuth angle of array";

  Modelica.Blocks.Interfaces.RealInput solarZenith(unit="deg", displayUnit="deg") "Solar zenith angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput solarAzimuth(unit="deg", displayUnit="deg") "Solar azimuth angle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealOutput angleOfIncidence(unit="rad", displayUnit="deg")
    "Angle of incidence between surface normal and sun beam" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.SIunits.Angle arrayAzimuthSolarCS "Array azimuth in the same coordinate system as the sun's position";
  Modelica.SIunits.Angle solarHeight=Modelica.SIunits.Conversions.from_deg(90 - solarZenith) "Height of the sun";
protected
  Modelica.SIunits.Angle angleOfIncidenceFullCircle;

equation
  arrayAzimuthSolarCS = arrayAzimuth + Modelica.Constants.pi;
  //     solarHeight = Modelica.SIunits.Conversions.from_deg(90 - solarZenith);
  //     angleOfIncidence = min(Modelica.SIunits.Conversions.from_deg(90), acos( sin(solarHeight)*cos(arrayTilt)
  //                                 - cos(solarHeight)*sin(arrayTilt)
  //                                 * cos(Modelica.SIunits.Conversions.from_deg(solarAzimuth) - arrayAzimuthSolarCS)));
  //     angleOfIncidence = acos( sin(solarHeight)*cos(arrayTilt)
  //                                 - cos(solarHeight)*sin(arrayTilt)
  //                                 * cos(Modelica.SIunits.Conversions.from_deg(solarAzimuth) - arrayAzimuthSolarCS))
  //                        - Modelica.SIunits.Conversions.from_deg(90);
  //     angleOfIncidence = acos( sin(solarHeight)*cos(arrayTilt)
  //                                 - cos(solarHeight)*sin(arrayTilt)
  //                                 * cos(Modelica.SIunits.Conversions.from_deg(solarAzimuth) - arrayAzimuthSolarCS));

  angleOfIncidenceFullCircle = acos(cos(Modelica.SIunits.Conversions.from_deg(solarZenith))*cos(arrayTilt) + sin(
    Modelica.SIunits.Conversions.from_deg(solarZenith))*sin(arrayTilt)*cos(Modelica.SIunits.Conversions.from_deg(
    solarAzimuth) - arrayAzimuthSolarCS));

  if (angleOfIncidenceFullCircle > -2*Modelica.Constants.pi and angleOfIncidenceFullCircle < -3*Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle + 2*Modelica.Constants.pi;
  elseif (angleOfIncidenceFullCircle < 2*Modelica.Constants.pi and angleOfIncidenceFullCircle > 3*Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle - 2*Modelica.Constants.pi;
  elseif (angleOfIncidenceFullCircle < Modelica.Constants.pi/2 and angleOfIncidenceFullCircle > -Modelica.Constants.pi
      /2) then
    angleOfIncidence = angleOfIncidenceFullCircle;
  else
    angleOfIncidence = angleOfIncidenceFullCircle;
  end if;

end AngleOfIncidence;
