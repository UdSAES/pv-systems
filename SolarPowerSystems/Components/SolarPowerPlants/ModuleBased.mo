within SolarPowerSystems.Components.SolarPowerPlants;
model ModuleBased
  "Model of a solar power plant that computes the electrical output as a function of the direct and diffuse irradiance on the horizontal plane based on module parameters and plant orientation"
  extends Interfaces.PhotoVoltaicPowerPlant(
                                 redeclare PlantInEnvironment.Simple
      inclinationAndShadowing(surfaceTilt=Modelica.SIunits.Conversions.from_deg(
           panelTilt), surfaceAzimuth=Modelica.SIunits.Conversions.from_deg(
          panelAzimuth)), redeclare
      PhotoVoltaicArray.ModuleBased.ModuleBased plantIrradianceNormal);
end ModuleBased;
