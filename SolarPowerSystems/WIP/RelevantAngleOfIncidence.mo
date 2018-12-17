within SolarPowerSystems.WIP;
model RelevantAngleOfIncidence "Test model to find correct conversion of relevant angles to range [-90, 90]"
  Real x;
  Real y;
  Real lower180(unit="deg") = -180;
  Real upper180(unit="deg") = 180;
  Real lower90(unit="deg") = -90;
  Real upper90(unit="deg") = 90;
  Real lower90rad(unit="rad") = -pi/2;
  Real upper90rad(unit="rad") = pi/2;
  Real lower270rad(unit="rad") = -3*pi/2;
  Real upper270rad(unit="rad") = 3*pi/2;
  Real pi = Modelica.Constants.pi;
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
//  x = 0.7*sin(time*6) + 1.9;
  x = 2*pi*sin(time*6);
  if (x > -2*pi and x < -3*pi/2) then
    y = x + 2*pi;
  elseif (x < 2*pi and x > 3*pi/2) then
    y = x - 2*pi;
  elseif (x < pi/2 and x > -pi/2) then
    y = x;
  else
    y = 0;
  end if;
  to_deg.u = y;
  annotation (__Dymola_Commands(file="Scripts/plot_WIP_RelevantAngleOfIncidence.mos" "plotResult"), experiment(StopTime=
         2));
end RelevantAngleOfIncidence;
