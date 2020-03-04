within SolarPowerSystems.WIP.Obsolete.ModelExport;
partial record Perez_Danny "Record containing all parameters needed for Perez_Danny"
  extends Modelica.Icons.Record;
  replaceable SolarPowerSystems.Records.Base.Location location constrainedby SolarPowerSystems.Records.Base.Location annotation (Placement(transformation(extent={{-70,30},{-50,50}})), __Dymola_choicesAllMatching=true);
  replaceable SolarPowerSystems.Records.Base.PVplant PVplant constrainedby SolarPowerSystems.Records.Base.PVplant annotation (Placement(transformation(extent={{-70,-10},{-50,10}})), __Dymola_choicesAllMatching=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Perez_Danny;
