within SolarPowerSystems.WIP;
model directHorizontalFromBus
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y1
               "Connector of Real output signal" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(validationData.directHorizontalIrradiance, realPassThrough.u) annotation (Line(
      points={{-99.9,0.1},{-56,0.1},{-56,0},{-12,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough.y, y1) annotation (Line(points={{11,0},{100,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end directHorizontalFromBus;
