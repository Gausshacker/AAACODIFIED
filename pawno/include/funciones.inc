#include <globalvars>
#include <a_mysql>
#include <colores>
#pragma tabsize 0
// Antibug Kick Sa-MP 0.3x





forward PasamontanasU(playerid);

public PasamontanasU(playerid)
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(Usando[playerid] == 1)
	    {
			ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
		if(Usando[playerid] == 0)
		{
		    ShowPlayerNameTagForPlayer(i, playerid, 1);
		}
	}
	return 1;
}

stock ChequearObjeto(playerid, objeto)
{
	for(new bol = 0; bol < 13; bol++)
	{
	if(BolsilloID[playerid][bol] == objeto) { return 1; }
	}
	return 0;
}
stock AutoRol(playerid,sAutorol[])
{
format(string,sizeof(string),"• %s %s",pName(playerid),sAutorol);
ProxDetector(30,playerid,string,Morado, Morado, Morado, Morado, Morado);
}
forward Descongelar25(playerid);
public Descongelar25(playerid)
{
ClearAnimations(playerid);
TogglePlayerControllable(playerid,1);
return 1;
}
stock encode_doors(bonnet, boot, driver_door, passenger_door, behind_driver_door, behind_passenger_door)
{
    #pragma unused behind_driver_door
    #pragma unused behind_passenger_door
    return bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24);
}
stock EsObjetoValido(id){
	new nombre[64];
	format(nombre, sizeof(nombre), ObtenerNombreObjeto(id));
	if(!strcmp(nombre, "Objeto desconocido", false)) return 0;
	else return 1;
}

stock ObtenerNombreObjeto(id){
	new nombre[64] = "n objeto desconocido";
	if(id == 0) nombre = "n vacío";
	if(id == 1) nombre = "n puño americano";
	if(id == 2) nombre = "n palo de golf";
	if(id == 3) nombre = "na porra policíaca";
	if(id == 4) nombre = "na navaja";
	if(id == 5) nombre = "n bate de béisbol";
	if(id == 6) nombre = "na pala";
	if(id == 7) nombre = "n taco de billar";
	if(id == 8) nombre = "na espada katana";
	if(id == 9) nombre = "na motosierra";
	if(id == 10) nombre = "n consolador dildo doble";
	if(id == 11) nombre = "n consolador dildo";
	if(id == 12) nombre = "n consolador vibrador";
	if(id == 13) nombre = "n consolador vibrador pequeño";
	if(id == 14) nombre = "n ramo de flores";
	if(id == 15) nombre = "n bastón";
	if(id == 16) nombre = "na granada";
	if(id == 17) nombre = "n gas lacrimógeno";
	if(id == 18) nombre = "n cóctel motolov";
	if(id == 22) nombre = "na pistola Colt .45";
	if(id == 23) nombre = "na pistola Colt .45 silenciada";
	if(id == 24) nombre = "na pistola Desert Eagle";
	if(id == 25) nombre = "na escopeta normal";
	if(id == 26) nombre = "na escopeta recortada";
	if(id == 27) nombre = "na escopeta de combate";
	if(id == 28) nombre = "n micro subfusil UZI";
	if(id == 29) nombre = "n subfusil MP5";
	if(id == 30) nombre = "n rifle automático AK-47";
	if(id == 31) nombre = "n rifle automático M4";
	if(id == 32) nombre = "n micro subfusil TEC-9";
	if(id == 33) nombre = "n rifle de caza";
	if(id == 34) nombre = "n rifle de francotirador";
	if(id == 35) nombre = "n lanzacohetes";
	if(id == 36) nombre = "n lanzamisiles busca-calor";
	if(id == 37) nombre = "n lanzallamas";
	if(id == 38) nombre = "na minigun";
	if(id == 39) nombre = "na carga explosiva";
	if(id == 40) nombre = "n detonador de carga explosiva";
	if(id == 41) nombre = "n aerosol";
	if(id == 42) nombre = "n extintor de fuego";
	if(id == 43) nombre = "na cámara fotográfica digital";
	if(id == 44) nombre = "n cargador de pistola Colt .45";
	if(id == 45) nombre = "n silenciador de pistola Colt .45";
	if(id == 46) nombre = "n cargador de pistola Desert Eagle";
	if(id == 47) nombre = "n cargador de escopeta normal";
	if(id == 48) nombre = "n cargador de escopeta recortada";
	if(id == 49) nombre = "n cargador de escopeta de combate";
	if(id == 50) nombre = "n cargador de microsubfusil UZI";
	if(id == 51) nombre = "n cargador de subfusil MP5";
	if(id == 52) nombre = "n cargador de rifle automático AK-47";
	if(id == 53) nombre = "n cargador de rifle automático M4";
	if(id == 54) nombre = "n cargador de microsubfusil TEC-9";
	if(id == 55) nombre = "n cargador de rifle de caza";
	if(id == 56) nombre = "n cargador de rifle de francotirador";
	if(id == 57) nombre = "n chaleco antibalas";
	if(id == 58) nombre = "na pizza";
	if(id == 59) nombre = "na hamburguesa";
	if(id == 60) nombre = "n kebap";
	if(id == 61) nombre = "n encendedor";
	if(id == 62) nombre = "na botella con vino";
	if(id == 63) nombre = "na botella con cerveza";
	if(id == 64) nombre = "n vaso con agua";
	if(id == 65) nombre = "n vaso con refresco";
	if(id == 66) nombre = "n perrito caliente";
	if(id == 67) nombre = "na ganzúa";
	if(id == 68) nombre = "n mismo objeto";
	if(id == 69) nombre = "na bolsa con semillas de marihuana";
	if(id == 70) nombre = "na bolsa con marihuana";
    if(id == 71) nombre = "nos materiales";
    if(id == 72) nombre = "na cuerda";
    if(id == 74) nombre = "n pasamontañas";
    if(id == 75) nombre = "na bolsa con tabaco";
    if(id == 76) nombre = "n encendedor";
    if(id == 77) nombre = "n botella con refresco";
    if(id == 78) nombre = "na botella con cerveza";
    if(id == 79) nombre = "na bolsa con comida rápida";
    if(id == 80) nombre = "na botella con agua";
    if(id == 81) nombre = "na botella con jugo";
    if(id == 82) nombre = "na botella con cerveza 0%";
    if(id == 83) nombre = "na lata de red bull";
    if(id == 84) nombre = "na botella con whisky";
    if(id == 85) nombre = "na botella con ron y agua";
    if(id == 86) nombre = "na botella con whisky y agua";
    if(id == 87) nombre = "na botella con vodka";
    if(id == 88) nombre = "na cajetilla de cigarros";
    if(id == 89) nombre = "n teléfono móvil";
    if(id == 90) nombre = "na ganzua";
    if(id == 91) nombre = "na bolsa de dinero grande";
	return nombre;
}

stock ActualizarObjetos(playerid){
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	RemovePlayerAttachedObject(playerid, CINTURON);
	RemovePlayerAttachedObject(playerid, ESPALDA);
if(CinturonID[playerid] != 0)  { SetPlayerAttachedObject(playerid,CINTURON,IDObjetos[CinturonID[playerid]][0]-1,8,-0.040999,0.150000,0.076999,-166.000030,0.000000,0.000000,1.000000,1.000000,1.000000); }  
if(EspaldaID[playerid] != 0) { SetPlayerAttachedObject(playerid,ESPALDA,IDObjetos[EspaldaID[playerid]][0]-1,1,-0.305999,-0.203000,0.097999,-170.500030,0.000000,0.000000,1.000000,1.000000,1.000000); }
	for(new i = 11; i < 13; i++){
	    new id = BolsilloID[playerid][i];
	    if(i == 11){
	        if(id == 1 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 331, 6);
	        if(id == 2 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 333, 6);
	        if(id == 3 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 334, 6);
	        if(id == 4 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 335, 6);
	        if(id == 5 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 336, 6);
	        if(id == 6 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 337, 6);
	        if(id == 7 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 338, 6);
	        if(id == 8 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 339, 6);
	        if(id == 9 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 341, 6);
	        if(id == 10 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 321, 6);
	        if(id == 11 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 322, 6);
	        if(id == 12 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 323, 6);
	        if(id == 13 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 324, 6);
	        if(id == 14 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 325, 6);
	        if(id == 15 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 326, 6);
	        if(id == 16 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 342, 6);
	        if(id == 17 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 343, 6);
	        if(id == 18 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 344, 6);
	        if(id == 22 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 346, 6);
	        if(id == 23 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 347, 6);
	        if(id == 24 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 348, 6);
	        if(id == 25 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 349, 6);
	        if(id == 26 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 350, 6);
	        if(id == 27 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 351, 6);
	        if(id == 28 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 352, 6);
	        if(id == 29 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 353, 6);
	        if(id == 30 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 355, 6);
	        if(id == 31 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 356, 6);
	        if(id == 32 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 372, 6);
	        if(id == 33 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 357, 6);
	        if(id == 34 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 358, 6);
	        if(id == 35 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 359, 6);
	        if(id == 36 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 360, 6);
	        if(id == 37 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 361, 6);
	        if(id == 38 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 362, 6);
	        if(id == 39 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 363, 6);
	        if(id == 40 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 364, 6);
	        if(id == 41 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 365, 6);
	        if(id == 42 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 366, 6);
	        if(id == 43 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 367, 6);
	        if(id >= 44 && id <= 56) SetPlayerAttachedObject(playerid,0,2039,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
	        if(id == 57) SetPlayerAttachedObject(playerid,0,1242,6,0.215000,0.000000,0.056999,-10.599992,-103.600021,-7.000000,1.000000,1.000000,1.000000);
	        if(id == 58) SetPlayerAttachedObject(playerid,0,2702,6,0.160999,0.038999,0.048000,-2.700039,-17.899940,-86.799949,1.000000,1.000000,1.000000);
	        if(id == 69) SetPlayerAttachedObject(playerid,0,327,6);
	        if(id == 71) SetPlayerAttachedObject(playerid,0,2039,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
	        if(id >= 80 && id <= 87 || id == 77) SetPlayerAttachedObject(playerid,0,1546,6,0.094999,0.043000,0.000000,0.000000,0.000000,180.000000,1.000000,1.000000,1.000000);
		if(id == 78 || id == 82) SetPlayerAttachedObject(playerid,0,1544,6,0.103000,0.057999,0.046000,0.000000,0.000000,180.000000,1.000000,1.000000,1.000000);
		if(id == 89) SetPlayerAttachedObject(playerid,0,18865,6,0.071999,0.052999,0.000000,93.499870,-2.199938,-5.300000,1.000000,1.000000,1.000000);
		if(id == 90) SetPlayerAttachedObject(playerid,0,18644,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
		if(id == 91) SetPlayerAttachedObject(playerid,0,1550,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
			}
	    if(i == 12){
	        if(id == 1) SetPlayerAttachedObject(playerid,1,331,5,0.024999,0.000000,-0.005999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id == 2) SetPlayerAttachedObject(playerid,1,333,5,-0.040000,0.067000,-0.003000,-29.899999,152.000000,176.000030,1.000000,1.000000,1.000000);
	        if(id == 3) SetPlayerAttachedObject(playerid,1,334,5,0.000000,0.059999,-0.022000,161.599990,10.700001,5.800002,1.000000,1.000000,1.000000);
	        if(id == 4) SetPlayerAttachedObject(playerid,1,335,5,0.180999,0.000000,0.017999,0.000000,177.800018,-8.799996,1.000000,1.000000,1.000000);
	        if(id == 5) SetPlayerAttachedObject(playerid,1,336,5,0.135999,0.030999,0.053999,-17.900001,153.800018,0.000000,1.000000,1.000000,1.000000);
	        if(id == 6) SetPlayerAttachedObject(playerid,1,337,5,0.041999,0.051999,-0.080000,-27.899986,155.800018,-167.499938,1.000000,1.000000,1.000000);
	        if(id == 7) SetPlayerAttachedObject(playerid,1,338,5,0.156999,0.092000,0.071999,-25.099998,172.899963,-19.899995,1.000000,1.000000,1.000000);
	        if(id == 8) SetPlayerAttachedObject(playerid,1,339,5,0.058000,0.008000,-0.109000,-27.999998,155.100036,172.699966,1.000000,1.000000,1.000000);
	        if(id == 9) SetPlayerAttachedObject(playerid,1,341,5,0.000000,0.078999,-0.009000,155.599990,7.200000,4.800000,1.000000,1.000000,1.000000);
	        if(id == 10) SetPlayerAttachedObject(playerid,1,321,5,0.015000,0.041000,-0.068000,-25.599971,162.900054,-175.300018,1.000000,1.000000,1.000000);
	        if(id == 11) SetPlayerAttachedObject(playerid,1,322,5,0.023999,0.052999,-0.041999,157.899978,2.499999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 12) SetPlayerAttachedObject(playerid,1,323,5,-0.002000,0.074000,0.001000,151.200042,23.000000,-9.100001,1.000000,1.000000,1.000000);
	        if(id == 13) SetPlayerAttachedObject(playerid,1,324,5,0.017999,0.003999,-0.047999,168.200012,18.300003,-27.900005,1.000000,1.000000,1.000000);
	        if(id == 14) SetPlayerAttachedObject(playerid,1,325,5,0.176000,0.000000,-0.011000,-23.399999,160.599990,-6.399995,1.000000,1.000000,1.000000);
	        if(id == 15) SetPlayerAttachedObject(playerid,1,326,5,0.008999,-0.018999,-0.047999,-33.199996,159.900085,156.399902,1.000000,1.000000,1.000000);
	        if(id == 16) SetPlayerAttachedObject(playerid,1,342,5,0.019000,0.047000,-0.021000,164.499984,0.000000,-17.599994,1.000000,1.000000,1.000000);
	        if(id == 17) SetPlayerAttachedObject(playerid,1,343,5,0.034000,0.063000,-0.037999,164.500000,14.599996,-4.700009,1.000000,1.000000,1.000000);
	        if(id == 18) SetPlayerAttachedObject(playerid,1,344,5,0.022999,0.039000,-0.125999,165.700012,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id == 22) SetPlayerAttachedObject(playerid,1,346,5,0.033000,0.057999,-0.017999,146.299987,14.999998,-4.700002,1.000000,1.000000,1.000000);
	        if(id == 23) SetPlayerAttachedObject(playerid,1,347,5,0.050999,0.038000,-0.021999,144.500015,9.100000,-11.600002,1.000000,1.000000,1.000000);
	        if(id == 24) SetPlayerAttachedObject(playerid,1,348,5,0.041000,0.038000,-0.026999,173.899963,0.000000,1.799999,1.000000,1.000000,1.000000);
	        if(id == 25) SetPlayerAttachedObject(playerid,1,349,5,0.000000,0.089000,0.000000,153.500015,10.000001,4.800000,1.000000,1.000000,1.000000);
	        if(id == 26) SetPlayerAttachedObject(playerid,1,350,5,0.040000,0.026000,0.011000,-156.300003,0.000000,2.600000,1.000000,1.000000,1.000000);
	        if(id == 27) SetPlayerAttachedObject(playerid,1,351,5,0.023000,0.048999,-0.013000,172.200012,14.400005,0.599999,1.000000,1.000000,1.000000);
	        if(id == 28) SetPlayerAttachedObject(playerid,1,352,5,0.024999,0.048000,-0.012000,172.000076,-3.099988,-2.099991,1.000000,1.000000,1.000000);
	        if(id == 29) SetPlayerAttachedObject(playerid,1,353,5,0.005000,0.065000,-0.016000,162.399963,9.599999,8.400000,1.000000,1.000000,1.000000);
	        if(id == 30) SetPlayerAttachedObject(playerid,1,355,5,0.057999,0.076999,-0.023999,162.799942,14.399999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 31) SetPlayerAttachedObject(playerid,1,356,5,0.043999,0.028999,-0.038000,167.499969,15.999998,0.000000,1.000000,1.000000,1.000000);
	        if(id == 32) SetPlayerAttachedObject(playerid,1,372,5,0.048000,0.049999,0.011000,-172.600006,-2.299995,5.999999,1.000000,1.000000,1.000000);
	        if(id == 33) SetPlayerAttachedObject(playerid,1,357,5,-0.043000,0.065999,-0.044999,167.499954,17.399999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 34) SetPlayerAttachedObject(playerid,1,358,5,-0.018000,0.085000,0.033000,167.399978,12.200000,-0.299997,1.000000,1.000000,1.000000);
	        if(id == 35) SetPlayerAttachedObject(playerid,1,359,5,-0.002000,0.031000,-0.064000,146.000061,17.700002,-6.700002,1.000000,1.000000,1.000000);
	        if(id == 36) SetPlayerAttachedObject(playerid,1,360,5,0.002000,0.032000,-0.071000,154.699981,16.600000,-9.000000,1.000000,1.000000,1.000000);
	        if(id == 37) SetPlayerAttachedObject(playerid,1,361,5,0.048000,0.038999,-0.091000,160.500045,27.300014,-3.600001,1.000000,1.000000,1.000000);
	        if(id == 38) SetPlayerAttachedObject(playerid,1,362,5,0.031000,0.030000,-0.105000,148.300064,28.699989,-0.700000,1.000000,1.000000,1.000000);
	        if(id == 39) SetPlayerAttachedObject(playerid,1,363,5,-0.022000,0.087999,0.006999,154.899978,20.799997,-0.300001,1.000000,1.000000,1.000000);
	        if(id == 40) SetPlayerAttachedObject(playerid,1,364,5,0.047000,0.057000,-0.038000,133.699981,17.199989,2.099999,1.000000,1.000000,1.000000);
	        if(id == 41) SetPlayerAttachedObject(playerid,1,365,5,0.036999,0.026999,-0.079999,152.899993,14.900004,-0.400000,1.000000,1.000000,1.000000);
	        if(id == 42) SetPlayerAttachedObject(playerid,1,366,5,0.004000,0.061999,-0.063999,126.599990,33.099998,2.200000,1.000000,1.000000,1.000000);
	        if(id == 43) SetPlayerAttachedObject(playerid,1,367,5,0.018000,0.062999,0.074999,-109.400039,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id >= 44 && id <= 56) SetPlayerAttachedObject(playerid,1,2039,5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999);
			if(id == 57) SetPlayerAttachedObject(playerid,1,1242,5,0.255000,0.000000,0.000000,-1.300001,-101.699958,16.500001,1.000000,1.000000,1.000000);
			if(id == 58) SetPlayerAttachedObject(playerid,1,2702,5,0.193999,0.054000,0.000000,-29.899995,4.000002,-96.200019,1.000000,1.000000,1.000000);
            if(id == 69) SetPlayerAttachedObject(playerid,1,327,5);
            if(id == 71) SetPlayerAttachedObject(playerid,1,2039,5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999);
            if(id >= 80 && id <= 87 || id == 77) SetPlayerAttachedObject(playerid,1,1546,5,0.123000,0.025000,-0.009999,158.499969,-1.000000,-177.599990,1.000000,1.000000,0.991999);
            if(id == 78 || id == 82) SetPlayerAttachedObject(playerid,1,1509,5,0.108999,0.026000,-0.019000,158.399978,0.000000,180.000000,1.000000,1.000000,1.000000);
			if(id == 89 || id == 43) SetPlayerAttachedObject(playerid,1,18865,5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999);
		if(id == 90) SetPlayerAttachedObject(playerid,1,18644,5,0.058000,0.000000,0.000000,171.000061,-80.600143,10.399996,1.000000,1.000000,1.000000);
		if(id == 91) SetPlayerAttachedObject(playerid,1,1550,5,0.058000,0.000000,0.000000,171.000061,-80.600143,10.399996,1.000000,1.000000,1.000000);
		}
		Streamer_Update(playerid);
	}
	return 1;
}

stock EsArma(id){
	if(id >= 1 && id <= 43) return 1;
	return 0;
}

stock ObjetoPesado(id){
 if(id == 1 || id == 4 || id == 3) return LIVIANO;
 if(id == 2) return PESADO;
 if(id >= 5 && id <= 10) return PESADO;
 if(id >= 11 && id <= 13) return LIVIANO;
 if(id >= 14 && id <= 15) return PESADO;
 if(id >= 16 && id <= 18) return LIVIANO;
 if(id >= 22 && id <= 24) return LIVIANO;
 if(id >= 25 && id <= 27) return PESADO;
 if(id == 28) return LIVIANO;
 if(id >= 30 && id <= 31) return PESADO;
 if(id == 32) return LIVIANO;
 if(id >= 33 && id <= 41) return PESADO;
 if(id == 42) return PESADO;
 if(id >= 43 && id <= 57) return LIVIANO;
 if(id >= 69 && id <= 90) return LIVIANO;
 if(id == 91) return PESADO;
 return -1;
}

stock TieneModel(id){
	if(id >= 1 && id <= 57) return 1;
	return 0;
}

stock DarObjeto(playerid, id, tipo, cantidad){
    for(new i = 11; i < 13; i++){
        if(BolsilloID[playerid][i] == 0){
			BolsilloID[playerid][i] = id;
			BolsilloTipo[playerid][i] = tipo;
			BolsilloCantidad[playerid][i] = cantidad;
			if(i == 11 && EsArma(id)) SafeGivePlayerWeapon(playerid, id, cantidad);
		    ActualizarObjetos(playerid);
            return 1;
        }
    }
    if(ObjetoPesado(id) == PESADO){
        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene una mano desocupada.");
        return 0;
    }
	for(new i = 1; i < 11; i++){
        if(BolsilloID[playerid][i] == 0){

			BolsilloID[playerid][i] = id;
			BolsilloTipo[playerid][i] = tipo;
			BolsilloCantidad[playerid][i] = cantidad;
			format(string, sizeof(string), "El objeto seleccionado ha sido colocado en el bolsillo #%d.", i);
			Mensaje(playerid, COLOR_BLANCO, string);
			return 1;
        }
    }
	return 0;
}
stock QuitarObjeto(targetid, bolsillo){
	if(EsArma(BolsilloID[targetid][11])) ResetPlayerWeapons(targetid);
	BolsilloID[targetid][bolsillo] = 0;
	BolsilloTipo[targetid][bolsillo] = 0;
	BolsilloCantidad[targetid][bolsillo] = 0;
	ActualizarObjetos(targetid);
	return 1;
}
stock MostrarBolsillos(playerid){
    new dialog[1024];
	for(new i = 1; i < 13; i++){
		if(i == 1){
		    if(BolsilloID[playerid][i] != 0) format(dialog, sizeof(dialog), "{FFFFFF}1) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][1]), BolsilloCantidad[playerid][1]);
		    else format(dialog, sizeof(dialog), "{FFFFFF}1) - Bolsillo vacío.");
		    continue;
		}
		if(i == 11){
			strcat(dialog, "\n|--------------------------------------------------------------|");
			if(BolsilloID[playerid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano derecha - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][i]), BolsilloCantidad[playerid][i]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano derecha desocupada.");
  			strcat(dialog, string);
  			continue;
		}
		if(i == 12){
			if(BolsilloID[playerid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano izquierda - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][i]), BolsilloCantidad[playerid][i]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano izquierda desocupada.");
  			strcat(dialog, string);
  			break;
		}
		if(BolsilloID[playerid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%d) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", i, ObtenerNombreObjeto(BolsilloID[playerid][i]), BolsilloCantidad[playerid][i]);
  		else format(string, sizeof(string), "\n{FFFFFF}%d) - Bolsillo vacío.", i);
  		strcat(dialog, string);
	}
	format(string, sizeof(string), "{FFFFFF}Bolsillos de %s", pName(playerid));
	ShowPlayerDialog(playerid, BOLSILLOS, DIALOG_STYLE_LIST, string, dialog, "Seleccionar", "Salir");
	return 1;
}
stock MostrarEspecial(playerid)
{
    new dialog[1024];
	if(CinturonID[playerid] != 0) format(dialog, sizeof(dialog), "{FFFFFF}1) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(CinturonID[playerid]), 	CinturonCantidad[playerid]);
	else format(dialog, sizeof(dialog), "{FFFFFF}1) - Cinturón vacío.");
	if(EspaldaID[playerid] != 0) format(string, sizeof(string), "\n{FFFFFF}2) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(EspaldaID[playerid]), 	EspaldaCantidad[playerid]);
  	else format(string, sizeof(string), "\n{FFFFFF}2) - Espalda libre.");
	strcat(dialog, string);
	strcat(dialog, "\n|--------------------------------------------------------------|");
	if(BolsilloID[playerid][11] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano derecha - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][11]), 	BolsilloCantidad[playerid][11]);
	else format(string, sizeof(string), "\n{FFFFFF}Mano derecha desocupada.");
	strcat(dialog, string);
	if(BolsilloID[playerid][12] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano izquierda - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][12]), 	BolsilloCantidad[playerid][12]);
	else format(string, sizeof(string), "\n{FFFFFF}Mano izquierda desocupada.");
	strcat(dialog, string);
	format(string, sizeof(string), "{FFFFFF}Bolsillos especiales de %s", pName(playerid));
	ShowPlayerDialog(playerid, ESPECIAL, DIALOG_STYLE_LIST, string, dialog, "Seleccionar", "Salir");
	return 1;
}
stock MostrarCacheo(targetid, playerid) {
    new dialog[1024];
	for(new i = 1; i < 13; i++){
		if(i == 1){
		    if(BolsilloID[targetid][i] != 0) format(dialog, sizeof(dialog), "{FFFFFF}1) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[targetid][1]), BolsilloCantidad[targetid][1]);
		    else format(dialog, sizeof(dialog), "{FFFFFF}1) - Bolsillo vacío.");
		    continue;
		}
		if(i == 11){
			strcat(dialog, "\n|--------------------------------------------------------------|");
			if(BolsilloID[targetid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano derecha - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[targetid][i]), BolsilloCantidad[targetid][i]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano derecha desocupada.");
  			strcat(dialog, string);
  			continue;
		}
		if(i == 12){
			if(BolsilloID[targetid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano izquierda - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[targetid][i]), BolsilloCantidad[targetid][i]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano izquierda desocupada.");
  			strcat(dialog, string);
  			break;
		}
		if(BolsilloID[targetid][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%d) - {FFFF00}U%s {FFFFFF}({00FF00}%d{FFFFFF})", i, ObtenerNombreObjeto(BolsilloID[targetid][i]), BolsilloCantidad[targetid][i]);
  		else format(string, sizeof(string), "\n{FFFFFF}%d) - Bolsillo vacío.", i);
  		strcat(dialog, string);
	}
	format(string, sizeof(string), "{FFFFFF}Bolsillos de %s", pName(targetid));
	ShowPlayerDialog(playerid, CACHEO, DIALOG_STYLE_LIST, string, dialog, "Seleccionar", "Salir");
	return 1;
}


forward EstablecerChaleco(playerid, Float: chaleco); public EstablecerChaleco(playerid, Float: chaleco){
    PlayerInfo[playerid][pArmor] = chaleco;
    SetPlayerArmour(playerid, chaleco);
    return 1;
}

stock CambiarArma(playerid){
    new armas[13][2];
	for(new i = 0; i < 13; i++){
		GetPlayerWeaponData(playerid, i, armas[i][0], armas[i][1]);
		if(GetPlayerWeapon(playerid) != armas[i][0]){
			if(armas[i][1] >= 1){
				SafeGivePlayerWeapon(playerid, armas[i][0], 0);
			}
		}
	}
	return 1;
}
forward KickRetra(playerid);
new ckick[MAX_PLAYERS];

public KickRetra(playerid) {
    if (!IsPlayerConnected(playerid)) return 1;
    Kick(playerid);
    return 1;
}
stock KickRetrasado(playerid) {
    KillTimer(ckick[playerid]);
    ckick[playerid] = SetTimerEx("KickRetra", 1, false, "i", playerid);
    return 1;
}

stock CleanScreen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        ClearChatbox(i, 100);
    }
    return 1;
}

stock PlayerToPlayer(Float:radi, playerid, playerid2)
{
    new Float:oldposx, Float:oldposy, Float:oldposz;
    GetPlayerPos(playerid2, oldposx, oldposy, oldposz);
    return PlayerToPoint(radi, playerid, oldposx, oldposy, oldposz);
}
stock MensajeFormato(playerid,color,const msg[],{Float,_}:...)
{
new len = strlen(msg),d=0,posArg = 3;
new dest[512];
for(new i=0;i<len;i++)
{
if(msg[i] == '%')
{
switch (msg[i+1])
{
case 's':
{
new pos,arg,tmppos;
new str[128];
while(getarg(posArg,pos)!=' ')
{
arg=getarg(posArg,pos++);
str[tmppos]=arg;
tmppos++;
}
strins(dest,str,d,strlen(str));
d+=strlen(str);
posArg++;
i++;
}
case 'i', 'd':
{
new str[128];
format(str,sizeof(str),"%d",getarg(posArg));
strins(dest,str,d,strlen(str));
d+=strlen(str);
posArg++;
i++;
}
case 'f':
{
new str[128];
format(str,sizeof(str),"%f",getarg(posArg));
strins(dest,str,d,strlen(str));
d+=strlen(str);
posArg++;
i++;
}
case '.':
{
new len2 = msg[i+2];
if(len2 == 0)
{
dest[d] = msg[i];
d++;
}
else
{
new str[32],formatting[5];
formatting[0] = '%';
formatting[1] = '.';
formatting[2] = len2;
formatting[3] = 'f';
format(str,sizeof(str),formatting,getarg(posArg));
strins(dest,str,d,len2);
d+=len;
posArg++;
i+= 2;
}
}
default:
{
dest[d] = msg[i];
d++;
}
}
}
else
{
dest[d] = msg[i];
d++;
}
}
return SendClientMessage(playerid,color,dest);
}
stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock PointToPoint2D(Float:radi, Float:x, Float:y, Float:x2, Float:y2)
{
	new Float:distance;
    distance= floatsqroot( floatadd ( floatpower( floatsub ( x2 , x) , 2) , floatpower( floatsub ( y2 , y), 2) ) );
	
    if (distance < radi)
    {
        return 1;
    }
	return 0;
}
stock PointToPoint3D(Float:radi, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
    new Float:distance;
    distance= floatsqroot( floatadd ( floatadd ( floatpower( floatsub ( x2 , x) , 2) , floatpower( floatsub ( y2 , y), 2) ), floatpower( floatsub ( z2 , z), 2) ) );

    if (distance < radi)
    {
        return 1;
    }
	return 0;
}

stock strtokex(const stringe[], &index)
{
	new length = strlen(stringe);
	while ((index < length) && (stringe[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (stringe[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = stringe[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
stock strtok(const stringe[], &index)
{
	new length = strlen(stringe);
	while ((index < length) && (stringe[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (stringe[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = stringe[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
stock ProxDetector(Float:radi, playerid, stringe[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
				    {
						GetPlayerPos(i, posx, posy, posz);
						tempposx = (oldposx -posx);
						tempposy = (oldposy -posy);
						tempposz = (oldposz -posz);
						//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
						if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SendClientMessage(i, col1, stringe);
						}
						else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SendClientMessage(i, col2, stringe);
						}
						else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SendClientMessage(i, col3, stringe);
						}
						else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SendClientMessage(i, col4, stringe);
						}
						else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SendClientMessage(i, col5, stringe);
						}
					}
				}
				else
				{
					SendClientMessage(i, col1, stringe);
				}
			}
	}//not connected
	return 1;
}

stock Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock Float:GetDistanceBetweenPoints(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetVehiclePos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

stock CheckPlayerDistanceToVehicle(Float:radi, playerid, vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:PX,Float:PY,Float:PZ,Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,PX,PY,PZ);
		GetVehiclePos(vehicleid, X,Y,Z);
		new Float:Distancia = (X-PX)*(X-PX)+(Y-PY)*(Y-PY)+(Z-PZ)*(Z-PZ);
		if(Distancia <= Float:radi*radi)
		{
			return 1;
		}
	}
	return 0;
}

stock Replace(stringo[24], find[128], replace[128])
{
	new pos;
	while((pos = strfind(stringo, find, true)) != -1)
	{
		strdel(stringo, pos, pos + strlen(find));
		strins(stringo, replace, pos);
	}
	return stringo;
}

stock VehicleToPoint(Float:radi, vehicleid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetVehiclePos(CarInfo[vehicleid][cId], oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock enfrente(playerid, Float:tmpdist, &Float:tx, &Float:ty, &Float:tz, &Float:tang)
{
	GetPlayerPos(playerid,tx,ty,tz);
	GetPlayerFacingAngle(playerid, tang);
	tx=floatadd(tx,floatmul(floatsin(tang,degrees),-tmpdist));
	ty=floatadd(ty,floatmul(floatcos(tang,degrees),tmpdist));
//	printf("%f %f %f", floatsin(tmpang,degrees), floatcos(tmpang,degrees), tmpang);
	return 1;
}

stock ABroadCast(color,const stringe[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdmin] >= level)
			{
				if(ChatAdmin[i] == 0) {
				SendClientMessage(i, color, stringe);
				}
			}
		}
	}
	printf("%s", stringe);
	return 1;
}

stock ABroadCastOnDuty(color,const stringe[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdminDuty] == 1)
			{
				SendClientMessage(i, color, stringe);
			}
		}
	}
	printf("%s", stringe);
	return 1;
}

stock ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21) // Strip out leading spaces
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos])) // Check whole passed string
	{
		// If they have a numeric name you have a problem (although names are checked on id failure)
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
			{
				/*if (playerid != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, 0xFF0000AA, "User not connected");
				}*/
				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid; // A player was found
			}
		}
		/*else
		{
			if (playerid != INVALID_PLAYER_ID)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
			}
			userid = INVALID_PLAYER_ID;
		}
		return userid;*/
		// Removed for fallthrough code
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{
				if (len == strlen(name)) // Exact match
				{
					return i; // Return the exact player on an exact match
					// Otherwise if there are two players:
					// Me and MeYou any time you entered Me it would find both
					// And never be able to return just Me's id
				}
				else // Partial match
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
		//		SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
			}
			else
			{
		//		SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}

stock IsNumeric(stringer[]) { for (new i = 0, j = strlen(stringer); i < j; i++) if (stringer[i] > '9' || stringer[i] < '0') return 0; return 1; }

stock MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[]) // by Luk0r
{
	print("MYSQL: Intentando conexión...");
	mysql_connect(sqlhost, sqluser, sqldb, sqlpass);
	if(mysql_ping()==1)
	{
		print("MYSQL: Conexión establecida.");
		return 1;
	}
	else
	{
		print("MYSQL: Error en la conexión, reintentando...");
		mysql_connect(sqlhost, sqluser, sqldb, sqlpass);
		if(mysql_ping()==1)
		{
			print("MYSQL: Reconexión exitosa. Se puede continuar normalmente.");
			return 1;
		}
		else
		{
			print("MYSQL: No se puede reconectar, cerrando servidor...");
			SendRconCommand("gmx");
			return 0;
		}
	}
}

forward Descongelar(playerid);
public Descongelar(playerid)
{
	TogglePlayerControllable(playerid, 1);
	PlayerInfo[playerid][pTempFrozen] = 0;
	return 1;
}

stock SaveCar(idx)
{
	new tmp[128];
	
	format(CarInfo[idx][cRadios], 40, "%d,%d,%d",
		CarInfo[idx][cEmisora],
		CarInfo[idx][cVolumen],
		CarInfo[idx][cEquipo]);
	format(tmp, 128, "UPDATE cars SET Radios='%s' WHERE `id` = %d", CarInfo[idx][cRadios], CarInfo[idx][cSQLID]);
	mysql_query(tmp);
	
	format(CarInfo[idx][cSlots], 128, "%d,%d,%d,%d,%d,%d,%d,%d",
		CarInfo[idx][cSlot][0],
		CarInfo[idx][cSlot][1],
		CarInfo[idx][cSlot][2],
		CarInfo[idx][cSlot][3],
		CarInfo[idx][cSlot][4],
		CarInfo[idx][cSlot][5],
		CarInfo[idx][cSlot][6],
		CarInfo[idx][cSlot][7]);
	format(tmp, 128, "UPDATE cars SET Slots='%s' WHERE `id` = %d", CarInfo[idx][cSlots], CarInfo[idx][cSQLID]);
    mysql_query(tmp);
    
	format(CarInfo[idx][cAmmos], 128, "%d,%d,%d,%d,%d,%d,%d,%d",
		CarInfo[idx][cAmmo][0],
		CarInfo[idx][cAmmo][1],
		CarInfo[idx][cAmmo][2],
		CarInfo[idx][cAmmo][3],
		CarInfo[idx][cAmmo][4],
		CarInfo[idx][cAmmo][5],
		CarInfo[idx][cAmmo][6],
		CarInfo[idx][cAmmo][7]);
	format(tmp, 128, "UPDATE cars SET Ammos='%s' WHERE `id` = %d", CarInfo[idx][cAmmos], CarInfo[idx][cSQLID]);
    mysql_query(tmp);
	
    format(CarInfo[idx][cDrogas], 128, "%d,%d,%d,%d,%d,%d,%d",
    CarInfo[idx][cSemillas][0],
    CarInfo[idx][cDrogaNP][0],
    CarInfo[idx][cDrogaP][0],
    CarInfo[idx][cSemillas][1],
    CarInfo[idx][cDrogaNP][1],
    CarInfo[idx][cDrogaP][1],
    CarInfo[idx][cDrogaP][2]);
	format(tmp, 128, "UPDATE cars SET Drogas='%s' WHERE `id` = %d", CarInfo[idx][cDrogas], CarInfo[idx][cSQLID]);
    mysql_query(tmp);
	
	GetVehicleDamageStatus(CarInfo[idx][cId], CarInfo[idx][cDano][0], CarInfo[idx][cDano][1], CarInfo[idx][cDano][2], CarInfo[idx][cDano][3]);
	GetVehicleHealth(CarInfo[idx][cId], CarInfo[idx][cDamage]);
	format(CarInfo[idx][cDanos], 40, "%d,%d,%d,%d,%f",
		CarInfo[idx][cDano][0],
		CarInfo[idx][cDano][1],
		CarInfo[idx][cDano][2],
		CarInfo[idx][cDano][3],
		CarInfo[idx][cDamage]);
	format(tmp, 128, "UPDATE cars SET Danos='%s' WHERE id = %d", CarInfo[idx][cDanos], CarInfo[idx][cSQLID]);
	mysql_query(tmp);

    format(CarInfo[idx][cComponentes], 128, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
		CarInfo[idx][cComp][0],
		CarInfo[idx][cComp][1],
		CarInfo[idx][cComp][2],
		CarInfo[idx][cComp][3],
		CarInfo[idx][cComp][4],
		CarInfo[idx][cComp][5],
		CarInfo[idx][cComp][6],
		CarInfo[idx][cComp][7],
		CarInfo[idx][cComp][8],
		CarInfo[idx][cComp][9],
		CarInfo[idx][cComp][10],
		CarInfo[idx][cComp][11],
		CarInfo[idx][cComp][12],
		CarInfo[idx][cComp][13]
	);
    format(tmp, 512, "UPDATE cars SET Comp='%s' WHERE `id` = %d", CarInfo[idx][cComponentes], CarInfo[idx][cSQLID]);
    mysql_query(tmp);
	
    new sql[2048];
	format(sql, sizeof(sql), "UPDATE cars SET `Key`=%d,Model=%d,C1=%d,C2=%d,Owner='%s',Des='%s',Val=%d,Uso=%d,Own=%d,`Lock`=%d,Motor=%d,B=%d,Gas=%d,PJ=%d,Horas=%d,Park=%d,Sirena=%d,Multa=%d,RazonMulta='%s',UltimoOcupante='%s' WHERE `id`=%d",
        CarInfo[idx][cCarKey],
		CarInfo[idx][cModel],
		CarInfo[idx][cColorOne],
		CarInfo[idx][cColorTwo],
		CarInfo[idx][cOwner],
		CarInfo[idx][cDescription],
		CarInfo[idx][cValue],
		CarInfo[idx][cUsos],
		CarInfo[idx][cOwned],
		CarInfo[idx][cLock],
		CarInfo[idx][cStarted],
		CarInfo[idx][cBroken],
		CarInfo[idx][cGas],
		CarInfo[idx][cPaintJob], // PJ -
		CarInfo[idx][horas],
		CarInfo[idx][cParking],
		CarInfo[idx][cSirena],
		CarInfo[idx][cMulta],
		CarInfo[idx][cRazonMulta],
		CarInfo[idx][cUltimoOcupante],
		CarInfo[idx][cSQLID]
	);
	mysql_query(sql);
	
	
	new sql2[2048];
	format(sql2, sizeof(sql2), "UPDATE cars SET MCantidad0=%d,MCantidad1=%d,MCantidad2=%d,MCantidad3=%d,MCantidad4=%d,MTipo0=%d,MTipo1=%d,`MTipo2`=%d,MTipo3=%d,MTipo4=%d,MID0=%d,MID1=%d,MID2=%d,MID3=%d,MID4=%d WHERE `id`=%d",
		CarInfo[idx][aMalCantidad][0],
		CarInfo[idx][aMalCantidad][1],
		CarInfo[idx][aMalCantidad][2],
		CarInfo[idx][aMalCantidad][3],
		CarInfo[idx][aMalCantidad][4],
		CarInfo[idx][aMalTipo][0],
		CarInfo[idx][aMalTipo][1],
		CarInfo[idx][aMalTipo][2],
		CarInfo[idx][aMalTipo][3],
		CarInfo[idx][aMalTipo][4],
		CarInfo[idx][aMalID][0],
		CarInfo[idx][aMalID][1],
		CarInfo[idx][aMalID][2], // PJ -
		CarInfo[idx][aMalID][3],
		CarInfo[idx][aMalID][4],
		CarInfo[idx][cSQLID]
	);
	mysql_query(sql2);
	
	if(CarInfo[idx][cUsos] == 0 && !(strcmp(CarInfo[idx][cOwner], "autoescuela", true) == 0))
	{
		format(sql, sizeof(sql), "UPDATE cars SET X=%f,Y=%f,Z=%f,A=%f,Kms=%f,Vw=%d,Interior=%d,Seguro=%d WHERE id = %d",
			CarInfo[idx][cLocationx],
			CarInfo[idx][cLocationy],
			CarInfo[idx][cLocationz],
			CarInfo[idx][cAngle],
			CarInfo[idx][cKms],
			CarInfo[idx][cVw],
			CarInfo[idx][cInt],
			CarInfo[idx][cSeguro],
			CarInfo[idx][cSQLID]);
		mysql_query(sql);
        //printf(sql);
	}
	return 1;
}

stock pName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	Replace(name, "_", " ");
	return name;
}

stock pNameEx(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if (x > minx && x < maxx && y > miny && y < maxy) return 1;
    return 0;
}

stock IsPlayerInParking(playerid)
{
	for(new i; i < TotalParkings; i++)
	{
		if(PlayerToPoint(2.0, playerid, ParkInfo[i][paX], ParkInfo[i][paY], ParkInfo[i][paZ]))
		{
			return 1;
		}
		else if(PlayerToPoint(20.0, playerid, 1499.4244384766, 183.61317443848, 1770.9107666016) && ParkInfo[i][paType] == 2)
		{
			return 1;
		}
	}
	return 0;
}

stock GetPlayerParking(playerid)
{
	new parking = -1;
	for(new i = 0; i < TotalParkings; i++)
	{
		if(PlayerToPoint(2.0, playerid, ParkInfo[i][paX], ParkInfo[i][paY], ParkInfo[i][paZ]))
		{
			parking = i;
			break;
		}
		else if(PlayerToPoint(20.0, playerid, 1499.4244384766, 183.61317443848, 1770.9107666016))
		{
			parking = GetPlayerVirtualWorld(playerid);
			break;
		}
	}
	return parking;
}

stock SendFamilyMessage(family, color, stringe[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == family)
		    {
				SendClientMessage(i, color, stringe);
			}
		}
	}
}

stock SendFamilyMessageOnDuty(family, color, stringe[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == family && PlayerInfo[i][pDuty] == 1)
		    {
				SendClientMessage(i, color, stringe);
			}
		}
	}
}

stock IsACop(playerid)
{
	if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 6)
	{
		return 1;
	}
	return 0;
}

stock IsAMedic(playerid)
{
	if(PlayerInfo[playerid][pMember] == 2)
	{
		return 1;
	}
	return 0;
}

stock IsABombero(playerid)
{
	if(PlayerInfo[playerid][pMember] == 2)
	{
		return 1;
	}
	return 0;
}
stock FuerzaPublica(playerid)
{
   if(PlayerInfo[playerid][pMember] == 1)
	{
		return 1;
	}
	if(PlayerInfo[playerid][pMember] == 2)
	{
		return 1;
	}
   	if(PlayerInfo[playerid][pMember] == 5)
	{
		return 1;
	}
	if(PlayerInfo[playerid][pMember] == 2)
	{
		return 1;
	}
	
	return 0;
}
stock GetPlayerHouse(playerid)
{
	for(new h = 0; h < sizeof(CasaInfo); h++)
	{
		if(PlayerInfo[playerid][pPhousekey] == CasaInfo[h][hId])
		{		
			return h;
		}
		else if(IsACop(playerid))
		{
			if( (PlayerToPoint(5.0, playerid, CasaInfo[h][hSx], CasaInfo[h][hSy], CasaInfo[h][hSz])) && GetPlayerVirtualWorld(playerid)==CasaInfo[h][hId])
			{
				return h;
			}
		}
	}
	return -1;
}

stock GetHouseFromId(id)
{
	for(new h = 0; h < sizeof(CasaInfo); h++)
	{
		if(id == CasaInfo[h][hId]) return h;
	}
	return -1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x2, &Float:y2, Float:distance)
{
	new Float:a;

	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);

	if(GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x2 += (distance * floatsin(-a, degrees));
	y2 += (distance * floatcos(-a, degrees));
}

stock CocheArray(playerid)
{
new coche = GetPlayerVehicleID(playerid);
if(coche==0) return INEXISTENTE;
for(new i=0; i<CochesCargados; i++)
if(coche == AutoInfo[i][aID]) return i;
return INEXISTENTE;
}


stock GetPlayerVehicle(playerid)
{
	new car = GetPlayerVehicleID(playerid);
    if (car==0) return NOEXISTE;
	for (new i=0; i < TotalVeh; i++)
 		if (car == CarInfo[i][cId])
			return i;
	return NOEXISTE;
}

stock GetPlayerLevel(playerid)
{
	new Level;
	if(PlayerInfo[playerid][pRespeto] >= 970) Level=24;
	if(PlayerInfo[playerid][pRespeto] >= 1050) Level=25;
	if(PlayerInfo[playerid][pRespeto] >= 1000) Level=25;
	if(PlayerInfo[playerid][pRespeto] >= 970) Level=24;
	if(PlayerInfo[playerid][pRespeto] >= 940) Level=23;
	if(PlayerInfo[playerid][pRespeto] >= 920) Level=22;
	else if(PlayerInfo[playerid][pRespeto] >= 900) Level=21;
	else if(PlayerInfo[playerid][pRespeto] >= 850) Level=20;
	else if(PlayerInfo[playerid][pRespeto] >= 780) Level=19;
	else if(PlayerInfo[playerid][pRespeto] >= 720) Level=18;
	else if(PlayerInfo[playerid][pRespeto] >= 660) Level=17;
	else if(PlayerInfo[playerid][pRespeto] >= 600) Level=16;
	else if(PlayerInfo[playerid][pRespeto] >= 550) Level=15;
	else if(PlayerInfo[playerid][pRespeto] >= 500) Level=14;
	else if(PlayerInfo[playerid][pRespeto] >= 450) Level=13;
	else if(PlayerInfo[playerid][pRespeto] >= 400) Level=12;
	else if(PlayerInfo[playerid][pRespeto] >= 350) Level=11;
	else if(PlayerInfo[playerid][pRespeto] >= 300) Level=10;
	else if(PlayerInfo[playerid][pRespeto] >= 250) Level=9;
	else if(PlayerInfo[playerid][pRespeto] >= 200) Level=8;
	else if(PlayerInfo[playerid][pRespeto] >= 140) Level=7;
	else if(PlayerInfo[playerid][pRespeto] >= 100) Level=6;
	else if(PlayerInfo[playerid][pRespeto] >= 60) Level=5;
	else if(PlayerInfo[playerid][pRespeto] >= 40) Level=4;
	else if(PlayerInfo[playerid][pRespeto] >= 20) Level=3;
	else if(PlayerInfo[playerid][pRespeto] >= 10) Level=2;
	else if(PlayerInfo[playerid][pRespeto] >= 0) Level=1;
	return Level;
}

stock SetPlayerLevel(playerid,level)
{
	new RespetoMinimo;
	if(level == 0 || level == 1) RespetoMinimo = 0;
	else if(level == 2) RespetoMinimo = 10;
	else if(level == 3) RespetoMinimo = 20;
	else if(level == 4) RespetoMinimo = 40;
	else if(level == 5) RespetoMinimo = 60;
	else if(level == 6) RespetoMinimo = 100;
	else if(level == 7) RespetoMinimo = 140;
	else if(level == 8) RespetoMinimo = 200;
	else if(level == 9) RespetoMinimo = 250;
	else if(level == 10) RespetoMinimo = 300;
	else if(level == 11) RespetoMinimo = 350;
	else if(level == 12) RespetoMinimo = 400;
	else if(level == 13) RespetoMinimo = 450;
	else if(level == 14) RespetoMinimo = 500;
	else if(level == 15) RespetoMinimo = 550;
	else if(level == 16) RespetoMinimo = 600;
	else if(level == 17) RespetoMinimo = 660;
	else if(level == 18) RespetoMinimo = 720;
	else if(level == 19) RespetoMinimo = 780;
	else if(level >= 20) RespetoMinimo = 850;
	return PlayerInfo[playerid][pRespeto] = RespetoMinimo;
}

stock GetRespetoMinimo(level)
{
	new RespetoMinimo;
	if(level == 0 || level == 1) RespetoMinimo = 0;
	else if(level == 2) RespetoMinimo = 10;
	else if(level == 3) RespetoMinimo = 20;
	else if(level == 4) RespetoMinimo = 40;
	else if(level == 5) RespetoMinimo = 60;
	else if(level == 6) RespetoMinimo = 100;
	else if(level == 7) RespetoMinimo = 140;
	else if(level == 8) RespetoMinimo = 200;
	else if(level == 9) RespetoMinimo = 250;
	else if(level == 10) RespetoMinimo = 300;
	else if(level == 11) RespetoMinimo = 350;
	else if(level == 12) RespetoMinimo = 400;
	else if(level == 13) RespetoMinimo = 450;
	else if(level == 14) RespetoMinimo = 500;
	else if(level == 15) RespetoMinimo = 550;
	else if(level == 16) RespetoMinimo = 600;
	else if(level == 17) RespetoMinimo = 660;
	else if(level == 18) RespetoMinimo = 720;
	else if(level == 19) RespetoMinimo = 780;
	else if(level >= 20) RespetoMinimo = 850;
	return RespetoMinimo;
}

stock IsATeamCar(vid, team)
{
	if(CarInfo[vid][cUsos] == team)
	{	
		return 1;
	}
	
	return 0;
}

stock ClearChatbox(playerid, lines)
{
	if (IsPlayerConnected(playerid))
	{
		for(new i=0; i<lines; i++)
		{
			SendClientMessage(playerid, Gris, " ");
		}
	}
	return 1;
}

stock GetPlayerStats(targetid,returnid)
{
	new Sex[10];
	if(PlayerInfo[targetid][pSex] == 1) Sex = "Masculino"; else if(PlayerInfo[targetid][pSex] == 2) Sex = "Femenino";
	
	new Faccion[15];
	if(PlayerInfo[targetid][pMember] == 0) Faccion = "Ninguna.";
	else if(PlayerInfo[targetid][pMember] == 1) Faccion = "LSPD";
	else if(PlayerInfo[targetid][pMember] == 2) Faccion = "LAED";
	else if(PlayerInfo[targetid][pMember] == 3) Faccion = "LSTD";
	else if(PlayerInfo[targetid][pMember] == 4) Faccion = "LSNEWS";
	else if(PlayerInfo[targetid][pMember] == 5) Faccion = "Senado";
	else if(PlayerInfo[targetid][pMember] == 6) Faccion = "Sheriff";
	else if(PlayerInfo[targetid][pMember] == 91) Faccion = "RCA";
	else if(PlayerInfo[targetid][pMember] == 31) Faccion = "Mecanicos";
	else if(PlayerInfo[targetid][pMember] == 32) Faccion = "Gobierno";
	else if(PlayerInfo[targetid][pMember] == 33) Faccion = "Abogados";
	else if(101 > PlayerInfo[targetid][pMember] > 4) format(Faccion,sizeof(Faccion),"%d",PlayerInfo[targetid][pMember]);
	
    new Rango[35];
	if(PlayerInfo[targetid][pRank] == 0 && PlayerInfo[targetid][pMember] == 1) format(Rango,sizeof(Rango),"%d",PlayerInfo[targetid][pRank]);
	else if(PlayerInfo[targetid][pRank] == 1 && PlayerInfo[targetid][pMember] == 1) Rango = "Cadete";
	else if(PlayerInfo[targetid][pRank] == 2 && PlayerInfo[targetid][pMember] == 1) Rango = "Oficial I";
	else if(PlayerInfo[targetid][pRank] == 3 && PlayerInfo[targetid][pMember] == 1) Rango = "Oficial II";
	else if(PlayerInfo[targetid][pRank] == 4 && PlayerInfo[targetid][pMember] == 1) Rango = "Oficial III";
	else if(PlayerInfo[targetid][pRank] == 5 && PlayerInfo[targetid][pMember] == 1) Rango = "Sargento I";
	else if(PlayerInfo[targetid][pRank] == 6 && PlayerInfo[targetid][pMember] == 1) Rango = "Sargento II";
	else if(PlayerInfo[targetid][pRank] == 7 && PlayerInfo[targetid][pMember] == 1) Rango = "Detective I";
	else if(PlayerInfo[targetid][pRank] == 8 && PlayerInfo[targetid][pMember] == 1) Rango = "Detective II";
	else if(PlayerInfo[targetid][pRank] == 9 && PlayerInfo[targetid][pMember] == 1) Rango = "Detective III";
	else if(PlayerInfo[targetid][pRank] == 10 && PlayerInfo[targetid][pMember] == 1) Rango = "Teniente I";
	else if(PlayerInfo[targetid][pRank] == 11 && PlayerInfo[targetid][pMember] == 1) Rango = "Teniente II";
	else if(PlayerInfo[targetid][pRank] == 12 && PlayerInfo[targetid][pMember] == 1) Rango = "Capitán I";
	else if(PlayerInfo[targetid][pRank] == 13 && PlayerInfo[targetid][pMember] == 1) Rango = "Capitán II";
	else if(PlayerInfo[targetid][pRank] == 14 && PlayerInfo[targetid][pMember] == 1) Rango = "Capitán III";
	else if(PlayerInfo[targetid][pRank] == 15 && PlayerInfo[targetid][pMember] == 1) Rango = "Comandante";
	else if(PlayerInfo[targetid][pRank] == 16 && PlayerInfo[targetid][pMember] == 1) Rango = "Subjefe I";
	else if(PlayerInfo[targetid][pRank] == 17 && PlayerInfo[targetid][pMember] == 1) Rango = "Subjefe II";
	else if(PlayerInfo[targetid][pRank] == 18 && PlayerInfo[targetid][pMember] == 1) Rango = "Jefe de Policia";
	
	else if(PlayerInfo[targetid][pRank] == 1 && PlayerInfo[targetid][pMember] == 2) Rango = "Bombero I";
	else if(PlayerInfo[targetid][pRank] == 2 && PlayerInfo[targetid][pMember] == 2) Rango = "Bombero II";
	else if(PlayerInfo[targetid][pRank] == 3 && PlayerInfo[targetid][pMember] == 2) Rango = "Bombero III";
	else if(PlayerInfo[targetid][pRank] == 4 && PlayerInfo[targetid][pMember] == 2) Rango = "Técnico";
	else if(PlayerInfo[targetid][pRank] == 5 && PlayerInfo[targetid][pMember] == 2) Rango = "Ingeniero";
	else if(PlayerInfo[targetid][pRank] == 6 && PlayerInfo[targetid][pMember] == 2) Rango = "Capitan de bomberos";
	else if(PlayerInfo[targetid][pRank] == 7 && PlayerInfo[targetid][pMember] == 2) Rango = "Subjefe de bomberos";
	else if(PlayerInfo[targetid][pRank] == 8 && PlayerInfo[targetid][pMember] == 2) Rango = "Jefe de bomberos ";
	else if(PlayerInfo[targetid][pRank] == 9 && PlayerInfo[targetid][pMember] == 2) Rango = "Pasante";
	else if(PlayerInfo[targetid][pRank] == 10 && PlayerInfo[targetid][pMember] == 2) Rango = "Paramedico";
	else if(PlayerInfo[targetid][pRank] == 11 && PlayerInfo[targetid][pMember] == 2) Rango = "Enfermera";
	else if(PlayerInfo[targetid][pRank] == 12 && PlayerInfo[targetid][pMember] == 2) Rango = "Medico";
	else if(PlayerInfo[targetid][pRank] == 13 && PlayerInfo[targetid][pMember] == 2) Rango = "Medico general";
	else if(PlayerInfo[targetid][pRank] == 14 && PlayerInfo[targetid][pMember] == 2) Rango = "Jefe médico";
	else if(PlayerInfo[targetid][pRank] == 15 && PlayerInfo[targetid][pMember] == 2) Rango = "Subjefe del hospital";
	else if(PlayerInfo[targetid][pRank] == 16 && PlayerInfo[targetid][pMember] == 2) Rango = "Jefe de hospital";
	else if(PlayerInfo[targetid][pRank] == 17 && PlayerInfo[targetid][pMember] == 2) Rango = "Director de LAED";
	
	//
	
	
	//Gobierno
	else if(PlayerInfo[targetid][pRank] == 1 && PlayerInfo[targetid][pMember] == 32) Rango = "Empleado";
	else if(PlayerInfo[targetid][pRank] == 2 && PlayerInfo[targetid][pMember] == 32) Rango = "GuardaEspaldas";
	else if(PlayerInfo[targetid][pRank] == 3 && PlayerInfo[targetid][pMember] == 32) Rango = "Hombre Negocios";
	else if(PlayerInfo[targetid][pRank] == 4 && PlayerInfo[targetid][pMember] == 32) Rango = "Secretario";
	else if(PlayerInfo[targetid][pRank] == 5 && PlayerInfo[targetid][pMember] == 32) Rango = "Secretario Administrativo";
	else if(PlayerInfo[targetid][pRank] == 6 && PlayerInfo[targetid][pMember] == 32) Rango = "Jefe de Prensa";
	else if(PlayerInfo[targetid][pRank] == 7 && PlayerInfo[targetid][pMember] == 32) Rango = "Ministro";
	else if(PlayerInfo[targetid][pRank] == 8 && PlayerInfo[targetid][pMember] == 32) Rango = "Superintendente";
	else if(PlayerInfo[targetid][pRank] == 9 && PlayerInfo[targetid][pMember] == 32) Rango = "Vice-Alcalde";
	else if(PlayerInfo[targetid][pRank] == 10 && PlayerInfo[targetid][pMember] == 32) Rango = "Alcalde";

	//
	//Colegio de Abogados
	else if(PlayerInfo[targetid][pRank] == 1 && PlayerInfo[targetid][pMember] == 33) Rango = "Secretario";
	else if(PlayerInfo[targetid][pRank] == 2 && PlayerInfo[targetid][pMember] == 33) Rango = "Seguridad";
	else if(PlayerInfo[targetid][pRank] == 3 && PlayerInfo[targetid][pMember] == 33) Rango = "Abogado";
	else if(PlayerInfo[targetid][pRank] == 4 && PlayerInfo[targetid][pMember] == 33) Rango = "Abogado Institucional";
	else if(PlayerInfo[targetid][pRank] == 6 && PlayerInfo[targetid][pMember] == 33) Rango = "Fiscal";
	else if(PlayerInfo[targetid][pRank] == 7 && PlayerInfo[targetid][pMember] == 33) Rango = "Fiscal Institucional";
	else if(PlayerInfo[targetid][pRank] == 8 && PlayerInfo[targetid][pMember] == 33) Rango = "Juez";
	else if(PlayerInfo[targetid][pRank] == 9 && PlayerInfo[targetid][pMember] == 33) Rango = "Juez de Paz";
	else if(PlayerInfo[targetid][pRank] == 9 && PlayerInfo[targetid][pMember] == 33) Rango = "VicePresidente de la Corte";
    else if(PlayerInfo[targetid][pRank] == 10 && PlayerInfo[targetid][pMember] == 33) Rango = "Presidente de la Corte";
	//
	
	
	else if(PlayerInfo[targetid][pRank] > 0 && PlayerInfo[targetid][pRank] < 6 && PlayerInfo[targetid][pMember] == 6) Rango = "Ayudante";
	else if(PlayerInfo[targetid][pRank] == 6 && PlayerInfo[targetid][pMember] == 6) Rango = "Sheriff";
	else if(PlayerInfo[targetid][pMember] > 2) format(Rango,sizeof(Rango),"%d",PlayerInfo[targetid][pRank]);
	
	new Trabajo[20];
	if(PlayerInfo[targetid][pJob] == 0) Trabajo = "Ninguno";
	else if(PlayerInfo[targetid][pJob] == 1) Trabajo = "Mecánico";
	else if(PlayerInfo[targetid][pJob] == 2) Trabajo = "Granjero";
	else if(PlayerInfo[targetid][pJob] == 3) Trabajo = "Pescador";
	else if(PlayerInfo[targetid][pJob] == 4) Trabajo = "Limpia Calles";
	else if(PlayerInfo[targetid][pJob] == 5) Trabajo = "Basurero";
	else if(PlayerInfo[targetid][pJob] == 6) Trabajo = "Pizzero";
	else if(PlayerInfo[targetid][pJob] == 7) Trabajo = "Transportista";
	else if(PlayerInfo[targetid][pJob] == 8) Trabajo = "Vendedor de Comida";
	else if(PlayerInfo[targetid][pJob] == 9) Trabajo = "Detective";
	else if(PlayerInfo[targetid][pJob] == 10) Trabajo = "Vendedor de Seguros";
	else if(PlayerInfo[targetid][pJob] == 11) Trabajo = "Ladrón";
	else if(PlayerInfo[targetid][pJob] > 11) format(Trabajo,sizeof(Trabajo),"%d",PlayerInfo[targetid][pJob]);
	
	new Licencias[35];
	if(PlayerInfo[targetid][pCarLic] == 0 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Ninguna";
	else if(PlayerInfo[targetid][pCarLic] == 2 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Ninguna";
	else if(PlayerInfo[targetid][pCarLic] == 1 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Conducción";
	else if(PlayerInfo[targetid][pCarLic] == 1 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Conducción/Aviación";
	else if(PlayerInfo[targetid][pCarLic] == 1 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Conducción/Navegación";
	else if(PlayerInfo[targetid][pCarLic] == 0 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Aviación";
	else if(PlayerInfo[targetid][pCarLic] == 2 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 0) Licencias = "Aviación";
	else if(PlayerInfo[targetid][pCarLic] == 0 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Aviación/Navegación";
	else if(PlayerInfo[targetid][pCarLic] == 2 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Aviación/Navegación";
	else if(PlayerInfo[targetid][pCarLic] == 0 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Navegación";
	else if(PlayerInfo[targetid][pCarLic] == 2 && PlayerInfo[targetid][pFlyLic] == 0 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Navegación";
	else if(PlayerInfo[targetid][pCarLic] == 1 && PlayerInfo[targetid][pFlyLic] == 1 && PlayerInfo[targetid][pBoatLic] == 1) Licencias = "Conducción/Aviación/Navegación";

	
	
	new Telefono[10],Telefono2[10];
	if(PlayerInfo[targetid][pPnumber][0] == 0) Telefono = "Ninguno"; else format(Telefono,sizeof(Telefono),"%d",PlayerInfo[targetid][pPnumber][0]);
	if(PlayerInfo[targetid][pPnumber][1] == 0) Telefono2 = "Ninguno"; else format(Telefono2,sizeof(Telefono2),"%d",PlayerInfo[targetid][pPnumber][1]);
	
	new RespetoNecesario, Respeto[40]; 
	if(GetPlayerLevel(targetid) != 20){	
	RespetoNecesario = (GetRespetoMinimo(GetPlayerLevel(targetid)+1)-PlayerInfo[targetid][pRespeto]);
	format(Respeto,sizeof(Respeto),"Necesitas %d más para subir de nivel.",RespetoNecesario);}
	else{ format(Respeto,sizeof(Respeto),"Has alcanzado el nivel máximo.");}
	
	new vehiculos[128], prestado[128];
	for(new i = 0; i < MAX_PROPIOS; i++)
	{
		if(PlayerInfo[targetid][pPCarKey][i] != NOEXISTE && i > 0)
		{
			format(string, 128, ", %d", PlayerInfo[targetid][pPCarKey][i]);
			strcat(vehiculos, string, 128);
		}
		else if(PlayerInfo[targetid][pPCarKey][i] != NOEXISTE && i == 0)
		{
			format(string, 128, "%d", PlayerInfo[targetid][pPCarKey][i]);
			strcat(vehiculos, string, 128);
		}
	}
	
	for(new i = 0; i < MAX_PRESTADOS; i++)
	{
		if(PlayerInfo[targetid][pPCochePrestado][i] != NOEXISTE && i > 0)
		{
			format(string, 128, ", %d", PlayerInfo[targetid][pPCochePrestado][i]);
			strcat(prestado, string, 128);
		}
		else if(PlayerInfo[targetid][pPCochePrestado][i] != NOEXISTE && i == 0)
		{
			format(string, 128, "%d", PlayerInfo[targetid][pPCochePrestado][i]);
			strcat(prestado, string, 128);
		}
	}
	new rPremium[40];
	new pPremium = GetPlayerPremium(targetid);
	if(pPremium == 0) rPremium = "Nada";if(pPremium == 1) rPremium = "Bronce";if(pPremium == 2) rPremium = "Plata";if(pPremium == 3) rPremium = "Oro";

	//-----------------------
	SendClientMessage(returnid, Gris, "|____________________________ Información de personaje: _______________________________|");
	format(string,sizeof(string),"Nombre: %s | Edad: %d | Facción: %s | Rango: %s | Sexo: %s | Tlfs.: %s, %s",pName(targetid), PlayerInfo[targetid][pAge], Faccion, Rango, Sex, Telefono, Telefono2);
	SendClientMessage(returnid, Gris, string);
	format(string,sizeof(string),"Trabajo: %s | Cartera: %d$ | Saldo Bancario: %d$ | Licencias: %s | Puntos de Rol: %d/%d ", Trabajo, SafeGetPlayerMoney(targetid), PlayerInfo[targetid][pBank], Licencias, PlayerInfo[targetid][PuntosPositivos], PlayerInfo[targetid][PuntosNegativos]);
    SendClientMessage(returnid, Gris, string);
    SendClientMessage(returnid, Gris, "|________________________________ Estadísiticas:  ____________________________________|");
	format(string,sizeof(string),"Premium: %s | Advertencias: %d | Nivel: %d | Respeto: %d - %s", rPremium, PlayerInfo[targetid][pAdvertencias], GetPlayerLevel(targetid), PlayerInfo[targetid][pRespeto], Respeto);
	SendClientMessage(returnid, Gris, string);
	SendClientMessage(returnid, Gris, "|________________________________ Propiedades: ____________________________________|");
	format(string,sizeof(string),"Casa: %d | Negocio: %d | Vehículos: %s | Prestados: %s", 
	PlayerInfo[targetid][pPhousekey], PlayerInfo[targetid][pPbiskey], vehiculos, prestado);
	SendClientMessage(returnid, Gris, string);
	//-----------------------
	if(PlayerInfo[returnid][pAdmin] > 0)
	{
		new dinerocasa, estadocasa[24];
		if(PlayerInfo[targetid][pPhousekey] == NOEXISTE)
		{
			dinerocasa = 0; format(estadocasa,sizeof(estadocasa),"No tiene"); 
		}
		else 
		{
			dinerocasa = CasaInfo[GetPlayerHouse(targetid)][hDinero];
			if(strcmp(pNameEx(targetid), CasaInfo[GetPlayerHouse(targetid)][hOwner], true) == 0)
			{
				format(estadocasa,sizeof(estadocasa),"Propietario");
			}
			else format(estadocasa,sizeof(estadocasa),"Inquilino");
		}
		SendClientMessage(returnid, Amarillo, "|____________________________ Información para Admins: _______________________________|");
		format(string,sizeof(string),"SQLID: %d | Admin Lvl: %d | Virtual World: %d | Interior: %d | Skin: %d,%d | Checkpoint: %d | ", PlayerInfo[targetid][pSQLID], PlayerInfo[targetid][pAdmin], GetPlayerVirtualWorld(targetid), GetPlayerInterior(targetid),
			PlayerInfo[targetid][pSkin], PlayerInfo[targetid][pUniforme], PlayerInfo[targetid][pCheckpoint]);
		SendClientMessage(returnid, AmarilloClaro, string);
		format(string,sizeof(string),"Trabajando: %d | Ganancias: %d | Tiempo Espera: %d | Jail: %d,%d | Dinero en casa: %d$ (%s)", PlayerInfo[targetid][pTrabajando] , PlayerInfo[targetid][pGanancias],(PlayerInfo[targetid][TiempoEsperaTrabajo]-gettime())/60,  PlayerInfo[targetid][pJailed],
			PlayerInfo[targetid][pJailTime], dinerocasa, estadocasa);
		SendClientMessage(returnid, AmarilloClaro, string);
	}
	return 1;
}

stock MostrarLlaves(playerid,returnid)
{
	if(playerid == returnid)
	{
		SendClientMessage(returnid,Azul, "______|- LLAVES -|______");
	}
	else
	{	
		format(string,sizeof(string),"______| Llaves de %s (%d) |______",pName(playerid),playerid);
		SendClientMessage(returnid,Azul,string);
	}	
	for(new i; i < MAX_PROPIOS; i++)
	{
		if(PlayerInfo[playerid][pPCarKey][i] != NOEXISTE)
		{
			new llave = PlayerInfo[playerid][pPCarKey][i];
			new arrayid = GetPlayerVehicleByKey(llave);
			format(string,sizeof(string),"Slot %d: %s (LS-%d) - Dueño: %s",i+1,CarInfo[arrayid][cDescription],llave,CarInfo[arrayid][cOwner]);
			SendClientMessage(returnid,Blanco,string);
		}
	}
	for(new i; i < MAX_PRESTADOS; i++)
	{
		if(PlayerInfo[playerid][pPCochePrestado][i] != NOEXISTE)
		{
			new llave = PlayerInfo[playerid][pPCochePrestado][i];
			new arrayid = GetPlayerVehicleByKey(llave);
			format(string,sizeof(string),"Slot %d: %s (LS-%d) - Dueño: %s",i+6,CarInfo[arrayid][cDescription],llave,CarInfo[arrayid][cOwner]);
			SendClientMessage(returnid,Blanco,string);
		}
	}
	return 1;
}
stock MostrarInventario(playerid,returnid)
{
	if(playerid == returnid)
	{
		SendClientMessage(returnid,Azul, "______|- INVENTARIO -|______");
	}
	else
	{	
		format(string,sizeof(string),"______| Inventario de %s (%d)",pName(playerid),playerid);
		SendClientMessage(returnid,Azul,string);
	}	
	if(PlayerInfo[playerid][pDrogaP][0] > 0 || PlayerInfo[playerid][pDrogaP][1] > 0 || PlayerInfo[playerid][pDrogaP][2] > 0)
	{
		format(string, 128, "Marihuana Preparada: %d | Cocaina Preparada: %d | Crack: %d", PlayerInfo[playerid][pDrogaP][0], PlayerInfo[playerid][pDrogaP][1], PlayerInfo[playerid][pDrogaP][2]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pDrogaNP][0] > 0 || PlayerInfo[playerid][pDrogaNP][1] > 0)
	{
		format(string, 128, "Marihuana sin preparar: %d | Coca sin preparar: %d", PlayerInfo[playerid][pDrogaNP][0], PlayerInfo[playerid][pDrogaNP][1]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pParafernalia][0] > 0 || PlayerInfo[playerid][pParafernalia][1] > 0)
	{
		format(string, 128, "Parafernalia de Cocaina: %d | Parafernalia de Crack: %d", PlayerInfo[playerid][pParafernalia][0], PlayerInfo[playerid][pParafernalia][1]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pSemillas][0] > 0 || PlayerInfo[playerid][pSemillas][1] > 0)
	{
		format(string, 128, "Semillas de Marihuana: %d | Semillas de Coca: %d", PlayerInfo[playerid][pSemillas][0], PlayerInfo[playerid][pSemillas][1]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pProductos] > 0)
	{
		format(string, 128, "Productos: %d", PlayerInfo[playerid][pProductos]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pEncendedor] > 0 || PlayerInfo[playerid][pCigarrillos] > 0)
	{
		format(string, 128, "Mechero: %d | Cigarrillos: %d", PlayerInfo[playerid][pEncendedor], PlayerInfo[playerid][pCigarrillos]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pDado] > 0 || PlayerInfo[playerid][pCartas] > 0 || PlayerInfo[playerid][pLoteria] > -1)
	{
		format(string, 128, "Dado: %d | Cartas: %d | Lotería: %d", PlayerInfo[playerid][pDado], PlayerInfo[playerid][pCartas], PlayerInfo[playerid][pLoteria]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pPalanca] > 0 || PlayerInfo[playerid][pGanzua] > 0 || PlayerInfo[playerid][pAlicates] > 0)
	{
		format(string, 128, "Palanca: %d | Ganzua: %d | Alicates: %d", PlayerInfo[playerid][pPalanca], PlayerInfo[playerid][pGanzua], PlayerInfo[playerid][pAlicates]);
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pGafas] > 0 || PlayerInfo[playerid][pCascos] > 0 || PlayerInfo[playerid][pBandana] > 0)
	{
		format(string, 128, "Gafas: ");
        if (PlayerInfo[playerid][pGafas] > 0)
            strcat(string, "Sí");
        else
            strcat(string, "No");
		strcat(string," | Casco: ");
		if (PlayerInfo[playerid][pCascos] > 0)
			strcat(string, "Sí");
        else
            strcat(string, "No");
		strcat(string," | Bandana: ");
		if (PlayerInfo[playerid][pBandana] > 0)
			strcat(string, "Sí");
        else
            strcat(string, "No");
		SendClientMessage(returnid, Blanco, string);
	}
	if(PlayerInfo[playerid][pJob] == 11 || PlayerInfo[playerid][pJob] == 2 || PlayerInfo[playerid][pJob] == 3)
	{
		if(PlayerInfo[playerid][pJob] == 11) format(string, 128, "Material robado: %d objetos.",PlayerInfo[playerid][pMaterialTrabajo]);
		if(PlayerInfo[playerid][pJob] == 3) format(string, 128, "Cubo con peces: %d gramos.",PlayerInfo[playerid][pMaterialTrabajo]);
		if(PlayerInfo[playerid][pJob] == 2) format(string, 128, "Saco de trigo: %d gramos.",PlayerInfo[playerid][pMaterialTrabajo]);
		SendClientMessage(returnid, Blanco, string);
	}
	return 1;
}
forward SetCameraPosAtStart(playerid);
public SetCameraPosAtStart(playerid)
{
    SetPlayerCameraPos(playerid, 1439.6588,-763.3558,118.2791);
    SetPlayerCameraLookAt(playerid, 1309.6588,-1283.3558,08.2791);
}


Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;

	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

	new Float:DX, Float:DY;
	new Float:angle;
		
	DX = floatabs(floatsub(x2,X));
	DY = floatabs(floatsub(y2,Y));
	
	if (DY == 0.0 || DX == 0.0) {
		if(DY == 0 && DX > 0) angle = 0.0;
		else if(DY == 0 && DX < 0) angle = 180.0;
		else if(DY > 0 && DX == 0) angle = 90.0;
		else if(DY < 0 && DX == 0) angle = 270.0;
		else if(DY == 0 && DX == 0) angle = 0.0;
	}
	else {
		angle = atan(DX/DY);
	
		if(X > x2 && Y <= y2) angle += 90.0;
		else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
		else if(X < x2 && Y >= y2) angle -= 90.0;
		else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
	}			

	return floatadd(angle, 90.0);
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius) {
	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid)) {
		case 34,35,36: {
			if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
			return false;
		}
		case 30,31: {vertical = 4.0; horizontal = -1.6;}
		case 33: {vertical = 2.7; horizontal = -1.0;}
		default: {vertical = 6.0; horizontal = -2.2;}
	}

	new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));
	
	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
	return false;
}

stock IsPlayerAimingAtPlayer(playerid, targetid) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	if (IsPlayerAimingAt(playerid, x, y, z-0.75, 0.25)) return true;
	if (IsPlayerAimingAt(playerid, x, y, z-0.25, 0.25)) return true;
	if (IsPlayerAimingAt(playerid, x, y, z+0.25, 0.25)) return true;
	if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
	if (IsPlayerAimingAt(playerid, x, y, z+1.00, 0.25)) return true;
	return false;
}

#define MAX_DISTANCE_UNIT   800.0   // maximum distance a player can shoot from
//**BODY PARTS**//
#define BODY_PART_HEAD  1
#define BODY_PART_TORSO 2
#define BODY_PART_LEGS  3

/*
											---[IsPlayerAimingBodyPart]---
			»playerid: the player
			»bodypart: the body part you want to check
			*Return: 1 if true, 0 if false
		*-------------------------------------------------------------------*
		| Checks if the player is aiming at any player's certain body part.	|
		*-------------------------------------------------------------------*
*/
#if defined SCRIPT_DEBUG
	new shootpick[100];
#endif

stock IsPlayerAimingBodyPart(playerid, bodypart)
{
    #if defined SCRIPT_DEBUG
		new c;
	#endif
	// Get the camera's positions
	new Float:x, Float:y, Float:z, Float:a;
	new Float:vx, Float:vy, Float:vz;
	new Float:cx, Float:cy, Float:cz;
	new Float:offset;
	new Float:radius;
	GetPlayerCameraFrontVector(playerid, vx, vy, vz);
	GetPlayerCameraPos(playerid, cx, cy, cz);
	GetPlayerFacingAngle(playerid, a);
	// Check if the player is aiming in a certain distance
	for(new Float:d; d < MAX_DISTANCE_UNIT; d += 0.5)
	{
		switch (GetPlayerWeapon(playerid))
		{
		    case 24, 29, 22, 23, 25, 26, 27, 28, 32: offset = 0.11;
		    case 30, 31: offset = 0.07;
		    case 33: offset = 0.045;
		    default: offset = 0.0;
		}
	    switch (GetPlayerWeapon(playerid))
	    {
	        case 22, 26, 28, 32:
	        {
			    // duals, where you don't need to change your angle to change aim direction --  Not very accurate, but considering they spray, it should be good
			    x = vx*d+cx;
			    y = vy*d+cy;
	        }
	        default:
	        {
	    		// this is for weapons where your angle moves when you change your aim(deagle, sdpistol, m4, etc)
	            x = cx + (d * floatsin(-a, degrees));
	    		y = cy + (d * floatcos(-a, degrees));
	        }
	    }

	    z = (vz+offset)*d+cz;
	    switch (bodypart)
	    {
	        case BODY_PART_HEAD: z -= 0.0, radius = 0.3;  // the offsets are made for head shots
	        case BODY_PART_TORSO: z += 0.6, radius = 0.5;
	        case BODY_PART_LEGS: z += 1.2, radius = 0.4;
	    }

		#if defined SCRIPT_DEBUG
	        if (IsValidObject(shootpick[c])) DestroyObject(shootpick[c]);
			shootpick[c] = CreateObject(1274, x, y, z, 0.0, 0.0, 0.0);
			c++;
		#endif
		
	    for(new i, m = GetMaxPlayers(); i < m; i++)
	    {
			if (!IsPlayerConnected(i)) continue;
			if (playerid == i) continue;
			if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_DUCK)
			{
				if (IsPlayerInRangeOfPoint(i, radius+0.2, x, y, z+1.2-1.3-(bodypart==BODY_PART_TORSO?0.42:0.0)))
				{
					return i;
				}
			}
			else if (IsPlayerInRangeOfPoint(i, radius, x, y, z-0.8))
			{
				return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

/*
											---[IsPlayerAimingTargetBodyPart]---
			»playerid: the player
			»targetid: the target
			»bodypart: the body part you want to check
			*Return: 1 if true, 0 if false
		*-------------------------------------------------------------------*
		| Checks if the player is aiming at target's specific body part.	|
		*-------------------------------------------------------------------*
*/
stock IsPlayerAimingTargetBodyPart(playerid, targetid, bodypart)
{
    #if defined SCRIPT_DEBUG
		new c;
	#endif
	// Get the camera's positions
	if(!IsPlayerLookingAtPlayer(playerid, targetid)) return 1;
	new Float:x, Float:y, Float:z, Float:a;
	new Float:vx, Float:vy, Float:vz;
	new Float:cx, Float:cy, Float:cz;
	new Float:offset;
	new Float:radius;
	GetPlayerCameraFrontVector(playerid, vx, vy, vz);
	GetPlayerCameraPos(playerid, cx, cy, cz);
	GetPlayerFacingAngle(playerid, a);
	// Check if the player is aiming in a certain distance
	for(new Float:d; d < MAX_DISTANCE_UNIT; d += 0.5)
	{
		switch (GetPlayerWeapon(playerid))
		{
		    case 24, 29, 22, 23, 25, 26, 27, 28, 32: offset = 0.11;
		    case 30, 31: offset = 0.07;
		    case 33, 34: offset = 0.0;
		}
	    switch (GetPlayerWeapon(playerid))
	    {
	        case 22, 26, 28, 32:
	        {
			    // duals, where you don't need to change your angle to change aim direction --  Not very accurate, but considering they spray, it should be good
			    x = vx*d+cx;
			    y = vy*d+cy;
	        }
	        default:
	        {
	    		// this is for weapons where your angle moves when you change your aim(deagle, sdpistol, m4, etc)
	            x = cx + (d * floatsin(-a, degrees));
	    		y = cy + (d * floatcos(-a, degrees));
	        }
	    }

	    z = (vz+offset)*d+cz;
	    switch (bodypart)
	    {
	        case BODY_PART_HEAD: z -= 0.0, radius = 0.3;  // the offsets are made for head shots
	        case BODY_PART_TORSO: z += 0.6, radius = 0.5;
	        case BODY_PART_LEGS: z += 1.2, radius = 0.4;
	    }

		#if defined SCRIPT_DEBUG
	        if (IsValidObject(shootpick[c])) DestroyObject(shootpick[c]);
			shootpick[c] = CreateObject(1274, x, y, z, 0.0, 0.0, 0.0);
			c++;
		#endif

		if (GetPlayerSpecialAction(targetid) == SPECIAL_ACTION_DUCK)
		{
			if (IsPlayerInRangeOfPoint(targetid, radius+0.2, x, y, z+1.2-1.3-(bodypart==BODY_PART_TORSO?0.42:0.0)))
			{
				return 1;
			}
		}
		else if (IsPlayerInRangeOfPoint(targetid, radius, x, y, z-0.8))
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerLookingAtPlayer(player1, player2) { // Simon edited by Carlton
	if (!IsPlayerConnected(player1) || !IsPlayerConnected(player2)) return 0;
 	if(player1 == player2) return 0;
	new
		Float: distance,
		Float: vectorX,
		Float: vectorY,
		Float: vectorZ,
		Float: plyrPos[2][3],
		Float: projPos[3];
	GetPlayerCameraFrontVector(player1, vectorX, vectorY, vectorZ);
	GetPlayerCameraPos(player1, plyrPos[0][0], plyrPos[0][1], plyrPos[0][2]);
	GetPlayerPos(player2, plyrPos[1][0], plyrPos[1][1], plyrPos[1][2]);
	#define SQUARE(%1)  ((%1)*(%1))
	distance = floatsqroot(
	SQUARE(plyrPos[1][0]-plyrPos[0][0]) + SQUARE(plyrPos[1][1]-plyrPos[0][1]) + SQUARE(plyrPos[1][2]-plyrPos[0][2]));
	projPos[0] = plyrPos[0][0] + vectorX * distance;
	projPos[1] = plyrPos[0][1] + vectorY * distance;
	projPos[2] = plyrPos[0][2] + vectorZ * distance;
	return ((SQUARE(plyrPos[1][0]-projPos[0]) + SQUARE(plyrPos[1][1]-projPos[1]) + SQUARE(plyrPos[1][2]-projPos[2])) <= SQUARE(distance / 6));
	#undef SQUARE
}

GM_SetPlayerHealth(playerid, Float:Vida)
{
	SetPlayerHealth(playerid, Vida);
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if((floatcmp(Health,100.000) == 1) && (PlayerInfo[playerid][pAdminDuty] == 0))
	{
		SetPlayerHealth(playerid, 100);
	}
	
	if(floatcmp(Health,0.000) == 1)
	{
		format(string, 128, "UPDATE players SET Vida=%f WHERE id=%d", Health, PlayerInfo[playerid][pSQLID]);
		mysql_query(string);
	}
	return 1;
}



stock GetPlayer2DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsNotValid2DZone(Float:x, Float:y)
{
	new zone[128];
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    format(zone, 128, "%s", gSAZones[i][SAZONE_NAME]);
		}
	}
	
	if(strcmp(zone, "Willowfield", true) == 0 || strcmp(zone, "El Corona", true) == 0) 
	{
		return 1;
	}
	return 0;
}

GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}

forward ResetearTimerAnuncios();
public ResetearTimerAnuncios()
{
	return AnuncioTimer = 0;
}

stock PremiumValido(playerid, level)
{
	if(level == 0) return -1;
	new validez;
	if(PlayerInfo[playerid][pPremiumTipo] >= level)
	{
		if(gettime() < PlayerInfo[playerid][pPremiumTime])
		{
			validez = 1;
		}
		else
		{
			SaveValue(playerid, "Premium_Tipo", 0);
			SaveValue(playerid, "Premium_Timestamp", 0);
			validez = 0;
		}
	}
	return validez;
}

stock GetPlayerPremium(playerid)
{
	if(PremiumValido(playerid, 3))
	{
		return 3;
	}
	else if(PremiumValido(playerid, 2))
	{
		return 2;
	}
	else if(PremiumValido(playerid, 1))
	{
		return 1;
	}
	return 0;
}

stock VerPremium(targetid,returnid)
{
	new restante_segundos = PlayerInfo[targetid][pPremiumTime] - gettime();
	new restante_dias = ((restante_segundos /60) /60) /24;
    restante_segundos -= restante_dias*24*60*60;
	new restante_horas = (restante_segundos /60) /60;
    restante_segundos -= restante_horas*60*60;
	new restante_minutos = (restante_segundos /60);
	restante_segundos -= restante_minutos*60;
	if(GetPlayerPremium(targetid) == 0)
	{
		format(string, 128, "PREMIUM: El usuario %s no lo es.", pName(targetid)); 
	}
	else
	{
		format(string, 128, "PREMIUM: %s {FFFFFF} - {77c7ff}TIEMPO RESTANTE:{FFFFFF} %d días %d horas %d minutos %d segundos", Premium[GetPlayerPremium(targetid)], restante_dias, restante_horas, restante_minutos, restante_segundos); 
	}
	SendClientMessage(returnid, AzulClaro, string);
	return 1;
}
stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}

	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		SafeGivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}
#define MAX_ZONE_NAME 28
stock GetPlayer3DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock GetCasa3DZone(idcasa, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	idcasa = GetHouseFromId(idcasa);
	x = CasaInfo[idcasa][hEx];
	y = CasaInfo[idcasa][hEy];
	z = CasaInfo[idcasa][hEz];
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
//---------------------------------------------------------------------------------------------------

/* IsPlayerInZone(playerid, zone[])
 * @Info:   Used to check if the player is inside the zone[] parameter.
 *
 * @params: playerid      - The id of the player whose zone you will check.
 * @params: zone[]        - The string with which we will compare the players zone name to.
 */
stock IsCasaInZone(idcasa, zone[]) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new TmpZone[MAX_ZONE_NAME];
	GetCasa3DZone(idcasa, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}

LoadHeadQuarter()
{
    MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	new sql[80], row[512];
	format(sql, sizeof(sql), "SELECT COUNT(*) FROM headquarters");
	mysql_query(sql);
	mysql_store_result();
	mysql_fetch_row(row);
	hqcount = strval(row);

	for (new idx=0; idx<hqcount; idx++)
	{
	    format(sql, sizeof(sql), "SELECT * FROM headquarters WHERE id=%d LIMIT 1", idx+1);
	    mysql_query(sql);
	    mysql_store_result();
     	mysql_fetch_row(row);
		split(row, arrCoords, '|');
		format(HeadQuarterInfo[idx][hqName], 128, "%s", arrCoords[1]);
		HeadQuarterInfo[idx][hqFaccion] = strval(arrCoords[2]);
		HeadQuarterInfo[idx][hqEPos_x] = floatstr(arrCoords[3]);
		HeadQuarterInfo[idx][hqEPos_y] = floatstr(arrCoords[4]);
		HeadQuarterInfo[idx][hqEPos_z] = floatstr(arrCoords[5]);
		HeadQuarterInfo[idx][hqSPos_x] = floatstr(arrCoords[6]);
		HeadQuarterInfo[idx][hqSPos_y] = floatstr(arrCoords[7]);
		HeadQuarterInfo[idx][hqSPos_z] = floatstr(arrCoords[8]);
		HeadQuarterInfo[idx][hqInterior] = strval(arrCoords[9]);
		HeadQuarterInfo[idx][hqLocked] = strval(arrCoords[10]);
		HeadQuarterInfo[idx][hqCajaFuerte] = strval(arrCoords[11]);
		printf("HQ de la Facción: %d | X: %f Y:%f Z:%f | Interior: %d | Cerradura: %d | CF: $%d",
		    HeadQuarterInfo[idx][hqFaccion],
		    HeadQuarterInfo[idx][hqEPos_x],
		    HeadQuarterInfo[idx][hqEPos_y],
		    HeadQuarterInfo[idx][hqEPos_z],
		    HeadQuarterInfo[idx][hqInterior],
		    HeadQuarterInfo[idx][hqLocked],
		    HeadQuarterInfo[idx][hqCajaFuerte]);
	}
	printf("HQs Totales: %d",hqcount);
	return 1;
}

SaveHeadQuarter(i)
{
	new sql[1024];
	format(sql, sizeof(sql), "UPDATE headquarters SET Nombre='%s',Faccion=%d,EPos_X=%f,EPos_Y=%f,EPos_Z=%f,SPos_X=%f,SPos_Y=%f,SPos_Z=%f,Interior=%d,Locked=%d,CajaFuerte=%d WHERE id=%d LIMIT 1",
    HeadQuarterInfo[i][hqName],
	HeadQuarterInfo[i][hqFaccion],
	HeadQuarterInfo[i][hqEPos_x],
	HeadQuarterInfo[i][hqEPos_y],
	HeadQuarterInfo[i][hqEPos_z],
	HeadQuarterInfo[i][hqSPos_x],
	HeadQuarterInfo[i][hqSPos_y],
	HeadQuarterInfo[i][hqSPos_z],
	HeadQuarterInfo[i][hqInterior],
	HeadQuarterInfo[i][hqLocked],
	HeadQuarterInfo[i][hqCajaFuerte],
	i);
	mysql_query(sql);
	return 1;
}
stock UpdateAttach(playerid)
{
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	for(new i = 11; i < 13; i++)
	{
	    new id = BolsilloID[playerid][i];
	    if(i == 11)
	    {
	        if(id == 1 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 331, 6);
	        if(id == 2 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 333, 6);
	        if(id == 3 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 334, 6);
	        if(id == 4 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 335, 6);
	        if(id == 5 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 336, 6);
	        if(id == 6 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 337, 6);
	        if(id == 7 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 338, 6);
	        if(id == 8 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 339, 6);
	        if(id == 9 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 341, 6);
	        if(id == 10 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 321, 6);
	        if(id == 11 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 322, 6);
	        if(id == 12 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 323, 6);
	        if(id == 13 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 324, 6);
	        if(id == 14 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 325, 6);
	        if(id == 15 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 326, 6);
	        if(id == 16 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 342, 6);
	        if(id == 17 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 343, 6);
	        if(id == 18 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 344, 6);
	        if(id == 22 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 346, 6);
	        if(id == 23 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 347, 6);
	        if(id == 24 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 348, 6);
	        if(id == 25 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 349, 6);
	        if(id == 26 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 350, 6);
	        if(id == 27 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 351, 6);
	        if(id == 28 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 352, 6);
	        if(id == 29 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 353, 6);
	        if(id == 30 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 355, 6);
	        if(id == 31 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 356, 6);
	        if(id == 32 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 372, 6);
	        if(id == 33 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 357, 6);
	        if(id == 34 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 358, 6);
	        if(id == 35 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 359, 6);
	        if(id == 36 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 360, 6);
	        if(id == 37 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 361, 6);
	        if(id == 38 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 362, 6);
	        if(id == 39 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 363, 6);
	        if(id == 40 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 364, 6);
	        if(id == 41 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 365, 6);
	        if(id == 42 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 366, 6);
	        if(id == 43 && BolsilloCantidad[playerid][i] == 0) SetPlayerAttachedObject(playerid, 0, 367, 6);
	        if(id >= 44 && id <= 56) SetPlayerAttachedObject(playerid,0,2039,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
	        if(id == 57) SetPlayerAttachedObject(playerid,0,1242,6,0.215000,0.000000,0.056999,-10.599992,-103.600021,-7.000000,1.000000,1.000000,1.000000);
	        if(id == 58) SetPlayerAttachedObject(playerid,0,2702,6,0.160999,0.038999,0.048000,-2.700039,-17.899940,-86.799949,1.000000,1.000000,1.000000);
	        if(id == 69) SetPlayerAttachedObject(playerid,0,327,6);
	        if(id == 71) SetPlayerAttachedObject(playerid,0,2039,6,0.065000,0.029999,0.016999,10.800001,-103.099998,0.000000,0.649999,0.910999,0.476999);
	        if(id >= 80 && id <= 87 || id == 77) SetPlayerAttachedObject(playerid,0,1546,6,0.094999,0.043000,0.000000,0.000000,0.000000,180.000000,1.000000,1.000000,1.000000);
			if(id == 78 || id == 82) SetPlayerAttachedObject(playerid,0,1544,6,0.103000,0.057999,0.046000,0.000000,0.000000,180.000000,1.000000,1.000000,1.000000);
			if(id == 88) SetPlayerAttachedObject(playerid,0,2102,6,0.350999,-0.023000,0.048000,0.000000,-97.699989,0.000000,1.000000,1.000000,1.000000);
			if(id == 89) SetPlayerAttachedObject(playerid,0,2226,6,0.384000,-0.004999,0.037999,0.000000,-98.100006,0.000000,1.000000,1.000000,1.000000);
		}
	    if(i == 12)
	    {
	        if(id == 1) SetPlayerAttachedObject(playerid,1,331,5,0.024999,0.000000,-0.005999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id == 2) SetPlayerAttachedObject(playerid,1,333,5,-0.040000,0.067000,-0.003000,-29.899999,152.000000,176.000030,1.000000,1.000000,1.000000);
	        if(id == 3) SetPlayerAttachedObject(playerid,1,334,5,0.000000,0.059999,-0.022000,161.599990,10.700001,5.800002,1.000000,1.000000,1.000000);
	        if(id == 4) SetPlayerAttachedObject(playerid,1,335,5,0.180999,0.000000,0.017999,0.000000,177.800018,-8.799996,1.000000,1.000000,1.000000);
	        if(id == 5) SetPlayerAttachedObject(playerid,1,336,5,0.135999,0.030999,0.053999,-17.900001,153.800018,0.000000,1.000000,1.000000,1.000000);
	        if(id == 6) SetPlayerAttachedObject(playerid,1,337,5,0.041999,0.051999,-0.080000,-27.899986,155.800018,-167.499938,1.000000,1.000000,1.000000);
	        if(id == 7) SetPlayerAttachedObject(playerid,1,338,5,0.156999,0.092000,0.071999,-25.099998,172.899963,-19.899995,1.000000,1.000000,1.000000);
	        if(id == 8) SetPlayerAttachedObject(playerid,1,339,5,0.058000,0.008000,-0.109000,-27.999998,155.100036,172.699966,1.000000,1.000000,1.000000);
	        if(id == 9) SetPlayerAttachedObject(playerid,1,341,5,0.000000,0.078999,-0.009000,155.599990,7.200000,4.800000,1.000000,1.000000,1.000000);
	        if(id == 10) SetPlayerAttachedObject(playerid,1,321,5,0.015000,0.041000,-0.068000,-25.599971,162.900054,-175.300018,1.000000,1.000000,1.000000);
	        if(id == 11) SetPlayerAttachedObject(playerid,1,322,5,0.023999,0.052999,-0.041999,157.899978,2.499999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 12) SetPlayerAttachedObject(playerid,1,323,5,-0.002000,0.074000,0.001000,151.200042,23.000000,-9.100001,1.000000,1.000000,1.000000);
	        if(id == 13) SetPlayerAttachedObject(playerid,1,324,5,0.017999,0.003999,-0.047999,168.200012,18.300003,-27.900005,1.000000,1.000000,1.000000);
	        if(id == 14) SetPlayerAttachedObject(playerid,1,325,5,0.176000,0.000000,-0.011000,-23.399999,160.599990,-6.399995,1.000000,1.000000,1.000000);
	        if(id == 15) SetPlayerAttachedObject(playerid,1,326,5,0.008999,-0.018999,-0.047999,-33.199996,159.900085,156.399902,1.000000,1.000000,1.000000);
	        if(id == 16) SetPlayerAttachedObject(playerid,1,342,5,0.019000,0.047000,-0.021000,164.499984,0.000000,-17.599994,1.000000,1.000000,1.000000);
	        if(id == 17) SetPlayerAttachedObject(playerid,1,343,5,0.034000,0.063000,-0.037999,164.500000,14.599996,-4.700009,1.000000,1.000000,1.000000);
	        if(id == 18) SetPlayerAttachedObject(playerid,1,344,5,0.022999,0.039000,-0.125999,165.700012,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id == 22) SetPlayerAttachedObject(playerid,1,346,5,0.033000,0.057999,-0.017999,146.299987,14.999998,-4.700002,1.000000,1.000000,1.000000);
	        if(id == 23) SetPlayerAttachedObject(playerid,1,347,5,0.050999,0.038000,-0.021999,144.500015,9.100000,-11.600002,1.000000,1.000000,1.000000);
	        if(id == 24) SetPlayerAttachedObject(playerid,1,348,5,0.041000,0.038000,-0.026999,173.899963,0.000000,1.799999,1.000000,1.000000,1.000000);
	        if(id == 25) SetPlayerAttachedObject(playerid,1,349,5,0.000000,0.089000,0.000000,153.500015,10.000001,4.800000,1.000000,1.000000,1.000000);
	        if(id == 26) SetPlayerAttachedObject(playerid,1,350,5,0.040000,0.026000,0.011000,-156.300003,0.000000,2.600000,1.000000,1.000000,1.000000);
	        if(id == 27) SetPlayerAttachedObject(playerid,1,351,5,0.023000,0.048999,-0.013000,172.200012,14.400005,0.599999,1.000000,1.000000,1.000000);
	        if(id == 28) SetPlayerAttachedObject(playerid,1,352,5,0.024999,0.048000,-0.012000,172.000076,-3.099988,-2.099991,1.000000,1.000000,1.000000);
	        if(id == 29) SetPlayerAttachedObject(playerid,1,353,5,0.005000,0.065000,-0.016000,162.399963,9.599999,8.400000,1.000000,1.000000,1.000000);
	        if(id == 30) SetPlayerAttachedObject(playerid,1,355,5,0.057999,0.076999,-0.023999,162.799942,14.399999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 31) SetPlayerAttachedObject(playerid,1,356,5,0.043999,0.028999,-0.038000,167.499969,15.999998,0.000000,1.000000,1.000000,1.000000);
	        if(id == 32) SetPlayerAttachedObject(playerid,1,372,5,0.048000,0.049999,0.011000,-172.600006,-2.299995,5.999999,1.000000,1.000000,1.000000);
	        if(id == 33) SetPlayerAttachedObject(playerid,1,357,5,-0.043000,0.065999,-0.044999,167.499954,17.399999,0.000000,1.000000,1.000000,1.000000);
	        if(id == 34) SetPlayerAttachedObject(playerid,1,358,5,-0.018000,0.085000,0.033000,167.399978,12.200000,-0.299997,1.000000,1.000000,1.000000);
	        if(id == 35) SetPlayerAttachedObject(playerid,1,359,5,-0.002000,0.031000,-0.064000,146.000061,17.700002,-6.700002,1.000000,1.000000,1.000000);
	        if(id == 36) SetPlayerAttachedObject(playerid,1,360,5,0.002000,0.032000,-0.071000,154.699981,16.600000,-9.000000,1.000000,1.000000,1.000000);
	        if(id == 37) SetPlayerAttachedObject(playerid,1,361,5,0.048000,0.038999,-0.091000,160.500045,27.300014,-3.600001,1.000000,1.000000,1.000000);
	        if(id == 38) SetPlayerAttachedObject(playerid,1,362,5,0.031000,0.030000,-0.105000,148.300064,28.699989,-0.700000,1.000000,1.000000,1.000000);
	        if(id == 39) SetPlayerAttachedObject(playerid,1,363,5,-0.022000,0.087999,0.006999,154.899978,20.799997,-0.300001,1.000000,1.000000,1.000000);
	        if(id == 40) SetPlayerAttachedObject(playerid,1,364,5,0.047000,0.057000,-0.038000,133.699981,17.199989,2.099999,1.000000,1.000000,1.000000);
	        if(id == 41) SetPlayerAttachedObject(playerid,1,365,5,0.036999,0.026999,-0.079999,152.899993,14.900004,-0.400000,1.000000,1.000000,1.000000);
	        if(id == 42) SetPlayerAttachedObject(playerid,1,366,5,0.004000,0.061999,-0.063999,126.599990,33.099998,2.200000,1.000000,1.000000,1.000000);
	        if(id == 43) SetPlayerAttachedObject(playerid,1,367,5,0.018000,0.062999,0.074999,-109.400039,0.000000,0.000000,1.000000,1.000000,1.000000);
	        if(id >= 44 && id <= 56) SetPlayerAttachedObject(playerid,1,2039,5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999);
			if(id == 57) SetPlayerAttachedObject(playerid,1,1242,5,0.255000,0.000000,0.000000,-1.300001,-101.699958,16.500001,1.000000,1.000000,1.000000);
			if(id == 58) SetPlayerAttachedObject(playerid,1,2702,5,0.193999,0.054000,0.000000,-29.899995,4.000002,-96.200019,1.000000,1.000000,1.000000);
            if(id == 69) SetPlayerAttachedObject(playerid,1,327,5);
            if(id == 71) SetPlayerAttachedObject(playerid,1,2039,5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999);
            if(id >= 80 && id <= 87 || id == 77) SetPlayerAttachedObject(playerid,1,1546,5,0.123000,0.025000,-0.009999,158.499969,-1.000000,-177.599990,1.000000,1.000000,0.991999);
            if(id == 78 || id == 82) SetPlayerAttachedObject(playerid,1,1509,5,0.108999,0.026000,-0.019000,158.399978,0.000000,180.000000,1.000000,1.000000,1.000000);
            if(id == 88) SetPlayerAttachedObject(playerid,1,2102,5,0.350999,-0.023000,0.048000,0.000000,-97.699989,0.000000,1.000000,1.000000,1.000000);
			if(id == 89) SetPlayerAttachedObject(playerid,1,2226,5,0.412999,-0.001999,0.000000,-30.699991,-96.799980,0.000000,1.000000,1.000000,1.000000);
		}
	}
	return 1;
}
stock MandarMensajeAdmins(COLOR, MSG[])
{
    for(new i = 0;i < MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] > 0)
        {
            SendClientMessage(i, COLOR, MSG);
        }
    }
    return 1;
}
stock ChequearDinero(playerid, dinero){
    if(EstaConectado(playerid)){
	    new dinerofaltante;
		dinerofaltante = dinero - (SafeGetPlayerMoney(playerid));
	    if(SafeGetPlayerMoney(playerid) >= dinero){
			return 1;
		}
		else{
		    format(string,sizeof(string),"[ERROR] Usted no tiene dinero suficiente. Le faltan %d$", dinerofaltante);
			Mensaje(playerid, COLOR_ERRORES, string);
			return 0;
		}
	}
	return 0;
}
stock Compra(playerid, precio){
	if(EstaConectado(playerid)){
		format(string,sizeof(string),"~r~ -%d$", precio);
	 	GameTextForPlayer(playerid, string, 5000, 1);
		SafeGivePlayerMoney(playerid, -precio);
		PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
	}
	return 1;
}
forward EstaConectado(playerid); public EstaConectado(playerid){
	if(IsPlayerConnected(playerid)) { return 1; }
    return 0;
}
forward EstaAfueraTaller(playerid); public EstaAfueraTaller(playerid){
    if(EstaConectado(playerid)){
		if(PlayerToPoint(10.0,playerid,720.4227,-465.2718,16.3359)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,2073.6716,-1831.2239,13.5469)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,1025.0483,-1031.6508,31.9656)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,488.8826,-1732.4053,11.2144)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,-1904.5531,276.1320,41.0469)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,1840.4047,-1856.3762,13.3828)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,1840.4047,-1856.3762,13.3828)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,-2713.8391,216.8167,4.2731)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,2644.9124,-2037.6128,13.5540)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,2386.7439,1040.9083,10.8203)) { return 1; }
		else if(PlayerToPoint(10.0,playerid,1041.3345,-1028.0857,32.1016)) { return 1; }
	}
	return 0;
}
GetVehiclePassengers(vehicleid, passengers[5]){
    for(new i = 0; i < 5; i ++)
        passengers[i] = -1;
    for(new i = 0; i < MAX_PLAYERS; i ++)
        if(GetPlayerVehicleID(i) == vehicleid)
            passengers[GetPlayerVehicleSeat(i)] = i;
}
