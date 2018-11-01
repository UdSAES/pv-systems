within SolarPowerSystems.Utilities;
model MeasurementDataTGM
  "Block for reading measurement data from the PV-plant on the roof of TGM in Vienna/Austria"
  extends Modelica.Blocks.Icons.Block;
  import ModelicaServices;

  parameter String fileName=ModelicaServices.ExternalReferences.loadResource("modelica://SolarPowerSystems/Resources/TGM_Trina_20160629.txt")
    "File where data from PV-plant on the roof of TGM in Vienna/Austria is stored";

  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableOnFile=true,
    fileName=fileName,
    tableName="trina",
    columns=2:10)      annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Modelica.Blocks.Sources.Clock clock(offset=0) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Interfaces.ValidationData validationData annotation (Placement(transformation(extent={{80,-20},{120,20}})));

protected
  Modelica.Blocks.Routing.RealPassThrough realPassThrough3
    annotation (Placement(transformation(extent={{34,74},{46,86}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough4
    annotation (Placement(transformation(extent={{34,-6},{46,6}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough5
    annotation (Placement(transformation(extent={{34,54},{46,66}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough1(y(unit="V"))
    annotation (Placement(transformation(extent={{34,-26},{46,-14}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough2(y(unit="A"))
    annotation (Placement(transformation(extent={{34,-46},{46,-34}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough6(y(unit="V"))
    annotation (Placement(transformation(extent={{34,34},{46,46}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough7(y(unit="A"))
    annotation (Placement(transformation(extent={{34,14},{46,26}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough8(y(unit="K"))
    annotation (Placement(transformation(extent={{34,-66},{46,-54}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough9(y(unit="K"))
    annotation (Placement(transformation(extent={{34,-86},{46,-74}})));
equation
  connect(clock.y, combiTable1Ds.u) annotation (Line(points={{-69,0},{-54,0}}, color={0,0,127}));
  connect(realPassThrough3.y, validationData.globalIrradiancePOA) annotation (Line(points={{46.6,80},{80,80},{80,0.1},{
          100.1,0.1}},                                                                                        color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[1], realPassThrough3.u)
    annotation (Line(points={{-31,0},{0,0},{0,80},{32.8,80}}, color={0,0,127}));
  connect(combiTable1Ds.y[5], realPassThrough5.u)
    annotation (Line(points={{-31,0},{0,0},{0,60},{32.8,60}}, color={0,0,127}));
  connect(realPassThrough5.y, validationData.powerDC) annotation (Line(points={{46.6,60},{80,60},{80,0.1},{100.1,0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[2], realPassThrough4.u) annotation (Line(points={{-31,0},{32.8,0}}, color={0,0,127}));
  connect(realPassThrough4.y, validationData.powerAC) annotation (Line(points={{46.6,0},{80,0},{80,0.1},{100.1,0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[3], realPassThrough1.u)
    annotation (Line(points={{-31,0},{0,0},{0,-20},{32.8,-20}}, color={0,0,127}));
  connect(realPassThrough1.y, validationData.voltageAC) annotation (Line(points={{46.6,-20},{80,-20},{80,0},{100,0}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[4], realPassThrough2.u)
    annotation (Line(points={{-31,0},{0,0},{0,-40},{32.8,-40}}, color={0,0,127}));
  connect(realPassThrough2.y, validationData.currentAC) annotation (Line(points={{46.6,-40},{80,-40},{80,0},{100,0}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[6], realPassThrough6.u)
    annotation (Line(points={{-31,0},{0,0},{0,40},{32.8,40}}, color={0,0,127}));
  connect(realPassThrough6.y, validationData.voltageDC) annotation (Line(points={{46.6,40},{80,40},{80,0},{100,0}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[7], realPassThrough7.u)
    annotation (Line(points={{-31,0},{0,0},{0,20},{32.8,20}}, color={0,0,127}));
  connect(realPassThrough7.y, validationData.currentDC) annotation (Line(points={{46.6,20},{80,20},{80,0},{100,0}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[8], realPassThrough8.u)
    annotation (Line(points={{-31,0},{0,0},{0,-60},{32.8,-60}}, color={0,0,127}));
  connect(realPassThrough8.y, validationData.T1) annotation (Line(points={{46.6,-60},{80,-60},{80,0},{100,0}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTable1Ds.y[9], realPassThrough9.u)
    annotation (Line(points={{-31,0},{0,0},{0,-80},{32.8,-80}}, color={0,0,127}));
  connect(realPassThrough9.y, validationData.T2) annotation (Line(points={{46.6,-80},{80,-80},{80,0},{100,0}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end MeasurementDataTGM;
