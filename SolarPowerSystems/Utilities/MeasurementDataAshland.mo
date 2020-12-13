within SolarPowerSystems.Utilities;
model MeasurementDataAshland "Block for reading measurement data from the PV-plant in Ashland, OR"
  extends Modelica.Blocks.Icons.Block;
  import ModelicaServices;

  parameter Modelica.SIunits.Time epochOffset=1540598400 "Time at the beginning of the simulation as unix epoch";
  parameter String fileName=ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/201810_ashland.txt")
    "File where data from PV-plant in Ashland, OR is stored";

  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableOnFile=true,
    tableName="ashland",
    columns=2:9,
    fileName=fileName) annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Modelica.Blocks.Sources.Clock timeAsEpoch(offset=epochOffset)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Math.Add substract(k1=+1, k2=-1) annotation (Placement(transformation(extent={{34,54},{46,66}})));

  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{80,-20},{120,20}})));

protected
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{34,34},{46,46}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough1
    annotation (Placement(transformation(extent={{34,74},{46,86}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough2
    annotation (Placement(transformation(extent={{34,14},{46,26}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough3
    annotation (Placement(transformation(extent={{34,-6},{46,6}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough4
    annotation (Placement(transformation(extent={{34,-46},{46,-34}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough5
    annotation (Placement(transformation(extent={{34,-26},{46,-14}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough6
    annotation (Placement(transformation(extent={{34,-66},{46,-54}})));
equation
  connect(timeAsEpoch.y, combiTable1Ds.u) annotation (Line(points={{-69,0},{-54,0}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], substract.u1)
    annotation (Line(points={{-31,0},{0,0},{0,63.6},{32.8,63.6}}, color={0,0,127}));
  connect(combiTable1Ds.y[3], substract.u2)
    annotation (Line(points={{-31,0},{0,0},{0,56.4},{32.8,56.4}}, color={0,0,127}));
  connect(combiTable1Ds.y[8], toKelvin.Celsius)
    annotation (Line(points={{-31,0},{0,0},{0,-80},{28,-80}}, color={0,0,127}));
  connect(substract.y, validationData.directHorizontalIrradiance) annotation (Line(points={{46.6,60},{80,60},{80,0.1},
          {100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[3], realPassThrough.u)
    annotation (Line(points={{-31,0},{0,0},{0,40},{32.8,40}}, color={0,0,127}));
  connect(realPassThrough.y, validationData.diffuseHorizontalIrradiance) annotation (Line(points={{46.6,40},{80,40},
          {80,0.1},{100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[1], realPassThrough1.u)
    annotation (Line(points={{-31,0},{0,0},{0,80},{32.8,80}}, color={0,0,127}));
  connect(realPassThrough1.y, validationData.globalHorizontalIrradiance) annotation (Line(points={{46.6,80},{80,80},
          {80,0.1},{100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[2], realPassThrough2.u)
    annotation (Line(points={{-31,0},{0,0},{0,20},{32.8,20}}, color={0,0,127}));
  connect(realPassThrough2.y, validationData.directNormalIrradiance) annotation (Line(points={{46.6,20},{80,20},{80,
          0.1},{100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[4], realPassThrough3.u) annotation (Line(points={{-31,0},{32.8,0}}, color={0,0,127}));
  connect(realPassThrough3.y, validationData.globalIrradiancePOA) annotation (Line(points={{46.6,0},{74,0},{74,0.1},
          {100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[5], realPassThrough5.u)
    annotation (Line(points={{-31,0},{0,0},{0,-20},{32.8,-20}}, color={0,0,127}));
  connect(realPassThrough5.y, validationData.powerDCsystem1) annotation (Line(points={{46.6,-20},{80,-20},{80,0},{100,
          0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[6], realPassThrough4.u)
    annotation (Line(points={{-31,0},{0,0},{0,-40},{32.8,-40}}, color={0,0,127}));
  connect(realPassThrough4.y, validationData.powerDCsystem2) annotation (Line(points={{46.6,-40},{80,-40},{80,0},{100,
          0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[7], realPassThrough6.u)
    annotation (Line(points={{-31,0},{0,0},{0,-60},{32.8,-60}}, color={0,0,127}));
  connect(realPassThrough6.y, validationData.windSpeed) annotation (Line(points={{46.6,-60},{80,-60},{80,0.1},{100.1,
          0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(toKelvin.Kelvin, validationData.ambientTemperature) annotation (Line(points={{51,-80},{80,-80},{80,0.1},{100.1,
          0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough4.y, validationData.powerDC)
    annotation (Line(points={{46.6,-40},{80,-40},{80,0.1},{100.1,0.1}}, color={0,0,127}));
end MeasurementDataAshland;
