within SolarPowerSystems.WIP.CellTemperature;
model Faiman "Model by Faiman, 2008"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Interfaces.RealInput globalIrradiancePOA(unit="W/m2")
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,60})));
equation
  connect(globalIrradiancePOA, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-100,60},{-70,60},{-70,0},{-50,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Faiman;
