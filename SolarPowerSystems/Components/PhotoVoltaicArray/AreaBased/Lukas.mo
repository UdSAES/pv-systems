within SolarPowerSystems.Components.PhotoVoltaicArray.AreaBased;
model Lukas "PV plant model based on the overall panel area (Lukas)"
  extends SolarPowerSystems.Interfaces.PhotoVoltaicArray;

  import SI = Modelica.SIunits;

  parameter SI.Area panel_area = 10;
  parameter SI.Efficiency overall_efficiency = 0.2;
  parameter SI.Efficiency temp_eta = 0;

  SI.Temp_C module_temperature;
  SI.Irradiance total_irra_on_panel;
  Real eta_mod;

equation

  module_temperature = T; // this is just wrong!
  (1 - (25 - module_temperature)*temp_eta) = eta_mod; // use parameter for now

  P_DC = panel_area * overall_efficiency * total_irra_on_panel * eta_mod;

  total_irra_on_panel = I_G_normal;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Text(
          extent={{18,-86},{18,-100}},
          lineColor={0,0,0},
          textString="P"),
        Text(
          extent={{44,100},{44,86}},
          lineColor={0,0,0},
          textString="I_G_normal")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end Lukas;
