within SolarPowerSystems.WIP;
package Directory "Package used for specifying the base path of dependencies"
  constant String dataFolder = Modelica.Utilities.Files.loadResource("modelica://SolarPowerSystems/Resources/") + "Data/";
end Directory;
