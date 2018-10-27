within SolarPowerSystems.Components.SolarPowerPlants;
model Isotropic_PhotoVoltaicsLib
  "Model of a solar power plant that computes the electrical output as a function of the direct and diffuse irradiance on the horizontal plane based on a diode model and plant orientation"
  extends Interfaces.PhotoVoltaicPowerPlant(redeclare PlantInEnvironment.Isotropic
                                                                          inclinationAndShadowing(arrayTilt=arrayTilt,
        arrayAzimuth=arrayAzimuth),
                          redeclare PhotoVoltaicArray.ModuleBased.PhotoVoltaicsLib plantIrradianceNormal(useHeatPort=
          true, T=fixedTemperature.T));
   Modelica.Blocks.Interfaces.RealOutput powerAC
     "The generated power on the AC side"
     annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
   Modelica.Blocks.Interfaces.RealOutput totalEnergyAC
     "The generated energy on the AC side"
     annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Continuous.Integrator integrator1(k=3.6e-6)
    annotation (Placement(transformation(extent={{64,-90},{84,-70}})));
equation
  connect(internalHeatPort, plantIrradianceNormal.heatPort)
    annotation (Line(points={{-40,-80},{42,-80},{42,-10}}, color={191,0,0}));
  connect(integrator1.y, totalEnergyAC) annotation (Line(points={{85,-80},{100,-80}}, color={0,0,127}));
end Isotropic_PhotoVoltaicsLib;
