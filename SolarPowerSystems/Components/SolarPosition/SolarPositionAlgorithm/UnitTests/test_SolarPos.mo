within SolarPowerSystems.Components.SolarPosition.SolarPositionAlgorithm.UnitTests;
model test_SolarPos
  extends Modelica.Icons.UnderConstruction;
  // jumps in actual azimuth value from 180 to -180 and their linear interpolation cause problems if angle is normalized to [0..360)
  Real zenith_actual(unit="deg");
  Real azimuth_actual(unit="deg");

  Modelica.Blocks.Sources.CombiTimeTable solarAzimuthAndAltitude(table=[0,17.1718586827,-60.6181509945; 900,23.9214212682,
        -59.7985850456; 1800,30.3471999946,-58.7339491694; 2700,36.4097963397,-57.4499979828; 3600,42.0950514378,
        -55.973630821; 4500,47.4085063571,-54.3311498211; 5400,52.3692719178,-52.5471302787; 6300,57.004590072,
        -50.6438309985; 7200,61.3456344698,-48.6410035783; 8100,65.424592813,-46.5559570828; 9000,69.2728219379,
        -44.4037655306; 9900,72.9198031884,-42.1975384498; 10800,76.3926465657,-39.9487045854; 11700,79.7159421066,
        -37.6672833958; 12600,82.9118183179,-35.3621306387; 13500,86.0001137252,-33.0411527095; 14400,88.9985983172,
        -30.711491874; 15300,91.923209598,-28.3796840576; 16200,94.7882832552,-26.0517916603; 17100,97.6067647669,
        -23.7335168359; 18000,100.3903979269,-21.430297564; 18900,103.1498895322,-19.1473884163; 19800,105.895047999,
        -16.8899302363; 20700,108.6348980082,-14.6630096428; 21600,111.377773553,-12.4717088679; 22500,114.1313884838,
        -10.3211487511; 23400,116.9028868275,-8.2165245617; 24300,119.6988750029,-6.1631340851; 25200,122.5254345583,
        -4.1663996762; 26100,125.3881172871,-2.2318830438; 27000,128.2919247141,0.1660599208; 27900,131.2412706921,
        1.7468062912; 28800,134.2399296172,3.3588119835; 29700,137.2909735089,4.932377414; 30600,140.3966983763,
        6.4354383929; 31500,143.5585447963,7.8514134609; 32400,146.7770189052,9.1694007606; 33300,150.0516173112,
        10.3809144205; 34200,153.3807641218,11.4787160448; 35100,156.761769135,12.4563806282; 36000,160.1908123305,
        13.3081517426; 36900,163.6629630829,14.0289227564; 37800,167.1722411868,14.6142754407; 38700,170.7117201282,
        15.0605419366; 39600,174.2736739303,15.3648718671; 40500,177.8497653138,15.5252927547; 41400,-178.568735206,
        15.5407553506; 42300,-174.9907086644,15.411158974; 43200,-171.4249370588,15.1373540035; 44100,-167.8798597374,
        14.7211212467; 45000,-164.3633487223,14.1651305362; 45900,-160.8825129178,13.4728829191; 46800,-157.4435423394,
        12.6486441608; 47700,-154.0515954512,11.6973804391; 48600,-150.7107290292,10.6247125768; 49500,-147.4238707454,
        9.4369185824; 50400,-144.1928278387,8.1410425523; 51300,-141.0183236724,6.7452439506; 52200,-137.90005712,
        5.2597433339; 53100,-134.836775656,3.6994255325; 54000,-131.826353766,2.0915687428; 54900,-128.8658729561,
        0.4966257611; 55800,-125.9516969184,-1.8269859484; 56700,-123.0795366895,-3.7472352222; 57600,-120.2445051946,
        -5.7308653296; 58500,-117.4411577822,-7.7722792602; 59400,-114.6635161261,-9.8660208721; 60300,-111.9050766932,
        -12.0067616257; 61200,-109.1588017701,-14.1892799264; 62100,-106.4170911874,-16.4084343737; 63000,-103.671736159,
        -18.6591292784; 63900,-100.9138531662,-20.9362730694; 64800,-98.1337956687,-23.2347299938; 65700,-95.3210445944,
        -25.54926238; 66600,-92.4640752711,-27.8744630274; 67500,-89.5501986519,-30.2046769278; 68400,-86.5653789068,
        -32.533908206; 69300,-83.4940277799,-34.8557104895; 70200,-80.3187790233,-37.1630584891; 71100,-77.0202552913,
        -39.4481954374; 72000,-73.5768453479,-41.7024538943; 72900,-69.9645233882,-43.9160481064; 73800,-66.1567682745,
        -46.0778352945; 74700,-62.1246687367,-48.1750501801; 75600,-57.8373439552,-50.1930245764; 76500,-53.2628680516,
        -52.1149141966; 77400,-48.3699378064,-53.921477678; 78300,-43.1305520541,-55.5909808651; 79200,-37.523929969,
        -57.0993312972; 80100,-31.5416857749,-58.4205808201; 81000,-25.1938301097,-59.5279394622; 81900,-18.5144798188,
        -60.3953901234; 82800,-11.5654085899,-60.9998556866; 83700,-4.4352734287,-61.3236460447; 84600,2.7668926264,
        -61.3566820391; 85500,9.9234107555,-61.0979015812; 86400,16.9221149062,-60.5554133336; 87300,23.6689470875,
        -59.7453479667; 88200,30.0957793441,-58.6897690539; 89100,36.1624161458,-57.4142260343; 90000,41.8538403868,
        -55.945490829; 90900,47.1748073046,-54.3098066258; 91800,52.1437829138,-52.5317420324; 92700,56.7875224913,
        -50.633584365; 93600,61.136857585,-48.635134402; 94500,65.2237516858,-46.5537602079; 95400,69.0794265353,
        -44.4045972857; 96300,72.7332920752,-42.2008146081; 97200,76.2124303703,-39.9538958201; 98100,79.5414319122,
        -37.6739095704; 99000,82.7424433254,-35.369754768; 99900,85.8353315614,-33.0493750745; 100800,88.8379004569,
        -30.7199445493; 101700,91.7661236586,-28.3880259669; 102600,94.6343733784,-26.0597041961; 103500,97.4556309137,
        -23.7407000318; 104400,100.2416746383,-21.4364667894; 105300,103.0032445215,-19.1522715539; 106200,105.7501808106,
        -16.8932653053; 107100,108.4915388966,-14.6645428336; 108000,111.2356826749,-12.4711929637; 108900,113.9903554554,
        -10.3183419187; 109800,116.7627306719,-8.2111895028; 110700,119.5594444897,-6.1550375448; 111600,122.3866089148,
        -4.1553123159; 112500,125.2498072428,-2.2175796846; 113400,128.1540738133,0.1809719787; 114300,131.1038567884,
        1.7664751992; 115200,134.1029664311,3.3829959587; 116100,137.154512099,4.9609385079; 117000,140.2608283464,
        6.4684158407; 117900,143.423395027,7.8889096851; 118800,146.6427575846,9.2115344583; 119700,149.9184510277,
        10.427800148; 120600,153.2489357977,11.5304535232; 121500,156.6315546191,12.5130480268; 122400,160.0625155378,
        13.3698009008; 123300,163.536909664,14.0955756201; 124200,167.0487708352,14.685921494; 125100,170.5911777676,
        15.1371366003; 126000,174.1564001549,15.4463358974; 126900,177.736086564,15.6115126713; 127800,-178.6785161836,
        15.6315848735; 128700,-175.0963215156,15.5064213852; 129600,-171.5261511671,15.2368452762; 130500,-167.9764898199,
        14.8246137036; 131400,-164.4552584262,14.2723767216; 132300,-160.9696163382,13.5836192794; 133200,-157.5258035494,
        12.7625939925; 134100,-154.1290262774,11.8142553158; 135000,-150.7833854063,10.7442109267; 135900,-147.4918480451,
        9.5587188328; 136800,-144.2562555767,8.2647851206; 137700,-141.0773599733,6.8704879051; 138600,-137.9548832696,
        5.3858583898; 139500,-134.8875910049,3.8252974356; 140400,-131.8733711776,2.2147242348; 141300,-128.9093149289,
        0.6115106847; 142200,-125.9917924596,-1.6925276674; 143100,-123.1165189718,-3.6118294426; 144000,-120.2786100006,
        -5.594642746; 144900,-117.4726227277,-7.6353567055; 145800,-114.6925806448,-9.7285021742; 146700,-111.9319827751,
        -11.8687385621; 147600,-109.1837954571,-14.0508332553; 148500,-106.440424853,-16.269634929; 149400,-103.6936716221,
        -18.520039132; 150300,-100.9346657321,-20.7969467702; 151200,-98.1537792177,-23.0952159174; 152100,-95.3405178955,
        -25.4096042281; 153000,-92.483389742,-27.7347015428; 153900,-89.5697478448,-30.0648519103; 154800,-86.5856100505,
        -32.3940609464; 155700,-83.5154557501,-34.715886772; 156600,-80.3420031262,-37.0233123631; 157500,-77.0459791914,
        -39.3085940047; 158400,-73.6059002918,-41.5630834269; 159300,-69.9978944796,-43.7770218614; 160200,-66.1956227768,
        -45.9393034371; 161100,-62.1703840101,-48.03721221; 162000,-57.8915303912,-50.0561445246; 162900,-53.3273789854,
        -51.9793385147; 163800,-48.4468538412,-53.7876550274; 164700,-43.2221222063,-55.4594817729; 165600,-37.6324486233,
        -56.9708637765; 166500,-31.6692870326,-58.2959957355; 167400,-25.3421959727,-59.4082174429; 168300,-18.6844906492,
        -60.2816017806; 169200,-11.7568093011,-60.8930908537; 170100,-4.6464658308,-61.2249167696; 171000,2.5388257052,
        -61.2668158664; 171900,9.682410846,-61.017450152; 172800,16.6726492407,-60.4845999321; 173700,23.4154528843,
        -59.6840652985; 174600,29.8422032197,-58.6376218522; 175500,35.911937212,-57.370601149; 176400,41.608783396,
        -55.9096348152; 177300,46.9366970332,-54.280895665; 178200,51.9134753648,-52.5089364422; 179100,56.5653597143,
        -50.6160661855; 180000,60.9228131368,-48.6221302011; 180900,65.0175515871,-46.5445526282; 181800,68.8806422426,
        -44.3985288288; 182700,72.5414080112,-42.1972865207; 183600,76.0268908145,-39.9523641779; 184500,79.3616722677,
        -37.6738799747; 185400,82.5679101092,-35.3707765525; 186300,85.6654945474,-33.0510355604; 187200,88.6722595279,
        -30.7218636381; 188100,91.6042122026,-28.3898512165; 189000,94.4757595182,-26.0611064334; 189900,97.2999174528,
        -23.7413695038; 190800,100.0884983237,-21.4361098309; 191700,102.8522750251,-19.150607737; 192600,105.6011196946,
        -16.8900250385; 193500,108.3441187328,-14.6594653802; 194400,111.0896664302,-12.464024853; 195300,113.8455362054,
        -10.3088357366; 196200,116.6189316749,-8.1991030521; 197100,119.4165196273,-6.1401333733; 198000,122.2444434825,
        -4.1373576165; 198900,125.1083190499,-2.1963465784; 199800,128.0132145294,0.2017843364; 200700,130.9636134433,
        1.7926583505; 201600,133.9633629471,3.414017527; 202500,137.015610704,4.9965147719; 203400,140.1227306798,
        6.5085276431; 204300,143.2862427268,7.9336315508; 205200,146.5067321234,9.2609685282; 206100,149.78377256,
        10.4820488134; 207000,153.1158607988,11.5896058956; 207900,156.5003721375,12.577171954; 208800,159.9335419572,
        13.4389375978; 209700,163.4104819751,14.1697358475; 210600,166.925238542,14.7650829155; 211500,170.4708936939,
        15.2212422225; 212400,174.0397105481,15.5352935893; 213300,177.6233210049,15.705195768; 214200,-178.787054496,
        15.7298338266; 215100,-175.2003645294,15.6090463599; 216000,-171.6254732773,15.3436295224; 216900,-168.0709133023,
        14.9353174479; 217800,-164.5446567709,14.3867412519; 218700,-161.0539154182,13.7013708084; 219600,-157.6049807423,
        12.8834467514; 220500,-154.2031077981,11.9379130907; 221400,-150.852442211,10.8703657254; 222300,-147.5559907255,
        9.6870441411; 223200,-144.3156286696,8.3949181688; 224100,-141.1321360745,7.0019871971; 225000,-138.0052572922,
        5.5180986393; 225900,-134.9337748482,3.9571853001; 226800,-131.915588997,2.3438555063; 227700,-128.9477991348,
        0.7323104513; 228600,-126.0267805121,-1.5524290862; 229500,-123.1482509975,-3.4709029988; 230400,-120.3073272301,
        -5.4530134431; 231300,-117.4985667351,-7.4931349326; 232200,-114.7159933669,-9.5857846135; 233100,-111.9531072987,
        -11.7256091816; 234000,-109.2028775738,-13.9073643623; 234900,-106.4577154055,-16.1258882735; 235800,-103.7094296964,
        -18.3760670604; 236700,-100.9491627828,-20.6527934447; 237600,-98.1673042614,-22.9509186253; 238500,-95.3533839474,
        -25.2651948302; 239400,-92.4959417345,-27.5902081202; 240300,-89.5823723192,-29.9203006989; 241200,-86.5987469757,
        -32.249478676; 242100,-83.5296128718,-34.5713035646; 243000,-80.3577732707,-36.8787653919; 243900,-77.0640609123,
        -39.1641321732; 244800,-73.6271220878,-41.4187733877; 245700,-70.0232424328,-43.6329557664; 246600,-66.2262707144,
        -45.7956088533; 247500,-62.2077239354,-47.8940646425; 248400,-57.9371986992,-49.9137828755; 249300,-53.3832705526,
        -51.8380834841; 250200,-48.5151114173,-53.6479297745; 251100,-43.3050832227,-55.321832933; 252000,-37.7325276104,
        -56.835979041; 252900,-31.7887736188,-58.1647118201; 253800,-25.4829623699,-59.2815101086; 254700,-18.8476339392,
        -60.160549227; 255600,-11.9422995527,-60.778805406; 256500,-4.8529109747,-61.1184485524; 257400,2.314187336,
        -61.1690441423; 258300,9.4434421667,-60.9289872297; 259200,16.4238273937,-60.4057321965; 260100,23.1613067015,
        -59.6147443261; 261000,29.5868311248,-58.5775018442; 261900,35.6587026538,-57.3191062265; 262800,41.3602025005,
        -55.8660361554; 263700,46.6944744748,-54.2443826547; 264600,51.6786250115,-52.4786732922; 265500,56.3383554336,
        -50.5912318293; 266400,60.7037345768,-48.6019432175; 267300,64.8062078072,-46.5282845252; 268200,68.676668295,
        -44.3855091532; 269100,72.3443361688,-42.1869027012; 270000,75.8362008209,-39.9440582664; 270900,79.1768254548,
        -37.6671437757; 271800,82.3883717143,-35.3651461012; 272700,85.4907477079,-33.046085532; 273600,88.5018135805,
        -30.717202023; 274500,91.4376072031,-28.3851144282; 275400,94.3125683381,-26.0559549229; 276300,97.1397463947,
        -23.7354838961; 277200,99.9309869015,-21.4291875703; 278100,102.6970953495,-19.1423602138; 279000,105.4479757534,
        -16.8801751673; 279900,108.1927457636,-14.6477456019; 280800,110.9398305066,-12.4501755392; 281700,113.6970341132,
        -10.2926039808; 282600,116.4715911188,-8.1802418392; 283500,119.2701997787,-6.118401127; 284400,122.0990358529,
        -4.1125181288; 285300,124.9637486518,-2.1681693302; 286200,127.8694412589,0.2285283893; 287100,130.8206335903,
        1.8253823984; 288000,133.8212107079,3.4518910466; 288900,136.8743595366,5.0391133101; 289800,139.9824943142,
        6.5557757614; 290700,143.1471756102,7.9855767561; 291600,146.3690290642,9.3176968146; 292500,149.6476673327,
        10.5436506203; 293400,152.9816234879,11.6561598481; 294300,156.3683050504,12.648735656; 295200,159.803974009,
        13.5155416946; 296100,163.2837615575,14.2513799547; 297000,166.8017250265,14.851732909; 297900,170.3509478511,
        15.312828723; 298800,173.9236843106,15.6317116045; 299700,177.511547105,15.8063054753; 300600,-178.8942724216,
        15.8354624401; 301500,-175.3027607772,15.7189909662; 302400,-171.7228273289,15.457660697; 303300,-168.1630551004,
        15.053183386; 304200,-164.631469784,14.5081720717; 305100,-161.1353374571,13.826082603; 306000,-157.6810026663,
        13.0111448377; 306900,-154.2737703976,12.0682936695; 307800,-150.917831654,11.0031146595; 308700,-147.6162330117,
        9.821830368; 309600,-144.370883533,8.5313763236; 310500,-141.1825907432,7.1396761864; 311400,-138.0511204495,
        5.6563999111; 312300,-134.975271064,4.0950299121; 313200,-131.9529538198,2.4789173901; 314100,-128.9812749653,
        0.8590640418; 315000,-126.0566133221,-1.4067723911; 315900,-123.1746879086,-3.3245394886; 316800,-120.3306149446,
        -5.3060622766; 317700,-117.5189507948,-7.345699908; 318600,-114.7337182097,-9.4379551286; 319500,-111.9684170958,
        -11.5774612645; 320400,-109.2160178458,-13.758961749; 321300,-106.4689354371,-15.9772835204; 322200,-103.7189858051,
        -18.2273026913; 323100,-100.9573225326,-20.5039031478; 324000,-98.1743517538,-22.8019285273; 324900,-95.3596263819,
        -25.1161248909; 325800,-92.5017174783,-27.4410737133; 326700,-89.5880607974,-29.7711144656; 327600,-86.604780756,
        -32.1002527699; 328500,-83.5364923727,-34.4220524462; 329400,-80.3660845624,-36.7295093768; 330300,-77.0744970473,
        -39.0149019999; 331200,-73.6405082617,-41.269616139; 332100,-70.0405649218,-43.4839425481; 333000,-66.2487088012,
        -45.6468446974; 333900,-62.236682716,-47.7457011141; 334800,-57.9743384249,-49.766033771; 335700,-53.4305247189,
        -51.6912437097; 336600,-48.574681035,-53.5023968303; 337500,-43.3793891458,-55.1781292179; 338400,-37.8240983939,
        -56.6947713065; 339300,-31.9000474218,-58.0268216439; 340200,-25.6159944126,-59.1479069443; 341100,-19.0037317923,
        -60.0323169568; 342000,-12.1216547603,-60.6570765673; 342900,-5.0543379903,-61.0043089276; 343800,2.0932893697,
        -61.0634225054; 344700,9.2068477781,-60.8325549351; 345600,16.1760111095,-60.3188379631], smoothness=
        Modelica.Blocks.Types.Smoothness.LinearSegments) " \"date\": \"1496234081\",
  \"position\": {\"latitude\": 51.5412804, \"elevation\": 150.0, \"longitude\": 9.9158035},"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  SolarAzimuth solarAzimuth(
    latitude=51.5412804,
    longitude=9.9158035,
    height_above_sealevel=150.0,
    simu_start_epochs=1356998400) annotation (Placement(transformation(extent={{-80,-12},{-60,8}})));
  SolarZenith solarZenith(
    latitude=51.5412804,
    longitude=9.9158035,
    height_above_sealevel=150.0,
    simu_start_epochs=1356998400) annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));

equation
  zenith_actual = MSaaSModelicaExport.Utilities.Functions.normalizeAngle((solarAzimuthAndAltitude.y[2] - 90)*(
    -1));
  azimuth_actual = MSaaSModelicaExport.Utilities.Functions.normalizeAngle(solarAzimuthAndAltitude.y[1]);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end test_SolarPos;
