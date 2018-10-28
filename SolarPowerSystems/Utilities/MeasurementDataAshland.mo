within SolarPowerSystems.Utilities;
model MeasurementDataAshland "Block for reading measurement data from the PV-plant in Ashland, OR"
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
  Modelica.Blocks.Interfaces.RealOutput globalHorizontalIrradiance(unit="W/m2")
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput directHorizontalIrradiance(unit="W/m2")
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput diffuseHorizontalIrradiance(unit="W/m2")
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Math.Add substract(k1=+1, k2=-1) annotation (Placement(transformation(extent={{50,50},{70,70}})));

  Modelica.Blocks.Interfaces.RealOutput directNormalIrradiance(unit="W/m2") "DNI"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput globalIrradiancePOA(unit="W/m2")
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput powerDCsystem1(unit="W")
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput powerDCsystem2(unit="W")
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealOutput windSpeed(unit="m/s")
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealOutput ambientTemperature(unit="K", displayUnit="degC")
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
equation
  connect(timeAsEpoch.y, combiTable1Ds.u) annotation (Line(points={{-69,0},{-54,0}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], globalHorizontalIrradiance)
    annotation (Line(points={{-31,0},{0,0},{0,80},{100,80}}, color={0,0,127}));
  connect(substract.y, directHorizontalIrradiance) annotation (Line(points={{71,60},{100,60}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], substract.u1) annotation (Line(points={{-31,0},{0,0},{0,66},{48,66}}, color={0,0,127}));
  connect(combiTable1Ds.y[3], diffuseHorizontalIrradiance)
    annotation (Line(points={{-31,0},{0,0},{0,40},{100,40}}, color={0,0,127}));
  connect(combiTable1Ds.y[3], substract.u2) annotation (Line(points={{-31,0},{0,0},{0,54},{48,54}}, color={0,0,127}));
  connect(combiTable1Ds.y[2], directNormalIrradiance)
    annotation (Line(points={{-31,0},{0,0},{0,20},{100,20}}, color={0,0,127}));
  connect(combiTable1Ds.y[4], globalIrradiancePOA) annotation (Line(points={{-31,0},{100,0}}, color={0,0,127}));
  connect(combiTable1Ds.y[5], powerDCsystem1)
    annotation (Line(points={{-31,0},{0,0},{0,-20},{100,-20}}, color={0,0,127}));
  connect(combiTable1Ds.y[6], powerDCsystem2)
    annotation (Line(points={{-31,0},{0,0},{0,-40},{100,-40}}, color={0,0,127}));
  connect(combiTable1Ds.y[7], windSpeed) annotation (Line(points={{-31,0},{0,0},{0,-60},{100,-60}}, color={0,0,127}));
  connect(combiTable1Ds.y[8], toKelvin.Celsius)
    annotation (Line(points={{-31,0},{0,0},{0,-80},{48,-80}}, color={0,0,127}));
  connect(toKelvin.Kelvin, ambientTemperature) annotation (Line(points={{71,-80},{100,-80}}, color={0,0,127}));
end MeasurementDataAshland;
