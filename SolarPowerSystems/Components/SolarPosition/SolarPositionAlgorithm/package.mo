within SolarPowerSystems.Components.SolarPosition;
package SolarPositionAlgorithm "External implementation of the accurate Solar Position Algorithm by Reda and Andreas (2008) of NREL"
annotation (Documentation(info="<html>
<p>This subpackage integrates the implementation of NREL&apos;s Solar Position Algorithm (SPA) that can be obtained from <a href=\"https://midcdmz.nrel.gov/spa/\">https://midcdmz.nrel.gov/spa/</a> as an external C-program.</p>
<p>Refer to <a href=\"http://www.nrel.gov/docs/fy08osti/34302.pdf\">Reda, I.; Andreas, A. (2003). Solar Position Algorithm for Solar Radiation Applications. 55 pp.; NREL Report No. TP-560-34302, Revised January 2008.</a> for a complete description of the algorithm.</p>
<p>The C-code and the corresponding header file are provided by NREL&apos;s Solar Radiation Research Laboratory and fall under the copyright notice available at <a href=\"https://midcdmz.nrel.gov/spa/\">https://midcdmz.nrel.gov/spa/</a>.</p>
<p><b>The license does not allow re-distribution of the source code, therefore the user has to obtain a copy from the website and paste the files <span style=\"font-family: monospace;\">spa.c</span> and <span style=\"font-family: monospace;\">spa.h</span> into the folder .<span style=\"font-family: monospace;\">/Resources/Include/</span> before this library can be used!</b></p>
</html>"));
end SolarPositionAlgorithm;
