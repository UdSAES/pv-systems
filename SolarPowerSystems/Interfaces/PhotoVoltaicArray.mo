within SolarPowerSystems.Interfaces;
partial model PhotoVoltaicArray "Interface for models of PV arrays (total irradiance normal to surface -> power)"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort;
  extends SolarPowerSystems.Icons.PVModule;
  Modelica.Blocks.Interfaces.RealInput I_G_normal(unit="W/m2", min=0) "Total irradiance normal to module surface"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput P_DC(unit="W") "Generated power across all panels" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealInput angleOfIncidence(final unit="rad", displayUnit="deg")
    "Angle between direct beam and surface normal"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput u(final unit="m/s") "Wind speed in PV plane"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false)));
end PhotoVoltaicArray;
