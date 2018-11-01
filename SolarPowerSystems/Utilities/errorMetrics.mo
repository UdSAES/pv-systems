within SolarPowerSystems.Utilities;
model errorMetrics "Block for calculating (n)MAE and (n)RMSE"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Frequency f "Base frequency";
  parameter Real x0=0 "Start value of integrator state";

  Modelica.Blocks.Math.RectifiedMean meanAbsoluteError(f=f, x0=x0) annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareError(f=f, x0=x0)
    annotation (Placement(transformation(extent={{28,-30},{48,-10}})));
  Modelica.Blocks.Math.Variance variance annotation (Placement(transformation(extent={{-18,38},{-2,54}})));
  Modelica.Blocks.Math.StandardDeviation standardDeviation
    annotation (Placement(transformation(extent={{-18,18},{-2,34}})));
  Modelica.Blocks.Math.Feedback absoluteError annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Interfaces.RealInput simulatedValue
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput measuredValue
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput MAE annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput RMSE annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

//   Modelica.Blocks.Math.Division normalizedMAE annotation (Placement(transformation(extent={{68,14},{80,26}})));
//   Modelica.Blocks.Math.Mean mean(f=f, x0=x0) annotation (Placement(transformation(extent={{-48,-8},{-32,8}})));
//   Modelica.Blocks.Math.Division normalizedRMSE annotation (Placement(transformation(extent={{68,-66},{80,-54}})));
//   Modelica.Blocks.Math.Min min annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
//   Modelica.Blocks.Sources.RealExpression realExpression(y=if initial() then 1 else Modelica.Constants.inf)
//     annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
//   Modelica.Blocks.Interfaces.RealOutput nMAE annotation (Placement(transformation(extent={{90,10},{110,30}})));
//   Modelica.Blocks.Interfaces.RealOutput nRMSE annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

equation
  connect(absoluteError.u1, simulatedValue) annotation (Line(points={{-68,60},{-100,60}}, color={0,0,127}));
  connect(measuredValue, absoluteError.u2) annotation (Line(points={{-100,-60},{-60,-60},{-60,52}}, color={0,0,127}));
  connect(absoluteError.y, meanAbsoluteError.u) annotation (Line(points={{-51,60},{28,60}}, color={0,0,127}));
  connect(absoluteError.y, variance.u)
    annotation (Line(points={{-51,60},{-40,60},{-40,46},{-19.6,46}}, color={0,0,127}));
  connect(absoluteError.y, standardDeviation.u)
    annotation (Line(points={{-51,60},{-40,60},{-40,26},{-19.6,26}}, color={0,0,127}));
  connect(meanAbsoluteError.y, MAE) annotation (Line(points={{51,60},{100,60}}, color={0,0,127}));
  connect(rootMeanSquareError.y, RMSE) annotation (Line(points={{49,-20},{100,-20}}, color={0,0,127}));
  connect(absoluteError.y, rootMeanSquareError.u)
    annotation (Line(points={{-51,60},{20,60},{20,-20},{26,-20}}, color={0,0,127}));

//   connect(meanAbsoluteError.y, normalizedMAE.u1)
//     annotation (Line(points={{51,60},{60,60},{60,23.6},{66.8,23.6}}, color={0,0,127}));
//   connect(rootMeanSquareError.y, normalizedRMSE.u1)
//     annotation (Line(points={{49,-20},{60,-20},{60,-56.4},{66.8,-56.4}}, color={0,0,127}));
//   connect(normalizedMAE.y, nMAE) annotation (Line(points={{80.6,20},{100,20}}, color={0,0,127}));
//   connect(normalizedRMSE.y, nRMSE) annotation (Line(points={{80.6,-60},{100,-60}}, color={0,0,127}));
//   connect(measuredValue, mean.u) annotation (Line(points={{-100,-60},{-60,-60},{-60,0},{-49.6,0}}, color={0,0,127}));
//   connect(realExpression.y, min.u2)
//     annotation (Line(points={{-29,-18},{-20,-18},{-20,-4.8},{-9.6,-4.8}}, color={0,0,127}));
//   connect(min.y, normalizedMAE.u2) annotation (Line(points={{8.8,0},{14,0},{14,16.4},{66.8,16.4}}, color={0,0,127}));
//   connect(min.y, normalizedRMSE.u2) annotation (Line(points={{8.8,0},{14,0},{14,-63.6},{66.8,-63.6}}, color={0,0,127}));
//   connect(mean.y, min.u1) annotation (Line(points={{-31.2,0},{-26,0},{-26,4.8},{-9.6,4.8}}, color={0,0,127}));
end errorMetrics;
