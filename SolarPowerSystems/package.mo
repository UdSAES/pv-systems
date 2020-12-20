within ;
package SolarPowerSystems "A model library of the components used in photovoltaic power systems"
  annotation (
    preferredView="info",
    version="0.9.0 Beta 0",
    uses(
      ModelicaServices(version="3.2.2"),
      PhotoVoltaics(version="1.X.X"),
      Buildings(version="6.0.0"),
      PhotoVoltaics_TGM(version="1.X.X"),
      Modelica(version="3.2.3"),
      DataFiles(version="1.0.5")),
    Documentation(info="<html>
<p>A Modelica-library that enables the design and investigation of solar power systems using Modelica, focusing on the DC power generated by arbitrarily oriented PV modules based on the irradiance in the horizontal plane; air temperature; and wind speed at the site.</p>
<p><br><br>Licensed by the <a href=\"https://www.uni-saarland.de/lehrstuhl/frey.html\">Chair of Automation- and Energy Systems of Saarland University</a> under the <a href=\"https://spdx.org/licenses/MIT.html\">MIT-license</a>.</p>
<p>Copyright (c) 2020 Chair of Automation- and Energy Systems, Saarland University.</p>
</html>"));
end SolarPowerSystems;
