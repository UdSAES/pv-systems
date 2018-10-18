# Photovoltaic Systems

## Error Message Upon Loading FMU-Export
```
parameter (line 2, column 18: E:/data/msaas_modelica_export/MSaaSModelicaExport/Types/pSaaSReal.mo)

Expected one of:
FLOW
STREAM
DER
"input"/"output"
identifier
"enumeration"
"."

parameter (line 2, column 21: E:/data/msaas_modelica_export/MSaaSModelicaExport/Types/psimSaaSReal.mo)

Expected one of:
FLOW
STREAM
DER
"input"/"output"
identifier
"enumeration"
"."
```

## Simulation Log 68 Days, Vienna
```
Log-file of program ./dymosim
(generated: Thu Oct 18 15:14:32 2018)

dymosim started
... "dsin.txt" loading (dymosim input file)
... loading "trina" from "E:/data/pv_systems/PhotoVoltaics/PhotoVoltaics/Resources/WeatherData/TGM_Trina_20160626_to_20161004.txt"
... "TGM_Trina_Measurement_20160626_to_20161004.mat" creating (simulation result file)

Integration started at T = 0 using integration method RKFIX4
(One-step solver with fixed stepsize and order 4)
Integration terminated successfully at T = 5875200
   CPU-time for integration      : 1.12e+003 seconds
   CPU-time for one GRID interval: 11.5 milliseconds
   Number of result points       : 195841
   Number of GRID   points       : 97921
   Number of (successful) steps  : 97920
   Number of F-evaluations       : 391680
   Number of H-evaluations       : 97920
   Number of Jacobian-evaluations: 0
   Number of (model) time events : 97920
   Number of (U) time events     : 0
   Number of state    events     : 0
   Number of step     events     : 0
   Minimum integration stepsize  : 60
   Maximum integration stepsize  : 60
   Maximum integration order     : 4
Calling terminal section
... "dsfinal.txt" creating (final states)
```
