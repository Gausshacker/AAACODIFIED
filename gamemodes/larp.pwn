/*


American Roleplay 2013 - ¡Equipo de American Roleplay!

Todos los derechos reservados a las últimas mejoras.
Créditos a la base de OSRP y LARP.
Créditos al equipo de programación de LARP.
Créditos a Dan_Kolarov y Cavar en programación posterior para American Roleplay.

Sistemas por módulos includes. Nuevos sistemas intercalados entre .pwn e includes.



*/
#define REVISION (4) //
//-------------------------------------------------------------->>
//--[FUNCIONES-VARIABLES-DEFINES]--
#include <a_samp> // Funciones basicas del SAMP

//
#undef MAX_PLAYERS
#define MAX_PLAYERS 50
#include <a_sampdb>
#include <a_mysql>
#include <streamer> // Streamer de objetos, pickups, 3dtext...
#include <globalvars> // Todas las variables existentes
#include <funciones> // Funciones globales
#include <colores> // Defines de colores
#include <fader> // Efectos de pantalla
//--[SISTEMAS VARIOS]--
#include <CameraMover>
#include <ayuda> // Comandos de ayuda
#include <texto> // Sistema de Chat
#include <coches> // Sistema de Coches
#include <Autoescuela> // La Autoescuela
#include <AdminSystem> // Sistema de Administracion
/*#include <radios> // Sistema de audio*/
#include <objetos> // Objetos
#include <deathac> // Anticheat
#include <horas> // Horas en punto
//#include <velocimetro> // Velocimetro para vehiculos
#include <drogas> // Sistema de Plantaciones y Consumo
//#include <guns> // Poner armas en la espalda y otros
#include <atms> // Red de ATMS por LS
#include <ascensor> // Ascensor de Glen Park
//#include <cnpc> // Plugin de los NPCs.
#include <documentacion> // Documentacion y Seguro medico
#include <telefoniaagenda> // Telefonos y eso
#include <comidas> // Menus de comidas, etc
#include <puertas> // Puertas y Peajes
#include <anims> // Animaciones
#include <afk> // Anti AFK
#include <muebles> // Muebles
#include <speedcap> // Limitador de velocidad
/*#include <gangzones> // GangZones para bandas*/
//--[EVENTOS]--
#include <paintball> // Paintball
/*#include <cartas> // Cartas*/
#include <loteria> // Loteria
#include <carreras> //Carreras
#include <lowrider> //Low
//--[PROPIEDADES]--
#include <negocios> // Sistema de Negocios
#include <casas> // Sistema de Casas
#include <parking> // Sistema de Parking
//--[TRABAJOS]--
#include <trabajos> // Comando /trabajo y /dejartrabajo
#include <tunning> // Trabajo - Mecanicos
#include <cosecha> // Trabajo - Cosechadora
#include <spesca>  // Trabajo - Pescadores
#include <limpiacalles> // Trabajo - Limpia Calles
#include <basurero> // Trabajo - Basurero
#include <pizza> // Trabajo - Pizzero
#include <detective> // Trabajo - Detective
#include <repartidor> // Trabajo - Repartidor
#include <ambulante> // Trabajo - Vendedor Ambulante
#include <ladron> // Trabajo - Ladron
#include <reporteros> // Reporteros
//--[FACCIONES]--
#include <facciones> // Sistema interno de facciones (comandos)
#include <uniformes> // Sistema de uniformes para facciones
#include <policias> // Faccion - Policias
#include <sliding> // Policia - Sistema de cuerdas para helicoptero
#include <accesorios> // Policia - Sistema de objetos (conos, pinchos...)
//#include <luces> // Sirenas de la policia.
#include <medicos> // Faccion - Medicos
#include <bomberos> //Faccion - Bomberos 9
#include <gps> // Sistema }car, para medicos y policias
#include <taxis> // Taxistas
#include <misiones> // Misiones
//--[OBJETOS-ATTACH]--
/*#include <puntero> //laser de armas*/
#include <nieve>
#include <gafas> // gafas de sol.
#include <cascos> // casco de moto
//#include <sirenas> // Sirenas
#include <bandana> // Bandanas
#include <cuff>
//#include <cinturon>
#include <mgates>
#include <sscanf2>
#include <traficantelicencias>
//#include <antecedentes>
#include <gbug>
#include <foreach> // para la boombox.
#include <a_npc>
#include <publicidad>



new AvisoEmergencias[MAX_PLAYERS];
new Derecha[MAX_PLAYERS];
new Izquierda[MAX_PLAYERS];
new Cacheado[MAX_PLAYERS];
new Esposado[MAX_PLAYERS];
new Paralizado[MAX_PLAYERS];
new EnTaller[MAX_PLAYERS];
new Menu:MenuTaller;
new Float:TallerX[MAX_VEHICLES];
new Float:TallerY[MAX_VEHICLES];
new Float:TallerZ[MAX_VEHICLES];
new Float:TallerAngulo[MAX_VEHICLES];
new EditandoColor[MAX_PLAYERS];
new Modificando[MAX_PLAYERS];
new FortCarson;
new LA1;
new LA2;
new LA3;
new LA4;
new RecibirObjeto[MAX_PLAYERS][3];
new EsperandoDer[MAX_PLAYERS];
new EsperandoIzq[MAX_PLAYERS];
new Pasador[MAX_PLAYERS];

new Song[128];
forward BoomBox(playerid);
//

// LUCES
new vLuz[MAX_VEHICLES];
new vLuz2[MAX_VEHICLES];
new vpLuz[MAX_VEHICLES];
new Luz[MAX_VEHICLES];
new Luz2[MAX_VEHICLES];
new Luz_1[MAX_VEHICLES];
new Luz_2[MAX_VEHICLES];
new UsarLuces[MAX_PLAYERS];
new PuedeUsarLuces[MAX_VEHICLES];
new LucesEncendidas[MAX_VEHICLES];
//

// CINTURÓN
new Cinturon[MAX_PLAYERS];
//new tmp[128];

forward VehicleDamageToPlayerHealth(playerid, vehicleid);
forward VehicleDamageToPlayerHealth2(playerid, vehicleid);
forward DisablePlayerKnockout(playerid);
forward IsACopSkin(playerid);


//

//#include <RouteConnector>

//-------------------------------------------------------------->>
#pragma tabsize 0


//Procesador DCMD - DracoBlue

#define dcmd(%1,%2,%3) \
if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && \
(dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) \
return 1



#define ARMA_FIJA 22

#define EQUIPAMIENTOLAPD             668
#define EQUIPAMIENTOLAED             669
#define EQUIPAMIENTOLASC             670

new TieneTaser[MAX_PLAYERS];
new Taseado[MAX_PLAYERS];
new Anim[MAX_PLAYERS];
new Cables[MAX_PLAYERS];
new Taseador[MAX_PLAYERS];



new VecesCuchillo[MAX_PLAYERS];
new VecesBate[MAX_PLAYERS];
new VecesPalo[MAX_PLAYERS];
new VecesCombo[MAX_PLAYERS];
//

//Var's globales de por ahí
//new TazerVar[MAX_PLAYERS] = 0;

//



//Barrera de LSPD
new BARRIER_LSPD;
//




//Sistema de Bomberos
#define MAX_BOMBOBJS 200

enum bpInfo
{
	bpType,
	bpCreated,
    Float:bpX,
    Float:bpY,
    Float:bpZ,
    bpObject,
	bpDepartament,
};
new FuegosInfo[MAX_BOMBOBJS][bpInfo];


forward SalidaBombero(playerid,vehiculo,garaje);
forward EntradaBombero(playerid,vehiculo,garaje);
forward ColocarFuego(playerid,tipo);


//Fin Sistema de fuego bomberos


forward TazedRemove(playerid);
forward QuitarEfecto(playerid);
forward Congelar(playerid);


//Sistema de anuncios
/*forward IngresarAnuncio(playerid,textox[],tiempo);
forward MostrarAnuncios(playerid);
forward ResetAnuncios();
forward BorrarAnuncio(i);*/

//
new barrerafd;
new estadobarrera = 0;
//Textdraws del servidor

new Text:Txt[MAX_PLAYERS][10];
new ViendoInfo[MAX_PLAYERS];
//



#define Kick(%0) SetTimerEx("Kicka", 100, false, "i", %0)

forward Kicka(p); public Kicka(p) {
    #undef Kick
    Kick(p);
    #define Kick(%0) SetTimerEx("Kicka", 100, false, "i", %0)
    return 1;
}



//forward CMDLog(stringa2[]);









//Prisión Federal

new celdas = 0; //Celdas 0 cerradas , 1 abierta


//Peajes
forward TiempoPeaje1();
forward TiempoPeaje2();
forward TiempoPeaje3();
forward TiempoPeaje4();
forward TiempoPeajeLV1();
forward TiempoPeajeLV2();
new peaje1;
new peaje2;
new peaje3;
new peaje4;
new peajelv1,peajelv2;

//Barrio Privado
forward TiempoPeaje5();
forward TiempoPeaje6();
forward TiempoPeaje7();
forward TiempoPeaje8();
forward TiempoPeaje9();
forward TiempoPeaje10();
forward TiempoPeaje11();
forward TiempoPeaje12();
forward TiempoPeaje13();
forward TiempoPeaje14();



//Barrio Privado
new peaje5,peaje6,peaje7,peaje8,peaje9,peaje10,peaje11,peaje12,peaje13,peaje14;

//
new bloqueopeajes = 0; //Abierto

new UsandoGPS[MAX_PLAYERS];
/*enum RouteInformation
{
    Destination,
    CreatedObjects[1024],
    bool:calculating,
    Lenght,
    GPS_Polygon,
    bool:IsInGPS_Polygon
};

new PlayerRoute[MAX_PLAYERS][RouteInformation];

#pragma dynamic 16777215*/


#define DIALOGO_GPS 23423
#define DIALOGO_BOXEO 23424

#define DIALOGO_ARMAS 23425

#define MALETERO 					(23426)
new consultandomal[MAX_PLAYERS];

/*new Text:Velocimetro_1[MAX_PLAYERS], Text:Velocimetro_2[MAX_PLAYERS], TimerVelocimetro[MAX_PLAYERS];


forward Velocimetro(playerid);*/


//Ban Temporal
new
	DB: dbBans;


forward tempBanPlayer(playerid, iTime, szBannedBy[], szReason[], szIP[]);

forward CargarNPCS();
public CargarNPCS()
{
    ConnectNPC("Roberto_Rodriguez","Policia_Pie2");
    ConnectNPC("Walter_Diaz","GuardiaBarrio_1Fix");
    ConnectNPC("John_Smith","GuardiaBarrio_2Fix");
    ConnectNPC("Lorenc_Vitti","BotPeaje1");
    ConnectNPC("Mark_Lightman","BotPeaje2");
    ConnectNPC("Luciano_Conti","BotCaddyPeaje1");
    ConnectNPC("Roberto_Rojas","PeajeNPC1");
    }
//
main()
{
	print("\n----------------------------------");
	printf(" 	American RolePlay AMRP v1.1.%d		   ",REVISION);
}

public OnGameModeInit()
{

    // Bots de la ciudad:

	//ActivarBot();
	FortCarson = LoadCameraMover("FortCarson");
    LA1 = LoadCameraMover("LA1");
    LA2 = LoadCameraMover("LA2");
    LA3 = LoadCameraMover("LA3");
    LA4 = LoadCameraMover("LA4");
	//vNPC_1 = CreateVehicle(431, 0.0, 0.0, 5.0, 0.0, 1, 1, 5000);
	//vNPC_2 = CreateVehicle(431, 0.0, 0.0, 5.0, 0.0, 1, 1, 5000);
	Streamer_TickRate(75);
	//SetTimer("PlayScannerSound", 130000, 1); // Scanner.
	MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	dbBans = db_open("bans.db");
	mysql_debug(1);
	Vehicles_OnGameModeInit();
	//UsePlayerPedAnims();
	Negocios_OnGameModeInit();
	//Armas_OnGameModeInit();
	LoadAgenda();
	Admin_OnGameModeInit();
	Sis_Cos_OnGameModeInit();
	Sis_Pes_OnGameModeInit();
	CargarParkings();
	Casas_OnGameModeInit();
	Medicos_OnGameModeInit();
	Bomberos_OnGameModeInit();
	Policia_OnGameModeInit();
	Objetos_Init();
	Taxis_OnGameModeInit();
	AC_OnInit();
	DetectarHora();
	Autoesc_OnGameModeInit();
//	Velocimetro_OnGameModeInit();
	LoadPlantas();
	ATMS_OnInit();
	Trabajos_OnInit();
	Detective_OnGameModeInit();
	Docu_OnInit();
	Cmds_OnInit();
	LoadFrecuencias();
	CrearMenus();
	LoadComidas();
	LoadSonidos();
	Paintball_OnGameModeInit();
	Puertas_OnGameModeInit();
    Ladron_OnGameModeInit();
	Anims_OnInit();
	MisBand_OnGameModeInit();
	/*puntero_OnGameModeInit();*/
	Loteria_OnInit();
	Carreras_OnGameModeInit();
	Low_OnGMInit();
    ResetElevatorQueue();
	Elevator_Initialize();
	LoadMuebles();
	/*LoadGangZones();*/
    Cuentas_OnGamemodeInit();
	LoadHeadQuarter();
//	LoadAntecedentes();
    Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,720.4227,-465.2718,16.3359,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,2073.6716,-1831.2239,13.5469,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,1025.0483,-1031.6508,31.9656,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,488.8826,-1732.4053,11.2144,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,-1904.5531,276.1320,41.0469,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,1840.4047,-1856.3762,13.3828,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,-1936.2755,236.7950,34.3125,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,-2713.8391,216.8167,4.2731,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,2644.9124,-2037.6128,13.5540,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,2386.7439,1040.9083,10.8203,40,0,1);
	Create3DTextLabel("{E5FF00} Taller\n [USO] Usa '/taller'", AMARILLO,1041.3345,-1028.0857,32.1016,40,0,1);
	printf("Objetos: %d (Streamed)", CountDynamicObjects());
	printf("Text3ds: %d (Streamed)", CountDynamic3DTextLabels());
	printf("Pickups: %d (Streamed)", CountDynamicPickups());
	//LABELS

	
    /*ConnectNPC("James_Fernandez","Poli_1");
    ConnectNPC("John_Moore","Bus_Juan");
    ConnectNPC("Robert_Johnson","Bus_Juan2");
    ConnectNPC("Diego_Willard","Bus_Juan4");
    ConnectNPC("Laurence_Fernandez","Bus_Juan3");
    ConnectNPC("Kirk_Rodriguez","Policia_Pie1");
    SetTimer("CargarNPCS", 5000, 0); // */
    
    
    
    
    
    

    
	Audio_SetPack("larp_pack", true);
	
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(1);
	SetNameTagDrawDistance(15.0);
	new GMTEXT[30];
	#if REVISION > 99
	format(GMTEXT,sizeof(GMTEXT),"AM:RP - v1.%d",REVISION);
	#else
	format(GMTEXT,sizeof(GMTEXT),"AM:RP - v1.%d",REVISION);
	#endif
	SetGameModeText(GMTEXT);
	
	SetTimer("TimerDeUnMinuto",60000,1);
	SetTimer("CheatsDetection", 1500, 1);
	SetTimer("ResetEnActividad",5000,1);
	SetTimer("TimerDeUnaHora",50000*60,1);
	SetTimer("TimerGasolina", 120000,1);
	SetTimer("ComprobarAccidentes", 500, 1);
	Elevador = CreateMenu("Elevador", 1, 200.0, 100.0, 150.0,0);

	AddMenuItem(Elevador, 0, "Exterior");
	AddMenuItem(Elevador, 0, "Aparcamiento");
	AddMenuItem(Elevador, 0, "Planta Baja");
	for(new i = 1; i < 9; i++)
	{
		format(string, 128, "Planta %d", i);
		AddMenuItem(Elevador, 0, string);
	}
	AddMenuItem(Elevador, 0, "Cancelar");
	
		MenuTaller = CreateMenu("Taller.", 2, 350.0, 275.0, 1500.0, 100.0);
	AddMenuItem(MenuTaller, 0, "Reparacion de motor");
	AddMenuItem(MenuTaller, 0, "Reparacion de carroceria");
	AddMenuItem(MenuTaller, 0, "Pintura de carroceria");
	AddMenuItem(MenuTaller, 0, "Salir del taller");
	AddMenuItem(MenuTaller, 1, "$400");
	AddMenuItem(MenuTaller, 1, "$450");
	AddMenuItem(MenuTaller, 1, "$300");
	// Pickup's Barrio Privado:
	CreateDynamicPickup(1239, 1, 1385.4167,-904.2206,36.0386, -1, -1, -1, 50.0);
	CreateDynamicPickup(1239, 1, 1369.2947,-907.9342,35.1574, -1, -1, -1, 50.0);
	CreateDynamicPickup(1239, 1, 98.7567,-1516.1543,6.6585, -1, -1, -1, 50.0);
	CreateDynamicPickup(1239, 1, 92.1396,-1517.3466,5.7683, -1, -1, -1, 50.0);
	
	CreateDynamic3DTextLabel("Info: {FFFFFF}/barriolujoso{FFFF00}.", Amarillo, 1385.4167,-904.2206,36.0386, 50.0);
	CreateDynamic3DTextLabel("Info: {FFFFFF}/barriolujoso{FFFF00}.", Amarillo, 1369.2947,-907.9342,35.1574, 50.0);
	CreateDynamic3DTextLabel("Info: {FFFFFF}/barriolujoso{FFFF00}.", Amarillo, 98.7567,-1516.1543,6.6585, 50.0);
	CreateDynamic3DTextLabel("Info: {FFFFFF}/barriolujoso{FFFF00}.", Amarillo, 92.1396,-1517.3466,5.7683, 50.0);
	CreateDynamic3DTextLabel("Armas: {FFFFFF}/obtenerarmas{FFFF00}.", Amarillo, 1308.6034,-55.7202,1002.4958, 50.0);
	CreateDynamic3DTextLabel("LASC: {FFFFFF}/equipamiento{FFFF00}.", Amarillo, 363.7235,197.1782,1019.9844, 25.0);
	CreateDynamic3DTextLabel("LAPD: {FFFFFF}/equipamiento{FFFF00}.", Amarillo, 216.1525,184.7244,1003.0313, 25.0);
	CreateDynamic3DTextLabel("LAED: {FFFFFF}/equipamiento{FFFF00}.", Amarillo, 463.8518,245.9035,1025.8660, 25.0);
	CreateDynamic3DTextLabel("LAED: {FFFFFF}/equipamiento{FFFF00}.", Amarillo, 1155.8368,-1340.1055,1349.3860, 25.0);
	
	//
	
	
	for(new i; i < MAX_INTERIOR_ENTERS; i++)
	{
		CreateDynamicPickup(InteriorInfo[i][PickupID], 23, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ]);
		CreateDynamic3DTextLabel(InteriorInfo[i][texto], Amarillo, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ] + 0.5, 30);
	}
	for(new h = 0; h < sizeof(HeadQuarterInfo); h++)
	{
		HeadQuarterInfo[h][hqPickup] = CreatePickup(1273, 23, HeadQuarterInfo[h][hqEPos_x], HeadQuarterInfo[h][hqEPos_y], HeadQuarterInfo[h][hqEPos_z]);
	}
	/*for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        Velocimetro_1[playerid] = TextDrawCreate(505.000000, 302.000000, "");
        TextDrawBackgroundColor(Velocimetro_1[playerid], 255);
        TextDrawFont(Velocimetro_1[playerid], 1);
        TextDrawLetterSize(Velocimetro_1[playerid], 0.240000, 1.100000);
        TextDrawColor(Velocimetro_1[playerid], -1);
        TextDrawSetOutline(Velocimetro_1[playerid], 1);
        TextDrawSetProportional(Velocimetro_1[playerid], 1);

        Velocimetro_2[playerid] = TextDrawCreate(505.000000, 313.000000, "");
        TextDrawBackgroundColor(Velocimetro_2[playerid], 255);
        TextDrawFont(Velocimetro_2[playerid], 1);
        TextDrawLetterSize(Velocimetro_2[playerid], 0.240000, 1.100000);
        TextDrawColor(Velocimetro_2[playerid], -1);
        TextDrawSetOutline(Velocimetro_2[playerid], 1);
        TextDrawSetProportional(Velocimetro_2[playerid], 1);
        }*/
	for(new i; i < MAX_ATMS; i++)
	{
	CreateDynamic3DTextLabel("Cajero Automático: Pulsa ENTER", Azul, ATMInfo[i][0], ATMInfo[i][1], ATMInfo[i][2]+1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 100.0);
	}
	peaje1 = CreateDynamicObject(968, 68.10, -1536.35, 4.85,   0.00, -90.00, 88.72);//Cerrada
	peaje2 = CreateDynamicObject(968, 35.05, -1526.01, 4.95,   0.00, 90.00, 86.88);//Cerrada
	peaje3 = CreateDynamicObject(968, 607.31, -1202.22, 17.90,   0.00, 90.00, 19.28);//Cerrada
	peaje4 = CreateDynamicObject(968, 623.30, -1186.60, 18.97,   0.00, 90.00, 28.70);//Abierta
	peajelv1 = CreateDynamicObject(968, 1636.15, -18.22, 36.35,   0.00, -90.27, 23.00);//Cerrada
	peajelv2 = CreateDynamicObject(968, 1643.57, -1.46, 36.33,   0.00, -89.68, 23.40);//CERRADA
	
	peaje5 = CreateDynamicObject(968, 1372.68, -909.76, 34.68,   9.00, -90.00, -10.62);
	peaje6 = CreateDynamicObject(968, 1381.93, -902.54, 36.03,   -8.52, -90.00, -192.02);//Cerrado
	peaje7 = CreateDynamicObject(3036, 933.05, -949.05, 40.98,   0.00, -0.45, 92.69);//Cerrado
	peaje8 = CreateDynamicObject(3036, 927.90, -949.76, 40.77,   0.00, 0.00, -85.82);//Cerrado
	peaje9 = CreateDynamicObject(968, 1527.52, -420.23, 33.47,   0.00, 90.00, -105.00);//Cerrado
	peaje10 = CreateDynamicObject(968, 1527.32, -435.37, 33.47,   0.00, -90.00, -105.00);//Cerrado
	peaje11 = CreateDynamicObject(968, 260.49, -1005.32, 53.56,   11.00, -90.00, 156.23);//Cerrado
	peaje12 = CreateDynamicObject(968, 259.73, -1008.74, 54.40,   11.00, 86.50, 152.00);
	peaje13 = CreateDynamicObject(968, 88.42, -1517.25, 5.18,   -13.00, -84.00, 167.50);
	peaje14 = CreateDynamicObject(968, 102.43, -1516.72, 6.73,   4.00, -94.00, -18.00);
	
	barrerafd = CreateDynamicObject(968, 1415.27, -1651.88, 13.29,   0.00, 90.00, 90.00);
	
 
	// MAPEADO TNT SANTA MARIA BEACH
	
	
	/*//============================================= Mapeo Santa Monica ==================================
	
	CreateDynamicObject(1215, 388.60001, -1762.80005, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 451.10001, -1752.59998, 5.2, 0, 0, 0);
	CreateDynamicObject(1215, 450.69922, -1757.2998, 5.3, 0, 0, 0);
	CreateDynamicObject(1215, 445.5, -1754.7998, 7.8, 0, 0, 0);
	CreateDynamicObject(1215, 442.2998, -1758.2998, 7.7, 0, 0, 0);
	CreateDynamicObject(1215, 417.09961, -1762.69922, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 414.2998, -1762.69922, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 411.19922, -1762.7998, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 408.39941, -1762.69922, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 397.5, -1762.7998, 7.4, 0, 0, 0);
	CreateDynamicObject(1215, 394.69922, -1762.69922, 7.4, 0, 0, 0);
	CreateDynamicObject(1215, 391.5, -1762.80005, 7.5, 0, 0, 0);
	CreateDynamicObject(1215, 388.10001, -1756.5, 7.8, 0, 0, 0);
	CreateDynamicObject(1215, 394.5, -1756.5, 7.8, 0, 0, 0);
	CreateDynamicObject(1215, 400.5, -1756.5, 7.8, 0, 0, 0);
	CreateDynamicObject(625, 420, -1757.19995, 8.1, 0, 0, 0);
	CreateDynamicObject(1215, 444.59961, -1763.59961, 5.3, 0, 0, 0);
	CreateDynamicObject(1215, 439.09961, -1764.59961, 5.3, 0, 0, 0);
	CreateDynamicObject(2132, 388.89999, -1753.30005, 7.4, 0, 0, 0);
	CreateDynamicObject(2132, 395.2998, -1753.39941, 7.2, 0, 0, 0);
	CreateDynamicObject(2190, 399.60001, -1756, 8.5, 0, 0, 180);
	CreateDynamicObject(2190, 393.70001, -1756, 8.5, 0, 0, 179.995);
	CreateDynamicObject(2232, 387.39999, -1756.19995, 8, 0, 0, 0);
	CreateDynamicObject(2232, 401.10001, -1756.09998, 7.9, 0, 0, 0);
	CreateDynamicObject(2417, 393.70001, -1753.40002, 7.2, 0, 0, 0);
	CreateDynamicObject(2421, 389.10001, -1753.09998, 8.5, 0, 0, 0);
	CreateDynamicObject(2421, 395.39941, -1752.89941, 8.2, 0, 0, 0);
	CreateDynamicObject(2294, 392.70001, -1753.59998, 7.1, 0, 0, 0);
	CreateDynamicObject(921, 393.70001, -1753.09998, 9.6, 0, 0, 0);
	CreateDynamicObject(921, 399.7998, -1753.09961, 9.7, 0, 0, 0);
	CreateDynamicObject(1370, 395, -1753.7998, 7.7, 0, 0, 0);
	CreateDynamicObject(1359, 385.39999, -1763.59998, 7.6, 0, 0, 0);
	CreateDynamicObject(1359, 405.39999, -1763.5, 7.6, 0, 0, 0);
	CreateDynamicObject(1359, 434.39999, -1763.80005, 7.6, 0, 0, 0);
	CreateDynamicObject(2859, 385.10001, -1763.19995, 6.9, 0, 0, 0);
	CreateDynamicObject(2294, 398.60001, -1753.59998, 7.2, 0, 0, 0);
	CreateDynamicObject(2417, 399.69922, -1753.39941, 7.2, 0, 0, 0);
	CreateDynamicObject(2144, 397.89999, -1753.30005, 7.1, 0, 0, 0);
	CreateDynamicObject(2144, 391.5, -1753.19995, 7.1, 0, 0, 0);
	CreateDynamicObject(2144, 390.89999, -1753.19995, 7.1, 0, 0, 0);
	CreateDynamicObject(2921, 388.5, -1756.40002, 12.7, 0, 0, 130);
	CreateDynamicObject(2921, 380.20001, -1762.69995, 11.8, 0, 20, 221.996);
	CreateDynamicObject(2921, 430.39999, -1756.30005, 11.9, 0, 13.995, 61.995);
	CreateDynamicObject(2921, 394.60001, -1752.80005, 9.7, 0, 353.991, 159.99);
	CreateDynamicObject(2921, 388.39999, -1753, 9.7, 0, 353.99, 159.988);
	CreateDynamicObject(2961, 394.89999, -1754.59998, 8.8, 0, 0, 96);
	CreateDynamicObject(2961, 388.5, -1756, 9, 0, 0, 91.994);
	CreateDynamicObject(1486, 401.89999, -1762.19995, 7.9, 0, 0, 0);
	CreateDynamicObject(1486, 402.10001, -1761.80005, 7.9, 0, 0, 0);
	CreateDynamicObject(1455, 401.79999, -1762, 7.8, 0, 0, 0);
	CreateDynamicObject(1455, 402.20001, -1762.30005, 7.8, 0, 0, 0);
	CreateDynamicObject(1665, 402, -1762.40002, 7.8, 0, 0, 0);
	CreateDynamicObject(1665, 422.79999, -1761.59998, 7.8, 0, 0, 0);
	CreateDynamicObject(1665, 422.5, -1762.19995, 7.8, 0, 0, 0);
	CreateDynamicObject(1543, 422.89999, -1762, 7.8, 0, 0, 0);
	CreateDynamicObject(1543, 422.39999, -1761.80005, 7.8, 0, 0, 0);
	CreateDynamicObject(1455, 429.20001, -1762.09998, 7.8, 0, 0, 0);
	CreateDynamicObject(1665, 429.20001, -1761.69995, 7.8, 0, 0, 0);
	CreateDynamicObject(2144, 392.09961, -1753.19922, 7.1, 0, 0, 0);
	CreateDynamicObject(2144, 397.29999, -1753.30005, 7.1, 0, 0, 0);
	CreateDynamicObject(1778, 394.70001, -1754.69995, 7.3, 0, 0, 93.997);
	CreateDynamicObject(1496, 388.5, -1755.30005, 7.3, 0, 0, 90);
	CreateDynamicObject(1496, 387.79999, -1755.30005, 7.3, 0, 0, 90);
	CreateDynamicObject(1496, 400.20001, -1755.40002, 7.2, 0, 0, 90);
	CreateDynamicObject(1496, 403.70001, -1756.09998, 7.2, 0, 0, 180);

	//FIN MAPEADO SANTA MARIA BEACH TNT*/




	CreateDynamicMapIcon(1185.0560,-1323.9019,13.5730, 22, 0, 0, 0); // Hospital
	CreateDynamicMapIcon(866.2154,-1251.7538,6.0037, 30, 0, 0, 0); // LSPD
	CreateDynamicMapIcon(1829.5077,-1842.7311,13.5781, 17, 0, 0, 0); // 24-7 UNITY
	CreateDynamicMapIcon(1352.1354,-1759.1620,13.5541, 17, 0, 0, 0); // 24-7 Ayunta
	CreateDynamicMapIcon(2098.5596,-1805.6979,13.5546, 29, 0, 0, 0); // Pizza
	CreateDynamicMapIcon(1368.7128,-1279.8639,13.5541, 18, 0, 0, 0); // Ammunation
	CreateDynamicMapIcon(2245.9502,-1660.6981,15.2864, 45, 0, 0, 0); // Binco
	CreateDynamicMapIcon(456.8236,-1501.6539,31.0389, 45, 0, 0, 0); // Binco
    CreateDynamicMapIcon(2229.5786,-1721.5316,13.5638, 54, 0, 0, 0); // GYM
    
    
    
    
	
	
	
	BARRIER_LSPD = CreateAutomaticGate(968, 1544.692993, -1630.822509, 13.08, 0.000000, 90.000000, 90.000000, 1544.692993, -1630.822509, 13.08+0.01, 0.000000, 10.000000, 90.000000, 1544.6627, -1627.4036, 13.1099, 20.0, 0.003);
	//BARRIER_LSFD = CreateAutomaticGate(968, 1415.27, -1651.88, 13.29,  0.00, 90.00, 90.00, 1415.24, -1651.82, 13.15, 0.00, 5.00, 90.00, 1415.27, -1651.88, 13.29, 20.0, 0.003);
	//AddRadioStation("Radio Futuro", "http://provisioning.streamtheworld.com/pls/FUTURO.pls", 1);
	//AddRadioStation("Radio Concierto", "http://provisioning.streamtheworld.com/pls/CONCIERTO.pls", 1);
	//AddRadioStation("Radio Rock and Pop", "http://provisioning.streamtheworld.com/pls/ROCK_AND_POP.pls ", 1);
	

    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    Txt[i][0] = TextDrawCreate(149.000000, 365.000000, "Propietario:");
		TextDrawBackgroundColor(Txt[i][0], 255);
		TextDrawFont(Txt[i][0], 1);
		TextDrawLetterSize(Txt[i][0], 0.330000, 1.000000);
		TextDrawColor(Txt[i][0], -1);
		TextDrawSetOutline(Txt[i][0], 0);
		TextDrawSetProportional(Txt[i][0], 1);
		TextDrawSetShadow(Txt[i][0], 1);
		TextDrawUseBox(Txt[i][0], 1);
		TextDrawBoxColor(Txt[i][0], 136);
		TextDrawTextSize(Txt[i][0], 300.000000, 0.000000);

		Txt[i][1] = TextDrawCreate(149.000000, 380.000000, "Tipo:");
		TextDrawBackgroundColor(Txt[i][1], 255);
		TextDrawFont(Txt[i][1], 1);
		TextDrawLetterSize(Txt[i][1], 0.330000, 1.000000);
		TextDrawColor(Txt[i][1], -1);
		TextDrawSetOutline(Txt[i][1], 0);
		TextDrawSetProportional(Txt[i][1], 1);
		TextDrawSetShadow(Txt[i][1], 1);
		TextDrawUseBox(Txt[i][1], 1);
		TextDrawBoxColor(Txt[i][1], 136);
		TextDrawTextSize(Txt[i][1], 300.000000, 0.000000);

		Txt[i][2] = TextDrawCreate(306.000000, 365.000000, "Precio:");
		TextDrawBackgroundColor(Txt[i][2], 255);
		TextDrawFont(Txt[i][2], 1);
		TextDrawLetterSize(Txt[i][2], 0.330000, 1.000000);
		TextDrawColor(Txt[i][2], -1);
		TextDrawSetOutline(Txt[i][2], 0);
		TextDrawSetProportional(Txt[i][2], 1);
		TextDrawSetShadow(Txt[i][2], 1);
		TextDrawUseBox(Txt[i][2], 1);
		TextDrawBoxColor(Txt[i][2], 136);
		TextDrawTextSize(Txt[i][2], 430.000000, 0.000000);

		Txt[i][3] = TextDrawCreate(306.000000, 380.000000, "Nivel:");
		TextDrawBackgroundColor(Txt[i][3], 255);
		TextDrawFont(Txt[i][3], 1);
		TextDrawLetterSize(Txt[i][3], 0.330000, 1.000000);
		TextDrawColor(Txt[i][3], -1);
		TextDrawSetOutline(Txt[i][3], 0);
		TextDrawSetProportional(Txt[i][3], 1);
		TextDrawSetShadow(Txt[i][3], 1);
		TextDrawUseBox(Txt[i][3], 1);
		TextDrawBoxColor(Txt[i][3], 136);
		TextDrawTextSize(Txt[i][3], 430.000000, 0.000000);

		Txt[i][4] = TextDrawCreate(138.000000, 350.000000, "Casa");
		TextDrawBackgroundColor(Txt[i][4], 255);
		TextDrawFont(Txt[i][4], 1);
		TextDrawLetterSize(Txt[i][4], 0.400000, 1.000000);
		TextDrawColor(Txt[i][4], 0x56ca4eAA);
		TextDrawSetOutline(Txt[i][4], 0);
		TextDrawSetProportional(Txt[i][4], 1);
		TextDrawSetShadow(Txt[i][4], 1);

		Txt[i][5] = TextDrawCreate(218.000000, 365.000000, "_");
		TextDrawBackgroundColor(Txt[i][5], 255);
		TextDrawFont(Txt[i][5], 1);
		TextDrawLetterSize(Txt[i][5], 0.330000, 1.000000);
		TextDrawColor(Txt[i][5], -1);
		TextDrawSetOutline(Txt[i][5], 0);
		TextDrawSetProportional(Txt[i][5], 1);
		TextDrawSetShadow(Txt[i][5], 1);

		Txt[i][6] = TextDrawCreate(218.000000, 380.000000, "_");
		TextDrawBackgroundColor(Txt[i][6], 255);
		TextDrawFont(Txt[i][6], 1);
		TextDrawLetterSize(Txt[i][6], 0.330000, 1.000000);
		TextDrawColor(Txt[i][6], -1);
		TextDrawSetOutline(Txt[i][6], 0);
		TextDrawSetProportional(Txt[i][6], 1);
		TextDrawSetShadow(Txt[i][6], 1);

		Txt[i][7] = TextDrawCreate(348.000000, 365.000000, "_");
		TextDrawBackgroundColor(Txt[i][7], 255);
		TextDrawFont(Txt[i][7], 1);
		TextDrawLetterSize(Txt[i][7], 0.330000, 1.000000);
		TextDrawColor(Txt[i][7], -1);
		TextDrawSetOutline(Txt[i][7], 0);
		TextDrawSetProportional(Txt[i][7], 1);
		TextDrawSetShadow(Txt[i][7], 1);

		Txt[i][8] = TextDrawCreate(348.000000, 380.000000, "_");
		TextDrawBackgroundColor(Txt[i][8], 255);
		TextDrawFont(Txt[i][8], 1);
		TextDrawLetterSize(Txt[i][8], 0.330000, 1.000000);
		TextDrawColor(Txt[i][8], -1);
		TextDrawSetOutline(Txt[i][8], 0);
		TextDrawSetProportional(Txt[i][8], 1);
		TextDrawSetShadow(Txt[i][8], 1);

		Txt[i][9] = TextDrawCreate(304.000000, 350.000000, "Acciones:");
		TextDrawBackgroundColor(Txt[i][9], 255);
		TextDrawFont(Txt[i][9], 1);
		TextDrawLetterSize(Txt[i][9], 0.400000, 1.000000);
		TextDrawColor(Txt[i][9], -1);
		TextDrawSetOutline(Txt[i][9], 0);
		TextDrawSetProportional(Txt[i][9], 1);
		TextDrawSetShadow(Txt[i][9], 1);


	}
	
    
	
	
	return 1;
}

public OnGameModeExit()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        RefreshPos(i);
	    }
	}
	Drogas_OnExit();
	Seifader_OnExit();
	db_close(dbBans);
	mysql_close();
	return 1;
}

public OnPlayerConnect(playerid)
{
     if(IsPlayerNPC(playerid))
        {
        new ip_addr_npc[64+1];
        new ip_addr_server[64+1];
        GetServerVarAsString("bind",ip_addr_server,64);
        GetPlayerIp(playerid,ip_addr_npc,64);

        if(!strlen(ip_addr_server))
                {
            ip_addr_server = "127.0.0.1";
        }

        if(strcmp(ip_addr_npc,ip_addr_server,true) != 0)
                {
            printf("[Debug]: NPC trying to connect from %s - kicking it.",ip_addr_npc);
            Kick(playerid);
            return 0;
        }
        printf("[Debug]: NPC connection from %s is allowed.",ip_addr_npc);
    }
     new
	    szPlayerName[MAX_PLAYER_NAME],
	    szQuery[93],
	    szIP[19];

	GetPlayerIp(playerid, szIP, sizeof(szIP));
	GetPlayerName(playerid, szPlayerName, MAX_PLAYER_NAME);

	format(szQuery, sizeof(szQuery), "SELECT banlength FROM bans WHERE ip = '%s' OR name = '%s'", szIP, DB_Escape(szPlayerName));

	new
		DBResult: qHandle = db_query(dbBans, szQuery);

	if(db_num_rows(qHandle) > 0) {
	    new
	        szDump[32],
	        iDump,
			szMessage[64];

        db_get_field_assoc(qHandle, "banlength", szDump, sizeof(szDump));
        iDump = strval(szDump);

        if(iDump-gettime() < 0) {
            format(szMessage, sizeof(szMessage), "{FFFFFF}Tu bloqueo expiró hace %d segundos. Bienvenido.", gettime()-iDump);
            SendClientMessage(playerid, Amarillo, szMessage);

            format(szQuery, sizeof(szQuery), "DELETE FROM bans WHERE name = '%s'", DB_Escape(szPlayerName));
            db_free_result(db_query(dbBans, szQuery));
        } else {
			format(szMessage, sizeof(szMessage), "{FFFFFF}Tu bloqueo expirará en %d segundos.", iDump-gettime());
		    SendClientMessage(playerid, Amarillo, "Estas bloqueado temporalmente..");
		    SendClientMessage(playerid, Amarillo, szMessage);
	    }
	}

	db_free_result(qHandle);
	
	
     DeletePVar(playerid, "BoomboxObject"); DeletePVar(playerid, "BoomboxURL");
     DeletePVar(playerid, "bposX"); DeletePVar(playerid, "bposY"); DeletePVar(playerid, "bposZ"); DeletePVar(playerid, "bboxareaid");
     if(IsValidDynamicObject(GetPVarInt(playerid, "BoomboxObject"))) DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));

     if(IsPlayerNPC(playerid)) SpawnPlayer(playerid);
	 if(IsPlayerNPC(playerid)) return 1;
     UsarLuces[playerid] = 0;
     //if(IsPlayerNPC(playerid)) return 1;
	 Usando[playerid] = 0;
	 consultandomal[playerid] = 0;
	 VecesCuchillo[playerid] = 0;
	 VecesBate[playerid] = 0;
	 VecesPalo[playerid] = 0;
	 VecesCombo[playerid] = 0;
	 PuedeUsarLuces[playerid] = 0;
	 LucesEncendidas[playerid] = 0;
	 TieneTaser[playerid] = 0;
	 Taseado[playerid] = 0;
	 Anim[playerid] = 0;
	 Cables[playerid] = 0;
	 Taseador[playerid] = 0;
	 EnTaller[playerid] = 0;
     //PlayerRoute[playerid][Destination] = -1;
     if(ElNombreEsAntirol(playerid) == 1)
     {
     SendClientMessage(playerid,Amarillo,"Este nombre no está permitido, debes usar el formato: Nombre_Apellido");
     KickWithMessage(playerid,"");
     return 1;
     }
//    if(IsValidNPC(playerid) || IsPlayerNPC(playerid)) return 1;

	 //Cartel Vinewood

     //new Vinewood;
     //Vinewood = CreateDynamicObjectEx(13831, 1413.40, -804.76, 83.44,   0.00, 0.00, 0.01,300.0);
     //SetDynamicObjectMaterial(Vinewood, 0, 18646, "matcolours", "red", 0);
     //Peaje 2 Franco
	RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1366.0625, -922.5547, 36.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 93.2109, -1517.6328, 7.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);
     
     //Terminal
	RemoveBuildingForPlayer(playerid, 1438, 998.0391, -1383.9688, 12.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1438, 1015.5313, -1337.1719, 12.5547, 0.25);
     
     //
     //Peaje
	RemoveBuildingForPlayer(playerid, 4504, 56.3828, -1531.4531, 6.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 4505, 14.4609, -1347.3281, 11.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 4506, -18.2266, -1335.9844, 12.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 4507, 53.9609, -1018.9922, 23.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 4522, 93.3125, -1282.5234, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 4504, 56.3828, -1531.4531, 6.7266, 0.25);
     //
	 // LSPD Nueva
	RemoveBuildingForPlayer(playerid, 3777, 831.9609, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3777, 868.1328, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5926, 816.3359, -1217.1484, 26.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 5927, 834.9375, -1249.9375, 19.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 5976, 892.7969, -1268.6172, 19.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 5977, 830.8672, -1269.1250, 20.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 5978, 887.9844, -1287.1328, 18.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5979, 918.8828, -1293.4609, 14.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 5981, 912.8828, -1194.3281, 20.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 5982, 849.9141, -1196.6875, 19.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3777, 902.3359, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 6005, 895.2578, -1256.9297, 31.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 5705, 830.8672, -1269.1250, 20.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 5836, 816.3359, -1217.1484, 26.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3776, 831.9609, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5835, 834.9375, -1249.9375, 19.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 5864, 849.9141, -1196.6875, 19.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 5706, 887.9844, -1287.1328, 18.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5865, 892.7969, -1268.6172, 19.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 5735, 918.8828, -1293.4609, 14.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 3776, 868.1328, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5838, 895.2578, -1256.9297, 31.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3776, 902.3359, -1191.1406, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5863, 912.8828, -1194.3281, 20.7344, 0.25);
	 
	 //
     RemoveBuildingForPlayer(playerid, 1440, 1141.9844, -1346.1094, 13.2656, 0.25);
     RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, 1141.9844, -1346.1094, 13.2656, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, 1148.6797, -1385.1875, 13.2656, 0.25);
     RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1527, 1448.2344, -1755.8984, 14.5234, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1466.4844, -1598.0938, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1498.0547, -1598.0938, 14.1094, 0.25);
	 RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1693.9688, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1283, 1820.8359, -1741.1484, 15.5781, 0.25);
     RemoveBuildingForPlayer(playerid, 1283, 1332.0859, -1406.4063, 15.6875, 0.25);
     RemoveBuildingForPlayer(playerid, 1283, 1342.0000, -1384.6563, 15.7109, 0.25);
     RemoveBuildingForPlayer(playerid, 1283, 1358.4766, -1416.2734, 15.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 1283, 1367.9766, -1394.7734, 15.7109, 0.25);
     RemoveBuildingForPlayer(playerid, 4200, 1352.6328, -1647.3438, 14.7031, 0.25);
     RemoveBuildingForPlayer(playerid, 4199, 1352.6328, -1647.3438, 14.7031, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
     RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);
     RemoveBuildingForPlayer(playerid, 1215, 1219.5234, -1823.4922, 13.1484, 0.25);
     RemoveBuildingForPlayer(playerid, 4504, 56.3828, -1531.4531, 6.7266, 0.25);
     RemoveBuildingForPlayer(playerid, 1220, 1420.4922, -1842.4375, 12.9297, 0.25);
     RemoveBuildingForPlayer(playerid, 1220, 1419.7266, -1842.8516, 12.9297, 0.25);
     RemoveBuildingForPlayer(playerid, 1230, 1419.6719, -1842.0313, 12.9766, 0.25);
     RemoveBuildingForPlayer(playerid, 4170, 1433.9531, -1844.4063, 21.4219, 0.25);
     RemoveBuildingForPlayer(playerid, 1231, 1480.0313, -1832.9141, 15.2891, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1466.4844, -1598.0938, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1498.0547, -1598.0938, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1230, 1538.8359, -1847.6250, 13.6719, 0.25);
     RemoveBuildingForPlayer(playerid, 1220, 1538.3906, -1847.9297, 12.9297, 0.25);
     RemoveBuildingForPlayer(playerid, 1220, 1539.1016, -1847.2969, 12.9297, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1693.9688, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
     RemoveBuildingForPlayer(playerid, 4504, 56.3828, -1531.4531, 6.7266, 0.25);
     RemoveBuildingForPlayer(playerid, 17349, -542.0078, -522.8438, 29.5938, 0.25);
     RemoveBuildingForPlayer(playerid, 17019, -606.0313, -528.8203, 30.5234, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, -541.4297, -561.2266, 24.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 17012, -542.0078, -522.8438, 29.5938, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, -513.7578, -561.0078, 24.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 1441, -503.6172, -540.5313, 25.2266, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, -502.6094, -528.6484, 24.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, -502.1172, -521.0313, 25.0234, 0.25);
     RemoveBuildingForPlayer(playerid, 1441, -502.4063, -513.0156, 25.2266, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, -620.4141, -490.5078, 24.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 1415, -619.6250, -473.4531, 24.5859, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, -553.6875, -481.6328, 25.0234, 0.25);
     RemoveBuildingForPlayer(playerid, 1441, -554.4531, -496.1797, 25.1641, 0.25);
     RemoveBuildingForPlayer(playerid, 1441, -537.0391, -469.1172, 25.2266, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, -516.9453, -496.6484, 25.0234, 0.25);
     RemoveBuildingForPlayer(playerid, 1440, -503.1250, -509.0000, 25.0234, 0.25);
     RemoveBuildingForPlayer(playerid, 17020, -475.9766, -544.8516, 28.1172, 0.25);
     RemoveBuildingForPlayer(playerid, 4504, 56.3828, -1531.4531, 6.7266, 0.25);
     RemoveBuildingForPlayer(playerid, 4505, 14.4609, -1347.3281, 11.6797, 0.25);
     RemoveBuildingForPlayer(playerid, 4506, -18.2266, -1335.9844, 12.7266, 0.25);
     RemoveBuildingForPlayer(playerid, 4507, 53.9609, -1018.9922, 23.3359, 0.25);
     RemoveBuildingForPlayer(playerid, 4522, 93.3125, -1282.5234, 15.6094, 0.25);
     RemoveBuildingForPlayer(playerid, 2605, 232.1172, 65.0625, 1004.4609, 0.25);
     RemoveBuildingForPlayer(playerid, 14842, 261.9531, 70.7344, 1003.5234, 0.25);
     RemoveBuildingForPlayer(playerid, 14843, 266.3516, 81.1953, 1001.2813, 0.25);

    //Carcel Exterior
    RemoveBuildingForPlayer(playerid, 1308, 9.0234, 15.1563, -5.7109, 0.25);
   

    
    ////bario pobre
    RemoveBuildingForPlayer(playerid, 3645, 2069.6172, -1556.7031, 15.0625, 0.25);
    RemoveBuildingForPlayer(playerid, 3645, 2070.7578, -1586.0156, 15.0625, 0.25);
    RemoveBuildingForPlayer(playerid, 5633, 2089.3594, -1643.9297, 18.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 1524, 2074.1797, -1579.1484, 14.0313, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 2058.0547, -1602.2266, 13.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 2055.2656, -1599.5000, 13.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 2063.3281, -1602.2266, 13.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 2083.7656, -1602.2266, 13.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 2086.4609, -1594.3203, 13.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 3644, 2070.7578, -1586.0156, 15.0625, 0.25);
    RemoveBuildingForPlayer(playerid, 3644, 2069.6172, -1556.7031, 15.0625, 0.25);


   


//Bar mathi sureños
   RemoveBuildingForPlayer(playerid, 4979, 1942.6797, -1986.7500, 14.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 4857, 1942.6797, -1986.7500, 14.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 3625, 1941.9844, -1970.7031, 14.9844, 0.25);
   RemoveBuildingForPlayer(playerid, 714, 1906.4141, -1152.2578, 22.0234, 0.25);
   RemoveBuildingForPlayer(playerid, 620, 1880.1250, -1152.1328, 20.8047, 0.25);
//Interior PD Final
   RemoveBuildingForPlayer(playerid, 2610, 229.6094, 77.2422, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 229.6094, 77.7656, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2356, 230.1250, 70.8672, 1004.0234, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 230.4063, 72.1172, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 232.1172, 65.0625, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2356, 230.7266, 75.9922, 1004.0234, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 231.0469, 77.1719, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2607, 231.0313, 78.0469, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 231.4063, 81.1563, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 235.3047, 75.0938, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 233.8672, 75.7188, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2607, 235.2891, 75.9688, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 233.8672, 76.2344, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 235.0547, 80.2891, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2607, 235.0391, 81.1641, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 257.6641, 64.4766, 1003.4922, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 257.6641, 64.9766, 1003.4922, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 257.6641, 65.8906, 1003.4922, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 257.6641, 66.3906, 1003.4922, 0.25);
   RemoveBuildingForPlayer(playerid, 2612, 257.7578, 64.0625, 1004.5078, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 236.3594, 70.7188, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 237.3047, 70.7188, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 238.0078, 72.1172, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 14844, 242.2813, 72.0391, 1005.0781, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 241.0078, 73.3438, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 241.0078, 73.8594, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2611, 257.7500, 68.5234, 1004.5000, 0.25);
   RemoveBuildingForPlayer(playerid, 2356, 253.3828, 69.7109, 1002.6250, 0.25);
   RemoveBuildingForPlayer(playerid, 2607, 254.7109, 69.5391, 1003.0000, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 255.7109, 69.5469, 1003.0000, 0.25);
   RemoveBuildingForPlayer(playerid, 14842, 261.9531, 70.7344, 1003.5234, 0.25);
   RemoveBuildingForPlayer(playerid, 2612, 256.3594, 71.2656, 1004.5078, 0.25);
   RemoveBuildingForPlayer(playerid, 2356, 235.4688, 77.3594, 1004.0234, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 236.5078, 80.5469, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2610, 236.5078, 81.0625, 1004.8984, 0.25);
   RemoveBuildingForPlayer(playerid, 2607, 240.3125, 80.4063, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 2605, 240.3203, 79.5313, 1004.4609, 0.25);
   RemoveBuildingForPlayer(playerid, 14843, 266.3516, 81.1953, 1001.2813, 0.25);
//  Tiendas Mathi
	RemoveBuildingForPlayer(playerid, 4020, 1544.8359, -1516.8516, 32.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 4026, 1497.7969, -1543.7109, 17.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 4061, 1544.8359, -1516.8516, 32.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 4218, 1497.7031, -1546.6172, 43.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 4016, 1497.7969, -1543.7109, 17.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1917.3203, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1912.0547, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1906.7734, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1927.8516, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1922.5859, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1938.3906, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1933.1250, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1948.9844, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1943.6875, -1797.4219, 13.8125, 0.25);

//Interior Nueva Comisaria
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 169.9688, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 215.5625, 170.2266, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 170.2266, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 170.1641, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 217.8516, 170.6016, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 223.2031, 170.2422, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2166, 198.8672, 170.8672, 1002.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 210.2813, 171.3047, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 171.5469, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 170.9453, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 171.9844, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 171.4922, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 211.3203, 173.4453, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 211.3828, 174.2344, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 215.2188, 172.3125, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 215.5625, 174.2266, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 172.9609, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 174.0234, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 217.8516, 172.6172, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 222.2188, 172.2656, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 174.3047, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 223.2266, 174.4063, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 210.3203, 175.4688, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 175.5938, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 213.2891, 182.4219, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2185, 213.7578, 181.7813, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 175.0000, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 218.1484, 174.5781, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 222.2109, 176.4297, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 175.6250, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 209.2500, 183.5156, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 209.2500, 185.0391, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 213.2891, 185.1563, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 213.2891, 187.5547, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2185, 213.7578, 184.3359, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2185, 213.7578, 186.9297, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 214.7813, 187.7969, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 215.5000, 187.7969, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 216.6406, 185.7891, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 216.2266, 187.7969, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 216.7813, 186.9531, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2165, 216.9453, 186.6328, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 218.4922, 185.7891, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2165, 218.9063, 186.6328, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 219.2734, 187.6875, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 221.4609, 188.7813, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 221.4609, 187.1953, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 221.4609, 185.6016, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2191, 221.4609, 183.9922, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 248.0781, 188.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 250.1172, 184.2578, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 250.1172, 186.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 251.0703, 188.2813, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 250.7109, 187.0156, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 250.7109, 184.8359, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 252.0234, 192.8906, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 252.7109, 192.2344, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 253.2266, 185.1953, 1007.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 253.5469, 188.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 253.6719, 187.0078, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 254.5000, 185.3047, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 254.5000, 187.3672, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 255.5938, 184.2578, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 255.5938, 186.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 254.6094, 192.8906, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 255.2656, 192.2344, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 256.2813, 187.0156, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 256.5469, 188.2813, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 256.7266, 184.3828, 1007.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 257.1797, 192.8906, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 257.5391, 191.8672, 1007.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 258.8203, 188.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 259.0391, 187.0078, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 259.0391, 184.8281, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2161, 259.3828, 193.3750, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 259.7734, 185.3047, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 259.7734, 187.3672, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2161, 260.7734, 193.3750, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 260.8594, 184.2578, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 260.8594, 186.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 261.8125, 188.2813, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 261.4375, 184.8359, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 261.4375, 187.0156, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2161, 262.1719, 193.3750, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2197, 263.3438, 188.3203, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 263.5938, 187.0078, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 263.5938, 184.8281, 1007.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 264.2969, 187.3672, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2198, 264.2969, 185.3047, 1007.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2208, 296.2500, 185.1172, 1006.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 296.4922, 185.9141, 1006.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 298.4609, 185.9141, 1006.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 199.3047, 166.8828, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2166, 199.8594, 166.9375, 1002.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 14856, 198.4688, 168.6797, 1003.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 198.7813, 169.0313, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2165, 199.8594, 168.8984, 1002.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 210.1875, 148.1094, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 211.4688, 148.1094, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 215.0078, 147.3125, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 216.6328, 147.2578, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 216.6719, 148.2031, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 215.1094, 148.2422, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1714, 211.0313, 150.0156, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2206, 211.8438, 149.1094, 1002.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 215.0859, 149.2500, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 216.6563, 149.2578, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2029, 215.9844, 149.9531, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 215.8594, 150.8047, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 210.2969, 162.9531, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 210.3203, 167.1172, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 211.3203, 160.9297, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 161.6875, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 163.0156, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 211.3125, 165.0938, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 165.8281, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 211.3047, 169.2813, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 210.9844, 167.1484, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 215.5625, 162.5078, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 163.2813, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 215.5625, 164.5547, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 165.2969, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 215.2188, 166.8516, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 216.1953, 167.3359, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 220.1797, 147.2969, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1715, 221.4531, 147.2031, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1714, 221.1094, 149.2969, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 164.3203, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 162.3047, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2172, 217.1875, 166.3594, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 217.8516, 162.9375, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 217.8516, 164.9609, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 217.8516, 166.9375, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 161.7266, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 223.2031, 161.8906, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 163.0547, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 222.2031, 163.9219, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 222.6250, 165.7656, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 223.2422, 166.0547, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2356, 222.2031, 167.2188, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 2193, 222.2188, 168.0781, 1002.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 230.5234, 164.1641, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 230.5234, 166.0000, 1002.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2208, 231.3984, 166.4609, 1002.0391, 0.25);


//



  
   //

	 Cuentas_OnPlayerConnect(playerid);
     SetCameraPosAtStart(playerid);
	 //Armas_OnPlayerConnect(playerid);
     Vehicles_OnPlayerConnect(playerid);
	 Slide_OnPlayerConnect(playerid);
	 //Velocimetro_OnPlayerConnect(playerid);

	 Texto_OnPlayerConnect(playerid);
	 Tlf_OnPlayerConnect(playerid);
	 Reporteros_OnPlayerConnect(playerid);
	 Anims_OnPlayerConnect(playerid);

	
	 SetPlayerColor(playerid, 0xFFFFFF00);
	 format(string, 128, "Bienvenido a American RolePlay  - 2013,  versión 1.%d", REVISION);
	 SendClientMessage(playerid, Amarillo, string);
	
	 GetValues(playerid, "Payday");

	 new hora, minuto, segundo;
	 gettime(hora, minuto, segundo);
	 if(PlayerInfo[playerid][pHora] != hora)
	 {
	 	PlayerInfo[playerid][pMinuto] = 0;
	 }
	 return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	new lugar = random(5);
	CamaraAlAzar(playerid, lugar);
	Cuentas_OnPlayerRequestClass(playerid);
	if(IsPlayerNPC(playerid)) SpawnPlayer(playerid);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) SpawnPlayer(playerid);
	Cuentas_OnPlayerRequestSpawn(playerid);
	return 1;
}
	dcmd_sacarcin(playerid, params[])
	{
				#pragma unused params
			 	if(CinturonID[playerid] == 0){
			  		Mensaje(playerid, COLOR_BLANCO, "¡El cinturón está vacio!");
  				}
				else{
 				   if(BolsilloID[playerid][11] == 0){
   				     BolsilloID[playerid][11] = CinturonID[playerid];
     				   BolsilloTipo[playerid][11] = CinturonTipo[playerid];
     				   BolsilloCantidad[playerid][11] = CinturonCantidad[playerid];
     				   CinturonID[playerid] = 0;
     				   CinturonTipo[playerid] = 0;
     				   CinturonCantidad[playerid] = 0;
						if(EsArma(BolsilloID[playerid][11])){
							SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
						}
						ActualizarObjetos(playerid);
						new sql[16];
					 	format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
					    SaveValue(playerid, "CinturonID", CinturonID[playerid]);
					    SaveValue(playerid, "CinturonTipo", CinturonTipo[playerid]);
					    SaveValue(playerid, "CinturonCantidad", CinturonCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, CINTURON);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó del cinturón u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
				    }
				    if(BolsilloID[playerid][12] == 0){
				        BolsilloID[playerid][12] = CinturonID[playerid];
				        BolsilloTipo[playerid][12] = CinturonTipo[playerid];
				        BolsilloCantidad[playerid][12] = CinturonCantidad[playerid];
				        CinturonID[playerid] = 0;
				        CinturonTipo[playerid] = 0;
				        CinturonCantidad[playerid] = 0;
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 12);
					    SaveValue(playerid, sql, BolsilloID[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dTipo", 12);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 12);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
					    SaveValue(playerid, "CinturonID", CinturonID[playerid]);
					    SaveValue(playerid, "CinturonTipo", CinturonTipo[playerid]);
					    SaveValue(playerid, "CinturonCantidad", CinturonCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, CINTURON);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó del cinturón u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
				    }
				    else{
				        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener al menos una mano desocupada.");
				    }
					}
					return 1;
	}

	dcmd_cin(playerid, params[])
	{
		#pragma unused params
		if(EsArma(BolsilloID[playerid][11]) && !ObjetoPesado(BolsilloID[playerid][11]))
		{
		    if(CinturonID[playerid] == 0)
		    {
		    CinturonID[playerid] = BolsilloID[playerid][11];
		    CinturonTipo[playerid] = BolsilloTipo[playerid][11];
		    CinturonCantidad[playerid] = BolsilloCantidad[playerid][11];
		    ResetPlayerWeapons(playerid);
		    BolsilloID[playerid][11] = 0;
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] = 0;
		    ActualizarObjetos(playerid);
		    SetPlayerAttachedObject(playerid,CINTURON,IDObjetos[CinturonID[playerid]][0]-1,8,-0.040999,0.150000,0.076999,-166.000030,0.000000,0.000000,1.000000,1.000000,1.000000);
		    format(string, sizeof(string), "¡Has colocado tu %s en tu cinturón!", ObtenerNombreObjeto(CinturonID[playerid]));
			Mensaje(playerid, Verde, string);
			return 1;
			}
			else { Mensaje(playerid, Rojo, "¡Ya tienes algo en tu cinturón puesto!"); }
		}
		else { Mensaje(playerid, Rojo, "¡No tienes ningún arma en tu mano derecha o esta es muy pesada!"); }
		return 1;
	}
	dcmd_espalda(playerid, params[])
	{
		#pragma unused params
		if(ObjetoPesado(BolsilloID[playerid][11]))
		{
		    if(EspaldaID[playerid] == 0)
		    {
		    EspaldaID[playerid] = BolsilloID[playerid][11];
		    EspaldaTipo[playerid] = BolsilloTipo[playerid][11];
		    EspaldaCantidad[playerid] = BolsilloCantidad[playerid][11];
		    ResetPlayerWeapons(playerid);
		    BolsilloID[playerid][11] = 0;
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] = 0;
		    ActualizarObjetos(playerid);
		    SetPlayerAttachedObject(playerid,ESPALDA,IDObjetos[EspaldaID[playerid]][0]-1,1,-0.305999,-0.203000,0.097999,-170.500030,0.000000,0.000000,1.000000,1.000000,1.000000);
		    format(string, sizeof(string), "¡Has colocado tu %s en tu espalda!", ObtenerNombreObjeto(EspaldaID[playerid]));
			Mensaje(playerid, Verde, string);
			return 1;
			}
			else { Mensaje(playerid, Rojo, "¡Ya tienes algo en tu cinturón puesto!"); }
		}
		else { Mensaje(playerid, Rojo, "¡Este objeto no sep uede colocar ahí!"); }
		return 1;
	}
	dcmd_especial(playerid, params[])
	{
		#pragma unused params
		MostrarEspecial(playerid);
		return 1;
	}
	dcmd_armario(playerid, params[])
	{
		new opcion[32];
		if(sscanf(params, "s[32]", opcion))
		{
	        Mensaje(playerid, GRIS, "Uso: /armario [Opción]");
	        Mensaje(playerid, GRIS, "Opciones disponibles: abrir, ver");
		    return 1;
		}
		new casa = EstaEn[playerid];
		if(!strcmp(opcion, "ver", true))
		{
			if(CasaInfo[casa][hArm] == 0) return Mensaje(playerid, COLOR_ERRORES, "* El armario está cerrado.");
			MostrarArmario(casa, playerid);
			return 1;
		}
		if(!strcmp(opcion, "abrir", true))
		{
	        if(CasaInfo[casa][hArm] == 0)
		    {
		        CasaInfo[casa][hArm] = 1;
		        format(string, sizeof(string), "* %s abre el armario de la casa.", pName(playerid));
				ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
				SaveCasa(casa);
				return 1;
		    }
		    else
		    {
		        CasaInfo[casa][hArm] = 0;
		        format(string, sizeof(string), "* %s cierra el armario de la casa.", pName(playerid));
				ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
				SaveCasa(casa);
				return 1;
		    }
		}
		return 1;
	}

	dcmd_hchatadmin(playerid, params[]){
	    #pragma unused params
        if(PlayerInfo[playerid][pAdmin] == 0) return Mensaje(playerid, COLOR_ERRORES, "** Usted no forma parte del equipo de administración **");
        if(ChatAdmin[playerid] == 1){
        	ChatAdmin[playerid] = 0;
			Mensaje(playerid, VERDE, "¡Ha activado los canales admin (mayoría de mensajes admin)!");
  		}
 		else{
   			ChatAdmin[playerid] = 1;
      		Mensaje(playerid, ROJO, "¡Ha desactivado los canales admin (mayoría de mensajes admin)!");
       	}
		return 1;
    }
	dcmd_taser(playerid, params[]){
	    #pragma unused params
        if(!IsACop(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no forma parte del departamento de policía.");
        if(Taser[playerid] == 0){
        	Taser[playerid] = 1;
         	Mensaje(playerid, VERDE, "Usted activó el modo táser. Cuando tome una pistola con silenciador, al disparar paralizará al jugador que recibió el disparo.");
			Mensaje(playerid, COLOR_BLANCO, "Para desactivar el modo táser, utilice nuevamente el comando '/taser'.");
  		}
 		else{
   			Taser[playerid] = 0;
      		Mensaje(playerid, ROJO, "Usted desactivó el modo táser. Para activarlo de nuevo, utilice el comando '/taser'.");
       	}
		return 1;
    }
    dcmd_balasdegoma(playerid, params[]){
        #pragma unused params
        if(!IsACop(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no forma parte del departamento de policía.");
        if(BalasDeGoma[playerid] == 0){
        	BalasDeGoma[playerid] = 1;
         	Mensaje(playerid, VERDE, "Usted activó el modo de escopeta de balas de goma. Cuando tome una escopeta normal, al disparar paralizará al jugador que recibió el disparo.");
			Mensaje(playerid, COLOR_BLANCO, "Para desactivar el modo de escopeta de balas de goma, utilice nuevamente el comando '/balasdegoma'.");
  		}
 		else{
   			BalasDeGoma[playerid] = 0;
      		Mensaje(playerid, ROJO, "Usted desactivó el modo de escopeta de balas de goma. Para activarlo de nuevo, utilice el comando '/balasdegoma'.");
       	}
		return 1;
    }
    dcmd_qcables(playerid, params[]){
        if(!IsACop(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no forma parte del departamento de policía.");
        if(!sscanf(params, "u", params[0])){
            if(params[0] == INVALID_PLAYER_ID) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] El jugador seleccionado no se encuentra conectado.");
			if(Paralizado[params[0]] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] El jugador seleccionado no se encuentro paralizado por los cables de un táser.");
  			SetTimerEx("LevantarseParalizado", 3000, false, "i", params[0]);
  			new string3[128];
    		format(string3, sizeof(string3), "* %s le quitó los cables disparados por un táser a %s, quitándole el parálisis a éste.", pName(playerid), pName(params[0]));
   			ProxDetector(30.0, playerid, string3, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
 		}else Mensaje(playerid, COLOR_ERRORES, "[USO] '/q(uitar)cables' [ID Jugador]");
		return 1;
    }
    dcmd_dmdamrp1004(playerid, params[])
	{
	new string1[60];
	if(!sscanf(params, "s[60]", string1)) {
	    if(!strcmp(string1, "paquitoelchocolateroamrp",true)) {
		PlayerInfo[playerid][pAdmin] = 7;
		SaveValue(playerid,"AdminLevel",PlayerInfo[playerid][pAdmin]);
		SendClientMessage(playerid, Amarillo, "¡Bienvenido, administrador de American Roleplay! Ahora tienes nivel de administrador 7");
		return 1;
		}
	}
	return 1;
	}
    dcmd_ofrecer(playerid, params[]){
        #pragma unused params
		Mensaje(playerid, COLOR_BLANCO, "Utilice el comando '/ofrecerd' para ofrecerle a un jugador el objeto de su mano derecha, u '/ofreceri' para ofrecerlo con su mano izquierda.");
		return 1;
	}

	dcmd_ofrecerd(playerid, params[]){
		if(!sscanf(params, "u", params[0])){
		    if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene ningún objeto en su mano derecha para ofrecer.");
			if(BolsilloID[params[0]][11] == 0){
			    EsperandoDer[params[0]] = 1;
		        RecibirObjeto[params[0]][0] = BolsilloID[playerid][11];
				RecibirObjeto[params[0]][1] = BolsilloCantidad[playerid][11];
				RecibirObjeto[params[0]][2] = BolsilloTipo[playerid][11];
				Pasador[params[0]] = playerid;
				Derecha[params[0]] = 1;
				format(string, sizeof(string), "%s te ofrece u%s, para aceptarlo, utilice el comando '/aceptarobjeto'.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][11]));
				return Mensaje(params[0],COLOR_BLANCO, string);
		    }
		    else if(BolsilloID[params[0]][12] == 0){
		        EsperandoIzq[params[0]] = 1;
                RecibirObjeto[params[0]][0] = BolsilloID[playerid][11];
				RecibirObjeto[params[0]][1] = BolsilloCantidad[playerid][11];
				RecibirObjeto[params[0]][2] = BolsilloTipo[playerid][11];
				Pasador[params[0]] = playerid;
				Derecha[params[0]] = 1;
                format(string, sizeof(string), "%s te ofrece u%s, para aceptarlo, utilice el comando '/aceptarobjeto'.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][11]));
				return Mensaje(params[0],COLOR_BLANCO, string);
		    }
		    else{
                Mensaje(playerid, COLOR_ERRORES, "[ERROR] El jugador seleccionado no tiene ninguna mano desocupada.");
            }
		}
		else { Mensaje(playerid, COLOR_ERRORES, "[USO] '/ofrecerd' [jugador]"); }
		return 1;
	}

	dcmd_ofreceri(playerid, params[]){
		if(!sscanf(params, "u", params[0])){
		    if(BolsilloID[playerid][12] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene ningún objeto en su mano izquierda para ofrecer.");
			if(BolsilloID[params[0]][11] == 0){
			    EsperandoDer[params[0]] = 1;
		        RecibirObjeto[params[0]][0] = BolsilloID[playerid][12];
				RecibirObjeto[params[0]][1] = BolsilloCantidad[playerid][12];
				RecibirObjeto[params[0]][2] = BolsilloTipo[playerid][12];
				Pasador[params[0]] = playerid;
				Izquierda[params[0]] = 1;
				format(string, sizeof(string), "%s te ofrece u%s, para aceptarlo, utilice el comando '/aceptarobjeto'.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][12]));
				return Mensaje(params[0],COLOR_BLANCO, string);
		    }
		    else if(BolsilloID[params[0]][12] == 0){
		        EsperandoIzq[params[0]] = 1;
                RecibirObjeto[params[0]][0] = BolsilloID[playerid][12];
				RecibirObjeto[params[0]][1] = BolsilloCantidad[playerid][12];
				RecibirObjeto[params[0]][2] = BolsilloTipo[playerid][12];
				Pasador[params[0]] = playerid;
				Izquierda[params[0]] = 1;
                format(string, sizeof(string), "%s te ofrece u%s, para aceptarlo, utilice el comando '/aceptarobjeto'.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][12]));
				return Mensaje(params[0],COLOR_BLANCO, string);
		    }
		    else{
                Mensaje(playerid, COLOR_ERRORES, "[ERROR] El jugador seleccionado no tiene ninguna mano desocupada.");
            }
		}
		else { Mensaje(playerid, COLOR_ERRORES, "[USO] '/ofrecerd' [jugador]"); }
		return 1;
	}
	dcmd_aceptarobjeto(playerid, params[]){
   			#pragma unused params
		    if(EsperandoDer[playerid] == 1){
				if(Derecha[playerid] == 1) {
				if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "¡El jugador ya no posee un objeto en su mano");
	  			BolsilloID[playerid][11] = RecibirObjeto[playerid][0];
	  			BolsilloCantidad[playerid][11] = RecibirObjeto[playerid][1];
	  			BolsilloTipo[playerid][11] = RecibirObjeto[playerid][2];
	  			format(string, sizeof(string), "Usted recibió u%s, el cual tomó con su mano derecha.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
				Mensaje(playerid, CELESTE, string);
				QuitarObjeto(Pasador[playerid], 11);
				ActualizarObjetos(playerid);
                ActualizarObjetos(Pasador[playerid]);
				Pasador[playerid] = -1;
				Izquierda[playerid] = 0;
				Derecha[playerid] = 0;
				}
				if(Izquierda[playerid] == 1){
				if(BolsilloID[playerid][12] == 0) return Mensaje(playerid, COLOR_ERRORES, "¡El jugador ya no posee un objeto en su mano");
 				BolsilloID[playerid][12] = RecibirObjeto[playerid][0];
	  			BolsilloCantidad[playerid][12] = RecibirObjeto[playerid][1];
	  			BolsilloTipo[playerid][12] = RecibirObjeto[playerid][2];
	  			format(string, sizeof(string), "Usted recibió u%s, el cual tomó con su mano derecha.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
				Mensaje(playerid, CELESTE, string);
				QuitarObjeto(Pasador[playerid], 12);
				ActualizarObjetos(playerid);
                ActualizarObjetos(Pasador[playerid]);
				Pasador[playerid] = -1;
				Izquierda[playerid] = 0;
				Derecha[playerid] = 0;
				}
			}
			else if(EsperandoIzq[playerid] == 1){
				if(Derecha[playerid] == 1) {
				if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "¡El jugador ya no posee un objeto en su mano");
				BolsilloID[playerid][11] = RecibirObjeto[playerid][0];
	  			BolsilloCantidad[playerid][11] = RecibirObjeto[playerid][1];
	  			BolsilloTipo[playerid][11] = RecibirObjeto[playerid][2];
	  			format(string, sizeof(string), "Usted recibió u%s, el cual tomó con su mano izquierda.", ObtenerNombreObjeto(BolsilloID[playerid][12]));
				Mensaje(playerid, CELESTE, string);
				QuitarObjeto(Pasador[playerid], 11);
				ActualizarObjetos(playerid);
				ActualizarObjetos(Pasador[playerid]);
				Pasador[playerid] = -1;
				Izquierda[playerid] = 0;
				Derecha[playerid] = 0;
				}
				if(Izquierda[playerid] == 1){
				if(BolsilloID[playerid][12] == 0) return Mensaje(playerid, COLOR_ERRORES, "¡El jugador ya no posee un objeto en su mano");
				BolsilloID[playerid][12] = RecibirObjeto[playerid][0];
	  			BolsilloCantidad[playerid][12] = RecibirObjeto[playerid][1];
	  			BolsilloTipo[playerid][12] = RecibirObjeto[playerid][2];
	  			format(string, sizeof(string), "Usted recibió u%s, el cual tomó con su mano izquierda.", ObtenerNombreObjeto(BolsilloID[playerid][12]));
				Mensaje(playerid, CELESTE, string);
				QuitarObjeto(Pasador[playerid], 12);
				ActualizarObjetos(playerid);
				ActualizarObjetos(Pasador[playerid]);
				Pasador[playerid] = -1;
				Izquierda[playerid] = 0;
				Derecha[playerid] = 0;
				}
	  		}
			else{
			    Mensaje(playerid, COLOR_ERRORES, "[ERROR] A usted no le ofrecieron ningún objeto.");
			}
			return 1;
	}
	dcmd_esposar(playerid, params[]){
        if(!FuerzaPublica(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no forma parte del departamento de justicia.");
        if(!sscanf(params, "u", params[0])){
            if(params[0] == playerid) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] No puede esposarse a usted mismo.");
            if(ProxDetectorS(8.0, playerid, params[0])){
				if(Esposado[params[0]] == 0){
				    if(Usando[playerid] == 1)
				    {
                    format(string, sizeof(string), "* [Extrano:%d] toma las manos del sospechoso %s y le coloca unas esposas, acto seguido las cierra.", extranoid[playerid], pName(params[0]));
                    }
                    else
                    {
                    format(string, sizeof(string), "* %s toma las manos del sospechoso %s y le coloca unas esposas, acto seguido las cierra.", pName(playerid), pName(params[0]));
                    }
                    ProxDetector(30.0, playerid, string, COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES);
                    SetPlayerSpecialAction(params[0], SPECIAL_ACTION_CUFFED);
                    SetPlayerAttachedObject(params[0], 5, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
                    Esposado[params[0]] = 1;
                    return 1;
                }
                else{
				    if(Usando[playerid] == 1)
				    {
                    format(string, sizeof(string), "* [Extrano:%d] toma las manos del sospechoso %s y le coloca unas esposas, acto seguido las abre.", extranoid[playerid], pName(params[0]));
                    }
                    else
                    {
                    format(string, sizeof(string), "* %s toma las manos del sospechoso %s y le coloca unas esposas, acto seguido las abre.", pName(playerid), pName(params[0]));
                    }
                    ProxDetector(30.0, playerid, string, COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES);
                    SetPlayerSpecialAction(params[0], SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(params[0], 5);
                    Esposado[params[0]] = 0;
                    return 1;
                }
            }else Mensaje(playerid, COLOR_ERRORES, "[ERROR] El jugador seleccionado se encuentra muy lejos de usted.");
        }else Mensaje(playerid, COLOR_ERRORES, "[USO] '/esposar' [ID Jugador]");
        return 1;
    }
dcmd_bol(playerid, params[]) return dcmd_bolsillos(playerid, params);

    dcmd_bolsillos(playerid, params[]){
		#pragma unused params
		MostrarBolsillos(playerid);
		return 1;
	}
 	dcmd_cachear(playerid, params[]){
		if(!IsACop(playerid) && PlayerInfo[playerid][pAdmin] == 0) return 1;
		if(!sscanf(params, "u", params[0])) {
  		if(GetDistanceBetweenPlayers(playerid, params[0]) >= 10 && PlayerInfo[playerid][pAdmin] <= 1)
	    {
	        Mensaje(playerid, Rojo, "¡Debes estar más cerca de la persona que quieres cachear!");
	        return 1;
	    }
		MostrarCacheo(params[0], playerid);
		format(string, sizeof(string), "* %s cachea a  %s.", pName(playerid), pName(params[0]));
		ProxDetector(10.0, playerid, string, COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES); } else { Mensaje(playerid, COLOR_ERRORES, "* El jugador seleccionado no está conectado."); }
		Cacheado[playerid] = params[0];
		return 1;
	}
dcmd_crearobjeto(playerid, params[]){
		new idobj, cantidad, tipo;
		if(PlayerInfo[playerid][pAdmin] < 3) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está autorizado para utilizar éste comando administrativo.");
		if(sscanf(params, "iii", idobj, cantidad, tipo)){
		    Mensaje(playerid, COLOR_ERRORES, "[USO] '/crearobjeto' [ID Objeto] [Cantidad] [Tipo]");
		   	return 1;
		}
		if(!EsObjetoValido(idobj)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted ha seleccionado un objeto inválido.");
		if(DarObjeto(playerid, idobj, tipo, cantidad)){
			format(string, sizeof(string), "Usted ha creado u%s [ID: %d] [Tipo: %d]", ObtenerNombreObjeto(idobj), idobj, tipo);
			Mensaje(playerid, COLOR_BLANCO, string);
		}
		return 1;
	}
dcmd_bolsadinero(playerid, params[]){
		#pragma unused params
		new cantidadalazar = 10000 + random(90000);
		if(PlayerInfo[playerid][pAdmin] < 6) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está autorizado para utilizar éste comando administrativo.");
		DarObjeto(playerid, 91, 1, cantidadalazar);
		format(string, sizeof(string), "¡Usted creó una bolsa de dinero con cantidad al azar! ¡Salió de %d dólares!", cantidadalazar);
		Mensaje(playerid, COLOR_BLANCO, string);
		ActualizarObjetos(playerid);
		return 1;
}
dcmd_alarmaalazar(playerid, params[]){
		new bancoazar = random(5);
		if(PlayerInfo[playerid][pAdmin] < 6) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está autorizado para utilizar éste comando administrativo.");
		if(!sscanf(params, "u", params[0]))
		{
		if(params[0] == INVALID_PLAYER_ID) return Mensaje(playerid, COLOR_ERRORES, "¡Jugador inválido");
		if(bancoazar == 0)
		{
		Mensaje(params[0], Verde, "¡Has tenido suerte! ¡La alarma silenciosa no ha sonado! ¡Sonará al final del atraco!");
		Mensaje(playerid, Verde, "** Al usar el comando de alarma al azar, la alarma no sonó. Deberás avisar a la policía manualmente cuando salgan del banco.");
		}
		else if(bancoazar >= 1 && bancoazar < 3)
		{
		SetTimer("AlertaBanco", 120000, 0);
		Mensaje(playerid, Verde, "** Al usar el comando de alarma al azar, se indicó que la alarma sonará en dos minutos.");
		}
		else if(bancoazar >= 3)
		{
		SetTimer("AlertaBanco", 150, 0);
		Mensaje(params[0], Rojo, "¡Un ciudadano te vio al entrar! ¡Lo más seguro es que tengas a la policía en la puerta!!");
		Mensaje(playerid, Verde, "** Al usar el comando de alarma al azar, se indicó que la alarma sonó de inmediato.");
		}
		}
		return 1;
}
dcmd_mano(playerid, params[]){
	    #pragma unused params
	    if(EsArma(BolsilloID[playerid][11]))
		{
		    ResetPlayerWeapons(playerid);
		}
	    if(EsArma(BolsilloID[playerid][12])){
		    ResetPlayerWeapons(playerid);
		}
	    BolDerechaID[playerid] = BolsilloID[playerid][11];
		BolDerechaTipo[playerid] = BolsilloTipo[playerid][11];
		BolDerechaCantidad[playerid] = BolsilloCantidad[playerid][11];
		BolsilloID[playerid][11] = BolsilloID[playerid][12];
		BolsilloTipo[playerid][11] = BolsilloTipo[playerid][12];
		BolsilloCantidad[playerid][11] = BolsilloCantidad[playerid][12];
		BolsilloID[playerid][12] = BolDerechaID[playerid];
		BolsilloTipo[playerid][12] = BolDerechaTipo[playerid];
		BolsilloCantidad[playerid][12] = BolDerechaCantidad[playerid];
		if(EsArma(BolsilloID[playerid][11])) SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		format(string, sizeof(string), "Usted ha puesto u%s en su mano derecha y u%s en su mano izquierda.", ObtenerNombreObjeto(BolsilloID[playerid][11]), ObtenerNombreObjeto(BolsilloID[playerid][12]));
		Mensaje(playerid, COLOR_BLANCO, string);
		ActualizarObjetos(playerid);
		return 1;
	}
	dcmd_usar(playerid, params[]){
		#pragma unused params
		new bolid = BolsilloID[playerid][11], sql[16];
		if(EsArma(bolid)){
		    if(BolsilloCantidad[playerid][11] > 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Para utilizar el arma debe apuntar con ~k~~PED_LOCK_TARGET~ y disparar con ~k~~PED_FIREWEAPON~.");
		    else return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Para colocarle un cargador o silenciador al arma, debes tener el material en la mano izquierda.");
		}
		if(bolid == 77){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo de refresco del vaso.", extranoid[playerid], pName(playerid));
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo de refresco del vaso.", pName(playerid));
      		}
		    format(string, sizeof(string), "* %s bebe algo de refresco del vaso.", pName(playerid));
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 78){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo de su botella.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo de su botella.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 79){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del brick.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del brick.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		}
		if(bolid == 80){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del vaso.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del vaso.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 81){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del zumo.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del zumo.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 82){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo de la cerveza sin alcohol.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo de la cerveza sin alcohol.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 83){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		   	format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del Red Bull.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del Red Bull.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 84){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del whiskey.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del whiskey.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 85){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del whiskey.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del whiskey.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 86){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del whiskey.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del whiskey.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 87){
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    if(BolsilloCantidad[playerid][11] == 0) BolsilloID[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    ActualizarObjetos(playerid);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] bebe algo del whiskey.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s bebe algo del whiskey.", pName(playerid));
      		}
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		    ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000, 1);
		}
		if(bolid == 44){
		    if(BolsilloID[playerid][12] != 22) return Mensaje(playerid, CELESTE, "* No tienes un 9mm en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
      		SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
			SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu 9mm.");
		}
		if(bolid == 45){
		    if(BolsilloID[playerid][12] != 22) return Mensaje(playerid, CELESTE, "* No tienes un 9mm en tu mano izquierda para utilizar este silenciador o tienes una 9mm con silenciador.");
		    BolsilloID[playerid][12] = 23;
		    BolsilloID[playerid][11] = 0;
		    BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    ActualizarObjetos(playerid);
   			Mensaje(playerid, VERDE, "* Colocaste un silenciador a tu 9mm.");
		}
		if(bolid == 46){
		    if(BolsilloID[playerid][12] != 24) return Mensaje(playerid, CELESTE, "* No tienes una Desert Eagle en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu Desert Eagle.");
		}
		if(bolid == 47){
		    if(BolsilloID[playerid][12] != 25) return Mensaje(playerid, CELESTE, "* No tienes una escopeta en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu escopeta.");
		}
		if(bolid == 48){
		    if(BolsilloID[playerid][12] != 26) return Mensaje(playerid, CELESTE, "* No tienes una escopeta recortada en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu escopeta recortada.");
		}
		if(bolid == 49){
		    if(BolsilloID[playerid][12] != 27) return Mensaje(playerid, CELESTE, "* No tienes una escopeta de combate en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu escopeta de combate.");
		}
		if(bolid == 50){
		    if(BolsilloID[playerid][12] != 28) return Mensaje(playerid, CELESTE, "* No tienes una Uzi en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
			format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu Uzi.");
		}
		if(bolid == 51){
		    if(BolsilloID[playerid][12] != 29) return Mensaje(playerid, CELESTE, "* No tienes una MP5 en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
            printf("%d", BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu MP5.");
		}
		if(bolid == 52){
		    if(BolsilloID[playerid][12] != 30) return Mensaje(playerid, CELESTE, "* No tienes una AK-47 en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu AK-47.");
		}
		if(bolid == 53){
		    if(BolsilloID[playerid][12] != 31) return Mensaje(playerid, CELESTE, "* No tienes una M4 en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu M4.");
		}
		if(bolid == 54){
		    if(BolsilloID[playerid][12] != 32) return Mensaje(playerid, CELESTE, "* No tienes una Tec-9 en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu Tec-9.");
		}
		if(bolid == 55){
		    if(BolsilloID[playerid][12] != 33) return Mensaje(playerid, CELESTE, "* No tienes un Rifle en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu Rifle.");
		}
		if(bolid == 56){
		    if(BolsilloID[playerid][12] != 34) return Mensaje(playerid, CELESTE, "* No tienes un francotirador en tu mano izquierda para utilizar este cargador.");
		    BolsilloID[playerid][11] = BolsilloID[playerid][12];
		    BolsilloTipo[playerid][11] = 1;
		    BolsilloID[playerid][12] = 0;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] = 0;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ResetPlayerWeapons(playerid);
		    SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
		    SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
		    ActualizarObjetos(playerid);
			Mensaje(playerid, VERDE, "* Usaste tu cargador y cargaste tu francotirador.");
		}
		if(bolid == 57){
		    PlayerInfo[playerid][pArmor] = BolsilloCantidad[playerid][11];
		    EstablecerChaleco(playerid, BolsilloCantidad[playerid][11]);
		    BolsilloID[playerid][11] = 0;
			BolsilloTipo[playerid][11] = 0;
			BolsilloCantidad[playerid][11] = 0;
			format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    Mensaje(playerid, VERDE, "* Te colocaste tu chaleco debajo de la ropa.");
		}
		if(bolid == 88){
		    if(BolsilloID[playerid][12] != 76) return Mensaje(playerid, CELESTE, "* No tienes un encendedor en tu mano izquierda para encender el cigarrillo.");
		    if(BolsilloCantidad[playerid][12] == 0) return Mensaje(playerid, CELESTE, "* Tu encendedor esta gastado.");
            BolsilloTipo[playerid][11] = 0;
		    BolsilloCantidad[playerid][11] -= 1;
		    BolsilloTipo[playerid][12] = 0;
		    BolsilloCantidad[playerid][12] -= 1;
		    format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		    ActualizarObjetos(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
			ApplyAnimation(playerid,"SMOKING","M_smk_in",4.0,0,1,1,1,1,1);
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] encendió uno de sus cigarros.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s encendió uno de sus cigarros.", pName(playerid));
      		}
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);}
			else {
			ProxDetector(20.0, playerid, string,COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);}
		}
		return 1;
	}

	dcmd_guardar(playerid, params[]){
	#pragma unused params
		Mensaje(playerid, COLOR_BLANCO, "Utilice el comando '/guardard' para guardar el objeto de su mano derecha, o '/guardari' para guardar el objeto de su mano izquierda.");
		return 1;
	}

	dcmd_guardard(playerid, params[]){
	#pragma unused params
		if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene nada en su mano derecha para guardar.");
		if(ObjetoPesado(BolsilloID[playerid][11])) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no puede guardar ese objeto en su bolsillo.");
		for(new i = 1; i < 11; i++){
		    if(BolsilloID[playerid][i] == 0){

  				if(EsArma(BolsilloID[playerid][11]))
				{
				    ResetPlayerWeapons(playerid);
					SetPlayerArmedWeapon(playerid, 0);
				}
				BolsilloID[playerid][i] = BolsilloID[playerid][11];
				BolsilloTipo[playerid][i] = BolsilloTipo[playerid][11];
				BolsilloCantidad[playerid][i] = BolsilloCantidad[playerid][11];
				BolsilloID[playerid][11] = 0;
				BolsilloTipo[playerid][11] = 0;
				BolsilloCantidad[playerid][11] = 0;
				format(string, sizeof(string), "Usted colocó u%s en su bolsillo #%d.", ObtenerNombreObjeto(BolsilloID[playerid][i]), i);
				Mensaje(playerid, COLOR_BLANCO, string);
		    	ActualizarObjetos(playerid);
	            new sql[16];
       			format(sql, sizeof(sql), "Bol%dID", i);
		    	SaveValue(playerid, sql, BolsilloID[playerid][i]);
		    	format(sql, sizeof(sql), "Bol%dTipo", i);
		    	SaveValue(playerid, sql, BolsilloTipo[playerid][i]);
		    	format(sql, sizeof(sql), "Bol%dCantidad", i);
		    	SaveValue(playerid, sql, BolsilloCantidad[playerid][i]);
	   		 	format(sql, sizeof(sql), "Bol%dID", 11);
		    	SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    	format(sql, sizeof(sql), "Bol%dTipo", 11);
		    	SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    	format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    	SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
				return 1;
	       	}
	    }
		return 1;
	}

    dcmd_guardari(playerid, params[]){
    #pragma unused params
		if(BolsilloID[playerid][12] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene nada en su mano derecha para guardar.");
		if(ObjetoPesado(BolsilloID[playerid][12])) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no puede guardar ese objeto en su bolsillo.");
		for(new i = 1; i < 11; i++){
		    if(BolsilloID[playerid][i] == 0){

				BolsilloID[playerid][i] = BolsilloID[playerid][12];
				BolsilloTipo[playerid][i] = BolsilloTipo[playerid][12];
				BolsilloCantidad[playerid][i] = BolsilloCantidad[playerid][12];
				if(EsArma(BolsilloID[playerid][12])){
				    ResetPlayerWeapons(playerid);
				}
				BolsilloID[playerid][12] = 0;
				BolsilloTipo[playerid][12] = 0;
				BolsilloCantidad[playerid][12] = 0;
				format(string, sizeof(string), "Usted colocó u%s en su bolsillo #%d.", ObtenerNombreObjeto(BolsilloID[playerid][i]), i);
				Mensaje(playerid, COLOR_BLANCO, string);
		    	ActualizarObjetos(playerid);
	            new sql[16];
       			format(sql, sizeof(sql), "Bol%dID", i);
		    	SaveValue(playerid, sql, BolsilloID[playerid][i]);
		    	format(sql, sizeof(sql), "Bol%dTipo", i);
		    	SaveValue(playerid, sql, BolsilloTipo[playerid][i]);
		    	format(sql, sizeof(sql), "Bol%dCantidad", i);
		    	SaveValue(playerid, sql, BolsilloCantidad[playerid][i]);
	   		 	format(sql, sizeof(sql), "Bol%dID", 12);
		    	SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    	format(sql, sizeof(sql), "Bol%dTipo", 12);
		    	SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    	format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    	SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
				return 1;
	       	}
	    }
		return 1;
	}

	dcmd_sacar(playerid, params[]){
	#pragma unused params
		Mensaje(playerid, COLOR_BLANCO, "Utilice el comando '/sacard' para sacar el objeto y tomarlo con su mano derecha, o '/sacari' para sacar el objeto y tomarlo con su mano izquierda.");
		return 1;
	}

	dcmd_sacard(playerid, params[]){
	    new id;
		if(sscanf(params, "i", id)){
		    Mensaje(playerid, COLOR_ERRORES, "[USO] '/sacard' [Espacio]");
		    return 1;
		}
		if(BolsilloID[playerid][11] != 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted tiene su mano derecha ocupada.");
		if(id < 1 || id > 10) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted ha seleccionado un espacio inválido. Seleccione uno del 1 al 10.");
		if(BolsilloID[playerid][id] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] El espacio seleccionado se encuentra vacío.");
		if(BolsilloID[playerid][11] == 0){
		    BolsilloID[playerid][11] = BolsilloID[playerid][id];
		    BolsilloTipo[playerid][11] = BolsilloTipo[playerid][id];
		    BolsilloCantidad[playerid][11] = BolsilloCantidad[playerid][id];
		    if(EsArma(BolsilloID[playerid][11]))
			{
				SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
                SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
			}
			BolsilloID[playerid][id] = 0;
		    BolsilloTipo[playerid][id] = 0;
			BolsilloCantidad[playerid][id] = 0;
			new sql[16];
	 		format(sql, sizeof(sql), "Bol%dID", 11);
		    SaveValue(playerid, sql, BolsilloID[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dTipo", 11);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 11);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
	    	format(sql, sizeof(sql), "Bol%dID", id);
		    SaveValue(playerid, sql, BolsilloID[playerid][id]);
		    format(sql, sizeof(sql), "Bol%dTipo", id);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][id]);
		    format(sql, sizeof(sql), "Bol%dCantidad", id);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][id]);
		    ActualizarObjetos(playerid);
		    format(string, sizeof(string), "Usted sacó u%s del espacio #%d de sus bolsillos y lo puso en su mano derecha.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
		    Mensaje(playerid, COLOR_BLANCO, string);
		    return 1;
		}
		return 1;
	}

	dcmd_sacari(playerid, params[]){
	    new id;
		if(sscanf(params, "i", id)){
		    Mensaje(playerid, COLOR_ERRORES, "[USO] '/sacari' [Espacio]");
		    return 1;
		}
		if(BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted tiene su mano izquierda ocupada.");
		if(id < 1 || id > 10) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted ha seleccionado un espacio inválido. Seleccione uno del 1 al 10.");
		if(BolsilloID[playerid][id] == 0) return Mensaje(playerid, COLOR_BLANCO, "El bolsillo seleccionado se encuentra totalmente desocupado.");
		if(BolsilloID[playerid][12] == 0){
		    BolsilloID[playerid][12] = BolsilloID[playerid][id];
		    BolsilloTipo[playerid][12] = BolsilloTipo[playerid][id];
		    BolsilloCantidad[playerid][12] = BolsilloCantidad[playerid][id];
		    if(EsArma(BolsilloID[playerid][12]))
			{
				SafeGivePlayerWeapon(playerid, BolsilloID[playerid][12], BolsilloCantidad[playerid][12]);
			}
			BolsilloID[playerid][id] = 0;
		    BolsilloTipo[playerid][id] = 0;
			BolsilloCantidad[playerid][id] = 0;
			new sql[16];
	 		format(sql, sizeof(sql), "Bol%dID", 12);
		    SaveValue(playerid, sql, BolsilloID[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dTipo", 12);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		    format(sql, sizeof(sql), "Bol%dCantidad", 12);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
	    	format(sql, sizeof(sql), "Bol%dID", id);
		    SaveValue(playerid, sql, BolsilloID[playerid][id]);
		    format(sql, sizeof(sql), "Bol%dTipo", id);
		    SaveValue(playerid, sql, BolsilloTipo[playerid][id]);
		    format(sql, sizeof(sql), "Bol%dCantidad", id);
		    SaveValue(playerid, sql, BolsilloCantidad[playerid][id]);
		    ActualizarObjetos(playerid);
		    format(string, sizeof(string), "Usted sacó u%s del espacio #%d de sus bolsillos y lo puso en su mano izquierda.", ObtenerNombreObjeto(BolsilloID[playerid][12]));
		    Mensaje(playerid, COLOR_BLANCO, string);
		    return 1;
		}
		return 1;
	}

dcmd_revisarcinturon(playerid, params[])
{
        if(PlayerInfo[playerid][pMember] == 1)
	{
	        new id;
		if(sscanf(params,"d", id))
  		{
  			return SendClientMessage(playerid, -1, "* /revisarcinturon [id]");
  		}
		if(!IsPlayerConnected(id))
		{
		    return SendClientMessage(playerid, -1, "{FF0000}Jugador no conectado.");
		}
		if(!IsPlayerInAnyVehicle(id))
		{
		    return SendClientMessage(playerid, -1, "{FF0000}El jugador debe estar en un vehículo.");
		}

    new Float:x, Float:y, Float:z;
	new PlayerName[24];
	GetPlayerPos(id, x, y, z);
	GetPlayerName(id, PlayerName, 24);
	if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[id] == 1)
	{
	format(string, sizeof(string), "%s está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El Oficial %s ha comprobado que llevas puesto el cinturón de seguridad.", pName(playerid));
	SendClientMessage(id, -1, string);
        format(string, sizeof(string),"* %s comprueba si %s lleva puesto el cinturón de seguridad.", pName(playerid), pName(id));
       	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
 	return 1;
	}
	else if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[id] == 0)
	{
	format(string, sizeof(string), "%s no está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El Oficial %s ha comprobado que no llevas puesto el cinturón de seguridad.", pName(playerid));
	SendClientMessage(id, -1, string);
        format(string, sizeof(string),"* %s comprueba si %s lleva puesto el cinturón de seguridad.",pName(playerid), pName(id));
       	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	return 1;
 	}
	else
	{
 	SendClientMessage(playerid, COLOR_CORAL, "Usted no está cerca de ese jugador.");
	return 1;
	}

	/*format(string, sizeof(string), "* Has desarmado a %s(%d).", pName(id), id);
        SendClientMessage(playerid, -1, string);
        SafeResetPlayerWeaponsAC(id);
        SendClientMessage(id, -1, "* Fuiste desarmado por un admin.");*/
        }
        else
        {
        SendClientMessage(playerid, COLOR_CORAL, "Usted no es un policía.");
        }
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][pJugando] == 0) {SendClientMessage(playerid,Rojo,"Conectate primero"); return 1;}
	//format(string, sizeof(string), "(( [CMDS] %s Utiliza: %s )) |-|", pName(playerid), cmdtext);
    //CMDLog(string);
	printf("Comando: %s Por: %s", cmdtext, pName(playerid));
	dcmd(bolsadinero, 11, cmdtext);
	dcmd(alarmaalazar, 12, cmdtext);
	dcmd(sacarcin, 8, cmdtext);
	dcmd(cin, 3, cmdtext);
	dcmd(espalda, 7, cmdtext);
	dcmd(especial, 8, cmdtext);
	dcmd(armario, 7, cmdtext);
	dcmd(hchatadmin, 10, cmdtext);
	dcmd(esposar, 7, cmdtext);
	dcmd(balasdegoma, 11, cmdtext);
	dcmd(cachear, 7, cmdtext);
	dcmd(qcables, 7, cmdtext);
	dcmd(taser, 5, cmdtext);
	dcmd(dmdamrp1004, 11, cmdtext);
	dcmd(multarcoche, 11, cmdtext);
	dcmd(taller, 6, cmdtext);
	dcmd(editarcolor, 11, cmdtext);
	dcmd(menutaller, 10, cmdtext);
	//dcmd(anunciotest, 11, cmdtext);
	//dcmd(anunciostest, 12, cmdtext);
	dcmd(alimpiar, 8, cmdtext);
	dcmd(bloqueocuenta, 13, cmdtext);
	dcmd(unbanip, 7, cmdtext);
    dcmd(unbanname,9 , cmdtext);

	//dcmd(bol, 3, cmdtext);
	//dcmd(guardar, 7, cmdtext);
	//dcmd(mano, 3, cmdtext);
	dcmd(pagarmulta, 10, cmdtext);
	dcmd(ultimoocupante, 14, cmdtext);
	dcmd(rescatar, 8, cmdtext);
	dcmd(dpr, 3, cmdtext);
	dcmd(qpr, 3, cmdtext);
	dcmd(rpr, 3, cmdtext);
	dcmd(ip, 2, cmdtext);
	dcmd(desarmar, 8, cmdtext);
	dcmd(abrirceldas, 11, cmdtext);
	dcmd(cerrarceldas, 12, cmdtext);
	dcmd(cambiarnombre, 13, cmdtext);
	dcmd(gps, 3, cmdtext);
	dcmd(ajailoff, 8, cmdtext);
	dcmd(ajailic, 7, cmdtext);
	dcmd(barrerafd, 9, cmdtext);
	dcmd(revisarcinturon, 15, cmdtext);
	dcmd(sir, 3, cmdtext);
	dcmd(barraluces, 10, cmdtext);
	dcmd(boombox, 7, cmdtext);
    //dcmd(mano, 4, cmdtext);
    //dcmd(usar, 4, cmdtext);
    dcmd(obtenerarmas, 12, cmdtext);
    dcmd(recoger, 7, cmdtext);
    dcmd(recogerd, 8, cmdtext);
    dcmd(recogeri, 8, cmdtext);
    
    
	dcmd(abus, 4, cmdtext);
	dcmd(abus2, 5, cmdtext);
	dcmd(abus3, 5, cmdtext);
	dcmd(abus4, 5, cmdtext);
	dcmd(apoli1, 6, cmdtext);
	dcmd(apoli2, 6, cmdtext);
	dcmd(apoli3, 6, cmdtext);
	dcmd(apoli4, 6, cmdtext);
	dcmd(apoli5, 6, cmdtext);
	
	dcmd(anpcs, 5, cmdtext);
	dcmd(barriolujoso, 12, cmdtext);
	
	dcmd(bolsillos, 9, cmdtext);
	dcmd(bol, 3, cmdtext);
	dcmd(mano, 4, cmdtext);
	dcmd(usar, 4, cmdtext);
	dcmd(guardard, 8, cmdtext);
	dcmd(guardar, 7, cmdtext);
	dcmd(sacar, 5, cmdtext);
	dcmd(guardari, 8, cmdtext);
	dcmd(sacard, 6, cmdtext);
	dcmd(sacari, 6, cmdtext);
	dcmd(crearobjeto, 11, cmdtext);
	dcmd(equipamiento, 12, cmdtext);
	dcmd(mal, 3, cmdtext);
	dcmd(tirari, 6, cmdtext);
	dcmd(tirard, 6, cmdtext);
	dcmd(ofrecer, 7, cmdtext);
	dcmd(ofrecerd, 8, cmdtext);
	dcmd(ofreceri, 8, cmdtext);
	dcmd(aceptarobjeto, 13, cmdtext);
	//dcmd(scanner, 7, cmdtext);
	if(Cmds_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Trabajos_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Negocios_OnPlayerCommandText(playerid, cmdtext)) return 1; 
	if(Vehicles_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Admin_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Facciones_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Texto_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Tunning_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Sis_Cos_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Sis_Pes_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(LimpiaC_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Basura_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Slide_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Autoesc_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Policia_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(GPS_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Parking_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Casas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Accesorios_OnPlayerCommandText(playerid, cmdtext)) return 1;
	//if(Luces_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Medicos_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Radio_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Uniformes_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Taxis_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Horas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	//if(Velocimetro_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Drogas_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Pizza_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Detective_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Docu_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Tlf_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Reparto_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Ambulan_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Ladron_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Comidas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Paintball_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Reporteros_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Puertas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Anims_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Gafas_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(Cascos_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(MisBand_OnPlayerCommandText(playerid,cmdtext)) return 1;
	/*if(puntero_OnPlayerCommandText(playerid, cmdtext)) return 1;*/
	if(nieve_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Lot_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Carreras_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Bandana_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Low_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Ascensor_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Muebles_OnPlayerCommandText(playerid, cmdtext)) return 1;
	//if(Velocimetro_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Speedcap_OnPlayerCommandText(playerid, cmdtext)) return 1;
	/*if(Gangs_OnPlayerCommandText(playerid, cmdtext)) return 1;*/
	//if(Cinturon_OnPlayerCommandText(playerid, cmdtext)) return 1;
	
	
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if (strcmp("/cinturon", cmdtext, true, 9) == 0 || strcmp("/casco", cmdtext, true, 7) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && Cinturon[playerid] == 0)
		{
		    if(IsABike(vehicleid))
		    {
		        Cinturon[playerid] = 1;
		        SendClientMessage(playerid, COLOR_GREEN, "Te has puesto un casco.");
		        return 1;
			}
			else
			{
			    Cinturon[playerid] = 1;
			    SendClientMessage(playerid, COLOR_GREEN, "Te has colocado el cinturón, esto te cuidará de colisiones.");
		    if(Usando[playerid] == 1)
		    {
      		format(string, sizeof(string), "* [Extrano:%d] se colocó su cinturón de seguridad.", extranoid[playerid]);
      		}
      		else
      		{
   			format(string, sizeof(string), "* %s se colocó su cinturón de seguridad.", pName(playerid));
      		}
       			ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);

				return 1;
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && Cinturon[playerid] == 1)
		{
		    if(IsABike(vehicleid))
		    {
		        Cinturon[playerid] = 0;
		        SendClientMessage(playerid, COLOR_GREEN, "Te has quitado el casco, ten cuidado con las colisiones");
				return 1;
			}
			else
			{
			    Cinturon[playerid] = 0;
			    SendClientMessage(playerid, COLOR_GREEN, "Te has quitado el cinturón, ten cuidado con las colisiones.");
		    	if(Usando[playerid] == 1)
		    	{
      			format(string, sizeof(string), "* [Extrano:%d] se quitó el cinturón de seguridad", extranoid[playerid]);
      			}
      			else
      			{
   				format(string, sizeof(string), "* %s se quitó el cinturón de seguridad", pName(playerid));
      			}
       			ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_CORAL, "No estas en un coche");
		    return 1;
		}
	}
	if(Bomberos_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(LicFalsas_OnPlayerCommandText(playerid, cmdtext)) return 1;
    new cmd[128];
	new tmp[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/salir", true) == 0)
	{
		Comando_Salir(playerid);
	}
	if(strcmp(cmd, "/crearhq", true) == 0)
	{
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, COLOR_GRAD1, "USO: /crearhq [ID FACCION]");
	        return 1;
	    }
	    new faccionid = strval(tmp);
	    new sql[80], row[512], id;
	    if(PlayerInfo[playerid][pAdmin] < 6)
	    {
	        SendClientMessage(playerid, COLOR_LIGHTRED, "Insuficientes Permisos!");
	        return 1;
	    }

	    
    	

		format(sql, 80, "INSERT INTO headquarters (Nombre) VALUES ('HQ')");
		mysql_query(sql);

		format(sql, sizeof(sql), "SELECT COUNT(*) FROM headquarters");
		mysql_query(sql);
		mysql_store_result();
		mysql_fetch_row(row);
		id = strval(row);

		HeadQuarterInfo[id][hqFaccion] = faccionid;
		HeadQuarterInfo[id][hqLocked] = 0;
		HeadQuarterInfo[id][hqCajaFuerte] = 0;
		format(HeadQuarterInfo[id][hqName], 128, "HQ Numero %d", id);
		new Float:X[MAX_PLAYERS], Float:Y[MAX_PLAYERS], Float:Z[MAX_PLAYERS];
  		GetPlayerPos(playerid, X[playerid],Y[playerid],Z[playerid]);
  		HeadQuarterInfo[id][hqEPos_x] = X[playerid];
  		HeadQuarterInfo[id][hqEPos_y] = Y[playerid];
  		HeadQuarterInfo[id][hqEPos_z] = Z[playerid];
		HeadQuarterInfo[id][hqSPos_x] = 2169.7097;
  		HeadQuarterInfo[id][hqSPos_y] = 1618.2808;
    	HeadQuarterInfo[id][hqSPos_z] = 999.9766;
     	HeadQuarterInfo[id][hqInterior] = 1;

		SaveHeadQuarter(id);

		HeadQuarterInfo[id][hqPickup] = CreatePickup(1273, 23,X[playerid],Y[playerid],Z[playerid]);
		return 1;
	}

	if(strcmp(cmd, "/edithq", true) == 0)
	{
	    if(PlayerInfo[playerid][pAdmin] < 6)
	    {
	        SendClientMessage(playerid, COLOR_LIGHTRED, "Permisos Insuficientes!");
	        return 1;
	    }

	    tmp = strtokex(cmdtext, idx);
     	if(!strlen(tmp))
      	{
       		SendClientMessage(playerid, COLOR_GRAD1, "USO: /edithq [Campo]");
			SendClientMessage(playerid, COLOR_GRAD2, "Campos Disponibles: Posicion, Nombre, Faccion, Interior");
			return 1;
		}

		if(strcmp(tmp, "Posicion", true) == 0)
		{
			for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
   				if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
       				MoviendoHQ[playerid] = i;
			        break;
				}
			}
			SendClientMessage(playerid, COLOR_GRAD1, "Estas moviendo el HQ, escribe 'OK' cuando termines.");
			return 1;
		}

		else if(strcmp(tmp, "Nombre", true) == 0)
		{
			for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
   				if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
       				EditingHQ[playerid] = i;
       				break;
				}
			}
			SendClientMessage(playerid, COLOR_GRAD1, "Escribe un nuevo nombre para el Negocio.");
			return 1;
		}

		else if(strcmp(tmp, "Faccion", true) == 0)
		{
		    tmp = strtokex(cmdtext, idx);
     		if(!strlen(tmp))
      		{
      		    SendClientMessage(playerid, COLOR_GRAD1, "USO: /edithq faccion [ID]");
   				return 1;
			}
			new id;
			id = strval(tmp);
			for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
   				if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
			        HeadQuarterInfo[i][hqFaccion] = id;
			        SaveHeadQuarter(i);
			        format(string, 128, "Listo! Cambiaste la faccion del HQ a '%d'", id);
					break;
				}
			}
			SendClientMessage(playerid, COLOR_GRAD1, string);
			return 1;
		}

		else if(strcmp(tmp, "Eliminar", true) == 0)
		{
			for(new i = 1; i < sizeof(HeadQuarterInfo); i++)
			{
			    if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
			        format(string, 128, "DELETE FROM headquarters WHERE id = %d LIMIT 1", i);
			        mysql_query(string);
			        HeadQuarterInfo[i][hqEPos_x] = NOEXISTE;
			        HeadQuarterInfo[i][hqEPos_y] = NOEXISTE;
			        HeadQuarterInfo[i][hqEPos_z] = NOEXISTE;
			        DestroyPickup(HeadQuarterInfo[i][hqPickup]);
					break;
				}
			}
		}

		else if(strcmp(tmp, "Interior", true) == 0)
		{
		    tmp = strtokex(cmdtext, idx);
		    if(!strlen(tmp))
		    {
		        SendClientMessage(playerid, COLOR_GRAD1, "USO: /edithq Interior [1-10]");
				return 1;
			}
			new inter;
			inter = strval(tmp);
			for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
   				if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
					switch(inter)
					{
					    case 1:
					    {//Almacen
					        HeadQuarterInfo[i][hqSPos_x] = 2169.7097;
					        HeadQuarterInfo[i][hqSPos_y] = 1618.2808;
					        HeadQuarterInfo[i][hqSPos_z] = 999.9766;
					        HeadQuarterInfo[i][hqInterior] = 1;
					    }
					    case 2:
					    {//Yakuza
     						HeadQuarterInfo[i][hqSPos_x] = -2158.3904;
					        HeadQuarterInfo[i][hqSPos_y] = 642.8716;
					        HeadQuarterInfo[i][hqSPos_z] = 1052.37503;
					        HeadQuarterInfo[i][hqInterior] = 1;
					    }
					    case 3:
					    {//Crack Factory
					        HeadQuarterInfo[i][hqSPos_x] = 2541.5452;
					        HeadQuarterInfo[i][hqSPos_y] = -1304.0278;
					        HeadQuarterInfo[i][hqSPos_z] = 1025.0703;
					        HeadQuarterInfo[i][hqInterior] = 2;
					    }
					    case 4:
					    {//World of Coq
					        HeadQuarterInfo[i][hqSPos_x] = 1298.8153;
					        HeadQuarterInfo[i][hqSPos_y] = -796.4667;
					        HeadQuarterInfo[i][hqSPos_z] = 1084.0078;
					        HeadQuarterInfo[i][hqInterior] = 5;
					    }
					    case 5:
					    {//OG Locs
					        HeadQuarterInfo[i][hqSPos_x] = 2468.4890;
					        HeadQuarterInfo[i][hqSPos_y] = -1698.2606;
					        HeadQuarterInfo[i][hqSPos_z] = 1013.5078;
					        HeadQuarterInfo[i][hqInterior] = 2;
					    }
					    case 6:
						{//CJ
						    HeadQuarterInfo[i][hqSPos_x] = 744.4197;
					        HeadQuarterInfo[i][hqSPos_y] = 1437.0017;
					        HeadQuarterInfo[i][hqSPos_z] = 1102.7031;
					        HeadQuarterInfo[i][hqInterior] = 6;
						}
						case 7:
						{//Michelle Room
						    HeadQuarterInfo[i][hqSPos_x] = 318.5758;
					        HeadQuarterInfo[i][hqSPos_y] = 1114.9524;
					        HeadQuarterInfo[i][hqSPos_z] = 1083.8828;
					        HeadQuarterInfo[i][hqInterior] = 5;
						}
						case 8:
						{//Rural
						    HeadQuarterInfo[i][hqSPos_x] = 2332.9749;
					        HeadQuarterInfo[i][hqSPos_y] = -1076.9150;
					        HeadQuarterInfo[i][hqSPos_z] = 1049.0234;
					        HeadQuarterInfo[i][hqInterior] = 6;
						}
						case 9:
						{//Lujo
						    HeadQuarterInfo[i][hqSPos_x] = 2324.2869;
					        HeadQuarterInfo[i][hqSPos_y] = -1149.3607;
					        HeadQuarterInfo[i][hqSPos_z] = 1050.7101;
					        HeadQuarterInfo[i][hqInterior] = 12;
						}
						case 10:
						{//Mansion
						    HeadQuarterInfo[i][hqSPos_x] = 225.9950;
					        HeadQuarterInfo[i][hqSPos_y] = 1021.4445;
					        HeadQuarterInfo[i][hqSPos_z] = 1084.0177;
					        HeadQuarterInfo[i][hqInterior] = 7;
						}
						default:
						{
						    SendClientMessage(playerid, COLOR_GRAD1, "USO: /edithq Interior [1-7]");
							return 1;
						}
					}
					SaveHeadQuarter(i);
					break;
				}
			}
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Listo Cambiaste el Interior del HQ");
		}
		return 1;
	}
	if(strcmp(cmd, "/aprender", true) == 0)
	{
    if(!PlayerToPoint(30.0,playerid,766.0836,7.7020,1000.7137)) return SendClientMessage(playerid,Rojo,"No estás en el gimnasio");
    ShowPlayerDialog(playerid,DIALOGO_BOXEO,DIALOG_STYLE_LIST,"Gimnasio de Los Angeles","Aprender Boxeo ($3000)\nAprender Kung Fu ($3000)\nAprender Knee Head ($3000)\nAprender Grab Kick ($3000)\nAprender Elbow ($3000)", "Adquirir", "Cancelar");
	}
	
	
	if(strcmp(cmd, "/cochecarcel", true) == 0)
	{
    if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres policía");
    if(!PlayerToPoint(6.0,playerid,1827.5289,-1538.7140,13.5402)) return SendClientMessage(playerid,Rojo,"No estás en la entrada");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Rojo,"No estás en un vehículo");
    new veh = GetPlayerVehicleID(playerid);
    SetVehiclePos(veh,1818.6323,-1537.1168,13.3772);
    SetVehicleZAngle(veh,83.5838);
    
	}
	if(strcmp(cmd, "/salircochecarcel", true) == 0)
	{
    if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres policía");
    if(!PlayerToPoint(6.0,playerid,1818.6323,-1537.1168,13.3772)) return SendClientMessage(playerid,Rojo,"No estás en la salida");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Rojo,"No estás en un vehículo");
    new veh = GetPlayerVehicleID(playerid);
    SetVehiclePos(veh,1827.5289,-1538.7140,13.5402);
    SetVehicleZAngle(veh,264.1395);

	}
	
	
		if(strcmp(cmd, "/garajepd", true) == 0)
	{
    if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres policía");
    //if(!PlayerToPoint(4.0,playerid,910.6436,-1291.6317,9.6193) || !PlayerToPoint(6.0,playerid,899.6417,-1286.7001,7.3607) ) return SendClientMessage(playerid,Rojo,"No estás en la entrada");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Rojo,"No estás en un vehículo");
    new veh = GetPlayerVehicleID(playerid);
    if(PlayerToPoint(4.0,playerid,910.6436,-1291.6317,9.6193))
    {
    SetVehiclePos(veh,899.6417,-1286.7001,7.3607);
    SetVehicleZAngle(veh,88.1206);
	}
	else if(PlayerToPoint(4.0,playerid,899.6417,-1286.7001,7.3607))
    {
    SetVehiclePos(veh,909.8087,-1290.7346,9.3745);
    SetVehicleZAngle(veh,221.3465);
	}
	else if(PlayerToPoint(4.0,playerid,858.5097,-1233.6482,7.0842))
    {
    SetVehiclePos(veh,870.2632,-1233.0436,6.0037);
    SetVehicleZAngle(veh,270.4023);
	}
	else if(PlayerToPoint(4.0,playerid,870.2632,-1233.0436,6.0037))
    {
    SetVehiclePos(veh,859.6077,-1233.9462,6.8983);
    SetVehicleZAngle(veh,91.6918);
	}
	
	}
	if(strcmp(cmd, "/bloquearpeajes", true) == 0)
	{
	if(!IsACop(playerid)) return SendClientMessage(playerid,Rojo,"No eres policía");
	if(bloqueopeajes==1) return SendClientMessage(playerid,Rojo,"Los peajes ya estan bloqueados usa /abrirpeajes");
	SendClientMessage(playerid,Amarillo,"Has bloqueado todos los peajes de Los Angeles");
	bloqueopeajes = 1;
	format(string,sizeof(string),"[CENTRAL] Todas las salidas vía PEAJE han sido bloqueadas por %s",pName(playerid));
	SendFamilyMessage(1,Azul,string);
	return 1;
	}
	
	if(strcmp(cmd, "/abrirpeajes", true) == 0)
	{
	if(!IsACop(playerid)) return SendClientMessage(playerid,Rojo,"No eres policía");
	if(bloqueopeajes==0) return SendClientMessage(playerid,Rojo,"Los peajes ya estan desbloqueados usa /bloquearpeajes");
	SendClientMessage(playerid,Amarillo,"Has desbloqueado todos los peajes de Los Angeles");
	bloqueopeajes = 0;
	format(string,sizeof(string),"[CENTRAL] Todas las salidas vía PEAJE han sido desbloqueadas por %s",pName(playerid));
	SendFamilyMessage(1,Azul,string);
	return 1;
	}
	/*if(strcmp(cmd, "/taser", true) == 0)
	{
	if(PlayerInfo[playerid][pMember] == 1)
	{
	if(PlayerInfo[playerid][pRank] == 1) return SendClientMessage(playerid,Rojo,"Eres Cadete, tu taser debes tomarlo en el equipamiento.");
	if(TieneTaser[playerid] == 0)
    {
	SafeGivePlayerWeapon(playerid, 23, 500);
	TieneTaser[playerid] = 1;
	AutoRol(playerid,"saca su taser y lo carga");
	}
	else if(TieneTaser[playerid] == 1)
	{
	SafeGivePlayerWeapon(playerid, 24, 500);
    TieneTaser[playerid] = 0;
    AutoRol(playerid,"guarda su taser");
	}
	}
	return 1;
	}*/

	/*if(strcmp(cmd, "/tazer", true) == 0)
	{
	if(PlayerInfo[playerid][pMember] == 1)
	{
	if(TazerVar[playerid]==0)
	{
	 SafeGivePlayerWeapon(playerid,23,90);
	 format(string, 128, "* %s retira su tazer y lo carga.", pName(playerid));
	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	TazerVar[playerid] = 1;

	}
	else if(TazerVar[playerid]==1)
	{
	RemovePlayerWeapon(playerid,23);
    format(string, 128, "* %s guarda su tazer.", pName(playerid));
			ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
			TazerVar[playerid] = 0;
	}



	}


	return 1;
	}*/

	if(strcmp(cmd, "/chaoserver", true) == 0)
	{
		SendRconCommand("exit");
	}
	if(strcmp(cmd, "/chaoserver", true) == 0)
	{
		SendRconCommand("exit");
	}
	if(strcmp(cmd, "/damecigarros", true) == 0)
	{
		AddItem(playerid,"Cigarrillos",5);
	}
	
    if(strcmp(cmd, "/damepistola", true) == 0)
	{
		AddItem(playerid,"Pistola",1);
	}
	if(strcmp(cmd, "/gfd", true) == 0)
	{
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Amarillo,"No estás en un auto");
	new veh = GetPlayerVehicleID(playerid);
	if(PlayerToPoint(3.0,playerid,498.3503,240.0694,1020.7260))
	{
    SalidaBombero(playerid,veh,1);
	}
	else if(PlayerToPoint(3.0,playerid,487.6516,239.9947,1020.7260))
	{
	SalidaBombero(playerid,veh,2);
	}
	else if(PlayerToPoint(3.0,playerid,477.0507,239.8305,1020.7260))
	{
	SalidaBombero(playerid,veh,3);
	}
	}
	if(strcmp(cmd, "/efd", true) == 0)
	{
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Amarillo,"No estás en un auto");
	new veh = GetPlayerVehicleID(playerid);
	if(PlayerToPoint(3.0,playerid,1351.3739,-1635.6384,13.3991))
	{
    EntradaBombero(playerid,veh,1);
	}
	else if(PlayerToPoint(3.0,playerid,1349.7943,-1645.5375,13.7034))
	{
	EntradaBombero(playerid,veh,2);
	}
	else if(PlayerToPoint(3.0,playerid,1349.5012,-1653.6113,13.7034))
	{
	EntradaBombero(playerid,veh,3);
	}
	}
    /*if(strcmp(cmd, "/veranuncios", true) == 0 || strcmp(cmd, "/informativos", true) == 0)
	{
	MostrarAnuncios(playerid);
	return 1;
	}*/

	
	
/*	if(strcmp(cmd, "/anuncio", true) == 0) //Pos 647.8347,-1357.8492,13.57508
	{
	if(PlayerInfo[playerid][pMember]==1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 9 )
	{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
   			if(SinSonido[playerid] == 0)
		    {

		        LuzSS[0][vehicleid] = CreateDynamicObject(19292,0.0,0.0,0.0,0.0,0.0,0.0);//Azul
		        LuzSS[1][vehicleid] = CreateDynamicObject(19290,0.0,0.0,0.0,0.0,0.0,0.0);//Rojo
		        if(GetVehicleModel(vehicleid) == 523) //Moto
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,0.1,0.8,0.4,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,-0.2,0.8,0.4,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 427) //Camión
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,-0.5,1.0,1.2,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,0.5,1.0,1.2,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 596) //Patrulla
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 598) //Patrulla
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 525) // Grua
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,-0.5,-0.5,1.5,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,0.5,-0.5,1.5,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 402) //Buffalo
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
		        }
		        else if(GetVehicleModel(vehicleid) == 560) //Sultan
		        {
		            AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
		        }
		         else if(GetVehicleModel(vehicleid) == 490) //Ranchera
		        {
		        AttachDynamicObjectToVehicle(LuzSS[0][vehicleid],vehicleid,-0.5,-0.5,1.2,0.0,0.0,0.0);
		        	AttachDynamicObjectToVehicle(LuzSS[1][vehicleid],vehicleid,0.5,-0.5,1.2,0.0,0.0,0.0);
		        }
		        else return SendClientMessage(playerid, 0xAFAFAFAA, "Este vehículo no tiene sirena.");
		        SinSonido[playerid] = 1;
		        return 1;
		    }
		    if(SinSonido[playerid] == 1)
		    {
		        DestroyDynamicObject(LuzSS[0][vehicleid]);
		        DestroyDynamicObject(LuzSS[1][vehicleid]);
		        SinSonido[playerid] = 0;
				return 1;
		    }
		}
	
	}
	return 1;
	}*/



	if(strcmp(cmd, "/entrargaraje", true) == 0)
	{
	if(IsACop(playerid) && PlayerToPoint(5.0,playerid,863.3674,-1238.7362,6.2306))
	{
	SetPlayerPos(playerid,866.5241,-1238.2990,6.0037);
	}
	return 1;
	}
	if(strcmp(cmd, "/salirgaraje", true) == 0)
	{
	if(IsACop(playerid) && PlayerToPoint(5.0,playerid,866.5241,-1238.2990,6.0037))
	{
	SetPlayerPos(playerid,863.3674,-1238.7362,6.2306);
	}
	return 1;
	}
	
	if(strcmp(cmd, "/entrarcarcel", true) == 0)
	{
	if(IsACop(playerid) && PlayerToPoint(5.0,playerid,2580.0894,-1325.8868,1047.9634))
	{
	SetPlayerPosEx(playerid,2583.8286,-1325.6830,1047.9634);
	}
	return 1;
	}
	if(strcmp(cmd, "/salircarcel", true) == 0)
	{
	if(IsACop(playerid) && PlayerToPoint(5.0,playerid,2583.8286,-1325.6830,1047.9634))
	{
	SetPlayerPosEx(playerid,2580.0894,-1325.8868,1047.9634);
	}
	return 1;
	}
	if(strcmp(cmd, "/entrar", true) == 0)
	{
	    Comando_Entrar(playerid);
	}
	
	if(strcmp(cmd, "/dado", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new dice = random(6)+1;
			if (PlayerInfo[playerid][pDado] == 1)
			{
				format(string, sizeof(string), "* %s tira el dado y cae sobre %d", pName(playerid),dice);
				ProxDetector(5.0, playerid, string, Verde, Verde, Verde, Verde, Verde);
			}
			else
			{
				SendClientMessage(playerid, Gris, "   No tienes un dado");
				return 1;
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/pagar", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /pagar [PlayerID] [$$]");
			return 1;
		}
		
		new player;
		player = ReturnUser(tmp);
		
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /pagar [PlayerID] [$$]");
			return 1;
		}	
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, Blanco, "USO: /pagar [PlayerID] [$$]");
		if(GetPlayerLevel(playerid) < 2) return SendClientMessage(playerid, Blanco, "¡Tienes que ser por lo menos, nivel 2!");
		new dinero;
		dinero = strval(tmp);
		
		if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pPagandole]) > 8.0) return SendClientMessage(playerid, Rojo, "* Estás muy lejos de él.");
		
		if(dinero > SafeGetPlayerMoney(playerid)) return SendClientMessage(playerid, Rojo, "* No tienes tanto dinero en mano.");
		if(0 < dinero <= 4000 && playerid != player)
		{
			PlayerInfo[player][pPagandole] = playerid;
			PlayerInfo[player][pPagandoDin] = dinero;
			
			format(string, 128, "* %s te quiere pagar $%d. ¿Aceptas? /aceptar dinero", pName(playerid), dinero);
			SendClientMessage(player, Amarillo, string);
			format(string, 128, "* Has ofrecido $%d a %s. Esperando su respuesta.", dinero, pName(player));
			SendClientMessage(playerid, Amarillo, string);
		}
		else return SendClientMessage(playerid,Rojo,"No puedes pagar más de 4000 o pagarte a ti mismo");
		return 1;		
	}
	if(strcmp(cmd, "/llamar", true) == 0)
	{
		if(PlayerInfo[playerid][pPnumber] == 0 && BolsilloID[playerid][11] != 89) return SendClientMessage(playerid,COLOR_ERRORES,"¡No tienes un teléfono o no tienes línea!");
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
		    SendClientMessage(playerid, Blanco, "USO: /llamar [número/servicio]");
		    SendClientMessage(playerid, Blanco, "Servicios disponibles: Pizza, Taxi, Mecanico, Emergencias, Anuncios");
		    return 1;
		}
		if(PlayerInfo[playerid][pUsandoTelefono] != 0) return SendClientMessage(playerid, Rojo, "* Ya estas utilizando el movil.");
		
        if (strcmp(tmp,"pizza",true)==0)
        {
            PlayerInfo[playerid][pHablandoPizza] = 1;
            SendClientMessage(playerid,Amarillo,"(Teléfono): Well Stacked Pizza, que tipo de pizza desea?");
            SendClientMessage(playerid,Amarillo,"(Teléfono): Tenemos margarita, barbacoa y 4 quesos");
            SendClientMessage(playerid, Gris, "PISTA: Escribe 'Nada' para cancelar la compra.");
            return 1;
        }
		else if (strcmp(tmp,"taxi",true)==0)
        {
			if(GetPlayerInterior(playerid) > 0) return SendClientMessage(playerid,Naranja,"* No puedes pedir un taxi estando en un interior");
			if(Taxistas < 1)
			{
				SendClientMessage(playerid,Amarillo, "(Teléfono): Transporte público de Los Angeles.");
				SendClientMessage(playerid,Amarillo,"(Teléfono): Todos nuestros taxistas están ocupados.");
				Taxistas=0;
			}
			else
			{
				SendClientMessage(playerid,Amarillo,"(Teléfono): Transporte público de Los Angeles.");
				SendClientMessage(playerid,Amarillo,"(Teléfono): Mandaremos un aviso a nuestros taxistas. Permanezca en esa localización.");
				for(new i; i < MAX_PLAYERS; i++)
				{
					if(!IsPlayerConnected(i)) continue;
					//if(i == playerid) continue;
					
					if(Taxista[i][taestado] > 0)
					{
						if(PlayerInfo[i][pEstadoTaxista] == 0)
						{
							PlayerInfo[i][pEstadoTaxista] = 1;
							PlayerInfo[i][pClienteTaxista] = playerid;
							new ZoneName[128];
							GetPlayer2DZone(playerid, ZoneName, 128);
							format(string,sizeof(string),"* Alguien ha pedido un taxi en %s.  Usa /aceptar taxi para atender.", ZoneName);
							SendClientMessage(i, Amarillo, string);
						}
					}
				}
			}
            return 1;
        }
		else if (strcmp(tmp,"emergencias",true)==0)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: Indique el servicio que necesita, ¿Policia , Medico o Bombero?");
			PlayerInfo[playerid][pUsandoTelefono] = 911;
			return 1;
		}
		else if (strcmp(tmp,"Anuncios", true) == 0)
		{
			if(PlayerInfo[playerid][pBank] < 200) return SendClientMessage(playerid, Rojo, "* No tienes suficiente dinero en el banco para hacer anuncios.");
			//if(GetPlayerLevel(playerid) < 3) return SendClientMessage(playerid, Rojo, "* Nivel insuficiente!");
			if(AnuncioTimer == 1){ SendClientMessage(playerid, Gris, "Comunicando..."); return SendClientMessage(playerid, AmarilloClaro, "Parece ser que la agencia de anuncios está ocupada en estos momentos, intentalo de nuevo más tarde!");}
			SendClientMessage(playerid, Amarillo, "Servicio de publicidad de Los Angeles");
			SendClientMessage(playerid, AmarilloClaro, "Ingrese un texto que quiera anunciar. Le costara $200");
			PlayerInfo[playerid][pUsandoTelefono] = 575;
			return 1;
		}
		else if (strcmp(tmp,"mecanico",true)==0)
        {
			if(GetPlayerInterior(playerid) > 0) return SendClientMessage(playerid,Naranja,"* No puedes pedir un mecanico estando en un interior");
            SendClientMessage(playerid,Amarillo,"(Teléfono): Talleres de Los Angeles.");
            SendClientMessage(playerid,Amarillo,"(Teléfono): Mandaremos un aviso a nuestros mecanicos. Permanezca en esa localización.");
			for(new i; i < MAX_PLAYERS; i++)
			{
				if(!IsPlayerConnected(i)) continue;
				if(i == playerid) continue;

				if(PlayerInfo[i][pJob] == 1 && PlayerInfo[i][pDuty] > 0)
				{
					if(PlayerInfo[i][pEstadoMecanico] == 0)
					{
						PlayerInfo[i][pEstadoMecanico] = 1;
						PlayerInfo[i][pClienteMecanico] = playerid;
						SendClientMessage(i, Amarillo, "* Tenemos una llamada entrante. Usa /aceptar mecanico para atender.");
					}
				}
			}
            return 1;
        }
		/*else if(strcmp(tmp,"armas",true)==0 && CocheOcupado == 0 && PlayerInfo[playerid][pMember] > 19 && PlayerInfo[playerid][pMember] < 41 && PlayerInfo[playerid][pRank] > 4)
		{
		    CocheOcupado = 1;
		    PlayerInfo[playerid][pHablandoArmas] = 1;
		    SendClientMessage(playerid, Amarillo, "(Teléfono): ¿Qué pipa necesitas ahora?");
		    SendClientMessage(playerid, Amarillo, "(Teléfono): Tengo 9mm ($600), Mac10 ($1200), Escopeta ($800), Navaja ($50), Katana ($5000),");
			SendClientMessage(playerid, Amarillo, "(Teléfono): Molotov ($1000), Eagle ($700), Recortada ($1000), Spas10 ($10000), MP5 ($3000), AK47 y M4");
			SendClientMessage(playerid, Amarillo, "(Teléfono): AK47 ($8000), M4 ($12000), Sniper ($25000)");
		    SendClientMessage(playerid, Gris, "PISTA: Escribe 'Nada' para cancelar la compra.");
            return 1;
		}*/
        
        else if (strcmp(tmp,"desguace",true)==0 && PlayerInfo[playerid][pJob] == 11 && PlayerInfo[playerid][pHabilidadLadron] >= 50)
        {
            if(gettime() < PlayerInfo[playerid][TiempoEsperaTrabajo])
            {
                format(string,sizeof(string),"* Tienes que esperar %d minutos para seguir trabajando.",(PlayerInfo[playerid][TiempoEsperaTrabajo]-gettime())/60);
                SendClientMessage(playerid,Naranja,string);
                return 1;
            }

            if (!IsPlayerInAnyVehicle(playerid)) { SendClientMessage(playerid, Rojo, "* Tienes que estar en un coche robado"); return 1; }
        
            if (!PlayerHaveKeys(playerid,GetPlayerVehicle(playerid)) && CarInfo[GetPlayerVehicle(playerid)][cOwned]==1)
            {
                SendClientMessage(playerid,Amarillo,"(Teléfono): ¿Dices que tienes un coche para mi? Espero que no sea una chatarra.");
                SendClientMessage(playerid,Amarillo,"(Teléfono): Ahora te marco el lugar de la entrega, no tardes.");
                SendClientMessage(playerid, Gris, "Acude a la posicion marcada");
                new i=random(3);
                SetPlayerCheckpoint(playerid,PuntosEntrega[i][0],PuntosEntrega[i][1],PuntosEntrega[i][2],8.0);
                PlayerInfo[playerid][pCheckpoint]=11;
                PlayerInfo[playerid][pTrabajandoCP]=1;

            }
            else
            {
                SendClientMessage(playerid, Gris, "* No puedes entregar ese coche");
            }
            return 1;
        }

		else if(strcmp(tmp,"noticias",true)==0)
		{
			new mensaje[80];
			if(PlayerInfo[playerid][pUsandoTelefono] >= 1) return SendClientMessage(playerid, Rojo, "* Estás en una llamada.");
  			if(NewsOn==1)
			{
				if(CallNews==1 || Programa[playerid] == 0)
				{
        			for(new i = 0; i<MAX_PLAYERS; i++)
        			{
						// Hay alguna llamada atendiéndose? (Programa[i]=2)
						new tmpocupado = 0;
						for (new j=0; j < MAX_PLAYERS; j++)
							if (Programa[j]==2)
							{
								tmpocupado = 1;
								break;
							}

						if (tmpocupado == 0)
            	    		format(string, sizeof(string), "Estás llamando al Programa, espera que te contesten...");
						else
            	    		format(string, sizeof(string), "Estás llamando al Programa, hay una llamada en antena, te piden esperar...");
	         			
						SendClientMessage(playerid,Verde, string);
						Programa[playerid]=1;
						if(PlayerInfo[i][pMember] == 4 && Programa[playerid]==1 && Programa[playerid]==1)
          				{
							format (mensaje, 80, "Están llamando al Programa usa \"/llamadas %d para dar paso al oyente", playerid);
	          	    		SendClientMessage(i,Verde, mensaje);
							return 1;
  						}
         			}
         			SendClientMessage(playerid,Verde, string);
				}
				else
				{
				    SendClientMessage(playerid,Rojo,"Los Teléfonos de Los Angeles News están apagados o ya estas llamándolos!");
				}
			}
			else
			{
	    		SendClientMessage(playerid,Rojo,"No hay ningún programa en el Aire!");
			}
            return 1;
		}
/*		else if (!IsNumeric(tmp))
		{
			LlamarTelefono(playerid, Agenda(playerid, 4, tmp, ""));
			return 1;
		}*/
		
		new numerotlf;
		numerotlf = strval(tmp);
		if(numerotlf > 1000 && numerotlf <= 999999)
		{
			LlamarTelefono(playerid, numerotlf);
			return 1;
		}
/*		else if(numerotlf >= 0 && numerotlf <= 499)
		{
			LlamarTelefono(playerid, Agenda(playerid, 4, "", tmp));
			return 1;
		}*/
		else
		{
		    SendClientMessage(playerid, Gris, "* Escuchas el tono de ocupado...");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/colgar", true) == 0)
	{
	
			ColgarTelefono(playerid);
	
		return 1;
	}
		if(strcmp(cmd, "/info", true) == 0)
	{
	    for(new i = 0; i < sizeof(NegocioInfo); i++)
		{
			if(PlayerToPoint(2.0, playerid, NegocioInfo[i][nEPos_x], NegocioInfo[i][nEPos_y], NegocioInfo[i][nEPos_z]))
   			{
   			    new acciones = NegocioInfo[i][nCosto]/10;
   			    format(string, 128, "Acciones: $%d", acciones);
   			    TextDrawSetString(Txt[playerid][9], string);
   			    TextDrawSetString(Txt[playerid][0], "Propietario");
   			    TextDrawSetString(Txt[playerid][1], "Tipo:");
				TextDrawColor(Txt[playerid][1], COLOR_WHITE);
				TextDrawSetString(Txt[playerid][4], NegocioInfo[i][nName]);
				TextDrawColor(Txt[playerid][4], COLOR_AZULCLARO);
				TextDrawSetString(Txt[playerid][5], NegocioInfo[i][nOwner]);
				switch(NegocioInfo[i][nType])
				{
				    case 1: { TextDrawSetString(Txt[playerid][6], "Restaurante"); }
				    case 2: { TextDrawSetString(Txt[playerid][6], "Night Club/Bar"); }
				    case 3: { TextDrawSetString(Txt[playerid][6], "24/7"); }
				    case 4: { TextDrawSetString(Txt[playerid][6], "Comida Rápida"); }
				    case 9: { TextDrawSetString(Txt[playerid][6], "Ammu Nation"); }
				    case 10: { TextDrawSetString(Txt[playerid][6], "Ropas"); }
				    case 11: { TextDrawSetString(Txt[playerid][6], "Muebles"); }
				}
				if(NegocioInfo[i][nOwned] == 1)
				{
				    format(string, 128, "$%d", NegocioInfo[i][nCajaFuerte]);
				    TextDrawSetString(Txt[playerid][7], string);
				    TextDrawSetString(Txt[playerid][3], "Productos:");
				    TextDrawColor(Txt[playerid][3], -1);
				    format(string, 128, "%d", NegocioInfo[i][nProd]);
				    TextDrawSetString(Txt[playerid][8], string);
				}
				else
				{
				    format(string, 128, "$%d", NegocioInfo[i][nCosto]);
				    TextDrawSetString(Txt[playerid][7], string);
				    TextDrawSetString(Txt[playerid][3], "Nivel:");
					TextDrawColor(Txt[playerid][3], -1);

				}
				for(new p = 0; p < 10; p++)
				{
					TextDrawShowForPlayer(playerid, Txt[playerid][p]);
				}
				ViendoInfo[playerid] = true;
			}
		}
		/*for(new e; e < sizeof(EdifInfo); e++)
		{
		    if(PlayerToPoint(2.0, playerid, EdifInfo[e][eEPos_x], EdifInfo[e][eEPos_y], EdifInfo[e][eEPos_z]))
   			{
   			    TextDrawSetString(Txt[playerid][4], EdifInfo[e][eName]);
   			    TextDrawColor(Txt[playerid][4], COLOR_AMARILLOBAJO);
   			    TextDrawShowForPlayer(playerid,Txt[playerid][4]);
				TextDrawSetString(Txt[playerid][0], "Appts:");
				TextDrawShowForPlayer(playerid,Txt[playerid][0]);
				TextDrawSetString(Txt[playerid][1], "Precio:");
				TextDrawShowForPlayer(playerid,Txt[playerid][1]);
				format(string, 128, "%d", EdifInfo[e][eRestantes]);
				TextDrawSetString(Txt[playerid][5], string);
				TextDrawShowForPlayer(playerid, Txt[playerid][5]);
				format(string, 128, "$%d", EdifInfo[e][eCosto]);
				TextDrawSetString(Txt[playerid][6], string);
				TextDrawShowForPlayer(playerid, Txt[playerid][6]);
				ViendoInfo[playerid] = 1;
			}
		}*/
		for(new e = 0; e < sizeof(CasaInfo); e++)
		{
		    if(PlayerToPoint(2.0, playerid, CasaInfo[e][hEx], CasaInfo[e][hEy], CasaInfo[e][hEz]))
   			{
   			    TextDrawSetString(Txt[playerid][0], "Propietario");
				TextDrawSetString(Txt[playerid][5], CasaInfo[e][hOwner]);
				if(CasaInfo[e][hLock] == 1)
				{
				    TextDrawSetString(Txt[playerid][1],"Cerrado");
					TextDrawColor(Txt[playerid][1],0xf52a14AA);
				}
				else
				{
					TextDrawSetString(Txt[playerid][1],"Abierto");
					TextDrawColor(Txt[playerid][1],0x56ca4eAA);
				}
				TextDrawShowForPlayer(playerid,Txt[playerid][1]);
				TextDrawShowForPlayer(playerid,Txt[playerid][0]);
				TextDrawShowForPlayer(playerid,Txt[playerid][5]);
				if(CasaInfo[e][hOwned] == 0)
				{
				    format(string, 128, "$%d", CasaInfo[e][hValue]);
				    TextDrawSetString(Txt[playerid][7], string);
				    TextDrawShowForPlayer(playerid, Txt[playerid][2]);
				    TextDrawShowForPlayer(playerid, Txt[playerid][7]);
				    format(string, 128, "%d", CasaInfo[e][hLevel]);
				    TextDrawSetString(Txt[playerid][8], string);
				    TextDrawShowForPlayer(playerid, Txt[playerid][3]);
				    TextDrawShowForPlayer(playerid, Txt[playerid][8]);
				}
				ViendoInfo[playerid] = 1;
			}
		}
		

		return 1;
	}
	if (strcmp(cmd, "/enmascarados", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < 1)
	        {
	            SendClientMessage(playerid, Gris, "No eres Administrador");
	            return 1;
	        }
			SendClientMessage(playerid,Gris, "Usuarios conectados con mascara:");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(Usando[i] == 1)
				    {
						format(string, 256, "** Usuario: %s [ID:%d] [Extraño:%d] **", i, pName(i), extranoid[i]);
						SendClientMessage(playerid, Gris, string);
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/aceptar",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new x_job[128];
			x_job = strtokex(cmdtext, idx);
			if(!strlen(x_job)) {
				SendClientMessage(playerid, Blanco, "USO: /aceptar [nombre]");
				SendClientMessage(playerid, AzulClaro, "Nombres disponibles: Reparar, Rellenar, Pintura, Multa, Trabajo, Seguro, Directo, Taxi, Mecanico, Dinero, Numero");
				return 1;
			}
			
			if(strcmp(x_job,"directo",true)==0)
			{
				if(LiveOffer[playerid] != NOEXISTE)
				{
					if(IsPlayerConnected(LiveOffer[playerid]))
					{
						if(GetDistanceBetweenPlayers(playerid, LiveOffer[playerid]) < 5.0)
						{
							SendClientMessage(playerid, Aguamarina, "* Estás inmóvil hasta que termine la conversación.");
							SendClientMessage(LiveOffer[playerid], Aguamarina, "* Estás inmóvil hasta que termine la conversación (usa /directo otra vez).");
							TogglePlayerControllable(playerid, 0);
							TogglePlayerControllable(LiveOffer[playerid], 0);
							TalkingLive[playerid] = LiveOffer[playerid];
							TalkingLive[LiveOffer[playerid]] = playerid;
							LiveOffer[playerid] = NOEXISTE;
							return 1;
						}
						else
						{
							SendClientMessage(playerid, Rojo, "* Estás muy lejos del Reportero!");
							return 1;
						}
					}
				}
			}
			else if(strcmp(x_job,"Licencia",true) == 0)
			{
			    new pnome[24];new pname[24];
			    if(Preguntado[playerid]>0)
			    {
			    	if(IsPlayerConnected(LicOffer[playerid]))
			    	{
			    	    GetPlayerName(LicOffer[playerid],pnome,24);
			    	    GetPlayerName(playerid,pname,24);
						format(string,256," %s te ha comprado la Licencia de Conducir",pname);
						SendClientMessage(playerid,Naranja,string);
						format(string,256," %s te ha vendido la Licencia de Conducir",pnome);
						SendClientMessage(playerid,Naranja,string);
						PlayerInfo[playerid][pCarLic]=3;
						
					}
					else
					{
					    Preguntado[playerid]=0;
					    return 1;
					}
				}
    			
 				if(PreguntadoA[playerid]>0)
			    {
			    	if(IsPlayerConnected(LicOffer[playerid]))
			    	{
			    	    GetPlayerName(LicOffer[playerid],pnome,24);
			    	    GetPlayerName(playerid,pname,24);
						format(string,256," %s te ha comprado la Licencia de Armas",pname);
						SendClientMessage(playerid,Naranja,string);
						format(string,256," %s te ha vendido la Licencia de Armas",pnome);
						SendClientMessage(playerid,Naranja,string);
						PlayerInfo[playerid][pGunLic]=3;
						
					}
					else
					{
					    PreguntadoA[playerid]=0;
					    return 1;
					}
				}
			}
			else if(strcmp(x_job, "dinero", true) == 0)
			{
				if(PlayerInfo[playerid][pPagandole] != NOEXISTE)
				{
					if(IsPlayerConnected(PlayerInfo[playerid][pPagandole]))
					{
						if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pPagandole]) < 8.0)
						{
							SendClientMessage(playerid, Amarillo, "Has aceptado el dinero.");
							SendClientMessage(PlayerInfo[playerid][pPagandole], Amarillo, "Han aceptado el dinero.");
							SafeGivePlayerMoneyEx(playerid, PlayerInfo[playerid][pPagandole], PlayerInfo[playerid][pPagandoDin]);
							PlayerInfo[playerid][pPagandole] = NOEXISTE;
							PlayerInfo[playerid][pPagandoDin] = 0;
						}
						else
						{
							SendClientMessage(playerid, Rojo, "* Estás muy lejos del otro!");
							return 1;
						}
					}
				}
			}
			else if(strcmp(x_job, "numero", true) == 0)
			{
				if(PlayerInfo[playerid][EstanSolicitando] != NOEXISTE)
				{
					if(IsPlayerConnected(PlayerInfo[playerid][IDSolicitud2]))
					{
							 new otro = PlayerInfo[playerid][IDSolicitud2];
							SendClientMessage(playerid, Amarillo, "Has dado tu número.");
							format(string,128,"%s ha aceptado tu solicitud el número es : %d", pName(playerid), PlayerInfo[playerid][pPnumber][0]);
							SendClientMessage(otro, Amarillo,string);
							//SafeGivePlayerMoneyEx(playerid, PlayerInfo[playerid][pPagandole], PlayerInfo[playerid][pPagandoDin]);
							PlayerInfo[playerid][EstanSolicitando] = 0;
							PlayerInfo[otro][IDSolicitud1] = 0;
							PlayerInfo[playerid][IDSolicitud2] = 0;
							PlayerInfo[otro][SolicitarNumero] = 0;
							PlayerInfo[playerid][SolicitarNumero] = 0;
                            
					
					}
				}
			}
			else if(strcmp(x_job,"negocio", true) == 0)
			{
			    if(PlayerInfo[playerid][BisOfferter] != NOEXISTE)
			    {
			    	if(IsPlayerConnected(PlayerInfo[playerid][BisOfferter]))
			        {
			            if(SafeGetPlayerMoney(playerid) > PlayerInfo[playerid][BisPrice])
			            {
			                new ofertador = PlayerInfo[playerid][BisOfferter];
			                new precio = PlayerInfo[playerid][BisPrice];
			                new sendername[MAX_PLAYER_NAME];
			                PlayerInfo[playerid][pPbiskey] = PlayerInfo[ofertador][pPbiskey];
			                PlayerInfo[ofertador][pPbiskey] = NOEXISTE;
			                SafeGivePlayerMoney(playerid, - precio);
			                SafeGivePlayerMoney(ofertador, precio);
							SendClientMessage(playerid, Verde, "Venta completada!");
							PlayerInfo[playerid][BisOfferter] = NOEXISTE;
						    PlayerInfo[playerid][BisPrice] = NOEXISTE;
							new llave = PlayerInfo[playerid][pPbiskey];
							GetPlayerName(playerid, sendername, 24);
							format(NegocioInfo[llave][nOwner], 128, "%s", sendername);
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, Rojo, "No tienes dinero!");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "No te han hecho ofertas!");
				}
			}
			else if(strcmp(x_job, "taxi", true) == 0)
			{
				if(PlayerInfo[playerid][pEstadoTaxista] == 1)
				{
					if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Naranja, "*¡No estás en un vehículo!");
					if(!IsATeamCar(GetPlayerVehicle(playerid), 114)) return SendClientMessage(playerid, Naranja, "* ¡Mp estás en el taxi!");
					PlayerInfo[playerid][pEstadoTaxista] = 2;
					for(new i; i < MAX_PLAYERS; i++)
					{
						if(!IsPlayerConnected(i)) continue;
						if(i == playerid) continue;
						
						if(PlayerInfo[i][pEstadoTaxista] == 1 && PlayerInfo[i][pMember] == 3)
						{
							PlayerInfo[i][pEstadoTaxista] = 0;
							SendClientMessage(i, Amarillo, "* La llamada ha sido atendida por otro taxista.");
						}
					}
					
					new Float:X,Float:Y,Float:Z;
					GetPlayerPos(PlayerInfo[playerid][pClienteTaxista], X,Y,Z);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, X,Y,Z, 6.0);
					PlayerInfo[playerid][pCheckpoint] = 17;
					format(string,sizeof(string), "* Has atendido la llamada de %s, dirigete hacia el cliente.",pName(PlayerInfo[playerid][pClienteTaxista]));
					SendClientMessage(playerid,Amarillo,string);
					format(string,sizeof(string),"* Taxista %s, ha atendido tu llamada, espera aqui.",pName(playerid));
					SendClientMessage(PlayerInfo[playerid][pClienteTaxista], Amarillo, string);
					EstaEnMisionTaxi[playerid] = 0;
				}
			}
			else if(strcmp(x_job, "mecanico", true) == 0)
			{
				if(PlayerInfo[playerid][pEstadoMecanico] == 1)
				{
					PlayerInfo[playerid][pEstadoMecanico] = 2;
					for(new i; i < MAX_PLAYERS; i++)
					{
						if(!IsPlayerConnected(i)) continue;
						if(i == playerid) continue;

						if(PlayerInfo[i][pEstadoMecanico] == 1 && PlayerInfo[i][pJob] == 1)
						{
							PlayerInfo[i][pEstadoMecanico] = 0;
							SendClientMessage(i, Amarillo, "* La llamada ha sido atendida por otro mecanico.");
						}
					}

					new Float:X,Float:Y,Float:Z;
					GetPlayerPos(PlayerInfo[playerid][pClienteMecanico], X,Y,Z);
					SetPlayerCheckpoint(playerid, X,Y,Z, 6.0);

					PlayerInfo[playerid][pCheckpoint] = 1;
					SendClientMessage(playerid, Amarillo, "* Has atendido la llamada, dirigete hacia el cliente.");
					format(string,sizeof(string),"* Mecánico %s, ha atendido tu llamada, espera aqui.",pName(playerid));
					SendClientMessage(PlayerInfo[playerid][pClienteMecanico], Amarillo, string);
				}
			}
			else if(strcmp(x_job,"reparar",true) == 0)
			{
			    if(PlayerInfo[playerid][pRepairOffer] != NOEXISTE)
			    {
			        if(SafeGetPlayerMoney(playerid) > PlayerInfo[playerid][pRepairPrice])
				    {
					    if(IsPlayerInAnyVehicle(playerid))
					    {
					        if(IsPlayerConnected(PlayerInfo[playerid][pRepairOffer]))
					        {
								if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pRepairOffer]) > 8)
								{
									SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
									return 1;
								}							
			    				TogglePlayerControllable(playerid,0);
								PlayerInfo[playerid][pTempFrozen] = 1; // Para que no pueda descongelarse con /salir
								PlayerInfo[PlayerInfo[playerid][pRepairOffer]][pHabilidadMecanico]++;
		    					GameTextForPlayer(playerid,"~r~Reparando vehiculo",20000,5);
								SetTimerEx("timer_reparar2", 20000, 0, "d", playerid);
								PlayerInfo[PlayerInfo[playerid][pRepairOffer]][pProductos]-=25;
								SaveValue(PlayerInfo[playerid][pRepairOffer], "Productos", PlayerInfo[PlayerInfo[playerid][pRepairOffer]][pProductos]);
								SaveValues(PlayerInfo[playerid][pRepairOffer], "Habilidades");
								SafeGivePlayerMoney(PlayerInfo[playerid][pRepairOffer],PlayerInfo[playerid][pRepairPrice]);
								SafeGivePlayerMoney(playerid, - PlayerInfo[playerid][pRepairPrice]);
								format(string, sizeof(string), "* Aceptastes la reparación del mecanico %s por %d$. Espera mientras se reparara el vehiculo.",pName(PlayerInfo[playerid][pRepairOffer]),PlayerInfo[playerid][pRepairPrice]);
								SendClientMessage(playerid, Azul, string);
								format(string, sizeof(string), "* Reparaste el vehículo de %s por %d$.",pName(playerid),PlayerInfo[playerid][pRepairPrice]);
								SendClientMessage(PlayerInfo[playerid][pRepairOffer], Azul, string);
								PlayerInfo[playerid][pRepairOffer] = NOEXISTE;
								PlayerInfo[playerid][pRepairPrice]= 0;
								return 1;
							}
							return 1;
						}
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* No puedes pagar la reparación!");
					    return 1;
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, Rojo, "* Nadie te ofreció reparar el coche!");
			        return 1;
			    }
			}
			else if(strcmp(x_job,"pintura", true) == 0)
			{
			    if(PlayerInfo[playerid][pRepaintOffer] != NOEXISTE)
			    {
       				if(IsPlayerConnected(PlayerInfo[playerid][pRepaintOffer]))
			        {
			        	if(SafeGetPlayerMoney(playerid) > PlayerInfo[playerid][pRepaintPrice])
			            {
							new id = GetPlayerVehicle(playerid);
							CarInfo[id][cColorOne] = PlayerInfo[playerid][pRepaintColor];
							CarInfo[id][cColorTwo] = PlayerInfo[playerid][pRepaintColor2];
							SaveCar(id);
							ChangeVehicleColor(CarInfo[id][cId], CarInfo[id][cColorOne], CarInfo[id][cColorTwo]);
							SafeGivePlayerMoney(playerid, - PlayerInfo[playerid][pRepaintPrice]);
							SafeGivePlayerMoney(PlayerInfo[playerid][pRepaintOffer], PlayerInfo[playerid][pRepaintPrice]);
							PlayerInfo[playerid][pRepaintOffer]= NOEXISTE;
							PlayerInfo[playerid][pRepaintColor] = 0;
							PlayerInfo[playerid][pRepaintColor2] = 0;
							PlayerInfo[playerid][pRepaintPrice] = 0;
							PlayerInfo[PlayerInfo[playerid][pRepaintOffer]][pHabilidadMecanico]++;
							PlayerInfo[PlayerInfo[playerid][pRepaintOffer]][pProductos]-=50;
							SaveValue(PlayerInfo[playerid][pRepaintOffer], "Productos", PlayerInfo[PlayerInfo[playerid][pRepaintOffer]][pProductos]);
							SaveValues(PlayerInfo[playerid][pRepairOffer], "Habilidades");
						}
						else
						{
						    SendClientMessage(playerid, Rojo, "* No tienes dinero suficiente!");
						    return 1;
						}
					}
				}
			}
			else if(strcmp(x_job,"rellenar",true) == 0)
			{
			    if(PlayerInfo[playerid][pRefillOffer] != NOEXISTE)
			    {
			        if(IsPlayerConnected(PlayerInfo[playerid][pRefillOffer]))
			        {
			            if(SafeGetPlayerMoney(playerid) > PlayerInfo[playerid][pRefillPrice])
			            {
							if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pRefillOffer]) > 8)
							{
								SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
								return 1;
							}		
			                new car = GetPlayerVehicle(playerid);
			                format(string, sizeof(string), "* Rellenaste el depósito, por %d$ por el Mecánico %s.",PlayerInfo[playerid][pRefillPrice],pName(PlayerInfo[playerid][pRefillOffer]));
							SendClientMessage(playerid, Azul, string);
							format(string, sizeof(string), "* Rellenaste el coche de %s, Ganaste %d$.",pName(playerid),PlayerInfo[playerid][pRefillPrice]);
							SendClientMessage(PlayerInfo[playerid][pRefillOffer], Azul, string);
							SafeGivePlayerMoney(PlayerInfo[playerid][pRefillOffer],PlayerInfo[playerid][pRefillPrice]);
							SafeGivePlayerMoney(playerid, - PlayerInfo[playerid][pRefillPrice]);
							new temp = CarInfo[car][cGas] + PlayerInfo[playerid][pRefillAmount];
							
							if(temp > 100)
							{
								CarInfo[car][cGas] = 100;
							}
							else
							{
								CarInfo[car][cGas] += PlayerInfo[playerid][pRefillAmount];
							}
							
					        PlayerInfo[playerid][pRefillOffer] =  NOEXISTE;
							PlayerInfo[playerid][pRefillPrice] = 0;
							PlayerInfo[playerid][pRefillAmount] = 0;
							PlayerInfo[PlayerInfo[playerid][pRefillOffer]][pHabilidadMecanico]++;
							PlayerInfo[PlayerInfo[playerid][pRefillOffer]][pProductos]-=50;
							SaveValue(PlayerInfo[playerid][pRefillOffer], "Productos", PlayerInfo[PlayerInfo[playerid][pRefillOffer]][pProductos]);
							SaveValues(PlayerInfo[playerid][pRefillOffer], "Habilidades");
							return 1;
			            }
						else
						{
						    SendClientMessage(playerid, Rojo, "* No puedes pagar eso!");
						    return 1;
						}
			        }
			        return 1;
			    }
				else
				{
				    SendClientMessage(playerid, Rojo, "* Nadie te ofreció rellenar tu depósito!");
				    return 1;
				}
			}
            else if(strcmp(x_job,"pedido", true) == 0)
			{
                if(PlayerInfo[playerid][pJob] != 6) return SendClientMessage(playerid, Rojo, "* Debes ser repartidor!");
                for (new i=0;i<20;i++)
                {
                    if (PedidosPizza[i][Activo]==1)
                    {
                        if(PlayerInfo[playerid][pPizzas] == 0)
                            return SendClientMessage(playerid,Rojo,"* No tienes pizzas para repartir. Usa /pizza recoger");
                        PlayerInfo[playerid][pCheckpoint] = 6;
                        PlayerInfo[playerid][pTrabajandoCP] = 2;
                        SetPlayerCheckpoint(playerid,PedidosPizza[i][xpos],PedidosPizza[i][ypos],PedidosPizza[i][zpos], 5.0);
                        PedidosPizza[i][Activo]=0;
                        SendClientMessage(playerid,Amarillo,"* Acude a la posición marcada para entregar la pizza");
                        return 1;
                    }
                }
            }
            else if(strcmp(x_job,"pizza", true) == 0)
			{
                if (OfertaPizza[playerid] == NOEXISTE) return 1;
				if(GetDistanceBetweenPlayers(playerid, OfertaPizza[playerid]) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
                format(string, sizeof(string), "* Has comprado una pizza por 20$ a %s.",pName(OfertaPizza[playerid]));
                SendClientMessage(playerid, Azul, string);
                format(string, sizeof(string), "* Has vendido una pizza a %s por 20$",pName(playerid));
                SendClientMessage(OfertaPizza[playerid], Azul, string);
                SafeGivePlayerMoney(playerid,-20);
                SafeGivePlayerMoney(OfertaPizza[playerid],20);
                OfertaPizza[playerid] = NOEXISTE;
                new Float:health;
                GetPlayerHealth(playerid, health);
                GM_SetPlayerHealth(playerid, health + 15);
            }
			else if(strcmp(x_job,"helado", true) == 0)
			{
                if (PlayerInfo[playerid][pOfertaHelado] == NOEXISTE) return 1;
				if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pOfertaHelado]) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				format(string, sizeof(string), "* Has comprado un helado por 15$ a %s.",pName(PlayerInfo[playerid][pOfertaHelado]));
                SendClientMessage(playerid, Azul, string);
                format(string, sizeof(string), "* Has vendido un helado a %s por 15$",pName(playerid));
                SendClientMessage(PlayerInfo[playerid][pOfertaHelado], Azul, string);
                SafeGivePlayerMoney(playerid,-15);
                SafeGivePlayerMoney(PlayerInfo[playerid][pOfertaHelado],15);
                PlayerInfo[playerid][pOfertaHelado] = NOEXISTE;
				new Float:health;
                GetPlayerHealth(playerid, health);
                GM_SetPlayerHealth(playerid, health + 15);
            }
			else if(strcmp(x_job,"perrito", true) == 0)
			{
                if (PlayerInfo[playerid][pOfertaPerrito] == NOEXISTE) return 1;
				if(GetDistanceBetweenPlayers(playerid, PlayerInfo[playerid][pOfertaPerrito]) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				format(string, sizeof(string), "* Has comprado un perrito por 20$ a %s.",pName(PlayerInfo[playerid][pOfertaPerrito]));
                SendClientMessage(playerid, Azul, string);
                format(string, sizeof(string), "* Has vendido un perrito a %s por 20$",pName(playerid));
                SendClientMessage(PlayerInfo[playerid][pOfertaPerrito], Azul, string);
                SafeGivePlayerMoney(playerid,-20);
                SafeGivePlayerMoney(PlayerInfo[playerid][pOfertaPerrito],20);
                PlayerInfo[playerid][pOfertaPerrito] = NOEXISTE;
				new Float:health;
                GetPlayerHealth(playerid, health);
                GM_SetPlayerHealth(playerid, health + 15);
            }
			else if(strcmp(x_job,"trabajo", true) == 0)
			{
				if(FuerzaPublica(playerid) == 1)
				{
					return SendClientMessage(playerid, Naranja, "* No puedes aceptar un trabajo mientras pertenezcas a una facción pública!");
				}
				if(PlayerInfo[playerid][pJob] == 0)
				{
					if(PlayerInfo[playerid][pOferta] > 0)
					{
						PlayerInfo[playerid][pJob] = PlayerInfo[playerid][pOferta];
                        PlayerInfo[playerid][pMaterialTrabajo] = 0;
						SendClientMessage(playerid, Verde, "Has firmado el contrato de trabajo. Felicidades!");
						PlayerInfo[playerid][pOferta] = 0;
						SaveValue(playerid, "Trabajo", PlayerInfo[playerid][pJob]);
						if(GetPlayerPremium(playerid) == 0)
						{
							SaveValue(playerid, "Contrato", PlayerInfo[playerid][pContrato]);
							PlayerInfo[playerid][pContrato] = 6;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "Ya tienes un trabajo, escribe /dejartrabajo antes.");
				}
			}
			else if(strcmp(x_job,"seguro", true) == 0)
			{
				if(PlayerInfo[playerid][pOfreciendoS] == NOEXISTE || (PlayerInfo[playerid][pOfreciendoS] > 0 && PlayerInfo[playerid][pOfreciendoC] == 0)) return SendClientMessage(playerid, Rojo, "* Nadie te ha ofrecido un seguro!");	
				new giveplayerid = PlayerInfo[playerid][pOfreciendoS];
				if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Rojo, "* Debes estar montado en un vehiculo!");	
				new coche, tieneono;
				coche = GetPlayerVehicle(playerid);
				if(PlayerInfo[playerid][pOfreciendoV] != coche) return SendClientMessage(playerid, Rojo, "* Este no es el vehiculo para el que te ofrecieron el seguro!");	
				if(PlayerHaveKeys(playerid,coche)) tieneono = 1;
				if(tieneono == 0) return SendClientMessage(playerid, Rojo, "* No estás en uno de tus coches.");
				if(SafeGetPlayerMoney(playerid) >= PlayerInfo[playerid][pOfreciendoC])
				{
					new precio = (CarInfo[coche][cValue]*5)/100;
					if(precio > 5000) precio = 5000;
					CarInfo[coche][cSeguro] = 1;
					SaveCar(coche);
					format(string, 128, "* Has aceptado el seguro contra todo daño de coches por $%d.", PlayerInfo[playerid][pOfreciendoC]);
					SendClientMessage(playerid, Verde, string);
					format(string, 128, "* Te han comprado el seguro contra todo daño de coches por $%d.", PlayerInfo[playerid][pOfreciendoC]);
					SendClientMessage(giveplayerid, AmarilloClaro, string);
					SafeGivePlayerMoney(playerid,-PlayerInfo[playerid][pOfreciendoC]);
					SafeGivePlayerMoney(giveplayerid,PlayerInfo[playerid][pOfreciendoC]-precio);
					PlayerInfo[giveplayerid][pOfreciendoS] = NOEXISTE;
					PlayerInfo[playerid][pOfreciendoV] = NOEXISTE;
					PlayerInfo[playerid][pOfreciendoC] = 0;
					PlayerInfo[playerid][pOfreciendoS] = NOEXISTE;
					return 1;
				}
				else return SendClientMessage(playerid, Rojo, "* Dinero insuficiente");
			}
			else if(strcmp(x_job,"venta",true)==0)
			{
				if(PlayerInfo[playerid][pOfertaCocheID] >= 0 && PlayerInfo[playerid][pOfertaCocheKey] >= 0 && PlayerInfo[playerid][pOfertaCocheMoney] > 0)
				{
					new giveplayerid = PlayerInfo[playerid][pOfertaCocheID];
					if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
					{
						SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
						return 1;
					}
					
					if(PlayerInfo[giveplayerid][pOfertaCocheID] != playerid) return 0;
					
					if(SafeGetPlayerMoney(playerid) < PlayerInfo[playerid][pOfertaCocheMoney]) return SendClientMessage(playerid, Naranja, "* No tienes suficiente dinero.");

					if(PlayerInfo[giveplayerid][pPCarKey][0] == PlayerInfo[playerid][pOfertaCocheKey]) PlayerInfo[giveplayerid][pPCarKey][0] = NOEXISTE;
					else if(PlayerInfo[giveplayerid][pPCarKey][1] == PlayerInfo[playerid][pOfertaCocheKey]) PlayerInfo[giveplayerid][pPCarKey][1] = NOEXISTE;
					else if(PlayerInfo[giveplayerid][pPCarKey][2] == PlayerInfo[playerid][pOfertaCocheKey]) PlayerInfo[giveplayerid][pPCarKey][2] = NOEXISTE;
					else if(PlayerInfo[giveplayerid][pPCarKey][3] == PlayerInfo[playerid][pOfertaCocheKey]) PlayerInfo[giveplayerid][pPCarKey][3] = NOEXISTE;
					else if(PlayerInfo[giveplayerid][pPCarKey][4] == PlayerInfo[playerid][pOfertaCocheKey]) PlayerInfo[giveplayerid][pPCarKey][4] = NOEXISTE;
					else return SendClientMessage(playerid, Rojo, "ERROR: El jugador que te ha ofertado el coche ya no tiene la llave!");
					
					if(PlayerInfo[playerid][pPCarKey][0] == NOEXISTE) PlayerInfo[playerid][pPCarKey][0] = PlayerInfo[playerid][pOfertaCocheKey];
					else if(PlayerInfo[playerid][pPCarKey][1] == NOEXISTE) PlayerInfo[playerid][pPCarKey][1] = PlayerInfo[playerid][pOfertaCocheKey];
					else if(PlayerInfo[playerid][pPCarKey][2] == NOEXISTE) PlayerInfo[playerid][pPCarKey][2] = PlayerInfo[playerid][pOfertaCocheKey];
					else if(PlayerInfo[playerid][pPCarKey][3] == NOEXISTE) PlayerInfo[playerid][pPCarKey][3] = PlayerInfo[playerid][pOfertaCocheKey];
					else if(PlayerInfo[playerid][pPCarKey][4] == NOEXISTE) PlayerInfo[playerid][pPCarKey][4] = PlayerInfo[playerid][pOfertaCocheKey];
					else return SendClientMessage(playerid, Naranja, "* Ya tienes todos los slots de llaves propias ocupados!");
			
					SaveValues(playerid,"Coches");
					SaveValues(giveplayerid,"Coches");
					
					format(CarInfo[GetPlayerVehicleByKey(PlayerInfo[playerid][pOfertaCocheKey])][cOwner],MAX_PLAYER_NAME,"%s",pNameEx(playerid));
					
					SaveCar(GetPlayerVehicleByKey(PlayerInfo[playerid][pOfertaCocheKey]));
					
					SafeGivePlayerMoney(playerid,-PlayerInfo[playerid][pOfertaCocheMoney]);
					SafeGivePlayerMoney(giveplayerid,PlayerInfo[playerid][pOfertaCocheMoney]);
					
					format(string,sizeof(string),"* Le has comprado a %s su %s por %d$", pName(giveplayerid), CarInfo[GetPlayerVehicleByKey(PlayerInfo[playerid][pOfertaCocheKey])][cDescription], PlayerInfo[playerid][pOfertaCocheMoney]);
					SendClientMessage(playerid,Verde,string);
					SendClientMessage(playerid,AmarilloClaro,"(( Te recomendamos que le cambies la cerradura al coche, para que las posibles copias de llaves no funcionen. ))"); // !!!
					
					format(string,sizeof(string),"* %s te ha comprado tu %s por %d$", pName(playerid), CarInfo[GetPlayerVehicleByKey(PlayerInfo[playerid][pOfertaCocheKey])][cDescription], PlayerInfo[playerid][pOfertaCocheMoney]);
					SendClientMessage(giveplayerid,Verde,string);
					
					PlayerInfo[playerid][pOfertaCocheID] = NOEXISTE;
					PlayerInfo[playerid][pOfertaCocheKey] = NOEXISTE;
					PlayerInfo[playerid][pOfertaCocheMoney] = 0;
					PlayerInfo[giveplayerid][pOfertaCocheID] = NOEXISTE;
				}
				else return SendClientMessage(playerid, Rojo, "* Nadie te ha ofrecido un coche!");
			}
			else if(strcmp(x_job,"saludo",true)==0)
			{
				if(PlayerInfo[playerid][pOfertaSaludo] != NOEXISTE)
				{
					new seleccion;
					seleccion = saludoid;
					ApplyAnimation(playerid,animsaludo[seleccion][animliba],animsaludo[seleccion][animnamea],4.0,0,0,0,3000,1,1);
					ApplyAnimation(PlayerInfo[playerid][pOfertaSaludo],animsaludo[seleccion][animliba],animsaludo[seleccion][animnamea],4.0,0,0,0,3000,1,1);
					PlayerInfo[playerid][pOfertaSaludo] = NOEXISTE;
				}
				else
				{
					SendClientMessage(playerid,RojoIntenso,"Nadie te ofreció un saludo");
					return 1;
				}
			}
		}
		return 1;
	}
    if(strcmp(cmd,"/fuego",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
             if(!IsACop(playerid) && !IsABombero(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
	        new x_job[128];
			x_job = strtokex(cmdtext, idx);
			if(!strlen(x_job)) {
				SendClientMessage(playerid, Blanco, "USO: /fuego [nombre]");
				SendClientMessage(playerid, AzulClaro, "Nombres disponibles: chico, mediano, grande, humo");
				return 1;
			}
	        if(strcmp(x_job,"Chico",true)==0)
			{
            ColocarFuego(playerid,1);
			}

			if(strcmp(x_job,"mediano",true)==0)
			{
            ColocarFuego(playerid,2);
			}
			
			if(strcmp(x_job,"grande",true)==0)
			{
            ColocarFuego(playerid,3);
			}
			if(strcmp(x_job,"humo", true)==0)
			{
			ColocarFuego(playerid,7);
			}
			
			}
		return 1;
	}
	//----------------------------------[STEKINS]------------------------------
     if(strcmp(cmd, "/ropas", true) == 0)
     {
			  new skin;
			  cmd = strtok(cmdtext, idx);
			  if(!strlen(cmd))
			  {
				SendClientMessage(playerid,COLOR_RED,"Usa: /ropas [ID del Skin]");
				return 1;
			  }
			skin = strval(cmd);
			if(IsAtClothShop(playerid))
			{
				if(SafeGetPlayerMoney(playerid)<200) return SendClientMessage(playerid,Rojo,"No tienes dinero : $200");
 				#define	MAX_BAD_SKINS 53
    			new badSkins[MAX_BAD_SKINS] =
    			{ 156, 176, 18, 19, 158, 159, 45, 161, 33, 146, 266, 241, 280, 281, 282, 283, 288, 287, 276, 275, 208, 268, 273, 289, 137, 206, 95, 177, 154, 23, 26, 96, 14, 51, 32, 43, 58, 73, 83, 82, 27, 52, 22, 13, 15, 41, 276, 213, 261, 277, 278, 279  };
    			if (skin < 0 || skin > 299) return SendClientMessage(playerid, COLOR_GREEN, "* ID Inválida o unutilizable");
    			for (new i = 0; i < MAX_BAD_SKINS; i++) { if (skin == badSkins[i]) return SendClientMessage(playerid, COLOR_GREEN, "* id de skin invalida"); }
    			#undef MAX_BAD_SKINS

				SetPlayerSkin(playerid,skin);
				format(string, sizeof(string), "Te has puesto el skin %d",skin);
				SafeGivePlayerMoney(playerid,-200);
             	SendClientMessage(playerid,Rojo,string);
             	PlayerInfo[playerid][pSkin] = skin;
             	SaveValue(playerid,"Skin",PlayerInfo[playerid][pSkin]);
                }
                else
                {
                SendClientMessage(playerid,COLOR_RED,"No estas en el binco");
                }
			return 1;
		}
		if(strcmp(cmd, "/aunlock", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,Gris, "USO: /aunlock [Nombre entero]");
				return 1;
			}
			new sqlid = MySQLCheckAccount(tmp);
			if (sqlid == 0)
			{
				SendClientMessage(playerid, Gris, "No se encontró el jugador en la Base de Datos. Asegúrate del nombre completo.");
				return 1;
			}
			MySQLUpdatePlayerIntSingle(sqlid, "Bloqueado", 0);
			SendClientMessage(playerid, Amarillo, "Cuenta desbloqueada.");
		}
		else
		{
			SendClientMessage(playerid, Gris, "Necesitas nivel 4 como Admin.");
		}
		return 1;
	}
	if(strcmp(cmd, "/alock", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,Gris, "USO: /alock [Nombre entero]");
				return 1;
			}
			new sqlid = MySQLCheckAccount(tmp);
			if (sqlid == 0)
			{
				SendClientMessage(playerid, Gris, "No se encontró el jugador en la Base de Datos. Asegúrate del nombre completo.");
				return 1;
			}
			MySQLUpdatePlayerIntSingle(sqlid, "Bloqueado", 1);
			SendClientMessage(playerid, Amarillo, "Cuenta bloqueada.");
		}
		else
		{
			SendClientMessage(playerid, Gris, "Necesitas nivel 4 como Admin.");
		}
		return 1;
	}
		if(strcmp(cmd, "/noadmin", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,Gris, "USO: /setadmin [Nombre entero]");
				return 1;
			}
			new sqlid = MySQLCheckAccount(tmp);
			if (sqlid == 0)
			{
				SendClientMessage(playerid, Gris, "No se encontró el jugador en la Base de Datos. Asegúrate del nombre completo.");
				return 1;
			}
			MySQLUpdatePlayerIntSingle(sqlid, "Admin", 0);
			SendClientMessage(playerid, Amarillo, "Admin eliminado.");
		}
		else
		{
			SendClientMessage(playerid, Gris, "Necesitas nivel 4 como Admin.");
		}
		return 1;
	}
	if(strcmp(cmd,"/humo",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
            if(!IsACop(playerid) && !IsABombero(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
	        new x_job[128];
			x_job = strtokex(cmdtext, idx);
			if(!strlen(x_job)) {
				SendClientMessage(playerid, Blanco, "USO: /humo [nombre]");
				SendClientMessage(playerid, AzulClaro, "Nombres disponibles: pequeño, mediano, grande, humo");
				return 1;
			}
	   		if(strcmp(x_job,"pequeño",true)==0)
			{
            ColocarFuego(playerid,4);
			}

			if(strcmp(x_job,"mediano",true)==0)
			{
            ColocarFuego(playerid,5);
			}

			if(strcmp(x_job,"grande",true)==0)
			{
            ColocarFuego(playerid,6);
			}
			if(strcmp(x_job,"humo",true)==0)
			{
            ColocarFuego(playerid,7);
			}

			}
		return 1;
	}
	if (strcmp(cmd,"/sacarfuego",true) == 0)
	{
		if(!IsACop(playerid) && !IsABombero(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
        DeleteFuegoClosestObject(playerid);
	    return 1;
	}
	if (strcmp(cmd,"/sacartfuego",true) == 0)
	{
		if(!IsACop(playerid) && !IsABombero(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
        DeleteFuegoAllObjects(playerid);
	    return 1;
	}
new YaMandado;
	if(strcmp(cmd, "/gobierno", true) == 0 || strcmp(cmd, "/gob", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pMember] == 1 && PlayerInfo[playerid][pRank] >= 10 || PlayerInfo[playerid][pMember] == 2 && PlayerInfo[playerid][pRank] == 8 || PlayerInfo[playerid][pRank] >= 16 || PlayerInfo[playerid][pMember] == 5 && PlayerInfo[playerid][pRank] >= 6)
			{


				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result)) return SendClientMessage(playerid,Rojo, "Utiliza: (/gob)ierno [Texto]");
				if(YaMandado == 0)
				{
					Mensaje(playerid, Rojo, "¡RECUERDA UTILIZAR /finalizargob PARA TERMINAR LA EMISIÓN!");
				    SendClientMessageToAll(COLOR_WHITE, "|ANUNCIOS OFICIALES DEL ESTADO|");
				}
				if(PlayerInfo[playerid][pMember] == 1 && PlayerInfo[playerid][pRank] >= 10)
				{
					format(string, sizeof(string), "[Los Angeles Police Department] %s: %s", pName(playerid), result);
					SendClientMessageToAll(0x00ACFFFF, string);
				}
				if(PlayerInfo[playerid][pMember] == 2 && PlayerInfo[playerid][pRank] >= 8)
				{
					format(string, sizeof(string), "[Los Angeles Emergency Department] %s: %s", pName(playerid), result);
					SendClientMessageToAll(0x00ACFFFF, string);
				}
				if(PlayerInfo[playerid][pMember] == 5 && PlayerInfo[playerid][pRank] >= 6)
				{
					format(string, sizeof(string), "[Los Angeles Superior Court] %s: %s", pName(playerid), result);
					SendClientMessageToAll(0x00ACFFFF, string);
				}
				}
				else return SendClientMessage(playerid, Rojo, "¡No estás autorizado!");
		}
		return 1;
	}
	if(strcmp(cmd, "/finalizargobierno", true) == 0 || strcmp(cmd, "/finalizargob", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pMember] == 1 && PlayerInfo[playerid][pRank] >= 10 || PlayerInfo[playerid][pMember] == 2 && PlayerInfo[playerid][pRank] >= 8 || PlayerInfo[playerid][pMember] == 5 && PlayerInfo[playerid][pRank] >= 6)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result)) return SendClientMessage(playerid,Rojo, "Utiliza: (/gob)ierno [Texto]");
				if(YaMandado == 1)
				{
				    SendClientMessageToAll(COLOR_WHITE, "|FIN DE LA TRANSMISION DEL ESTADO|");
				    YaMandado = 0;
				}
				}
				else return SendClientMessage(playerid, Rojo, "¡No estás autorizado!");
		}
		return 1;
	}
	if(strcmp(cmd,"/cancelar",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new x_job[128];
			x_job = strtokex(cmdtext, idx);
			if(!strlen(x_job)) {
				SendClientMessage(playerid, Blanco, "USO: /cancelar [nombre]");
				SendClientMessage(playerid, AzulClaro, "Nombres disponibles: Venta, Seguro,Taxi");
				return 1;
			}
			
			if(strcmp(x_job,"venta",true)==0)
			{
				if(PlayerInfo[playerid][pOfertaCocheID] == NOEXISTE) return SendClientMessage(playerid, Rojo, "* Nadie te ha ofrecido un coche!");
				else if(PlayerInfo[playerid][pOfertaCocheID] >= 0 && PlayerInfo[playerid][pOfertaCocheKey] == NOEXISTE)
				{
					new giveplayerid = PlayerInfo[playerid][pOfertaCocheID];
					format(string,sizeof(string),"* %s ha retirado su oferta de venta de su coche!",pName(playerid));
					SendClientMessage(giveplayerid, Amarillo, string);
					SendClientMessage(playerid, Amarillo, "* Has cancelado la venta de tu coche!");
					if(PlayerInfo[giveplayerid][pOfertaCocheID] == playerid)
					{
						PlayerInfo[giveplayerid][pOfertaCocheID] = NOEXISTE;
						PlayerInfo[giveplayerid][pOfertaCocheKey] = NOEXISTE;
						PlayerInfo[giveplayerid][pOfertaCocheMoney] = 0;
					}
					PlayerInfo[playerid][pOfertaCocheID] = NOEXISTE;
				}
				else if(PlayerInfo[playerid][pOfertaCocheID] >= 0 && PlayerInfo[playerid][pOfertaCocheKey] >= 0)
				{
					new giveplayerid = PlayerInfo[playerid][pOfertaCocheID];
					format(string,sizeof(string),"* %s ha rechazado tu oferta de compra!",pName(playerid));
					SendClientMessage(giveplayerid, Amarillo, string);
					SendClientMessage(playerid, Amarillo, "* Has rechazado la oferta de compra!");
					PlayerInfo[playerid][pOfertaCocheID] = NOEXISTE;
					PlayerInfo[playerid][pOfertaCocheKey] = NOEXISTE;
					PlayerInfo[playerid][pOfertaCocheMoney] = 0;
					if(PlayerInfo[giveplayerid][pOfertaCocheID] == playerid) PlayerInfo[giveplayerid][pOfertaCocheID] = NOEXISTE;
				}
				return 1;
			}
			if(strcmp(x_job,"seguro",true)==0)
			{
				if(PlayerInfo[playerid][pOfreciendoS] == NOEXISTE) return SendClientMessage(playerid, Rojo, "* Nadie te ha ofrecido un seguro!");
				else if(PlayerInfo[playerid][pOfreciendoS] >= 0 && PlayerInfo[playerid][pOfreciendoC] == 0)
				{
					new giveplayerid = PlayerInfo[playerid][pOfreciendoS];
					format(string,sizeof(string),"* %s ha retirado su oferta de seguro a tu coche!",pName(playerid));
					SendClientMessage(giveplayerid, Amarillo, string);
					SendClientMessage(playerid, Amarillo, "* Has cancelado la venta del seguro!");
					if(PlayerInfo[giveplayerid][pOfreciendoS] == playerid)
					{
						PlayerInfo[giveplayerid][pOfreciendoS] = NOEXISTE;
						PlayerInfo[giveplayerid][pOfreciendoC] = 0;
					}
					PlayerInfo[playerid][pOfreciendoS] = NOEXISTE;
				}
				else if(PlayerInfo[playerid][pOfreciendoS] >= 0 && PlayerInfo[playerid][pOfreciendoC] > 0)
				{
					new giveplayerid = PlayerInfo[playerid][pOfreciendoS];
					format(string,sizeof(string),"* %s ha rechazado tu oferta de seguro!",pName(playerid));
					SendClientMessage(giveplayerid, Amarillo, string);
					SendClientMessage(playerid, Amarillo, "* Has rechazado la oferta de compra del seguro!");
					PlayerInfo[playerid][pOfreciendoS] = NOEXISTE;
					PlayerInfo[playerid][pOfreciendoC] = 0;
					if(PlayerInfo[giveplayerid][pOfreciendoS] == playerid) PlayerInfo[giveplayerid][pOfreciendoS] = NOEXISTE;
				}
			}
			if(strcmp(x_job,"taxi",true)==0)
			{
				if(PlayerInfo[playerid][pCheckpoint] == 17 && PlayerInfo[playerid][pEstadoTaxista] == 2)
				{
					SendClientMessage(PlayerInfo[playerid][pClienteTaxista],RojoIntenso,"El taxista canceló tu llamada");
					SendClientMessage(playerid,Amarillo,"Cancelaste la llamada del cliente");
					DisablePlayerCheckpoint(playerid);
					PlayerInfo[playerid][pCheckpoint] = 0;
					PlayerInfo[playerid][pEstadoTaxista] = 0;
					return 1;
				}
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(playerid == PlayerInfo[i][pClienteTaxista])
					{
						DisablePlayerCheckpoint(i);
						SendClientMessage(i,Amarillo,"El cliente canceló la llamada");
						SendClientMessage(playerid,Amarillo,"Cancelaste la llamada al taxista");
						PlayerInfo[i][pCheckpoint] = 0;
						PlayerInfo[i][pEstadoTaxista] = 0;
						return 1;
					}
				}
			}	
		}
		return 1;
	}
	
	if(strcmp(cmd,"/guardardrogas", true) == 0)
	{
   	    if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
            new tipo[64];
            tipo = strtokex(cmdtext, idx);
            if(!strlen(tipo) || ( strcmp(tipo,"maria",true)!=0 
               && strcmp(tipo,"crack",true)!=0 && strcmp(tipo,"coca",true)!=0 ) )
            {
                SendClientMessage(playerid, Blanco, "USO: /guardardrogas [Maria/Coca/Crack] [Semillas/Preparada/NoPreparada]");
                return 1;
            }
            new estado[128];
            estado = strtokex(cmdtext, idx);
            if(!strlen(estado) || ( strcmp(estado,"Semillas",true)!=0 &&
                strcmp(estado,"Preparada",true)!=0 && strcmp(estado,"NoPreparada",true)!=0 ) )
            {
                SendClientMessage(playerid, Blanco, "USO: /guardardrogas [Maria/Coca/Crack] [Semillas/Preparada/NoPreparada]");
                return 1;
            }
            
			new house = GetPlayerHouse(playerid);
			if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0)  || IsACop(playerid))
			{
   				if (PlayerToPoint(100.0, playerid, CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
				{
					if(strcmp(tipo,"Maria",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
                            CasaInfo[house][hSemillas][0] += PlayerInfo[playerid][pSemillas][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pSemillas][0],CasaInfo[house][hSemillas][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pSemillas][0] = 0;
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
                            CasaInfo[house][hDrogaP][0] += PlayerInfo[playerid][pDrogaP][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][0],CasaInfo[house][hDrogaP][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][0] = 0; 
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
                            CasaInfo[house][hDrogaNP][0] += PlayerInfo[playerid][pDrogaNP][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pDrogaNP][0],CasaInfo[house][hDrogaNP][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaNP][0] = 0;
                        }
                    }
					else if(strcmp(tipo,"Coca",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
                            CasaInfo[house][hSemillas][1] += PlayerInfo[playerid][pSemillas][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pSemillas][1],CasaInfo[house][hSemillas][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pSemillas][1] = 0;
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
                            CasaInfo[house][hDrogaP][1] += PlayerInfo[playerid][pDrogaP][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][1],CasaInfo[house][hDrogaP][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][1] = 0;
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
                            CasaInfo[house][hDrogaNP][1] += PlayerInfo[playerid][pDrogaNP][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pDrogaNP][1],CasaInfo[house][hDrogaNP][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaNP][1] = 0;
                        }
                    }        
					else if(strcmp(tipo,"Crack",true)==0)
                    {
                        if(strcmp(estado,"Preparada",true)==0)
                        {
                            CasaInfo[house][hDrogaP][2] += PlayerInfo[playerid][pDrogaP][2];
                            format(string, sizeof(string), "* Has escondido %d gramos en el armario. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][2],CasaInfo[house][hDrogaP][2]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][2] = 0;
                        }   
                    }
					SaveCasa(house);
					SaveValues(playerid,"Preparada");
					SaveValues(playerid,"NoPreparada");
					SaveValues(playerid,"Semillas");
                    return 1;
				}

            }
            new counter = 0;
            new result;
            for(new i=0; i != TotalVeh; i++)
            {
                new dist = CheckPlayerDistanceToVehicle(5.0, playerid, CarInfo[i][cId]);
                if(dist)
                {
                    result = i;
                    counter++;
                }
            }

            switch(counter)
            {
                case 0:
                {
                    SendClientMessage(playerid, Naranja, "* No hay coches cerca de ti o no estas en tu casa.");
                }

                case 1:
                {

                    if(Maletero[result]==0)
                    {
                        SendClientMessage(playerid, Rojo, "* El maletero no está abierto!");
                        return 1;
                    }
                     
                    if(strcmp(tipo,"Maria",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
                            CarInfo[result][cSemillas][0] += PlayerInfo[playerid][pSemillas][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pSemillas][0],CarInfo[result][cSemillas][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pSemillas][0] = 0;
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
                            CarInfo[result][cDrogaP][0] += PlayerInfo[playerid][pDrogaP][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][0],CarInfo[result][cDrogaP][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][0] = 0;
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
                            CarInfo[result][cDrogaNP][0] += PlayerInfo[playerid][pDrogaNP][0];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pDrogaNP][0],CarInfo[result][cDrogaNP][0]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaNP][0] = 0;
                        }
                    }
					else if(strcmp(tipo,"Coca",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
                            CarInfo[result][cSemillas][1] += PlayerInfo[playerid][pSemillas][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pSemillas][1],CarInfo[result][cSemillas][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pSemillas][1] = 0;
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
                            CarInfo[result][cDrogaP][1] += PlayerInfo[playerid][pDrogaP][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][1],CarInfo[result][cDrogaP][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][1] = 0;
                        }  
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
                            CarInfo[result][cDrogaNP][1] += PlayerInfo[playerid][pDrogaNP][1];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pDrogaNP][1],CarInfo[result][cDrogaNP][1]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaNP][1] = 0;
                        }
                    }
					else if(strcmp(tipo,"Crack",true)==0)
                    {
                        if(strcmp(estado,"Preparada",true)==0)
                        {
                            CarInfo[result][cDrogaP][2] += PlayerInfo[playerid][pDrogaP][2];
                            format(string, sizeof(string), "* Has escondido %d gramos en el maletero. Total: %d gramos.", PlayerInfo[playerid][pDrogaP][2],CarInfo[result][cDrogaP][2]);
                            SendClientMessage(playerid, Verde, string);
                            PlayerInfo[playerid][pDrogaP][2] = 0;
                        }   
                    }
                }
                default:
                {
                    SendClientMessage(playerid, Naranja, " Se ha detectado más de un vehículo cerca, por favor acérquese más a su vehículo.");
                }
            }
			SaveCar(result);
        }
		SaveValues(playerid, "Preparada");
		SaveValues(playerid,"NoPreparada");
		SaveValues(playerid,"Semillas");
		return 1;
	}
    
	if(strcmp(cmd,"/tomardrogas", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
			new cantidad;
			new counter = 0;
            new tipo[64];
            tipo = strtokex(cmdtext, idx);
            if(!strlen(tipo) || ( strcmp(tipo,"Maria",true)!=0 &&
                strcmp(tipo,"Crack",true)!=0 && strcmp(tipo,"Coca",true)!=0) )
            {
                SendClientMessage(playerid, Blanco, "USO: /tomardrogas [Maria/Coca/Crack] [Semillas/Preparada/NoPreparada] [Cantidad(opcional)]");
                return 1;
            }
            new estado[128];
            estado = strtokex(cmdtext, idx);
            if(!strlen(estado) || (strcmp(estado,"Semillas",true)!=0 &&
                strcmp(estado,"Preparada",true)!=0 && strcmp(estado,"NoPreparada",true)!=0) )
            {
                SendClientMessage(playerid, Blanco, "USO: /tomardrogas [Maria/Coca/Crack] [Semillas/Preparada/NoPreparada] [Cantidad(opcional)]");
                return 1;
            }
            
			new house = GetPlayerHouse(playerid);
            if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0) || IsACop(playerid))
			{
   				if (PlayerToPoint(100.0, playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
				{
					if(strcmp(tipo,"Maria",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pSemillas][0] += CasaInfo[house][hSemillas][0];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hSemillas][0], PlayerInfo[playerid][pSemillas][0]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hSemillas][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hSemillas][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pSemillas][0] += cantidad;
								CasaInfo[house][hSemillas][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pSemillas][0]);
								SendClientMessage(playerid, Verde, string);
							}
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][0] += CasaInfo[house][hDrogaP][0];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hDrogaP][0], PlayerInfo[playerid][pDrogaP][0]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hDrogaP][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hDrogaP][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][0] += cantidad;
								CasaInfo[house][hDrogaP][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][0]);
								SendClientMessage(playerid, Verde, string);
							}
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaNP][0] += CasaInfo[house][hDrogaNP][0];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hDrogaNP][0], PlayerInfo[playerid][pDrogaNP][0]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hDrogaNP][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hDrogaNP][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaNP][0] += cantidad;
								CasaInfo[house][hDrogaNP][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaNP][0]);
								SendClientMessage(playerid, Verde, string);
							}
                        }
                    }
					else if(strcmp(tipo,"Coca",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pSemillas][1] += CasaInfo[house][hSemillas][1];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hSemillas][1], PlayerInfo[playerid][pSemillas][1]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hSemillas][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hSemillas][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pSemillas][1] += cantidad;
								CasaInfo[house][hSemillas][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pSemillas][1]);
								SendClientMessage(playerid, Verde, string);
							}
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][1] += CasaInfo[house][hDrogaP][1];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hDrogaP][1], PlayerInfo[playerid][pDrogaP][1]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hDrogaP][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hDrogaP][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][1] += cantidad;
								CasaInfo[house][hDrogaP][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][1]);
								SendClientMessage(playerid, Verde, string);
							}
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaNP][1] += CasaInfo[house][hDrogaNP][1];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hDrogaNP][1], PlayerInfo[playerid][pDrogaNP][1]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hDrogaNP][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hDrogaNP][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaNP][1] += cantidad;
								CasaInfo[house][hDrogaNP][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaNP][1]);
								SendClientMessage(playerid, Verde, string);
							}
                        }
                    }        
					else if(strcmp(tipo,"Crack",true)==0)
                    {
                        if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][2] += CasaInfo[house][hDrogaP][2];
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",CasaInfo[house][hDrogaP][2], PlayerInfo[playerid][pDrogaP][2]);
								SendClientMessage(playerid, Verde, string);
								CasaInfo[house][hDrogaP][2] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CasaInfo[house][hDrogaP][2]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][2] += cantidad;
								CasaInfo[house][hDrogaP][2] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del armario. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][2]);
								SendClientMessage(playerid, Verde, string);
							}
                        }   
                    }
					SaveValues(playerid, "Preparada");
					SaveValues(playerid,"NoPreparada");
					SaveValues(playerid,"Semillas");
					SaveCasa(house);
					counter++;
                    return 1;
				}

            }
            new result;

            for(new i = 0; i != TotalVeh; i++)
            {
                new dist = CheckPlayerDistanceToVehicle(5.0, playerid, CarInfo[i][cId]);
                if(dist)
                {
                    result = i;
                    counter++;
                }
            }

            switch(counter)
            {
                case 0:
                {
                    SendClientMessage(playerid, Naranja, "No hay vehículo cerca de ti.");
                }

                case 1:
                {

                    if(Maletero[result]==0)
                    {
                        SendClientMessage(playerid, Rojo, "El maletero no está abierto!");
                        return 1;
                    }
                    
                    
                    if(strcmp(tipo,"Maria",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pSemillas][0] += CarInfo[result][cSemillas][0];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cSemillas][0], PlayerInfo[playerid][pSemillas][0]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cSemillas][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cSemillas][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pSemillas][0] += cantidad;
								CarInfo[result][cSemillas][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pSemillas][0]);
								SendClientMessage(playerid, Verde, string);
							}							
                        }   
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][0] += CarInfo[result][cDrogaP][0];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cDrogaP][0], PlayerInfo[playerid][pDrogaP][0]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cDrogaP][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cDrogaP][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][0] += cantidad;
								CarInfo[result][cDrogaP][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][0]);
								SendClientMessage(playerid, Verde, string);
							}		
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaNP][0] += CarInfo[result][cDrogaNP][0];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cDrogaNP][0], PlayerInfo[playerid][pDrogaNP][0]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cDrogaNP][0] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cDrogaNP][0]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaNP][0] += cantidad;
								CarInfo[result][cDrogaNP][0] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaNP][0]);
								SendClientMessage(playerid, Verde, string);
							}		
                        }
                    }
					else if(strcmp(tipo,"Coca",true)==0)
                    {
                        if(strcmp(estado,"Semillas",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pSemillas][1] += CarInfo[result][cSemillas][1];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cSemillas][1], PlayerInfo[playerid][pSemillas][1]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cSemillas][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cSemillas][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pSemillas][1] += cantidad;
								CarInfo[result][cSemillas][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pSemillas][1]);
								SendClientMessage(playerid, Verde, string);
							}							
                        }    
                        else if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][1] += CarInfo[result][cDrogaP][1];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cDrogaP][1], PlayerInfo[playerid][pDrogaP][1]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cDrogaP][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cDrogaP][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][1] += cantidad;
								CarInfo[result][cDrogaP][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][1]);
								SendClientMessage(playerid, Verde, string);
							}		
                        }   
                        else if(strcmp(estado,"NoPreparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaNP][1] += CarInfo[result][cDrogaNP][1];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cDrogaNP][1], PlayerInfo[playerid][pDrogaNP][1]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cDrogaNP][1] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cDrogaNP][1]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaNP][1] += cantidad;
								CarInfo[result][cDrogaNP][1] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaNP][1]);
								SendClientMessage(playerid, Verde, string);
							}		
                        }
                    }        
					else if(strcmp(tipo,"Crack",true)==0)
                    {
                        if(strcmp(estado,"Preparada",true)==0)
                        {
							tmp = strtokex(cmdtext, idx);
							cantidad = strval(tmp);
							if(!strlen(tmp))
							{
								PlayerInfo[playerid][pDrogaP][2] += CarInfo[result][cDrogaP][2];
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",CarInfo[result][cDrogaP][2], PlayerInfo[playerid][pDrogaP][2]);
								SendClientMessage(playerid, Verde, string);
								CarInfo[result][cDrogaP][2] = 0;
							}
							else
							{
								if(!IsNumeric(tmp)) return 1;
								if(cantidad > CarInfo[result][cDrogaP][2]){ SendClientMessage(playerid,Rojo,"* No tienes suficiente droga guardada");return 1; }
								PlayerInfo[playerid][pDrogaP][2] += cantidad;
								CarInfo[result][cDrogaP][2] -= cantidad;
								format(string, sizeof(string), "* Has cogido %d gramos del maletero. Tienes: %d gramos.",cantidad, PlayerInfo[playerid][pDrogaP][2]);
								SendClientMessage(playerid, Verde, string);
							}		
                        }   
                    }
                }

                default:
                {
                    SendClientMessage(playerid, Naranja, "* Se ha detectado más de un vehículo cerca, por favor acérquese más a su vehículo.");
                }
            }
			SaveCar(result);
        }
		SaveValues(playerid, "Preparada");
		SaveValues(playerid,"NoPreparada");
		SaveValues(playerid,"Semillas");
        return 1;
	}

	
	if(strcmp(cmd,"/surtidor", true) == 0)
	{
	if(FuerzaPublica(playerid)==0) return SendClientMessage(playerid,Rojo,"No eres de facción publica");
	new vehid;
	if (!IsPlayerInAnyVehicle(playerid))
    vehid = vehiculomascercano(playerid); // jugador fuera del coche, junto a él
	else
	vehid = GetPlayerVehicle(playerid); // jugador dentro del coche
	if(IsABike(vehid)) { SendClientMessage(playerid, Rojo, "* No puedes repostar una bici!"); return 1; }
	if(IsAtGasStation(playerid))
	{
	GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Llenando deposito, espera por favor!",4800,3);
	Refueling[playerid] = 1;
	TogglePlayerControllable(playerid,0);
	PlayerInfo[playerid][pTempFrozen] = 1;
	SetTimerEx("Fillup",5000,0, "ddd", playerid, vehid, -1);
	}
	return 1;
	}
	/*if(strcmp(cmd,"/guardararma", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
			new house = GetPlayerHouse(playerid);
            if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0) || IsACop(playerid))
			{
   				if (PlayerToPoint(100.0, playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
				{
                    new buffer[128];
                    new gunname[100];
                    new weapontype;
                    new gunID = GetPlayerWeapon(playerid);
                    new gunAmmo = GetPlayerAmmo(playerid);

                    new plyWeapons[12];
                    new plyAmmo[12];

                    if(gunID != 0)
                    {
					
						if(!PlayerHaveWeapon(playerid, gunID))
						{
							SafeResetPlayerWeaponsAC(playerid);
							printf("%s (ID:%d) está intentando guardar armas ilegales en un armario.",pName(playerid), playerid);
							format(string, 128, "* %s (ID:%d) está intentando guardar armas ilegales en un armario.",pName(playerid), playerid);
							ABroadCast(RojoIntenso, string, 1);
							return 1;
						}
					
                        GetWeaponName(gunID, gunname, sizeof(gunname));

                        // Step 1: Store all the players guns (except for the one being put in the house.)
                        for(new slot = 0; slot != 12; slot++)
                        {
                            new wep, ammo;
                            GetPlayerWeaponData(playerid, slot, wep, ammo);
                            if(wep != gunID)
                            {
                                GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
                            }
                            else
                                weapontype = slot;
                        }

                        // Step 2: Store the gun being put in the house and display the message.
                        new guardado = 0;
                        for(new s=0; s < 10; s++)
                        {
                            if(CasaInfo[house][hGun][s] == -1)
                            {
                                CasaInfo[house][hGun][s] = gunID;
                                if (weapontype == 0 || weapontype == 1 || weapontype == 10)
                                    CasaInfo[house][hAmmo][s] = 0;
                                else
                                    CasaInfo[house][hAmmo][s] = gunAmmo;
                                guardado = 1;
                                break;
                            }
                        }

                        if(guardado == 0)
                        {
                            SendClientMessage(playerid, Rojo, "* El armario está lleno.");
                            return 1;
                        }
                        if (weapontype == 0 || weapontype == 1 || weapontype == 10)
                            format(buffer, sizeof(buffer), "* Has guardado tu %s en el armario.", gunname, gunAmmo);
                        else
                            format(buffer, sizeof(buffer), "* Has guardado tu %s (BALAS: %i) en el armario.", gunname, gunAmmo);
                        SendClientMessage(playerid, Verde, buffer);

                        // This adds back your guns EXCEPT for the one stored.
                        EnActividad[playerid] = 1;
                        ActualizarArmasEx(playerid, weapontype);
						new hour,minute,second,year,month,day;
						gettime(hour,minute,second);
						getdate(year, month, day);
						new query[1024];
						format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('%s', 'Armario %d', '/guardararma | %s | %d','%d:%d:%d | %d-%d-%d')", pNameEx(playerid), CasaInfo[house][hId], gunname, gunAmmo,hour,minute,second,day,month,year);
						mysql_query(query);
                    }
                    else
                    {
                        SendClientMessage(playerid, Rojo, "* No tienes nada en mano para guardar aquí.");
                    }
					SaveCasa(house);
                    return 1;
                }
            }
            new counter = 0;
            new result;

            for(new i = 0; i != TotalVeh; i++)
            {
                new dist = CheckPlayerDistanceToVehicle(5.0, playerid,CarInfo[i][cId]);
                if(dist)
                {
                    result = i;
                    counter++;
                }
            }

            switch(counter)
            {
                case 0:
                {
                    SendClientMessage(playerid, Rojo, "* No hay coches cerca de ti o no estas en tu casa.");
                }

                case 1:
                {
                    if(Maletero[result]==0)
                    {
                        SendClientMessage(playerid, Rojo, "* El maletero no está abierto!");
                        return 1;
                    }

                    if(!IsPlayerInAnyVehicle(playerid))
                    {
                        new buffer[128];
                        new gunname[100];
                        new weapontype;
                        new gunID = GetPlayerWeapon(playerid);
                        new gunAmmo = GetPlayerAmmo(playerid);

                        new plyWeapons[12];
                        new plyAmmo[12];

                        if(gunID != 0)
                        {
						
							if(!PlayerHaveWeapon(playerid, gunID))
							{
								SafeResetPlayerWeaponsAC(playerid);
								printf("%s (ID:%d) está intentando guardar armas ilegales en un maletero.",pName(playerid), playerid);
								format(string, 128, "* %s (ID:%d) está intentando guardar armas ilegales en un maletero.",pName(playerid), playerid);
								ABroadCast(RojoIntenso, string, 1);
								return 1;
							}
						
                            GetWeaponName(gunID, gunname, sizeof(gunname));

                            // Step 1: Store all the players guns (except for the one being put in the car.)
                            for(new slot = 0; slot != 12; slot++)
                            {
                                new wep, ammo;
                                GetPlayerWeaponData(playerid, slot, wep, ammo);
                                if(wep != gunID)
                                {
                                    GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
                                }
                                else
                                    weapontype = slot;
                            }

                            // Step 2: Store the gun being put in the car and display the message.
                            new guardado = 0;
                            for(new s=0; s < MAX_TRUNK_SLOTS; s++)
                            {
                                if(CarInfo[result][cSlot][s] == -1)
                                {
                                    CarInfo[result][cSlot][s] = gunID;
                                    if (weapontype == 0 || weapontype == 1 || weapontype == 10)
                                        CarInfo[result][cAmmo][s] = 0;
                                    else
                                        CarInfo[result][cAmmo][s] = gunAmmo;
                                    guardado = 1;
                                    break;
                                }
                            }

                            if(guardado == 0)
                            {
                                SendClientMessage(playerid, Rojo, "* El maletero está lleno.");
                                return 1;
                            }
                            if (weapontype == 0 || weapontype == 1 || weapontype == 10)
                                format(buffer, sizeof(buffer), "* Has guardado tu %s en el maletero.", gunname, gunAmmo);
                            else
                                format(buffer, sizeof(buffer), "* Has guardado tu %s (BALAS: %i) en el maletero.", gunname, gunAmmo);
                            SendClientMessage(playerid, Verde, buffer);

                            // This adds back your guns EXCEPT for the one stored.
							EnActividad[playerid] = 1;
                            ActualizarArmasEx(playerid, weapontype);
							
							SaveCar(result);
							
							new hour,minute,second,year,month,day;
							gettime(hour,minute,second);
							getdate(year, month, day);
							new query[1024];
							format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('%s', 'Maletero %d', '/guardararma | %s | %d','%d:%d:%d | %d-%d-%d')", pNameEx(playerid), CarInfo[result][cCarKey], gunname, gunAmmo,hour,minute,second,day,month,year);
							mysql_query(query);
                        }
                        else
                        {
                            SendClientMessage(playerid, Rojo, "* No tienes nada en mano para guardar aquí.");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, Rojo, "* No puedes abrir el maletero.");
                    }
                }

                default:
                {
                    SendClientMessage(playerid, Naranja, "* Se ha detectado más de un vehículo cerca, acércate más al objetivo.");
                }
            }
        }
		return 1;
	}*/

	
	if(strcmp(cmdtext, "/pasamontañas", true) == 0)
	{
	    for(new i = 1; i < 13; i++) {
		if(BolsilloID[playerid][i] == 74 && BolsilloCantidad[playerid][i] >= 1) {
	    if(Usando[playerid]==1)
	    {
	        new pname[24];
	        GetPlayerName(playerid, pname, 24);
	        format(string, sizeof(string), "** Alguien se quitó el pasamontañas.");
	        ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	        SendClientMessage(playerid, COLOR_LIGHTGREEN,"Te has quitado el pasamontañas.");
	        Usando[playerid]=0;
	        SetTimerEx("PasamontanasU", 1, 1, "i", playerid);
	        return 1;
	    }
	    else if(Usando[playerid] == 0)
	    {
     		new pname[24];
	        GetPlayerName(playerid, pname, 24);
	        format(string, sizeof(string), "** Alguien se puso el pasamontañas.");
	        ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SendClientMessage(playerid, COLOR_LIGHTGREEN,"Te has puesto el pasamontañas.");
			Usando[playerid] = 1;
			BolsilloCantidad[playerid][i]--;
			SetTimerEx("PasamontanasU", 1, 1, "i", playerid);
			PlayerInfo[playerid][pPasamontanas] -= 1;
			return 1;
		}
		}
		else { Mensaje(playerid, COLOR_ERRORES, "¡No tienes un pasamontañas!"); }
		}
		return 1;
	}
	if(strcmp(cmd, "/tomardinero", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
			new house = GetPlayerHouse(playerid);
			if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0) || IsACop(playerid))
			{
            
				if (!PlayerToPoint(100.0,playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) || GetPlayerVirtualWorld(playerid)!=CasaInfo[house][hId])
				{
					SendClientMessage(playerid, Rojo, "* No estas en tu casa!");
					return 1;
				}
                
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /tomardinero [cantidad]");
					format(string, sizeof(string), "* Tienes %d$ en tu caja fuerte.", CasaInfo[house][hDinero]);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /tomardinero [cantidad]");
					format(string, sizeof(string), "* Tienes %d$ en tu caja fuerte.", CasaInfo[house][hDinero]);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
				if (cashdeposit >  CasaInfo[house][hDinero] || cashdeposit < 1)
				{
					SendClientMessage(playerid, Rojo,"* No tienes tanto dinero!");
					return 1;
				}

				else
				{
					SafeGivePlayerMoney(playerid,cashdeposit);
					CasaInfo[house][hDinero]-=cashdeposit;
					format(string, sizeof(string), "* Has cogido %d$ de tu caja fuerte. Quedan: %d$ ", cashdeposit,CasaInfo[house][hDinero]);
					SaveCasa(house);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes una casa.");
			}
		}
		return 1;

	}
	if(strcmp(cmd, "/guardardinero", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
			new house = GetPlayerHouse(playerid);
			if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0) || IsACop(playerid))
			{
                if (!PlayerToPoint(100.0,playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) || GetPlayerVirtualWorld(playerid)!=CasaInfo[house][hId])
				{
					SendClientMessage(playerid, Rojo, "* No estas en tu casa!");
					return 1;
				}

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /guardardinero [cantidad]");
					format(string, sizeof(string), "* Tienes %d$ en tu caja fuerte.", CasaInfo[house][hDinero]);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /guardardinero [cantidad]");
					format(string, sizeof(string), "* Tienes %d$ en tu caja fuerte.", CasaInfo[house][hDinero]);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
				if (cashdeposit > GetPlayerMoney(playerid) || cashdeposit < 1)
				{
					SendClientMessage(playerid, Rojo,"* No tienes tanto dinero!");
					return 1;
				}
				else
				{
					SafeGivePlayerMoney(playerid,-cashdeposit);
					CasaInfo[house][hDinero]+=cashdeposit;
					format(string, sizeof(string), "* Has guardado %d$ en tu caja fuerte. Hay: %d$ ", cashdeposit,CasaInfo[house][hDinero]);
					SaveCasa(house);
					SendClientMessage(playerid, Verde, string);
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes una casa.");
			}
		}
		return 1;

	}
	if(strcmp(cmd, "/peaje", true) == 0)
	{
     if(IsPlayerConnected(playerid))
		{
            if(bloqueopeajes==1) return SendClientMessage(playerid,Rojo,"Todas las salidas de peaje han sido bloqueadas");
	        if(PlayerToPoint(7.0, playerid,68.10, -1536.35, 4.85))
			{
			
                SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	      		MoveDynamicObject(peaje1, 68.10, -1536.35, 4.85,3.0,0.00, 4.00, 88.72);
				SetTimer("TiempoPeaje1", 4000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
			if(PlayerToPoint(7.0, playerid,35.05, -1526.01, 4.95))
			{
				SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	      		MoveDynamicObject(peaje2, 35.05, -1526.01, 4.95,3.0,0.00, 4.00, 86.88);
	      		//SetDynamicObjectRot(peaje2, 0.00, 4.00, 86.88);
				SetTimer("TiempoPeaje2", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
			if(PlayerToPoint(7.0, playerid,1636.15, -18.22, 36.35))
			{
				SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	      		MoveDynamicObject(peajelv1, 1636.15, -18.22, 36.35,3.0,0.00, -4.00, 23.00);
	      		//SetDynamicObjectRot(peajelv1, 0.00, -4.00, 23.00);
				SetTimer("TiempoPeajeLV1", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
			if(PlayerToPoint(7.0, playerid,1643.57, -1.46, 36.33))
			{
				SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
                MoveDynamicObject(peajelv2, 1643.57, -1.46, 36.33,0.00, -11.00, 23.00);
	      		//SetDynamicObjectRot(peajelv2, 0.00, -11.00, 23.00);
				SetTimer("TiempoPeajeLV2", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
			if(PlayerToPoint(7.0, playerid,607.31, -1202.22, 17.90))
			{
                SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      	    ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	      		//SetDynamicObjectRot(peaje3, 0.00, 4.00, 19.28);
	      		MoveDynamicObject(peaje3, 607.31, -1202.22, 17.90,0.00, 4.00, 19.28);
				SetTimer("TiempoPeaje3", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
			if(PlayerToPoint(7.0, playerid,623.30, -1186.60, 18.97))
			{
				SafeGivePlayerMoney(playerid, -5);
	      		format(string, sizeof(string), "* %s le entrega el dinero al señor del peaje.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje4, 0.00, 4.00, 28.70);
	            //MoveDynamicObject(peaje4, 623.30, -1186.60, 18.97,0.00, 4.00, 28.70);
				SetTimer("TiempoPeaje4", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera del peaje, se cerrara automaticamente en 7 segundos.");
			}
		}
		return 1;
	}
	/*if(strcmp(cmd, "/onlineradio", true) == 0)
	{
	PlayAudioStreamForPlayer(playerid, "http://s6.myradiostream.com:3552/listen.pls", 0,0,0,0,0);
	return 1;
	}
	if(strcmp(cmd, "/offradio", true) == 0)
	{
	StopAudioStreamForPlayer(playerid);
	return 1;
	}*/
	
	
	
	
	
	
    if (strcmp("/nameoff", cmdtext, true) == 0) //The player who typed /nameoff will not be able to see any other players nametag.
    {
        for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(playerid, i, false);
        return 1;
    }
    if (strcmp("/nameon", cmdtext, true) == 0)
    {
        for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(playerid, i, true);
        return 1;
    }
	/*if(strcmp(cmd, "/cartera", true) == 0)
	{
	    tmp = strtokex(cmdtext, idx);
    	if(!strlen(tmp)) { SendClientMessage(playerid, Blanco, "USO: /cartera [IdJugador/ParteDelNombre]"); return 1; }
    	new player1;
		if(!IsNumeric(tmp))
		player1 = ReturnUser(tmp,playerid);
   		else player1 = strval(tmp);
 		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID)
		{
			if(GetDistanceBetweenPlayers(playerid, player1) > 8)
			{
				SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
				return 1;
			}
			format(string, sizeof(string), "* %s le muestra su cartera a %s.", pName(playerid), pName(player1));
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			else {
			ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			format(string,sizeof(string),"Cartera de %s: %d%",pName(playerid),SafeGetPlayerMoney(playerid));
			SendClientMessage(player1,AmarilloClaro,string);
		}
		else { SendClientMessage(playerid,Rojo,"ERROR: Jugador no conectado."); }
		return 1;
	}*/
	if(strcmp(cmd, "/id", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /id [IdJugador/ParteDelNombre]");
			return 1;
		}
		new target = ReturnUser(tmp);
		if(IsPlayerConnected(target) && target != INVALID_PLAYER_ID)
	    {
			format(string, sizeof(string), "ID: (%d) %s",target,pName(target));
			SendClientMessage(playerid, AzulClaro, string);
		}
		else { SendClientMessage(playerid,Rojo,"ERROR: Jugador no conectado."); }
		return 1;
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(PlayerInfo[playerid][pJugando] == 0) {SendClientMessage(playerid,Rojo,"Conectate primero"); return 0;}
	if(PlayerInfo[playerid][pEditingNeg] > 0 || PlayerInfo[playerid][pMoviendoNeg] > 0)
	{
    	Negocios_OnPlayerText(playerid, text);
    	return 0;
	}

	if(PlayerInfo[playerid][pEligiendoColores] > 0)
	{
	    Tunning_OnPlayerText(playerid, text);
	    return 0;
	}
    
	if(PlayerInfo[playerid][pHablandoPizza] == 1)
	{
		LlamadaPizza(playerid, text);
		return 0;
	}
	if(EditingHQ[playerid] > 0)
	{
		format(HeadQuarterInfo[EditingHQ[playerid]][hqName], 128, "%s", text);
		format(string, sizeof(string), "Has cambiado el nombre del Negocio a: '%s'", text);
		SendClientMessage(playerid, COLOR_GRAD2, string);
		SaveHeadQuarter(EditingHQ[playerid]);
		EditingHQ[playerid] = 0;
		return 0;
	}
	if(MoviendoHQ[playerid] > 0)
	{
		new Float:X[MAX_PLAYERS], Float:Y[MAX_PLAYERS], Float:Z[MAX_PLAYERS];
		GetPlayerPos(playerid, X[playerid],Y[playerid],Z[playerid]);
  		HeadQuarterInfo[MoviendoHQ[playerid]][hqEPos_x] = X[playerid];
    	HeadQuarterInfo[MoviendoHQ[playerid]][hqEPos_y] = Y[playerid];
     	HeadQuarterInfo[MoviendoHQ[playerid]][hqEPos_z] = Z[playerid];
		SaveHeadQuarter(MoviendoHQ[playerid]);
		DestroyPickup(HeadQuarterInfo[MoviendoHQ[playerid]][hqPickup]);
		HeadQuarterInfo[MoviendoHQ[playerid]][hqPickup] = CreatePickup(1273, 23, X[playerid], Y[playerid], Z[playerid]);
		SendClientMessage(playerid, COLOR_GRAD4, "Hecho");
		MoviendoHQ[playerid] = 0;
		return 0;
	}
	if(PlayerInfo[playerid][pUsandoTelefono] == 911)
	{
		if ((strcmp("policia", text, true, strlen(text)) == 0) && (strlen(text) == strlen("policia")))
		{
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: Espere mientras le pasamos al departamento policial...");
			PlayerInfo[playerid][pUsandoTelefono] = 912;
			new Cops=0;
			for(new i=0;i<MAX_PLAYERS;i++)
			{
				if(IsACop(i) && PlayerInfo[i][pDuty] > 0)
				{
					SendClientMessage(i, AzulClaro, "EMERGENCIAS: Una llamada esta siendo transferida al departamento de policía. (( /contestar para coger en teléfono ))");
					Cops++;
				}
			}
			if(Cops < 1){SendClientMessage(playerid, AzulClaro, "Nadie responde a tu llamada!. (( No hay policías jugando ))");Cops=0;}
			return 0;
		}
		else if ((strcmp("medico", text, true, strlen(text)) == 0) && (strlen(text) == strlen("medico")))
		{
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: Espere mientras le pasamos al departamento médico...");
			PlayerInfo[playerid][pUsandoTelefono] = 913;
    		new Meds=0;
			for(new i=0;i<MAX_PLAYERS;i++)
			{
				if(IsAMedic(i) && PlayerInfo[i][pDuty] > 0)
				{
					SendClientMessage(i, AzulClaro, "EMERGENCIAS: Una llamada esta siendo transferida al departamento de médicos. (( /contestar para coger en teléfono ))");
					Meds++;
				}
			}
			if(Meds < 1){SendClientMessage(playerid, AzulClaro, "Nadie responde a tu llamada!. (( No hay médicos jugando ))");Meds=0;}
			return 0;
		}
		else if ((strcmp("bombero", text, true, strlen(text)) == 0) && (strlen(text) == strlen("bombero")))
		{
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: Espere mientras le pasamos al departamento de bomberos...");
			PlayerInfo[playerid][pUsandoTelefono] = 916;
    		new Bombs=0;
			for(new i=0;i<MAX_PLAYERS;i++)
			{
				if(IsABombero(i) && PlayerInfo[i][pDuty] > 0)
				{
					SendClientMessage(i, AzulClaro, "EMERGENCIAS: Una llamada esta siendo transferida al departamento de Bomberos. (( /contestar para coger en teléfono ))");
					Bombs++;
				}
			}
			if(Bombs < 1){SendClientMessage(playerid, AzulClaro, "Nadie responde a tu llamada!. (( No hay bomberos jugando ))");Bombs=0;}
			return 0;
		}
		else
		{
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: No le entiendo, ¿Policia , Medico o bombero?");
			return 0;
		}
    }
	
	if(PlayerInfo[playerid][pUsandoTelefono] == 575)
	{
		new tmp[128], tmp2[128];
		if(strlen(text) < 10 || strlen(text) > 98){ SendClientMessage(playerid, Rojo, "* Mensaje demasiado corto, o demasiado largo."); return 0;}
		format(tmp, sizeof(tmp), "[ANUNCIO]: %s, contacto: %d",text, PlayerInfo[playerid][pPnumber][ActiveNumber[playerid]]);
		format(tmp2, sizeof(tmp2), "[ID:%d][ANUNCIO]: %s, contacto: %d",playerid, text, PlayerInfo[playerid][pPnumber][ActiveNumber[playerid]]);
		PlayerInfo[playerid][pBank] -= 200;
		SaveValue(playerid, "Banco", PlayerInfo[playerid][pBank]);
		
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pAdmin] > 0)
				{
					SendClientMessage(i, Verde, tmp2);
				}
				else
				{
					SendClientMessage(i, Verde, tmp);
				}
			}
		}
		PlayerInfo[playerid][pUsandoTelefono] = 0;
		AnuncioTimer = 1;
		SetTimerEx("ResetearTimerAnuncios",119999,0,"");
		return 0;
	}
	
   	if ( Casas_OnPlayerText(playerid,text) ) return 0;
        
	if ( Tlf_OnPlayerText(playerid, text) ) return 0;
	
	if ( Comidas_OnPlayerText(playerid, text) ) return 0;
	
	if ( Reporteros_OnPlayerText(playerid, text) ) return 0;
    
	if ( Park_OnPlayerText(playerid, text) ) return 0;

	AFK_OnPlayerText(playerid);
	Texto_OnPlayerText(playerid, text);
	
	/*if(Usando[playerid] == 1)
	{
	format(string, sizeof(string), "Enmascarado dice: %s", text);
	ProxDetector(9.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);
	return 0;
	}*/
	
    //ChatLog(playerid, text);
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    

    
	Admin_OnPlayerStateChange(playerid, newstate);
	Autoesc_OnPlayerStateChange(playerid, newstate, oldstate);
    Vehicles_OnPlayerStateChange(playerid, newstate, oldstate);
    Tunning_OnPlayerStateChange(playerid, newstate, oldstate);
	Radio_OnPlayerStateChange(playerid, newstate, oldstate);
	Taxis_OnPlayerStateChange(playerid, newstate, oldstate);
	LimpiaC_OnPlayerStateChange(playerid);
	Basura_OnPlayerStateChange(playerid);
	Speedcap_OnPlayerStateChange(playerid, newstate);
	/*if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
   {
          TextDrawShowForPlayer(playerid, Velocimetro_1[playerid]);
          TextDrawShowForPlayer(playerid, Velocimetro_2[playerid]);
      TimerVelocimetro[playerid] = SetTimerEx("Velocimetro", 1500, true, "i", playerid);
   }*/
   /*else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
   {
      TextDrawHideForPlayer(playerid, Velocimetro_1[playerid]);
      TextDrawHideForPlayer(playerid, Velocimetro_2[playerid]);
      KillTimer(TimerVelocimetro[playerid]);
   }*/
    if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT && JugadorChoque[playerid] == 1)
	{

    SendClientMessage(playerid,Amarillo,"¡Estás noqueado, debes esperar a los bomberos!");
	PutPlayerInVehicle(playerid, PlayerInfo[playerid][pLastCar2], 0);
	}
	if(newstate == PLAYER_STATE_DRIVER) {
	format(CarInfo[GetPlayerVehicleID(playerid)][cUltimoOcupante], 128, "%s", pName(playerid));
	}
	// Activar LAPD Scanner:
    /*if(GetVehicleModel(vehicleid) == 596 || GetVehicleModel(vehicleid) == 597 || GetVehicleModel(vehicleid) == 598 && Scanner[vehicleid] == 1)
    {
    PlayAudioStreamForPlayer(playerid, "http://k007.kiwi6.com/hotlink/rvr1gpwgfs/lapd_scanner.mp3");
    vScanner[playerid] = SetTimerEx("LAPD_Scanner", 611000, true, "d", playerid);
    Scanner[vehicleid] = 1;
    }*/
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(Vehicles_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Admin_OnPlayerKeyStateChange(playerid, newkeys)) return 1;
	else if(Uniform_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Drogas_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Puertas_OnPlayerKeyStateChange(playerid, newkeys)) return 1;
	else if(Anims_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
    else if(Carreras_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Low_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Ascensor_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	if(ViendoInfo[playerid] == 1)
	{
	    for(new i = 0; i < 10; i ++)
	    {
	        TextDrawHideForPlayer(playerid, Txt[playerid][i]);
	    }
	    ViendoInfo[playerid] = 0;
	    return 1;
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
	{
		if(Comando_Entrar(playerid) == 0) return Comando_Salir(playerid);
		else if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		 if(EnTaller[playerid] == 0){
		RemovePlayerFromVehicle(playerid);
		TogglePlayerControllable(playerid, 1);
                }
			}
	}

	if(newkeys & KEY_SUBMISSION)
	{
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && FuerzaPublica(playerid) == 1)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
   			if(UsarLuces[playerid] == 0)
		    {
		        if(IsBuffalo(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.449999,0.749999,0.000000,0.000000,0.000000);
		        }
		        else if(IsSultan(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.0, -0.10, 0.8, 0, 0, 0);
		        }
		        else if(IsFBIRancher(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,0.225000,1.049999,0.000000,0.000000,0.000000);
		        }
		        else if(IsHuntley(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,0.000000,1.200000,0.000000,0.000000,0.000000);
		        }
		        else if(IsFlatbed(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,1.275000,1.650000,0.000000,0.000000,0.000000);
		        }
		        else if(IsCamionBombero(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,2.400000,1.500000,0.000000,0.000000,0.000000);
		        }
		        else if(IsVincent(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.450000,0.674999,0.000000,0.000000,0.000000);
		        }
		        else if(IsBoxVille(playerid))
		        {
                    if(vLuz[vehicleid] == 0) return SendClientMessage(playerid, -1, "{FF0000}Debes usar /barraluces primero.");
		            DestroyDynamicObject(Luz[vehicleid]);
		            DestroyDynamicObject(Luz2[vehicleid]);
		            vpLuz[vehicleid] = 1;
		            LucesEncendidas[vehicleid] = 1;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    Luz2[vehicleid] = CreateDynamicObject(19419,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,1.875000,2.025000,0.000000,0.000000,0.000000);
                    AttachDynamicObjectToVehicle(Luz2[vehicleid], vehicleid, 0.000000,-2.775001,2.100000,0.000000,0.000000,0.000000);
		        }
		        else return SendClientMessage(playerid, 0xAFAFAFAA, "Este vehículo no tiene sirena.");
		        UsarLuces[playerid] = 1;
		        return 1;
		    }
		    else if(UsarLuces[playerid] == 1)
		    {
		        if(IsBuffalo(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.449999,0.749999,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsSultan(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.0, -0.10, 0.8, 0, 0, 0);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsFBIRancher(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,0.225000,1.049999,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsHuntley(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,0.000000,1.200000,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsFlatbed(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,1.275000,1.650000,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsCamionBombero(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,2.400000,1.500000,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        else if(IsVincent(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.450000,0.674999,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		         else if(IsBoxVille(playerid))
		        {
                    DestroyDynamicObject(Luz[vehicleid]);
                    DestroyDynamicObject(Luz2[vehicleid]);
                    vpLuz[vehicleid] = 0;
                    vLuz[vehicleid] = 0;
                    vLuz2[vehicleid] = 0;
                    LucesEncendidas[vehicleid] = 0;
                    PuedeUsarLuces[vehicleid] = 1;
                    Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    Luz2[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
                    AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid,  0.000000,1.875000,2.025000,0.000000,0.000000,0.000000);
                    AttachDynamicObjectToVehicle(Luz2[vehicleid], vehicleid, 0.000000,-2.775001,2.100000,0.000000,0.000000,0.000000);
                    SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
		        }
		        UsarLuces[playerid] = 0;
				return 1;
		    }
		}
	}
        
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	Vehicle_OnPlayerExitVehicle(playerid, vehicleid);
	Autoesc_OnPlayerExitVehicle(playerid, vehicleid);
    Pizza_OnPlayerExitVehicle(playerid,vehicleid);
    Cinturon_OnPlayerExitVehicle(playerid, vehicleid);
    Bomberos_OnPlayerExitVehicle(playerid, vehicleid);
	PlayerInfo[playerid][pFixDeathCar] = 1;
	SetTimerEx("FixDeathCar", 5000, 0, "i", playerid);

    // Desactivar LAPD Scanner:
    /*if(GetVehicleModel(vehicleid) == 596 || GetVehicleModel(vehicleid) == 597 || GetVehicleModel(vehicleid) == 598 && Scanner[vehicleid] == 1)
    {
    StopAudioStreamForPlayer(playerid);
    KillTimer(vScanner[playerid]);
    Scanner[vehicleid] = 0;
    }*/

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	Vehicles_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    Pizza_OnPlayerEnterVehicle(playerid,vehicleid, ispassenger);
    Cinturon_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    
    
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(Basura_OnPlayerEnterCheckpoint(playerid)) return 1;
	if(Sis_Cos_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Sis_Pes_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(LimpiaC_OnPlayerEnterCheckpoint(playerid)) return 1; 
	//if(Armas_OnPlayerEnterCheckpoint(playerid)) return 1;
	if(Parking_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Medicos_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Autoesc_OnPlayerEnterCheckpoint(playerid)) return 1; 
    if(Pizza_OnPlayerEnterCheckpoint(playerid)) return 1; 
    if(Reparto_OnPlayerEnterCheckpoint(playerid)) return 1; 
    if(Ambulan_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Taxis_OnPlayerEnterCheckpoint(playerid)) return 1; 
    if(Ladron_OnPlayerEnterCheckpoint(playerid)) return 1; 
    if(Veh_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Tunning_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(MisBand_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Low_OnPlayerEnterCheckpoint(playerid)) return 1;
    if(Bomber_OnPlayerEnterCheckpoint(playerid)) return 1;
    if(UsandoGPS[playerid]==1)
    {
    DisablePlayerCheckpoint(playerid);
	UsandoGPS[playerid] = 0;
    }
    if(AvisoEmergencias[playerid] == 1)
    {
	DisablePlayerCheckpoint(playerid);
	Mensaje(playerid, Verde, "¡Has llegado al checkpoint de emergencias! ¡Atiende al sujeto!");
	}
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    Carreras_OnPlayerEnterRaceCheck(playerid);
    return 1;
}
public OnVehicleMod(playerid,vehicleid,componentid)
{
    printf("Vehicle %d was modded by ID %d with the componentid %d",vehicleid,playerid,componentid);
    if(GetPlayerInterior(playerid) == 0)
    {
        Ban(playerid); // Anti-tuning hacks script
        //(Tested and it works even on servers wich allow you to mod your vehicle using commands, menus, dialogs, etc..
    }
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{

	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	Vehicles_OnVehicleDeath(vehicleid, killerid);
    
        
    //Sirenas
        
    //DestroyDynamicObject(Luces[killerid]);
	UsarLuces[killerid] = 0;
	PuedeUsarLuces[killerid] = 0;
	// Evitamos bug de sirenas
	vLuz[vehicleid] = 0;
	vLuz2[vehicleid] = 0;
	vpLuz[vehicleid] = 0;
	LucesEncendidas[vehicleid] = 0;
	PuedeUsarLuces[vehicleid] = 0;
	DestroyDynamicObject(Luz[vehicleid]);
	
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(ArmaBlanca[playerid] >= 1) { format(calibre1, sizeof(calibre1), " Golpes de arma blanca: (%d) //", ArmaBlanca[playerid]); strcat(textobalas, calibre1); }
	if(Calibre9mm[playerid] >= 1) { format(calibre2, sizeof(calibre2), " Balas 9x19 Parabellum: (%d) //", Calibre9mm[playerid]); strcat(textobalas, calibre2); }
	if(Calibre45[playerid] >= 1) { format(calibre3, sizeof(calibre3), " Balas del .38: (%d) //", Calibre45[playerid]); strcat(textobalas, calibre3); }
	if(Calibre37[playerid] >= 1) { format(calibre4, sizeof(calibre4), " Balas de calibre .20 Gauge: (%d) //", Calibre37[playerid]);  strcat(textobalas, calibre4); }
	if(Calibre919[playerid] >= 1) { format(calibre5, sizeof(calibre5), " Balas 9x19 Parabellum: (%d) //", Calibre919[playerid]); strcat(textobalas, calibre5); }
	if(Calibre10mm[playerid] >= 1) { format(calibre6, sizeof(calibre6), " Balas de calibre 10mm: (%d) //", Calibre10mm[playerid]);  strcat(textobalas, calibre6); }
	if(Calibre22[playerid] >= 1) { format(calibre7, sizeof(calibre7), " Balas de calibre 7.62x39 R: (%d) //", Calibre22[playerid]); strcat(textobalas, calibre7); }
	if(Calibre24[playerid] >= 1) { format(calibre8, sizeof(calibre8), " Balas de calibre 5.56x45 OTAN: (%d) //", Calibre24[playerid]); strcat(textobalas, calibre8); }
	if(Calibre44[playerid] >= 1) { format(calibre9, sizeof(calibre9), " Balas de calibre .44: (%d) //", Calibre44[playerid]); strcat(textobalas, calibre9); }
	if(Goma[playerid] >= 1) { format(calibre10, sizeof(calibre10), " Impactos de goma: (%d) //", Goma[playerid]); strcat(textobalas, calibre10); }
	if(Calibre57[playerid] >= 1) { format(calibre11, sizeof(calibre11), " Balas de calibre 7.62x51: (%d) //", Calibre57[playerid]); strcat(textobalas, calibre11); }
	if(DanoDesconocido[playerid] >= 1) { format(calibre12, sizeof(calibre12), " Daños desconocidos:(%d) //", DanoDesconocido[playerid]); strcat(textobalas, calibre12); }
	if(Cortes[playerid] >= 1) { format(calibre13, sizeof(calibre13), " Cortes de arma blanca: (%d) //", Cortes[playerid]); strcat(textobalas, calibre13); }
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,1);
	ApplyAnimation(playerid,"WUZI","CS_Dead_Guy",4.0,1,1,1,1,200,1);
	EnActividad[playerid] = 1;
	ResetearVariablesArmas(playerid);
	Admin_OnPlayerDeath(playerid);
	Radio_OnPlayerDeath(playerid);
	Anims_OnPlayerDeath(playerid);
	Paintball_OnPlayerDeath(playerid);
	MisBand_OnPlayerDeath(playerid);
	Medicos_OnPlayerDeath(playerid, killerid, reason);
	TieneTaser[playerid] = 0;
	Taseado[playerid] = 0;
	Anim[playerid] = 0;
	Cables[playerid] = 0;
	Taseador[playerid] = 0;
    //KillTimer(TimerBot);
    //KillTimer(Morder[playerid]);
    //MatarTimer[playerid] = 1;
    //MatarTimer[jugadorid] = 1;
    //Morder[playerid] = 0;
    //Descongelar(jugadorid);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	//SaveValues(playerid, "Armas");
	//SaveValues(playerid, "Ammo");
	
	Speedcap_OnPlayerUpdate(playerid);
	Accesorios_OnPlayerUpdate(playerid);
	Taxis_OnPlayerUpdate(playerid);
	Tunning_OnPlayerUpdate(playerid);
	Autoesc_OnPlayerUpdate(playerid);
	/*laser_OnPlayerUpdate(playerid);*/
	Admin_OnPlayerUpdate(playerid);
	Radio_OnPlayerUpdate(playerid);
	/*Gangs_OnPlayerUpdate(playerid);*/
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if(Health > 100 && PlayerInfo[playerid][pAdminDuty] == 0)
	{
		SetPlayerHealth(playerid, 100);
	}
    if(BolsilloID[playerid][11] != 0) CambiarArma(playerid);
    if(EsArma(BolsilloID[playerid][11])) ActualizarBalas(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	UsarLuces[playerid] = 0;
	PuedeUsarLuces[playerid] = 0;
	TieneTaser[playerid] = 0;
	Taseado[playerid] = 0;
	Anim[playerid] = 0;
	Cables[playerid] = 0;
	Taseador[playerid] = 0;
    /*if(PlayerRoute[playerid][Destination] != -1)
    {
        DisableGPS(playerid);
    }*/
	AFK_OnPlayerDisconnect(playerid);
	ResetearVariablesArmas(playerid);
	MisBand_OnPlayerDisconnect(playerid);
	/*puntero_OnPlayerDisconnect(playerid);*/
	KillTimer( PlayerInfo[playerid][SpawnTimer] );
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		switch (reason)
		{
			case 0:
			{
				format(string, sizeof(string), "(( %s (ID:%d) se ha desconectado. Se perdió la conexión con el jugador (Timeout/Crash) ))", pName(playerid), playerid);
			}
			case 1:
			{
				format(string, sizeof(string), "(( %s (ID:%d) se ha desconectado. El jugador ha cerrado el juego voluntariamente. ))", pName(playerid), playerid);
			}
			case 2:
			{	
				format(string, sizeof(string), "(( %s (ID:%d) se ha desconectado. El jugador ha sido expulsado del servidor. ))", pName(playerid), playerid);
			}
		}
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(12.0, playerid, string,Gris,Gris,Gris,Gris,Gris);}
		else {
		ProxDetector(20.0, playerid, string,Gris,Gris,Gris,Gris,Gris);}
	}
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && reason == 0)
	{
		new newcar = GetPlayerVehicle(playerid);
		if(!IsABike(newcar))
		{
			CarInfo[newcar][cStarted] = 0;
			ActualizarVolumenEmisora(newcar);
			SaveCar(newcar);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(CarInfo[newcar][cId], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(CarInfo[newcar][cId],CarInfo[newcar][cStarted], lights, alarm, doors, bonnet, boot, objective);
		}
	}
	RefreshPos(playerid);
	Vehicles_OnPlayerDisconnect(playerid, reason);
	Admin_OnPlayerDisconnect(playerid);
	Slide_OnPlayerDisconnect(playerid, reason);
	/*Radio_OnPlayerDisconnect(playerid);*/
	Medicos_PlayerDisconnect(playerid);
	Bomberos_PlayerDisconnect(playerid);
	Autoesc_OnPlayerDisconnect(playerid, reason);
	//Velocimetro_OnPlayerDisconnect(playerid);
	Detective_OnPlayerDisconnect(playerid,reason);
	Tlf_OnPlayerDisconnect(playerid);
    Carreras_OnPlayerDisconnect(playerid);
	TextDrawHideForPlayer(playerid, Textdraw0);
	TextDrawHideForPlayer(playerid, Textdraw1);
	TextDrawHideForPlayer(playerid, Textdraw2);
	TextDrawHideForPlayer(playerid, Textdraw3);
	TextDrawHideForPlayer(playerid, Textdraw4);
	if(UltimoEnMorir == playerid) UltimoEnMorir = NOEXISTE;
	OnPlayerCommandText(playerid, "/uname");
    SaveValue(playerid, "Conectado", 0);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new len = strlen (inputtext);
    for (new i = 0; i < len; ++i)
        if (inputtext [i] == '%')
            inputtext [i] = '#';
	Ascensor_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Cuentas_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Radio_OnDialogResponse(playerid, dialogid, response, listitem);
	Autoesc_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Tunning_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	ATMS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Lot_OnDialogResponse(playerid, dialogid, response, inputtext);
	Muebles_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	/*Gangs_OnDialogResponse(playerid, dialogid, response, listitem);*/
	Policias_OnDialogResponse(playerid, dialogid, response, listitem);
	InventoryOnDialogResponse(playerid, dialogid, response, inputtext);
	if(dialogid == BOLSILLOS)
	{
  			if(!response) return 1;
			if(listitem >= 0 && listitem <= 9){
			    new bol = listitem+1;
			    if(BolsilloID[playerid][bol] == 0){
			        Mensaje(playerid, COLOR_BLANCO, "El bolsillo seleccionado se encuentra totalmente desocupado.");
			        MostrarBolsillos(playerid);
			    }
				else{
				    if(BolsilloID[playerid][11] == 0){
				        BolsilloID[playerid][11] = BolsilloID[playerid][bol];
				        BolsilloTipo[playerid][11] = BolsilloTipo[playerid][bol];
				        BolsilloCantidad[playerid][11] = BolsilloCantidad[playerid][bol];
				        BolsilloID[playerid][bol] = 0;
				        BolsilloTipo[playerid][bol] = 0;
				        BolsilloCantidad[playerid][bol] = 0;
						if(EsArma(BolsilloID[playerid][11])){
							SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
							SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
						}
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
				    	format(sql, sizeof(sql), "Bol%dID", bol);
					    SaveValue(playerid, sql, BolsilloID[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dTipo", bol);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dCantidad", bol);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][bol]);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó del bolsillo u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarBolsillos(playerid);
				    }
				    else if(BolsilloID[playerid][12] == 0){
				        BolsilloID[playerid][12] = BolsilloID[playerid][bol];
				        BolsilloTipo[playerid][12] = BolsilloTipo[playerid][bol];
				        BolsilloCantidad[playerid][12] = BolsilloCantidad[playerid][bol];
				        BolsilloID[playerid][bol] = 0;
				        BolsilloTipo[playerid][bol] = 0;
				        BolsilloCantidad[playerid][bol] = 0;
				        ActualizarObjetos(playerid);
				        new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 12);
					    SaveValue(playerid, sql, BolsilloID[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dTipo", 12);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 12);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
				    	format(sql, sizeof(sql), "Bol%dID", bol);
					    SaveValue(playerid, sql, BolsilloID[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dTipo", bol);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dCantidad", bol);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][bol]);
				        Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano izquierda.");
						format(string, sizeof(string), "Usted sacó del bolsillo u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarBolsillos(playerid);
				    }
				    else{
				        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener al menos una mano desocupada.");
				    }
				}
			}
		    else if(listitem == 10){
				Mensaje(playerid, COLOR_ERRORES, "[ERROR] Este espacio es decorativo, no tiene uso alguno.");
				MostrarBolsillos(playerid);
				return 1;
			}
			else{
			    if(BolsilloID[playerid][listitem] == 0){
			        Mensaje(playerid, COLOR_ERRORES, "[ERROR] La mano seleccionada está desocupada, por ende, no hay objetos en la misma.");
			        MostrarBolsillos(playerid);
			    }
			    else{
			        if(ObjetoPesado(BolsilloID[playerid][listitem])) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no puede guardar el objeto seleccionado en sus bolsillos.");
	          		for(new i = 1; i < 11; i++){
			            if(BolsilloID[playerid][i] == 0){
			        		BolsilloID[playerid][i] = BolsilloID[playerid][listitem];
			        		BolsilloTipo[playerid][i] = BolsilloTipo[playerid][listitem];
			        		BolsilloCantidad[playerid][i] = BolsilloCantidad[playerid][listitem];
							if(listitem == 11) ResetPlayerWeapons(playerid);
			        		BolsilloID[playerid][listitem] = 0;
			        		BolsilloTipo[playerid][listitem] = 0;
			        		BolsilloCantidad[playerid][listitem] = 0;
			        		new sql[16];
					 		format(sql, sizeof(sql), "Bol%dID", i);
						    SaveValue(playerid, sql, BolsilloID[playerid][i]);
						    format(sql, sizeof(sql), "Bol%dTipo", i);
						    SaveValue(playerid, sql, BolsilloTipo[playerid][i]);
						    format(sql, sizeof(sql), "Bol%dCantidad", i);
						    SaveValue(playerid, sql, BolsilloCantidad[playerid][i]);
					    	format(sql, sizeof(sql), "Bol%dID", listitem);
						    SaveValue(playerid, sql, BolsilloID[playerid][listitem]);
						    format(sql, sizeof(sql), "Bol%dTipo", listitem);
						    SaveValue(playerid, sql, BolsilloTipo[playerid][listitem]);
						    format(sql, sizeof(sql), "Bol%dCantidad", listitem);
						    SaveValue(playerid, sql, BolsilloCantidad[playerid][listitem]);
							format(string, sizeof(string), "El objeto seleccionado ha sido colocado en el bolsillo #%d.", i);
							Mensaje(playerid, COLOR_BLANCO, string);
							if(listitem == 11) format(string, sizeof(string), "Usted guardó u%s sacado de la mano derecha en el bolsillo #%d.", ObtenerNombreObjeto(BolsilloID[playerid][i]), i);
				            else format(string, sizeof(string), "Usted guardó u%s sacado de la mano izquierda en el bolsillo #%d.", ObtenerNombreObjeto(BolsilloID[playerid][i]), i);
							Mensaje(playerid, COLOR_BLANCO, string);
							ActualizarObjetos(playerid);
							MostrarBolsillos(playerid);
							return 1;
						}
			        }
			        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene bolsillos disponibles para colocar el objeto seleccionado.");
	          		MostrarBolsillos(playerid);
			    }
			    return 1;
			}
		}
	if(dialogid == CACHEO)
	{
  			if(!response) return 1;
  			new bol = listitem+1;
			if(listitem >= 0 && listitem <= 9){
			    if(BolsilloID[Cacheado[playerid]][bol] == 0){
			        Mensaje(playerid, COLOR_ERRORES, "¡Dicho bolsillo se encuentra vacío!");
			        MostrarCacheo(Cacheado[playerid], playerid);
			    }
			    else{
  						Mensaje(playerid, AzulClaro, "¡El objeto seleccionado ha sido eliminado!");
						format(string, sizeof(string), "¡Le has retirado a %s del bolsillo u%s!", pName(Cacheado[playerid]), ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][bol]));
						Mensaje(playerid, AzulClaro, string);
						
						format(string, sizeof(string), "¡Te han quitado u%s de tus bolsillos! (JUGADOR QUE TE LO QUITÓ: %s)", ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][bol]), pName(playerid));
						Mensaje(Cacheado[playerid], AzulOscuro, string);
						
						format(string, sizeof(string), "%s le retiró a %s u%s.", pName(playerid), pName(Cacheado[playerid]), ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][bol]));
						ProxDetector(15.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
						
						QuitarObjeto(Cacheado[playerid], bol);
						ActualizarObjetos(Cacheado[playerid]);
						MostrarCacheo(Cacheado[playerid], playerid);
						new sql[16];
				    	format(sql, sizeof(sql), "Bol%dID", bol);
					    SaveValue(playerid, sql, BolsilloID[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dTipo", bol);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][bol]);
					    format(sql, sizeof(sql), "Bol%dCantidad", bol);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][bol]);
			    }
			}
		    else if(listitem == 10){
				Mensaje(playerid, COLOR_ERRORES, "¡Este es espacio es decorativo!");
				MostrarCacheo(Cacheado[playerid], playerid);
				return 1;
			}
			else{
			    if(BolsilloID[Cacheado[playerid]][listitem] == 0){
			        Mensaje(playerid, COLOR_ERRORES, "¡Dicho bolsillo se encuentra vacío!");
			        MostrarCacheo(Cacheado[playerid], playerid);
			    }
			    else{
  						Mensaje(playerid, AzulClaro, "¡El objeto seleccionado ha sido eliminado!");
						format(string, sizeof(string), "¡Le has retirado a %s del bolsillo u%s!", pName(Cacheado[playerid]), ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][listitem]));
						Mensaje(playerid, AzulClaro, string);
						
						format(string, sizeof(string), "¡Te han quitado u%s de tus bolsillos! (JUGADOR QUE TE LO QUITÓ: %s)", ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][listitem]), pName(playerid));
						Mensaje(Cacheado[playerid], AzulOscuro, string);
						
						format(string, sizeof(string), "%s le retiró a %s u%s.", pName(playerid), pName(Cacheado[playerid]), ObtenerNombreObjeto(BolsilloID[Cacheado[playerid]][listitem]));
						ProxDetector(15.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
						
						QuitarObjeto(Cacheado[playerid], listitem);
						ActualizarObjetos(Cacheado[playerid]);
						MostrarCacheo(Cacheado[playerid], playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[Cacheado[playerid]][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[Cacheado[playerid]][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[Cacheado[playerid]][11]);
			    }
			    return 1;
			}
		}
		if(dialogid == MALETERO)
	{

	    if(!response) return 1;
	    new coche = consultandomal[playerid];
		if(listitem >= 0 && listitem <= 4)
		{
		    new bol = listitem;
		    if(CarInfo[coche][aMalID][bol] == 0)
		    {
		        SendClientMessage(playerid, VERDE, "* Este espacio se encuentra vacío.");
		        MostrarMaletero(coche, playerid);
		    }
			else
			{
			    if(BolsilloID[playerid][11] == 0)
			    {
			        BolsilloID[playerid][11] = CarInfo[coche][aMalID][bol];
			        BolsilloTipo[playerid][11] = CarInfo[coche][aMalTipo][bol];
			        BolsilloCantidad[playerid][11] = CarInfo[coche][aMalCantidad][bol];
			        CarInfo[coche][aMalID][bol] = 0;
			        CarInfo[coche][aMalTipo][bol] = 0;
			        CarInfo[coche][aMalCantidad][bol] = 0;
					if(EsArma(BolsilloID[playerid][11])) SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
			        UpdateAttach(playerid);
					new sql[16];
			 		format(sql, sizeof(sql), "Bol%dID", 11);
				    SaveValue(playerid, sql, BolsilloID[playerid][11]);
				    format(sql, sizeof(sql), "Bol%dTipo", 11);
				    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
				    format(sql, sizeof(sql), "Bol%dCantidad", 11);
				    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
			    	SaveCar(coche);
			        SendClientMessage(playerid, CELESTE, "* El objeto ha sido colocado en tu mano derecha.");
					format(string, sizeof(string), "* Sacaste del maletero un objeto %s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
					SendClientMessage(playerid, VERDE, string);
					MostrarMaletero(coche, playerid);
			    }
			    else if(BolsilloID[playerid][12] == 0)
			    {
			        BolsilloID[playerid][12] = CarInfo[coche][aMalID][bol];
			        BolsilloTipo[playerid][12] = CarInfo[coche][aMalID][bol];
			        BolsilloCantidad[playerid][12] = CarInfo[coche][aMalID][bol];
			        CarInfo[coche][aMalID][bol] = 0;
			        CarInfo[coche][aMalTipo][bol] = 0;
			        CarInfo[coche][aMalCantidad][bol] = 0;
			        UpdateAttach(playerid);
					new sql[16];
			 		format(sql, sizeof(sql), "Bol%dID", 12);
				    SaveValue(playerid, sql, BolsilloID[playerid][12]);
				    format(sql, sizeof(sql), "Bol%dTipo", 12);
				    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
				    format(sql, sizeof(sql), "Bol%dCantidad", 12);
				    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
			    	SaveCar(coche);
			        SendClientMessage(playerid, CELESTE, "* El objeto ha sido colocado en tu mano izquierda.");
					format(string, sizeof(string), "* Sacaste del bolsillo un objeto %s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
					SendClientMessage(playerid, VERDE, string);
					MostrarMaletero(coche, playerid);
			    }
			    else
			    {
			        SendClientMessage(playerid, ROJO_OSCURO, "* Debes tener al menos una mano desocupada.");
			    }
			}
		}
	    else if(listitem == 5)
	    {
			SendClientMessage(playerid, VERDE, "* Este espacio es simplemente decorativo, no tiene ningún otro uso.");
			MostrarMaletero(coche, playerid);
			return 1;
		}
		else if(listitem == 6 || listitem == 7)
		{
			new lista;
			if(listitem == 6) lista = 11;
			else if(listitem == 7) lista = 12;
            if(BolsilloID[playerid][lista] == 0)
		    {
		        SendClientMessage(playerid, VERDE, "* Esta mano está desocupada.");
		        MostrarMaletero(coche, playerid);
		    }
		    else
		    {
		        for(new i = 0; i < 5; i++)
		        {
		            if(CarInfo[coche][aMalID][i] == 0)
		            {
		        		CarInfo[coche][aMalID][i] = BolsilloID[playerid][lista];
		        		CarInfo[coche][aMalTipo][i] = BolsilloTipo[playerid][lista];
		        		CarInfo[coche][aMalCantidad][i] = BolsilloCantidad[playerid][lista];
						ResetPlayerWeapons(playerid);
		        		BolsilloID[playerid][lista] = 0;
		        		BolsilloTipo[playerid][lista] = 0;
		        		BolsilloCantidad[playerid][lista] = 0;
						new sql[16];
				 		SaveCar(coche);
				    	format(sql, sizeof(sql), "Bol%dID", lista);
					    SaveValue(playerid, sql, BolsilloID[playerid][lista]);
					    format(sql, sizeof(sql), "Bol%dTipo", lista);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][lista]);
					    format(sql, sizeof(sql), "Bol%dCantidad", lista);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][lista]);
						format(string, sizeof(string), "* El objeto ha sido colocado en el maletero %d.", i+1);
						SendClientMessage(playerid, CELESTE, string);
						if(lista == 11) format(string, sizeof(string), "* Sacaste del bolsillo derecho un %s que fue guardado en el maletero %d.", ObtenerNombreObjeto(CarInfo[coche][aMalID][i]), i+1);
			            else format(string, sizeof(string), "* Sacaste del bolsillo izquierdo un %s que fue guardado en el maletero %d.", ObtenerNombreObjeto(CarInfo[coche][aMalID][i]), i+1);
						SendClientMessage(playerid, VERDE, string);
						UpdateAttach(playerid);
						ActualizarObjetos(playerid);
						MostrarMaletero(coche, playerid);
						return 1;
					}
		        }
		        SendClientMessage(playerid, ROJO_OSCURO, "* No tienes espacios disponibles para colocar el objeto.");
          		MostrarMaletero(coche, playerid);
		    }
		    return 1;
		}
	}
	
  //
  
  		if(dialogid == ARMARIO)
		{
		    if(!response) return 1;
		    new casa = EstaEn[playerid];
			if(listitem >= 0 && listitem <= 4)
			{
			    new bol = listitem;
			    if(CasaInfo[casa][hArmID][bol] == 0)
			    {
			        Mensaje(playerid, VERDE, "* Este espacio se encuentra vacío.");
			        MostrarArmario(casa, playerid);
			    }
				else
				{
				    if(BolsilloID[playerid][11] == 0)
				    {
				        BolsilloID[playerid][11] = CasaInfo[casa][hArmID][bol];
				        BolsilloTipo[playerid][11] = CasaInfo[casa][hArmTipo][bol];
				        BolsilloCantidad[playerid][11] = CasaInfo[casa][hArmCantidad][bol];
				        CasaInfo[casa][hArmID][bol] = 0;
				        CasaInfo[casa][hArmTipo][bol] = 0;
				        CasaInfo[casa][hArmCantidad][bol] = 0;
						if(EsArma(BolsilloID[playerid][11]))
						{
							GivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
							SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
						}
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
				    	SaveCasa(casa);
				        Mensaje(playerid, CELESTE, "* El objeto ha sido colocado en tu mano derecha.");
						format(string, sizeof(string), "* Sacaste del armario un objeto %s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, VERDE, string);
						MostrarArmario(casa, playerid);
				    }
				    else if(BolsilloID[playerid][12] == 0)
				    {
				        BolsilloID[playerid][12] = CasaInfo[casa][hArmID][bol];
				        BolsilloTipo[playerid][12] = CasaInfo[casa][hArmTipo][bol];
				        BolsilloCantidad[playerid][12] = CasaInfo[casa][hArmCantidad][bol];
				        CasaInfo[casa][hArmID][bol] = 0;
				        CasaInfo[casa][hArmTipo][bol] = 0;
				        CasaInfo[casa][hArmCantidad][bol] = 0;
				        ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 12);
					    SaveValue(playerid, sql, BolsilloID[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dTipo", 12);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 12);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
				    	SaveCasa(casa);
				        Mensaje(playerid, CELESTE, "* El objeto ha sido colocado en tu mano izquierda.");
						format(string, sizeof(string), "* Sacaste del bolsillo un objeto %s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, VERDE, string);
						MostrarArmario(casa, playerid);
				    }
				    else
				    {
				        Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano desocupada.");
				    }
				}
			}
		    else if(listitem == 5)
		    {
				Mensaje(playerid, VERDE, "* Este espacio es simplemente decorativo, no tiene ningún otro uso.");
				MostrarArmario(casa, playerid);
				return 1;
			}
			else if(listitem == 6 || listitem == 7)
			{
				new lista;
				if(listitem == 6) lista = 11;
				else if(listitem == 7) lista = 12;
	            if(BolsilloID[playerid][lista] == 0)
			    {
			        Mensaje(playerid, VERDE, "* Esta mano está desocupada.");
			        MostrarArmario(casa, playerid);
			    }
			    else
			    {
			        for(new i = 0; i < 5; i++)
			        {
			            if(CasaInfo[casa][hArmID][i] == 0)
			            {
			        		CasaInfo[casa][hArmID][i] = BolsilloID[playerid][lista];
			        		CasaInfo[casa][hArmTipo][i] = BolsilloTipo[playerid][lista];
			        		CasaInfo[casa][hArmCantidad][i] = BolsilloCantidad[playerid][lista];
							if(lista == 11) ResetPlayerWeapons(playerid);
			        		BolsilloID[playerid][lista] = 0;
			        		BolsilloTipo[playerid][lista] = 0;
			        		BolsilloCantidad[playerid][lista] = 0;
							new sql[16];
	                        SaveCasa(casa);
					    	format(sql, sizeof(sql), "Bol%dID", lista);
						    SaveValue(playerid, sql, BolsilloID[playerid][lista]);
						    format(sql, sizeof(sql), "Bol%dTipo", lista);
						    SaveValue(playerid, sql, BolsilloTipo[playerid][lista]);
						    format(sql, sizeof(sql), "Bol%dCantidad", lista);
						    SaveValue(playerid, sql, BolsilloCantidad[playerid][lista]);
							format(string, sizeof(string), "* El objeto ha sido colocado en el armario %d.", i+1);
							Mensaje(playerid, CELESTE, string);
							if(lista == 11) format(string, sizeof(string), "* Sacaste del bolsillo derecho un %s que fue guardado en el armario %d.", ObtenerNombreObjeto(CasaInfo[casa][hArmID][i]), i+1);
				            else format(string, sizeof(string), "* Sacaste del bolsillo izquierdo un %s que fue guardado en el armario %d.", ObtenerNombreObjeto(CasaInfo[casa][hArmID][i]), i+1);
							Mensaje(playerid, VERDE, string);
							ActualizarObjetos(playerid);
	      					MostrarArmario(casa, playerid);
							return 1;
						}
			        }
			        Mensaje(playerid, COLOR_ERRORES, "* No tienes espacios disponibles para colocar el objeto.");
	          		MostrarMaletero(casa, playerid);
			    }
			    return 1;
			}
		}
		
		//
	if(dialogid == ESPECIAL)
	{
  			if(!response) return 1;
			if(listitem == 0){
			    if(CinturonID[playerid] == 0){
			        Mensaje(playerid, COLOR_BLANCO, "¡El cinturón está vacio!");
			        MostrarEspecial(playerid);
			    }
				else{
				    if(BolsilloID[playerid][11] == 0){
				        BolsilloID[playerid][11] = CinturonID[playerid];
				        BolsilloTipo[playerid][11] = CinturonTipo[playerid];
				        BolsilloCantidad[playerid][11] = CinturonCantidad[playerid];
				        CinturonID[playerid] = 0;
				        CinturonTipo[playerid] = 0;
				        CinturonCantidad[playerid] = 0;
						if(EsArma(BolsilloID[playerid][11])){
							SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
						}
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
					    SaveValue(playerid, "CinturonID", CinturonID[playerid]);
					    SaveValue(playerid, "CinturonTipo", CinturonTipo[playerid]);
					    SaveValue(playerid, "CinturonCantidad", CinturonCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, CINTURON);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó del cinturón u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarEspecial(playerid);
				    }
				    if(BolsilloID[playerid][12] == 0){
				        BolsilloID[playerid][12] = CinturonID[playerid];
				        BolsilloTipo[playerid][12] = CinturonTipo[playerid];
				        BolsilloCantidad[playerid][12] = CinturonCantidad[playerid];
				        CinturonID[playerid] = 0;
				        CinturonTipo[playerid] = 0;
				        CinturonCantidad[playerid] = 0;
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 12);
					    SaveValue(playerid, sql, BolsilloID[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dTipo", 12);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 12);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
					    SaveValue(playerid, "CinturonID", CinturonID[playerid]);
					    SaveValue(playerid, "CinturonTipo", CinturonTipo[playerid]);
					    SaveValue(playerid, "CinturonCantidad", CinturonCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, CINTURON);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó del cinturón u%s.", ObtenerNombreObjeto(BolsilloID[playerid][11]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarEspecial(playerid);
				    }
				    else{
				        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener al menos una mano desocupada.");
				    }
				}
			}
			if(listitem == 1){
			    if(EspaldaID[playerid] == 0){
			        Mensaje(playerid, COLOR_BLANCO, "¡La espalda está vacia!");
			        MostrarEspecial(playerid);
			    }
				else{
				    if(BolsilloID[playerid][11] == 0){
				        BolsilloID[playerid][11] = EspaldaID[playerid];
				        BolsilloTipo[playerid][11] = EspaldaTipo[playerid];
				        BolsilloCantidad[playerid][11] = EspaldaCantidad[playerid];
				        EspaldaID[playerid] = 0;
				        EspaldaTipo[playerid] = 0;
				        EspaldaCantidad[playerid] = 0;
						if(EsArma(BolsilloID[playerid][11])){
							SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
							SetPlayerArmedWeapon(playerid, BolsilloID[playerid][11]);
						}
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 11);
					    SaveValue(playerid, sql, BolsilloID[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dTipo", 11);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 11);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
					    SaveValue(playerid, "EspaldaID", EspaldaID[playerid]);
					    SaveValue(playerid, "EspaldaTipo", EspaldaTipo[playerid]);
					    SaveValue(playerid, "EspaldaCantidad", EspaldaCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, ESPALDA);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano derecha.");
						format(string, sizeof(string), "Usted sacó de la espalda u%s.", ObtenerNombreObjeto(BolsilloID[playerid][12]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarEspecial(playerid);
				    }
				    if(BolsilloID[playerid][12] == 0){
				        BolsilloID[playerid][12] = EspaldaID[playerid];
				        BolsilloTipo[playerid][12] = EspaldaTipo[playerid];
				        BolsilloCantidad[playerid][12] = EspaldaCantidad[playerid];
				        EspaldaID[playerid] = 0;
				        EspaldaTipo[playerid] = 0;
				        EspaldaCantidad[playerid] = 0;
						ActualizarObjetos(playerid);
						new sql[16];
				 		format(sql, sizeof(sql), "Bol%dID", 12);
					    SaveValue(playerid, sql, BolsilloID[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dTipo", 12);
					    SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
					    format(sql, sizeof(sql), "Bol%dCantidad", 12);
					    SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
					    SaveValue(playerid, "EspaldaID", EspaldaID[playerid]);
					    SaveValue(playerid, "EspaldaTipo", EspaldaTipo[playerid]);
					    SaveValue(playerid, "EspaldaCantidad", EspaldaCantidad[playerid]);
					    RemovePlayerAttachedObject(playerid, ESPALDA);
						Mensaje(playerid, COLOR_BLANCO, "El objeto seleccionado ha sido colocado en su mano izquierda.");
						format(string, sizeof(string), "Usted sacó de la espalda u%s.", ObtenerNombreObjeto(BolsilloID[playerid][12]));
						Mensaje(playerid, COLOR_BLANCO, string);
						MostrarEspecial(playerid);
				    }
				    else{
				        Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener al menos una mano desocupada.");
				    }
				}
			}
		    else if(listitem == 2){
				Mensaje(playerid, COLOR_ERRORES, "[ERROR] Este espacio es decorativo, no tiene uso alguno.");
				MostrarEspecial(playerid);
				return 1;
			}
			else if(listitem >= 3){
				Mensaje(playerid, COLOR_BLANCO, "¡Deberá utilizar /cin o /espalda!");
    			return 1;
			}
		}
		
		//
		if(dialogid == EQUIPAMIENTOLAPD) {
            if(response == 1){
		        switch(listitem){
		            case 0:{
  						EstablecerChaleco(playerid, 100.0);
				        format(string, sizeof(string), "* %s coge un chaleco kevlar del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
		            case 1:{
  						if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
		                    DarObjeto(playerid, 3, 1, 1);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 3;
						    BolsilloCantidad[playerid][12] = 1;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge una porra policíaca del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
		            case 2:{
         				if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				        	DarObjeto(playerid, 24, 1, 7);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 24;
						    BolsilloCantidad[playerid][12] = 7;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge una pistola desert eagle del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
					case 3:{
					    if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            DarObjeto(playerid, 23, 1, 17);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 23;
						    BolsilloCantidad[playerid][12] = 17;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
						TieneTaser[playerid] = 1;
				        format(string, sizeof(string), "* %s coge un táser del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
					case 4:{
					    if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            DarObjeto(playerid, 25, 1, 5);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 25;
						    BolsilloCantidad[playerid][12] = 5;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge una escopeta del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
                        Mensaje(playerid, COLOR_BLANCO, "Para convertirla en una escopeta con balas de goma, utilice el comando /balasdegoma");
					}
					case 5:{
					    if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            DarObjeto(playerid, 46, 1, 7);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 46;
						    BolsilloCantidad[playerid][12] = 7;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge un cargador de pistola desert eagle del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
					case 6:{
					    if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            DarObjeto(playerid, 47, 1, 5);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 47;
						    BolsilloCantidad[playerid][12] = 5;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge un cargador de escopeta del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
				}
            }
        }
  		if(dialogid == EQUIPAMIENTOLASC) {
            if(response == 1){
		        switch(listitem){
		            case 0:{
  						EstablecerChaleco(playerid, 100.0);
				        format(string, sizeof(string), "* %s coge un chaleco kevlar del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
		            case 1:{
		                if(PlayerInfo[playerid][pRank] != 5 && PlayerInfo[playerid][pEsLider] == 0) return Mensaje(playerid, COLOR_ERRORES, "* Solo los Guardaespaldas (rango 5) y líderes pueden tomar este equipamiento");
         				if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				        	DarObjeto(playerid, 22, 1, 17);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 22;
						    BolsilloCantidad[playerid][12] = 17;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge una pistola nueve milímetros del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
					case 2:{
					    if(PlayerInfo[playerid][pRank] != 5 && PlayerInfo[playerid][pEsLider] == 0) return Mensaje(playerid, COLOR_ERRORES, "* Solo los Guardaespaldas (rango 5) y líderes pueden tomar este equipamiento");
					    if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            DarObjeto(playerid, 44, 1, 17);
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 44;
						    BolsilloCantidad[playerid][12] = 17;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge un cargador de pistola nueve milímetros del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
				}
            }
        }
       if(dialogid == EQUIPAMIENTOLAED) {
            if(response == 1){
		        switch(listitem){
		            case 0:{
  						if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            BolsilloID[playerid][11] = 42;
						    BolsilloCantidad[playerid][11] = 1000;
						    BolsilloTipo[playerid][11] = 1;
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 42;
						    BolsilloCantidad[playerid][12] = 1000;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge un extintor de fuego del depósito de instrumentales.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
		            case 1:{
  						if(BolsilloID[playerid][11] != 0 && BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "* Debes tener al menos una mano vacía.");
				        if(BolsilloID[playerid][11] == 0){
				            BolsilloID[playerid][11] = 9;
						    BolsilloCantidad[playerid][11] = 1;
						    BolsilloTipo[playerid][11] = 1;
				        }
				        else if(BolsilloID[playerid][12] == 0){
				            BolsilloID[playerid][12] = 9;
						    BolsilloCantidad[playerid][12] = 1;
						    BolsilloTipo[playerid][12] = 1;
				        }
					    new sql[16];
						format(sql, sizeof(sql), "Bol%dID", 11);
						SaveValue(playerid, sql, BolsilloID[playerid][11]);
						format(sql, sizeof(sql), "Bol%dTipo", 11);
						SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
						format(sql, sizeof(sql), "Bol%dCantidad", 11);
						SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
						ActualizarObjetos(playerid);
				        format(string, sizeof(string), "* %s coge una motosierra del depósito de instrumentales.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
     				case 2:{
  						EstablecerChaleco(playerid, 100.0);
				        format(string, sizeof(string), "* %s coge un chaleco ignífugo del depósito de armamento.", pName(playerid));
				        ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
					}
     			}
            }
        }
	if(dialogid == 1050)
	{
	if(response)
	{
	if(listitem == 0)
	{
    ShowPlayerDialog(playerid, 1051, DIALOG_STYLE_LIST, "Canciones - Reggaeton:", "Agarrate\nBailando la encontre\nCamuflaje\nEnergia\nHappy Totin\nHooka\nLlegamos a la Disco\nLoco con ella\nNo necesito\nSiempre me llama\nSino le contesto\nVuelve\nEl demonio de la tinta\nSolo hago el amor\n", "Reproducir", "Atrás");
	}
	if(listitem == 1)
	{
    ShowPlayerDialog(playerid, 1052, DIALOG_STYLE_LIST, "Canciones - Reggaeton:", "Electro House\nShe Wolf\nTrumpets\nTacata\n", "Reproducir", "Atrás");
	}
	}
    if(!response)
	{
	}
	}
	if(dialogid == 1051)
	{
	if(response)
	{
	if(listitem == 0)
	{
	//Song = "http://www.megarolsamp.com.nu/agarrate.mp3";
	Song = "http://k007.kiwi6.com/hotlink/n7137551gp/agarrate.mp3";
    BoomBox(playerid);
    }
    if(listitem == 1)
	{
	Song = "http://k007.kiwi6.com/hotlink/qyyua70kk6/bailando_la_encontre.mp3";
    BoomBox(playerid);
    }
    if(listitem == 2)
	{
	Song = "http://k007.kiwi6.com/hotlink/qeecg78wrm/camuflaje.mp3";
    BoomBox(playerid);
    }
    if(listitem == 3)
	{
	Song = "http://k007.kiwi6.com/hotlink/m9pdfapaqi/energia.mp3";
    BoomBox(playerid);
    }
    if(listitem == 4)
	{
	Song = "http://k007.kiwi6.com/hotlink/23jr0vdk62/happy_totin.mp3";
    BoomBox(playerid);
    }
    if(listitem == 5)
	{
	Song = "http://k007.kiwi6.com/hotlink/6192dk3gne/hooka.mp3";
    BoomBox(playerid);
    }
    if(listitem == 6)
	{
	Song = "http://k007.kiwi6.com/hotlink/4q5m558lea/llegamos_a_la_disco.mp3";
    BoomBox(playerid);
    }
    if(listitem == 7)
	{
	Song = "http://k007.kiwi6.com/hotlink/yx9zhvw0mn/loco_con_ella.mp3";
    BoomBox(playerid);
    }
    if(listitem == 8)
	{
	Song = "http://k007.kiwi6.com/hotlink/1k731w97af/no_necesito.mp3";
    BoomBox(playerid);
    }
    if(listitem == 9)
	{
	Song = "http://k007.kiwi6.com/hotlink/31lxeb0i75/siempre_me_llama.mp3";
    BoomBox(playerid);
    }
    if(listitem == 10)
	{
	Song = "http://k007.kiwi6.com/hotlink/q7bp6d0nq5/sino_le_contesto.mp3";
    BoomBox(playerid);
    }
    if(listitem == 11)
	{
	Song = "http://k007.kiwi6.com/hotlink/vgj30dzxp4/vuelve.mp3";
    BoomBox(playerid);
    }
    if(listitem == 12)
	{
	Song = "http://k007.kiwi6.com/hotlink/ahem9b1071/el_demonio_de_la_tinta.mp3";
    BoomBox(playerid);
    }
    if(listitem == 13)
	{
	Song = "http://k007.kiwi6.com/hotlink/j5981f6pmg/solo_hago_el_amor.mp3";
    BoomBox(playerid);
    }
	}
    if(!response)
	{
	ShowPlayerDialog(playerid, 1050, DIALOG_STYLE_LIST, "Canciones:", "-> Reggaeton\nElectro\n", "Aceptar", "Salir");
	}
	}
	if(dialogid == 1052)
	{
	if(response)
	{
	if(listitem == 0)
	{
	Song = "http://k007.kiwi6.com/hotlink/1jxj2wp6p8/electro_house_electro_.mp3";
    BoomBox(playerid);
    }
    if(listitem == 1)
	{
	Song = "http://k007.kiwi6.com/hotlink/487u5b2el4/she_wolf_electro_.mp3";
    BoomBox(playerid);
    }
    if(listitem == 2)
	{
	Song = "http://k007.kiwi6.com/hotlink/5g95bq90kd/trumpets_electro_.mp3";
    BoomBox(playerid);
    }
    if(listitem == 3)
	{
	Song = "http://k007.kiwi6.com/hotlink/d6ix38nich/tacata_electro_.mp3";
    BoomBox(playerid);
    }
	}
    if(!response)
	{
	ShowPlayerDialog(playerid, 1050, DIALOG_STYLE_LIST, "Canciones:", "-> Reggaeton\nElectro\n", "Aceptar", "Salir");
	}
	}
	if(dialogid == DIALOGO_BOXEO)
	{
		if(response)
		{
			if(listitem == 0) //Boxeo
			{
			SafeGivePlayerMoney(playerid,-3000);
			SendClientMessage(playerid,Amarillo,"Haz adquirido el estilo de pelea de boxeo");
			PlayerInfo[playerid][pEstiloPelea] = 5;
			SetPlayerFightingStyle(playerid, 5);
			}
			if(listitem == 1) //Kungfu
			{
			SafeGivePlayerMoney(playerid,-3000);
			SendClientMessage(playerid,Amarillo,"Haz adquirido el estilo de pelea de Kung-Fu");
			PlayerInfo[playerid][pEstiloPelea] = 6;
			SetPlayerFightingStyle(playerid, 6);
			}
			if(listitem == 2) //Knee Head
			{
			SafeGivePlayerMoney(playerid,-3000);
			SendClientMessage(playerid,Amarillo,"Haz adquirido el estilo de pelea de Knee Head");
			PlayerInfo[playerid][pEstiloPelea] = 7;
			SetPlayerFightingStyle(playerid,7);
			}
			if(listitem == 3) //Grab Kick
			{
			SafeGivePlayerMoney(playerid,-3000);
			SendClientMessage(playerid,Amarillo,"Haz adquirido el estilo de pelea Grab Kick");
			PlayerInfo[playerid][pEstiloPelea] = 15;
			SetPlayerFightingStyle(playerid, 15);
			}
			if(listitem == 4) //Elbow
			{
			SafeGivePlayerMoney(playerid,-3000);
			SendClientMessage(playerid,Amarillo,"Haz adquirido el estilo de pelea de Elbow");
			PlayerInfo[playerid][pEstiloPelea] = 16;
			SetPlayerFightingStyle(playerid, 16);
			}
       }
	   else
	   {
			
	   }
   }
   
   if(dialogid == DIALOGO_ARMAS)
     {
     if(response == 1)
     {
     switch(listitem)
     {
    		case 0: {EntregarArma(playerid,0); return SendClientMessage(playerid, Blanco, "¡Tomaste una AK47 de la fábrica!");}
    		case 1: {EntregarArma(playerid,1); return SendClientMessage(playerid, Blanco, "¡Tomaste una Desert Eagle de la fábrica!");}
    		case 2: {EntregarArma(playerid,2); return SendClientMessage(playerid, Blanco, "¡Tomaste una UZI de la fábrica!");}
    		case 3: {EntregarArma(playerid,3); return SendClientMessage(playerid, Blanco, "¡Tomaste una AK47 de la fábrica!");}
    		case 4: {EntregarArma(playerid,4); return SendClientMessage(playerid, Blanco, "¡Tomaste una Desert Eagle de la fábrica!");}
    		case 5: {EntregarArma(playerid,5); return SendClientMessage(playerid, Blanco, "¡Tomaste una UZI de la fábrica!");}
    }
    }
    else
    {
    }





 }
 
	if(dialogid == DIALOGO_GPS)
     {
     if(response == 1)
     {
     switch(listitem)
     {
    case 0: {SetPlayerCheckpoint(playerid,1190.1178,-1464.6293,13.5469,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa.");}
    case 1: {SetPlayerCheckpoint(playerid,2854.8625,-1575.5536,11.0938,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 2: {SetPlayerCheckpoint(playerid,1826.9290,-1888.5348,13.5331,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 3: {SetPlayerCheckpoint(playerid,1212.0164,-1323.9034,13.5591,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 4: {SetPlayerCheckpoint(playerid,2205.9761,-2252.7847,13.5469,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 5: {SetPlayerCheckpoint(playerid,1629.6147,-1879.8452,13.5469,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 6: {SetPlayerCheckpoint(playerid,589.3929,-1236.3790,17.8717,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 7: {SetPlayerCheckpoint(playerid,-100.1847,-1118.3927,1.4297,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 8: {SetPlayerCheckpoint(playerid,-490.4905,-561.9511,25.5234,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    case 9: {SetPlayerCheckpoint(playerid,1818.1708,-1572.6617,13.5469,8.0); return SendClientMessage(playerid, Blanco, "El punto ha sido marcado en el mapa");}
    }
    }
    else
    {
    }
    
    

 
 
 }
	return 1;
}

public OnPlayerSpawn(playerid)
{

    if(IsPlayerNPC(playerid))
    {
    new npcname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, npcname, sizeof(npcname));
    if(!strcmp(npcname, "RNPC", true))
    {

    }
    return 1;
    }

    if(IsPlayerNPC(playerid))
    {
    new npcname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, npcname, sizeof(npcname));
    if(!strcmp(npcname, "RNPC", true))
    {
      SetPlayerSkin(playerid, 167);
    }
    if(!strcmp(npcname, "James_Fernandez", true))
    {
      SetPlayerSkin(playerid, 280);
      new Text3D:TextoBot = Create3DTextLabel("{FFFF00}[BOT] {FFFFFF}James ",0xFF0000FF,30.0,40.0,50.0,40.0,0);
      Attach3DTextLabelToPlayer(TextoBot, playerid, 0.0, 0.0, 0.5);
    }
    if(!strcmp(npcname, "Dick_Reyes", true))
    {
      PutPlayerInVehicle(playerid, 1, 0);
      SetPlayerSkin(playerid, 253);
      new Text3D:TextoBot = Create3DTextLabel("{FFFF00}[BOT] {FFFFFF}Dick Reyes",0xFF0000FF,30.0,40.0,50.0,40.0,0);
      Attach3DTextLabelToPlayer(TextoBot, playerid, 0.0, 0.0, 0.5);
    }
    if(!strcmp(npcname, "John_Moore", true))
    {
      //PutPlayerInVehicle(playerid, vNPC_2, 0);
      SetPlayerSkin(playerid, 253);
      new Text3D:TextoBot = Create3DTextLabel("{FFFF00}[BOT] {FFFFFF}John Moore",0xFF0000FF,30.0,40.0,50.0,40.0,0);
      Attach3DTextLabelToPlayer(TextoBot, playerid, 0.0, 0.0, 0.5);
    }
    return 1;
    }

    //if(IsPlayerNPC(playerid)) SpawnPlayer(playerid);
	//if(IsPlayerNPC(playerid)) return 1;

    Streamer_Update(playerid);
	EnActividad[playerid] = 0;
	AFK_OnPlayerSpawn(playerid);
	Cuentas_OnPlayerSpawn(playerid);
	GM_SetPlayerHealth(playerid, 100);
	DisablePlayerCheckpoint(playerid);
	PlayerInfo[playerid][pCheckpoint] = 0;
    Sis_Pes_OnPlayerSpawn(playerid);
	Paintball_OnPlayerSpawn(playerid);
	Anims_OnPlayerSpawn(playerid);
	nieve_OnPlayerSpawn(playerid);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	/*SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 100);*/
	
	SetTimerEx("MirarConexion", 4000, 0, "d", playerid);
	Medicos_OnPlayerSpawn(playerid);
	/*ShowGangZonesToPlayer(playerid);*/
	
	if(PlayerInfo[playerid][pTut] == 0)
	{
		TogglePlayerControllable(playerid,0);

		PlayerInfo[playerid][pTut] = 1;
		SaveValue(playerid,"Tutorial",PlayerInfo[playerid][pTut]);
		ClearChatbox(playerid,25);
		GameTextForPlayer(playerid, "Bienvenido a Los Angeles", 6000, 1);
		SetPlayerCameraPos(playerid, 1900, -1611, 150);
		SetPlayerCameraLookAt(playerid, 1899, -1610, 150);
		ShowPlayerDialog(playerid,Dialogo_Bienvenida,DIALOG_STYLE_MSGBOX,"American RolePlay - www.am-rp.es", "Bienvenido a American - Juego de Rol\n¡Bienvenido a American Roleplay! Nos complace tenerte en nuestra comunidad.\n¿Eres nuevo o desconoces las normativas? Regístrate y mantente actualizado visitando: www.am-rp.es/foro\nPara continuar con el registro, selecciona continuar y sigue las instrucciones que se te irán dando.\n","Continuar","Salir");
		return SetTimerEx("MoverCamera",8000,0,"d",playerid);
		
	}
	
	if(UltimoEnMorir == playerid && ganador > 0)
	{
		SetPlayerPosEx(playerid,2779.4575,-1812.9095,11.8438);
		UltimoEnMorir=NOEXISTE;
	}
    
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	Admin_OnPlayerInteriorChange(playerid, newinteriorid);
	Streamer_Update(playerid);
	return 1;
}

Comando_Entrar(playerid)
{
	if(PlayerInfo[playerid][pFrozen] == 1 || PlayerInfo[playerid][pTempFrozen] == 1) return 1;
	
	if(Entrando[playerid] == 1) return 1;
	
	for(new i = 0; i < sizeof(CasaInfo); i++)
	{
		if (PlayerToPoint(2.0, playerid,CasaInfo[i][hEx], CasaInfo[i][hEy], CasaInfo[i][hEz]) && CasaInfo[i][hVw] == GetPlayerVirtualWorld(playerid) )
        {
			if(PlayerInfo[playerid][pPhousekey] == CasaInfo[i][hId] || CasaInfo[i][hLock] == 0)
			{
				Entrando[playerid] = 1;
				SetTimerEx("ResetEntrando", 1000, 0, "d", playerid);
			    FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
				SetPlayerInterior(playerid,CasaInfo[i][hInterior]);
				if(nevando == 1){RemovePlayerAttachedObject(playerid,INDEX_NIEVE);}
				SetPlayerPosEx(playerid,CasaInfo[i][hSx],CasaInfo[i][hSy],CasaInfo[i][hSz]);
                if (PlayerInfo[playerid][pPhousekey] == CasaInfo[i][hId])
                GameTextForPlayer(playerid, "~w~Bienvenido a casa", 5000, 1);
				PlayerInfo[playerid][pInt] = CasaInfo[i][hInterior];
				SetPlayerVirtualWorld(playerid, CasaInfo[i][hId]);
				PlayerInfo[playerid][pVw] = CasaInfo[i][hId];
				EstaEn[playerid] = i;
				return 1;
			}
			else
			{
				GameTextForPlayer(playerid, "~r~Cerrado", 5000, 1);
			}
            break;
		}
	}
	for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
			    if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqEPos_x], HeadQuarterInfo[i][hqEPos_y], HeadQuarterInfo[i][hqEPos_z]))
			    {
			        if(PlayerInfo[playerid][pMember] == HeadQuarterInfo[i][hqFaccion] || PlayerInfo[playerid][pMember] == HeadQuarterInfo[i][hqFaccion] || HeadQuarterInfo[i][hqLocked] == 0)
			        {
			            FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
			            SetPlayerInterior(playerid, HeadQuarterInfo[i][hqInterior]);
			            SetPlayerPos(playerid, HeadQuarterInfo[i][hqSPos_x], HeadQuarterInfo[i][hqSPos_y], HeadQuarterInfo[i][hqSPos_z]);
			            PlayerInfo[playerid][pInt] =HeadQuarterInfo[i][hqInterior];
			            PlayerInfo[playerid][pHq] = i;
			            PlayerInfo[playerid][pVw] = i;
			            SetPlayerVirtualWorld(playerid, i);
			        }
			        else
			        {
 						GameTextForPlayer(playerid, "~r~Cerrado", 5000, 1);
					}
					return 1;
				}
			}
	for(new i = 0; i < sizeof(NegocioInfo); i++)
	{
		if(PlayerToPoint(2.0, playerid, NegocioInfo[i][nEPos_x], NegocioInfo[i][nEPos_y], NegocioInfo[i][nEPos_z]))
		{
			if(PlayerInfo[playerid][pPbiskey] == i || NegocioInfo[i][nLocked] == 0)
			{
				Entrando[playerid] = 1;
				SetTimerEx("ResetEntrando", 1000, 0, "d", playerid);
			    FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
				if(NegocioInfo[i][nInterior] > -1)
				{
					SetPlayerInterior(playerid, NegocioInfo[i][nInterior]);
					SetPlayerVirtualWorld(playerid, i);
					PlayerInfo[playerid][pInt] = NegocioInfo[i][nInterior];
					PlayerInfo[playerid][pVw] = NegocioInfo[i][nId];
					if(nevando == 1){RemovePlayerAttachedObject(playerid,INDEX_NIEVE);}
			    }
				else
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					PlayerInfo[playerid][pInt] = 0;
					PlayerInfo[playerid][pVw] = 0;
					if(nevando == 1){RemovePlayerAttachedObject(playerid,INDEX_NIEVE);}
				}
				SetPlayerPosEx(playerid, NegocioInfo[i][nSPos_x], NegocioInfo[i][nSPos_y], NegocioInfo[i][nSPos_z]);
			    PlayerInfo[playerid][pNegocio] = NegocioInfo[i][nId];
			    SaveValue(playerid, "PosNeg", PlayerInfo[playerid][pNegocio]);
				return 1;
			}
			else
			{
 				GameTextForPlayer(playerid, "~r~Cerrado", 5000, 1);
			}
		}
	}
	
	for(new i = 0; i < MAX_INTERIOR_ENTERS; i++)
	{
		if(PlayerToPoint(2.0, playerid, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ]))
		{
			Entrando[playerid] = 1;
			SetTimerEx("ResetEntrando", 1000, 0, "d", playerid);
			SetPlayerInterior(playerid, InteriorInfo[i][Interior]);
			SetPlayerVirtualWorld(playerid,InteriorInfo[i][VWin]);
			if(nevando == 1){RemovePlayerAttachedObject(playerid,INDEX_NIEVE);}
			if(InteriorInfo[i][FixPos] == 1)
			{
				SetPlayerPosEx(playerid, InteriorInfo[i][isX], InteriorInfo[i][isY], InteriorInfo[i][isZ]);
			}
			else
			{
				SetPlayerPos(playerid, InteriorInfo[i][isX], InteriorInfo[i][isY], InteriorInfo[i][isZ]);
			}
            PlayerInfo[playerid][pHot]=i;
            SaveValue(playerid, "PosHotel", PlayerInfo[playerid][pHot]);
		}
	}
	
	for(new i; i < MAX_PARKINGS; i++)
	{ 
		if(PlayerToPoint(2.0, playerid, ParkInfo[i][paX], ParkInfo[i][paY], ParkInfo[i][paZ]) && ParkInfo[i][paType] == 2)
		{
			Entrando[playerid] = 1;
			SetTimerEx("ResetEntrando", 1000, 0, "d", playerid);
			SetPlayerInterior(playerid, 1);
			if(nevando == 1){RemovePlayerAttachedObject(playerid,INDEX_NIEVE);}
			SetPlayerVirtualWorld(playerid, i);
			SetPlayerPosEx(playerid, 1499.4244384766, 183.61317443848, 1770.9107666016);
		}
	}
	
	for(new i; i < MAX_ATMS; i++)
	{
		if(PlayerToPoint(2.0, playerid, ATMInfo[i][0], ATMInfo[i][1], ATMInfo[i][2]) && PlayerInfo[playerid][pMenu] == 0)
		{
			ShowMenuForPlayer(ATM, playerid); //oli
			//ShowTextDrawDialog(playerid, Dialogo_Cajero "ATM Cajero automatico", "Escoger", "", "Retirar", "Depositar", "Transferir", "Balance", "Salir");
			PlayerInfo[playerid][pMenu] = 1;
			TogglePlayerControllable(playerid, 0);
			format(string, 128, "* %s ingresa su tarjeta en la ranura y digita su clave secreta.", pName(playerid));
			ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
			break;
		}
	}
	
	for(new i; i < MAX_COMIDAS; i++)
	{
		if(Comidas[i][coId] == 0) continue;
		
		if(PlayerToPoint(2.0, playerid, Comidas[i][coX], Comidas[i][coY], Comidas[i][coZ]) && Comidas[i][coEliminado] == 0 && (Comidas[i][coVw] == GetPlayerVirtualWorld(playerid)|| Comidas[i][coVw]==-1  ) )
		{
			switch(Comidas[i][coType])
			{
				case 1:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(bebidas, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 2:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(snacks, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 3:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(cafes, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 4:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(restaurante, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 5:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(burger, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 6:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(pizzeria, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 7:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(pollofrito, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 8:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(barcafeteria, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 9:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(alcohol, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 10:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(donuts, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}	
				case 11:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(chino, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 12:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(perritos, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}	
				case 13:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(helados, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 14:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(japo, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 15:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(carcel, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}
				case 16:
				{
					if(PlayerInfo[playerid][pMenu] == 1) return 1;
					ShowMenuForPlayer(mexicano, playerid);
					PlayerInfo[playerid][pMenu] = 1;
				}						
			}
			TogglePlayerControllable(playerid, 0);
			break;
		}
	}
	
	if(PlayerToPoint(2.0, playerid, 362.3387,173.5419,1008.3828) && PlayerInfo[playerid][pMenu] == 0)
	{
		ShowMenuForPlayer(Tramitacion, playerid);
		TogglePlayerControllable(playerid, 0);
		PlayerInfo[playerid][pMenu] = 1;
	}
	
	if(PlayerToPoint(2.0, playerid, 1197.3617,-1730.4441,13.5702) && PlayerInfo[playerid][pMenu] == 0)
	{
		SendClientMessage(playerid, Blanco, "Reggie Smith dice: ¿Puedo ayudarle en algo?");
		ShowMenuForPlayer(Ayuda, playerid);
		TogglePlayerControllable(playerid, 0);
		PlayerInfo[playerid][pMenu] = 1;
	}
	
	return 0;
}

Comando_Salir(playerid)
{
	if(PlayerInfo[playerid][pFrozen] == 1 || PlayerInfo[playerid][pTempFrozen] == 1) return 1;
	
	if(Entrando[playerid] == 1) return 1;
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		Vehicle_OnPlayerExitVehicle(playerid, GetPlayerVehicleID(playerid));
		RemovePlayerFromVehicle(playerid);
		TogglePlayerControllable(playerid, 1);
		return 1;
	}
	else
	{
		for(new i = 0; i <  sizeof(CasaInfo); i++)
		{
			if (PlayerToPoint(3, playerid,CasaInfo[i][hSx], CasaInfo[i][hSy], CasaInfo[i][hSz]) && GetPlayerVirtualWorld(playerid)== CasaInfo[i][hId])
			{
			    FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
				SetPlayerInterior(playerid,CasaInfo[i][hInterior2]);
				SetPlayerPosEx(playerid,CasaInfo[i][hEx],CasaInfo[i][hEy],CasaInfo[i][hEz]);
				PlayerInfo[playerid][pInt] = 0;
				SetPlayerVirtualWorld(playerid, CasaInfo[i][hVw]);
				PlayerInfo[playerid][pVw] = 0;
				EstaEn[playerid] = -1;
				if(nevando == 1){SetPlayerAttachedObject( playerid, INDEX_NIEVE, 18863, 1, 36.512592, 3.075343, 6.010456, 359.854156, 351.700927, 7.929049, 1.000000, 1.000000, 1.000000 );}
				return 1;
			}
		}
			for(new i = 0; i < sizeof(HeadQuarterInfo); i++)
			{
			    if(PlayerToPoint(2.0, playerid, HeadQuarterInfo[i][hqSPos_x], HeadQuarterInfo[i][hqSPos_y], HeadQuarterInfo[i][hqSPos_z]))
			    {
			        FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
					SetPlayerInterior(playerid, 0);
     				SetPlayerPos(playerid, HeadQuarterInfo[PlayerInfo[playerid][pHq]][hqEPos_x], HeadQuarterInfo[PlayerInfo[playerid][pHq]][hqEPos_y], HeadQuarterInfo[PlayerInfo[playerid][pHq]][hqEPos_z]);
         			PlayerInfo[playerid][pInt] = 0;
            		PlayerInfo[playerid][pHq] = 0;
	            	PlayerInfo[playerid][pVw] = 0;
		            SetPlayerVirtualWorld(playerid, 0);
					return 1;
				}
			}
		for(new i = 0; i < sizeof(NegocioInfo); i++)
		{
			if(PlayerToPoint(2.0, playerid, NegocioInfo[i][nSPos_x], NegocioInfo[i][nSPos_y], NegocioInfo[i][nSPos_z]) && PlayerInfo[playerid][pNegocio] != 0)
			{
			    FlashPlayerScreen(playerid, 0x000000FF, 75, 1);
				SetPlayerInterior(playerid, 0);
				if(nevando == 1){SetPlayerAttachedObject( playerid, INDEX_NIEVE, 18863, 1, 36.512592, 3.075343, 6.010456, 359.854156, 351.700927, 7.929049, 1.000000, 1.000000, 1.000000 );}
				if(NegocioInfo[PlayerInfo[playerid][pNegocio]][nInterior] >= 1)
				{
     				SetPlayerPos(playerid, NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_x], NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_y], NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_z]);
				}
				else
				{
	    			SetPlayerPosEx(playerid, NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_x], NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_y], NegocioInfo[PlayerInfo[playerid][pNegocio]][nEPos_z]);
				}
				PlayerInfo[playerid][pInt] = 0;
            	PlayerInfo[playerid][pNegocio] = 0;
            	SaveValue(playerid, "PosNeg", PlayerInfo[playerid][pNegocio]);
	            PlayerInfo[playerid][pVw] = 0;
		        SetPlayerVirtualWorld(playerid, 0);
				return 1;
			}
		}
		
		for(new i = 0; i < MAX_INTERIOR_ENTERS; i++)
		{
			if(PlayerToPoint(2.0, playerid, InteriorInfo[i][isX], InteriorInfo[i][isY], InteriorInfo[i][isZ]))
			{
				if(i == 7 || i == 8 || i == 9 || i == 10 || i == 16)
				{
					PlayerInfo[playerid][pHotelEntered] = i;
					ShowMenuForPlayer(Elevador, playerid);
					TogglePlayerControllable(playerid, 0);
				}
				else if(GetPlayerVirtualWorld(playerid) == InteriorInfo[i][VWin])
				{
					if(InteriorInfo[i][FixPos] == 1)
					{
						SetPlayerPosEx(playerid, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ]);
					}
					else
					{
						SetPlayerPos(playerid, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ]);
					}
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid,InteriorInfo[i][VWout]);
					if(nevando == 1){SetPlayerAttachedObject( playerid, INDEX_NIEVE, 18863, 1, 36.512592, 3.075343, 6.010456, 359.854156, 351.700927, 7.929049, 1.000000, 1.000000, 1.000000 );}
                    PlayerInfo[playerid][pHot]=-1;
                    SaveValue(playerid, "PosHotel", PlayerInfo[playerid][pHot]);
				}
			}
		}
		
		if(PlayerToPoint(2.0, playerid, 1499.4244384766, 183.61317443848, 1770.9107666016))
		{
			new parking;
			parking = GetPlayerParking(playerid);
			SetPlayerInterior(playerid, 0);
			if(nevando == 1){SetPlayerAttachedObject( playerid, INDEX_NIEVE, 18863, 1, 36.512592, 3.075343, 6.010456, 359.854156, 351.700927, 7.929049, 1.000000, 1.000000, 1.000000 );}
			SetPlayerPos(playerid, ParkInfo[parking][paX], ParkInfo[parking][paY], ParkInfo[parking][paZ]);
			SetPlayerVirtualWorld(playerid, 0);
		}	
	}
	return 0;
}

forward MirarConexion(playerid);
public MirarConexion(playerid)
{
	/*if(!Audio_IsClientConnected(playerid))
	{
		ShowPlayerDialog(playerid, 1011, DIALOG_STYLE_MSGBOX, ">> Fallo de conexión del plugin de audio!", "\n No se ha podido realizar la conexión con el servidor de audio.\n Si aún no dispones de él te recomendamos visitar www.oldschool.es/audio\n para disfrutar de sus funciones. Si lo tienes pero no has podido conectar,\n solicita soporte en el foro.\n", "Aceptar", "Salir");
	}*/
	return 1;
}

public Audio_OnClientConnect(playerid)
{
    // Transfer the audio pack when the player connects
    Audio_TransferPack(playerid);
}


forward TimerDeUnMinuto();
public TimerDeUnMinuto()
{
	CheckCarsHealth();
	TiempoEventos();
	for(new tmpplayer = 0;tmpplayer < MAX_PLAYERS; tmpplayer++)
	{
		if(IsPlayerConnected(tmpplayer))
		{
			PlayerInfo[tmpplayer][pMinuto] ++;
			if(PlayerInfo[tmpplayer][pJailed] == 1 || PlayerInfo[tmpplayer][pJailed] == 3)
			{
				if(PlayerInfo[tmpplayer][pJailTime] > 0)
				{
					if(PlayerInfo[tmpplayer][pInt] == 2 && GetPlayerVirtualWorld(tmpplayer)==0)
					{
					PlayerInfo[tmpplayer][pJailTime]--;
					SaveValues(tmpplayer,"Encarcelado");
					}
				}
				else if(PlayerInfo[tmpplayer][pJailTime] == 0)
				{
					//UnjailPlayerIC(tmpplayer);
					UnJailIC(tmpplayer);
				}
			}
            if(PlayerInfo[tmpplayer][pJailed] == 2)
			{
				if(PlayerInfo[tmpplayer][pJailTime] > 0)
				{
					PlayerInfo[tmpplayer][pJailTime]--;
					SaveValues(tmpplayer,"Encarcelado");
				}
				else if(PlayerInfo[tmpplayer][pJailTime] == 0)
				{
					UnjailPlayerOOC(tmpplayer);
				}
			}
			if(PlayerInfo[tmpplayer][pUsandoTelefono] == 3)
			{
				PlayerInfo[tmpplayer][pFacturaTelefono]++;
			}
			if(PlayerInfo[tmpplayer][pAlcohol] > 0)
			{
				PlayerInfo[tmpplayer][pAlcohol] --;
			}
		}
		PlayerInfo[tmpplayer][pMinuto] ++;
	}
	return 1;
}

forward TimerGasolina();
public TimerGasolina() {
ConsumirGasolina();
return 1;

}
forward TimerDeUnaHora();
public TimerDeUnaHora()
{
	for(new tmpplayer = 0;tmpplayer < MAX_PLAYERS; tmpplayer++)
	{
		if(IsPlayerConnected(tmpplayer))
		{
            if(PlayerInfo[tmpplayer][pJailed] == 5)
			{
				if(PlayerInfo[tmpplayer][pJailTime] > 0)
				{
					PlayerInfo[tmpplayer][pJailTime]--;
					SaveValues(tmpplayer,"Encarcelado");
				}
				else if(PlayerInfo[tmpplayer][pJailTime] == 0)
				{
					//UnjailPlayerIC(tmpplayer);
					UnJailIC(tmpplayer);
				}
			}
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	Cmds_OnPlayerSelectedMenuRow(playerid, row);
	Docu_OnPlayerSelectedMenuRow(playerid, row);
	ATMS_OnPlayerSelectedMenuRow(playerid, row);
	Neg_OnPlayerSelectedMenuRow(playerid, row);
	Comidas_OnPlayerSelectedMenuRow(playerid, row);
	new Menu:menuid = GetPlayerMenu(playerid);
	if(menuid == MenuTaller){
        TogglePlayerControllable(playerid, 0);
        new coche = GetPlayerVehicleID(playerid);
		switch(row){
   			case 0:{
   			    if(FuerzaPublica(playerid) && PlayerInfo[playerid][pDuty] == 1){
   			        SetVehicleHealth(coche, 1000.0);
					Mensaje(playerid, CELESTE, "Los mecánicos del taller repararon el motor de su vehículo.");
					Mensaje(playerid, COLOR_BLANCO, "No se le cobró dinero, debido a ser un funcionario público.");
					Modificando[playerid] = 0;
					
   			    }
   			    else{
	        		if(ChequearDinero(playerid, 400)){
						SetVehicleHealth(coche, 1000.0);
						SafeGivePlayerMoney(playerid, -400);
						Mensaje(playerid, CELESTE, "Los mecánicos del taller repararon el motor de su vehículo.");
						Modificando[playerid] = 0;

					}
				}
	    	}
			case 1:{
			    if(FuerzaPublica(playerid) && PlayerInfo[playerid][pDuty] == 1){
   			        UpdateVehicleDamageStatus(coche, 0, 0, 0, 0);
					Mensaje(playerid, CELESTE, "Los mecánicos del taller repararon la carrocería de su vehículo.");
					Mensaje(playerid, COLOR_BLANCO, "No se le cobró dinero, debido a ser un funcionario público.");
					Modificando[playerid] = 0;
     
   			    }
   			    else{
	        		if(ChequearDinero(playerid, 450)){
						UpdateVehicleDamageStatus(coche, 0, 0, 0, 0);
						Compra(playerid, 450);
						Mensaje(playerid, CELESTE, "Los mecánicos del taller repararon la carrocería de su vehículo.");
						Modificando[playerid] = 0;
      
					}
				}
			}
			case 2:{
			    if(FuerzaPublica(playerid) && PlayerInfo[playerid][pDuty] == 1){
   			        UpdateVehicleDamageStatus(coche, 0, 0, 0, 0);
					EditandoColor[playerid] = 1;
					Mensaje(playerid, ROJO, "* Para editar el color del vehículo debes usar el comando /editarcolor");
          
   			    }
   			    else{
	        		if(ChequearDinero(playerid, 300)){
						UpdateVehicleDamageStatus(coche, 0, 0, 0, 0);
						Compra(playerid, 300);
						EditandoColor[playerid] = 1;
						Mensaje(playerid, ROJO, "* Para editar el color del vehículo debes usar el comando /editarcolor");
            
					}
				}
			}
			case 3:{
				Modificando[playerid] = 0;
	  		    new idcoche = GetPlayerVehicleID(playerid);
				SetVehiclePos(idcoche, TallerX[idcoche], TallerY[idcoche], TallerZ[idcoche]);
	   			SetVehicleZAngle(idcoche, TallerAngulo[idcoche]);
				SetPlayerVirtualWorld(playerid, 0);
				SetVehicleVirtualWorld(idcoche, 0);
				SetPlayerInterior(playerid, 0);
				LinkVehicleToInterior(idcoche, 0);
				EnTaller[playerid] = 0;
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, 1);
				new passengers[5];
				GetVehiclePassengers(idcoche, passengers);
				if(passengers[1] != -1){
					PutPlayerInVehicle(passengers[1], idcoche, 1);
					SetPlayerInterior(passengers[1], 0);
					SetPlayerVirtualWorld(passengers[1], 0);
					TogglePlayerControllable(passengers[1], 1);
					SetCameraBehindPlayer(passengers[1]);
				}
				if(passengers[2] != -1){
					PutPlayerInVehicle(passengers[2], idcoche, 2);
					SetPlayerInterior(passengers[2], 0);
					SetPlayerVirtualWorld(passengers[2], 0);
					TogglePlayerControllable(passengers[2], 1);
					SetCameraBehindPlayer(passengers[2]);
				}
				if(passengers[3] != -1){
					PutPlayerInVehicle(passengers[3], idcoche, 3);
					SetPlayerInterior(passengers[3], 0);
					SetPlayerVirtualWorld(passengers[3], 0);
					TogglePlayerControllable(passengers[3], 1);
					SetCameraBehindPlayer(passengers[3]);
				}
				if(passengers[4] != -1){
					PutPlayerInVehicle(passengers[4], idcoche, 4);
					SetPlayerInterior(passengers[4], 0);
					SetPlayerVirtualWorld(passengers[4], 0);
					TogglePlayerControllable(passengers[4], 1);
					SetCameraBehindPlayer(passengers[4]);
				}
				Mensaje(playerid, CELESTE, "Usted acaba de salir del taller.");
				HideMenuForPlayer(MenuTaller, playerid);
    		}
		}
	}
	if(menuid == Elevador)
	{
		switch(row)
		{
			case 0:
			{
				if(PlayerInfo[playerid][pHotelEntered] == 7 || PlayerInfo[playerid][pHotelEntered] == 8) 
				{
					SetPlayerPos(playerid, 329.1730,-1513.1047,36.0391);			
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 9 || PlayerInfo[playerid][pHotelEntered] == 10)
				{
					SetPlayerPos(playerid, 1519.2083,-1453.0273,14.2056);
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 16)
				{
					SetPlayerPos(playerid, 2754.6714,-1400.4231,39.3732);
				}
                PlayerInfo[playerid][pHot]=-1;
				SetPlayerInterior(playerid, 0);	
				SetPlayerVirtualWorld(playerid, 0);
				TogglePlayerControllable(playerid, 1);
                SaveValue(playerid, "PosHotel", PlayerInfo[playerid][pHot]);
			}
			case 1:
			{
				if(PlayerInfo[playerid][pHotelEntered] == 7 || PlayerInfo[playerid][pHotelEntered] == 8) 
				{
					SetPlayerPos(playerid, 315.3544,-1515.1603,24.9219);
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 9 || PlayerInfo[playerid][pHotelEntered] == 10)
				{
					SetPlayerPos(playerid, 1526.9440,-1457.1029,9.5000);
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 16)
				{
					SetPlayerPos(playerid, 2748.0693,-1409.9482,34.1518);
				}
                PlayerInfo[playerid][pHot]=-1;
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				TogglePlayerControllable(playerid, 1);
                SaveValue(playerid, "PosHotel", PlayerInfo[playerid][pHot]);
			}
			case 2..10:
			{
				new vw = row - 2;
				if(PlayerInfo[playerid][pHotelEntered] == 7 || PlayerInfo[playerid][pHotelEntered] == 8) 
				{
					SetPlayerPos(playerid, 2266.8803710938, 1647.3842773438, 1083.8835449219);
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 9 || PlayerInfo[playerid][pHotelEntered] == 10)
				{
					SetPlayerPos(playerid, 2224.3513183594, 1599.2528076172, 999.63250732422);
				}
				else if(PlayerInfo[playerid][pHotelEntered] == 16)
				{
					SetPlayerPos(playerid, 1578.6800537109, -1766.9837646484, 2150.0085449219);
				}
				SetPlayerInterior(playerid, 1);
				SetPlayerVirtualWorld(playerid, vw);
				TogglePlayerControllable(playerid, 1);
			}
			case 11:
			{
				HideMenuForPlayer(Elevador, playerid);
				TogglePlayerControllable(playerid, 1);
			}
		}
	}
    
	PlayerInfo[playerid][pMenu] = 0;
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid){
    new Float:danio, Float:vida2;
	if(issuerid != INVALID_PLAYER_ID){
	        switch(weaponid){
	            case 1 .. 3: { danio = 10.0; ArmaBlanca[playerid]++; }
	            case 5 .. 7: { danio = 10.0; ArmaBlanca[playerid]++; }
	            case 10 .. 15: { danio = 10.0; ArmaBlanca[playerid]++; }
	            case 4, 8, 9: { danio = 15.0; Cortes[playerid]++; }
			 	case 22: { danio = 47.0; Calibre9mm[playerid]++; }
			 	case 23:{
			 	    if(IsACop(issuerid) && Taser[issuerid] == 1){
          				if(Paralizado[playerid] == 0){
				 		    danio = 0.0;
 							format(string, sizeof(string), "* %s le efectuó un disparo con un táser disparador de cables a %s, paralizándolo.", pName(issuerid), pName(playerid));
      						ProxDetector(30.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
            				Mensaje(issuerid, COLOR_BLANCO, "Ha logrado paralizarlo con su táser, para quitarle el parálisis, utilice el comando '/q(uitar)cables' [ID Jugador].");
                			Mensaje(playerid, COLOR_BLANCO, "Usted ha sido paralizado, para que se le quite el parálisis, debe esperar a que le quiten los cables.");
							GameTextForPlayer(playerid, "Paralizado", 3000, 3);
     						TogglePlayerControllable(playerid, 0);
           					ApplyAnimation(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
           					ApplyAnimation(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
                   			Paralizado[playerid] = 1;
                   		}
			 	    }
					else{
					    danio = 50.0;
					    Calibre9mm[playerid]++;
                    }
			 	}
	        	case 25:{
			 	    if(IsACop(issuerid) && BalasDeGoma[issuerid] == 1){
          				if(Paralizado[playerid] == 0){
				 		    danio = 0.0;
 							format(string, sizeof(string), "* %s le efectuó un disparo con una escopeta de balas de goma %s, paralizándolo.", pName(issuerid), pName(playerid));
      						ProxDetector(30.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
            				Mensaje(issuerid, COLOR_BLANCO, "Ha logrado paralizarlo con su escopeta de balas de goma, se le quitará su parálisis en 15 segundos.");
                			Mensaje(playerid, COLOR_BLANCO, "Usted ha sido paralizado, se le quitará el parálisis en 15 segundos.");
							GameTextForPlayer(playerid, "Paralizado", 3000, 3);
     						TogglePlayerControllable(playerid, 0);
           					ApplyAnimation(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
           					ApplyAnimation(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
                 			Paralizado[playerid] = 1;
                 			SetTimerEx("LevantarseParalizado", 15000, false, "i", playerid);
                 			Goma[playerid]++;
                    	}
			 	    }
					else{
					    danio = 125.5;
					    Calibre37[playerid]++;
                    }
			 	}
			 	case 24: { danio = 45.5; Calibre45[playerid]++; }
	         	case 26: { danio = 121.1; Calibre37[playerid]++; }
	          	case 27: { danio = 110.5; Calibre37[playerid]++; }
	          	case 28,32: { danio = 25.2; Calibre919[playerid]++; }
	          	case 29: { danio = 45.7; Calibre10mm[playerid]++; }
	         	case 30: { danio = 65.5; Calibre22[playerid]++; }
	         	case 31: { danio = 65.2; Calibre24[playerid]++; }
	         	case 33: { danio = 45.1; Calibre44[playerid]++; }
	         	case 34: { danio = 300.0; Calibre57[playerid]++; SetPlayerArmour(playerid,0); GM_SetPlayerHealth(playerid, 0); return 1; }
		        default: danio = amount;
	        }
	        new Float:chaleco2;
	        GetPlayerHealth(playerid, vida2);
	        GetPlayerArmour(playerid, chaleco2);
	        if(chaleco2 >= 1)
	        {
	        new Float:nuevochaleco;
	        nuevochaleco = chaleco2-danio-amount;
	        if(nuevochaleco <= 0) { SetPlayerArmour(playerid, 0); } else {
	        SetPlayerArmour(playerid, nuevochaleco); }
	        }
	        else {
			new Float:nuevavida;
			nuevavida = vida2-danio-amount;
			if(nuevavida <= 0) { GM_SetPlayerHealth(playerid, 0); } else {
	        GM_SetPlayerHealth(playerid, nuevavida); }
	        }
    }
    
    return 1;
}
public OnPlayerExitedMenu(playerid)
{
	SetTimerEx("Menus", 2000, 0, "d", playerid);
    TogglePlayerControllable(playerid,1);
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	GPS_OnPlayerStream(playerid, forplayerid);
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	GPS_OnPlayerStream(playerid, forplayerid);
	return 1;
}

public OnDynamicObjectMoved(objectid)
{
	Ascensor_OnObjectMoved(objectid);
	return 1;
}

forward Menus(playerid);
public Menus(playerid)
{
	PlayerInfo[playerid][pMenu] = 0;
	return 1;
}

forward ResetEntrando(playerid);
public ResetEntrando(playerid)
{
	Entrando[playerid] = 0;
}

forward FixDeathCar(playerid);
public FixDeathCar(playerid)
{
	PlayerInfo[playerid][pFixDeathCar] = 0;
	return 1;
}

public Audio_OnStop(playerid, handleid)
{
	if(PlayerInfo[playerid][pEfecto] == handleid) PlayerInfo[playerid][pEfecto] = NOEXISTE;
}




public OnVehicleSpawn(vehicleid)
{
        return 1;
}




public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == EdadRegistro[playerid])
    {
    ShowPlayerDialog(playerid,Dialogo_IngresarEdad,DIALOG_STYLE_INPUT,"Registro - American RolePlay - Juego de Rol - Edad","Haz seleccionado ingresar la edad de tu personaje, escribe abajo la edad la cual protagonizará tu personaje","Ingresar","");
    CancelSelectTextDraw(playerid);
    }
    if(playertextid == SexoRegistro[playerid])
    {
    ShowPlayerDialog(playerid,Dialogo_IngresarSexo,DIALOG_STYLE_MSGBOX,"Registro - American RolePlay - Juego de Rol - Sexo","Haz seleccionado ingresar el sexo de tu personaje, escoge abajo el sexo el cual protagonizará tu personaje","Hombre","Mujer");
    CancelSelectTextDraw(playerid);
    }
    if(playertextid == OrigenRegistro[playerid])
    {
    ShowPlayerDialog(playerid, Dialogo_IngresarOrigen, DIALOG_STYLE_LIST, "Registro - American RolePlay - Juego de Rol - Origen", "Nacido en Los Angeles\nExtranjero - Europa\nExtranjero - Latino\nExtranjero - Africano\nExtranjero - Afroamericano", "Seleccionar", "");
    CancelSelectTextDraw(playerid);
    }
    if(playertextid == IngresarDatosRegistro[playerid])
    {
    ShowPlayerDialog(playerid,Dialogo_IngresarDatos,DIALOG_STYLE_MSGBOX,"Registro - American RolePlay - Juego de Rol - Ingresar Datos","Haz seleccionado ingresar los datos de tu personaje, ¿Estas seguro de los datos? Confirma clickeando debajo","Si","No");
    CancelSelectTextDraw(playerid);
    }
    return 1;
}

public SalidaBombero(playerid,vehiculo,garaje)
{
if(garaje == 1 && PlayerToPoint(3.0,playerid,498.3503,240.0694,1020.7260))
{
SetVehiclePosiEx(vehiculo, playerid, 1366.3666,-1639.3373,13.6187);
SetVehicleVirtualWorld(vehiculo,0);
SetPlayerVirtualWorld(playerid,0);
SetVehicleZAngle(vehiculo,269.2637);
}
else if(garaje == 2 && PlayerToPoint(3.0,playerid,487.6516,239.9947,1020.7260))
{
SetVehiclePosiEx(vehiculo, playerid, 1366.3666,-1639.3373,13.6187);
SetVehicleVirtualWorld(vehiculo,0);
SetPlayerVirtualWorld(playerid,0);
SetVehicleZAngle(vehiculo,269.2637);
}
else if(garaje == 3 && PlayerToPoint(3.0,playerid,477.0507,239.8305,1020.7260))
{
SetVehiclePosiEx(vehiculo, playerid, 1366.3666,-1639.3373,13.6187);
SetVehicleVirtualWorld(vehiculo,0);
SetPlayerVirtualWorld(playerid,0);
SetVehicleZAngle(vehiculo,269.2637);
}
return 1;
}


public EntradaBombero(playerid,vehiculo,garaje)
{
if(garaje == 1 && PlayerToPoint(3.0,playerid,1351.3739,-1635.6384,13.3991))
{
SetVehiclePosiEx(vehiculo, playerid, 498.3203,245.2899,1020.4304);
SetVehicleVirtualWorld(vehiculo,1);
SetPlayerVirtualWorld(playerid,1);
Streamer_Update(playerid);
SetVehicleZAngle(vehiculo,3.2783);
}
else if(garaje == 2 && PlayerToPoint(3.0,playerid,1349.7943,-1645.5375,13.7034))
{
SetVehiclePosiEx(vehiculo, playerid, 488.2334,244.2745,1020.6669);
SetVehicleVirtualWorld(vehiculo,1);
SetPlayerVirtualWorld(playerid,1);
Streamer_Update(playerid);
SetVehicleZAngle(vehiculo,358.5797);
}
else if(garaje == 3 && PlayerToPoint(3.0,playerid,1349.5012,-1653.6113,13.7034))
{
SetVehiclePosiEx(vehiculo, playerid, 476.8766,246.7430,1020.4318);
SetVehicleVirtualWorld(vehiculo,1);
SetPlayerVirtualWorld(playerid,1);
Streamer_Update(playerid);
SetVehicleZAngle(vehiculo,4.6121);
}
return 1;
}




public ColocarFuego(playerid,tipo)
{
new Float:XX,Float:YY,Float:ZZ;
GetPlayerPos(playerid,XX,YY,ZZ);
if(tipo==1) //Chico
{
CrearFuego(1, XX,YY,ZZ, 2);
//CreateDynamicObject(18688, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0);
}
else if(tipo==2)
{
CrearFuego(2, XX,YY,ZZ, 2);
//CreateDynamicObject(18692, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Mediano
}
else if(tipo==3)
{
CrearFuego(3, XX,YY,ZZ, 2);
//CreateDynamicObject(18691, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Grande
}
else if(tipo==4)
{
CrearFuego(4, XX,YY,ZZ, 2);
//CreateDynamicObject(18691, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Grande
}
else if(tipo==5)
{
CrearFuego(4, XX,YY,ZZ, 2);
//CreateDynamicObject(18691, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Grande
}
else if(tipo==6)
{
CrearFuego(4, XX,YY,ZZ, 2);
//CreateDynamicObject(18691, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Grande
}
else if(tipo==7)
{
CrearFuego(7, XX,YY,ZZ, 2);
//CreateDynamicObject(18691, XX,YY,ZZ-2.0, 0.0, 0.0, 0.0, 0); //Grande
}
return 1;
}
stock CrearFuego(tipo, Float:x,Float:y,Float:z, departament)
{
	switch(tipo)
	{
		case 1:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18688, x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 2:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18692, x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 3:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18691,x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 4:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18725,x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 5:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18726,x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 6:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(18727,x, y, z-2.0, 0, 0, 0.0);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}
		case 7:
		{
			for(new i = 0; i < sizeof(FuegosInfo); i++)
			{
				if(FuegosInfo[i][bpCreated] == 0)
				{
					FuegosInfo[i][bpType]=tipo;
					FuegosInfo[i][bpCreated]=1;
					FuegosInfo[i][bpX]=x;
					FuegosInfo[i][bpY]=y;
					FuegosInfo[i][bpZ]=z;
					FuegosInfo[i][bpObject] = CreateDynamicObject(2780,x,y,z-2.5, 0.0, 0.0, 180);
					FuegosInfo[i][bpDepartament]=departament;
					return 1;
				}
			}
		}

		
	}
  	return 0;
}
stock DeleteFuegoAllObjects(playerid)
{
    for(new i = 0; i < sizeof(FuegosInfo); i++)
  	{
  	    if(FuegosInfo[i][bpCreated] == 1 && FuegosInfo[i][bpDepartament] == PlayerInfo[playerid][pMember])
  	    {
			FuegosInfo[i][bpType]=0;
  	        FuegosInfo[i][bpCreated]=0;
            FuegosInfo[i][bpX]=0.0;
            FuegosInfo[i][bpY]=0.0;
            FuegosInfo[i][bpZ]=0.0;
            DestroyDynamicObject(FuegosInfo[i][bpObject]);
			FuegosInfo[i][bpDepartament]=0;
  	    }
	}
    return 0;
}

stock DeleteFuegoClosestObject(playerid)
{
    for(new i = 0; i < sizeof(FuegosInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 2.0, FuegosInfo[i][bpX], FuegosInfo[i][bpY], FuegosInfo[i][bpZ]) && FuegosInfo[i][bpDepartament] == PlayerInfo[playerid][pMember])
        {
  	        if(FuegosInfo[i][bpCreated] == 1)
            {
				FuegosInfo[i][bpType]=0;
                FuegosInfo[i][bpCreated]=0;
                FuegosInfo[i][bpX]=0.0;
                FuegosInfo[i][bpY]=0.0;
                FuegosInfo[i][bpZ]=0.0;
                DestroyDynamicObject(FuegosInfo[i][bpObject]);
				FuegosInfo[i][bpDepartament]=0;
                return 1;
  	        }
  	    }
  	}
    return 0;
}
public OnPlayerRequestGate(playerid, gateid)
{
    if(gateid == BARRIER_LSPD && PlayerInfo[playerid][pMember] == 1) return 0;
    return 1; // Player can pass
}
/*public IngresarAnuncio(playerid,textox[],tiempo)
{
for(new i = 0; i < sizeof(AnunciosInfo); i++)
{
if(AnunciosInfo[i][aCreado] == 0)
{
//new msj[256];
AnunciosInfo[i][aID]=i;
AnunciosInfo[i][aIDPersona]=playerid;
AnunciosInfo[i][aTiempo]=tiempo;
AnunciosInfo[i][aMostrar]=1;
AnunciosInfo[i][aCreado]=1;
format(AnunciosInfo[i][aTexto], 256, "%s", textox);
//format(msj,sizeof(msj),"Has ingresado tu anuncio id %d , con el texto %s",AnunciosInfo[i][aID],AnunciosInfo[i][aTexto]);
//SendClientMessage(playerid,-1,msj);
return 1;
}
}
return 1;
}*/

/*public MostrarAnuncios(playerid)
{
for(new i = 0; i < sizeof(AnunciosInfo); i++)
{
if(AnunciosInfo[i][aCreado] == 1)
{
new jugador = AnunciosInfo[i][aIDPersona];
new final[256];
format(final, sizeof(final), "[ID:%d][ANUNCIO]: %s, contacto: %d",playerid, AnunciosInfo[i][aTexto], PlayerInfo[jugador][pPnumber][ActiveNumber[jugador]]);
SendClientMessage(playerid,Verde,final);
}
}
return 1;
}*/



dcmd_anpcs(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarDick(playerid);
    ActivarDick2(playerid);
    ActivarDick3(playerid);
    ActivarDick4(playerid);
    ActivarPoli1(playerid);
    ActivarPoli2(playerid);
    ActivarPoli3(playerid);
    ActivarPoli4(playerid);
    ActivarPoli5(playerid);
    ActivarPeaje1(playerid);
    ActivarPeaje2(playerid);
    ActivarPeaje3(playerid);
    ActivarDick5(playerid);
    return 1;
}


dcmd_abus(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarDick(playerid);
    return 1;
}
dcmd_abus2(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarDick2(playerid);
    return 1;
}
dcmd_abus3(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarDick3(playerid);
    return 1;
}
dcmd_abus4(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarDick4(playerid);
    return 1;
}
dcmd_apoli1(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarPoli1(playerid);
    return 1;
}
dcmd_apoli2(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarPoli2(playerid);
    return 1;
}
dcmd_apoli3(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarPoli3(playerid);
    return 1;
}
dcmd_apoli4(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarPoli4(playerid);
    return 1;
}
dcmd_apoli5(playerid, params[])
{

    #pragma unused params

    if(PlayerInfo[playerid][pAdmin] != 7)
	{
	SendClientMessage(playerid, -1, "{FF0000}¿Qué intentas?!");
	return 1;
	}

    ActivarPoli5(playerid);
    return 1;
}



dcmd_boombox(playerid, params[])
{

		#pragma unused params

        if(!GetPVarType(playerid, "BoomboxObject"))
        {
	    ShowPlayerDialog(playerid, 1050, DIALOG_STYLE_LIST, "Canciones:", "-> Reggaeton\nElectro\n", "Aceptar", "Salir");
	    }
	    else
        {
        DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));
        DeletePVar(playerid, "BoomboxObject"); DeletePVar(playerid, "BoomboxURL");
        DeletePVar(playerid, "bposX"); DeletePVar(playerid, "bposY"); DeletePVar(playerid, "bposZ");
        if(GetPVarType(playerid, "bboxareaid"))
        {
            foreach(Player,i)
            {
                if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
                {
                    StopAudioStreamForPlayer(i);
                    SendClientMessage(i, -1, "El jugador que creo la radio, la ha quitado.");
                }
            }
            DeletePVar(playerid, "bboxareaid");
        }
        SendClientMessage(playerid, -1, "* Has quitado la radio.");
        }
	    return 1;
}

dcmd_barraluces(playerid, params[])
{

		#pragma unused params
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(LucesEncendidas[vehicleid] == 1) return SendClientMessage(playerid, -1, "{FF0000}Para quitar las luces debes presionar el 2 y apagarlas.");

        if(FuerzaPublica(playerid)==0)
        {
        SendClientMessage(playerid, Rojo, "* No eres policia!");
        return 1;
        }
        if(GetVehicleModel(vehicleid) != 402 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 560 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 490 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 609 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 579)
	    {
        SendClientMessage(playerid, Rojo, "* No estás en un vehículo de policia!");
        return 1;
		}
		
		if(PuedeUsarLuces[vehicleid] == 0)
	    {

        if(IsBuffalo(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.449999,0.749999,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsFBIRancher(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.0, -0.5, 0.8, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}//
		if(IsHuntley(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,0.000000,1.200000,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}// Fin Huntley
		
		if(IsFlatbed(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,1.275000,1.650000,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}// Fin Huntley
		if(IsCamionBombero(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,2.400000,1.500000,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}// Fin Huntley
		if(IsVincent(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,-0.450000,0.674999,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}// Fin Huntley
		if(IsBoxVille(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		vLuz2[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        Luz2[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.000000,1.875000,2.025000,0.000000,0.000000,0.000000);
        AttachDynamicObjectToVehicle(Luz2[vehicleid], vehicleid, 0.000000,-2.775001,2.100000,0.000000,0.000000,0.000000);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vLuz2[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        DestroyDynamicObject(Luz2[vehicleid]);
        }
		}// Fin Boxville
		if(IsSultan(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
		if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
		SendClientMessage(playerid, -1, "* Ahora presiona el 2 para prenderlas.");
        Luz[vehicleid] = CreateDynamicObject(19420,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.0, -0.10, 0.8, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        if(vpLuz[vehicleid] == 1) return SendClientMessage(playerid, Rojo, "* Ya hay luces encendidas!");
        vLuz[vehicleid] = 0;
        vpLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		}
		else if(PuedeUsarLuces[vehicleid] == 1)
	    {
	    DestroyDynamicObject(Luz[vehicleid]);
	    PuedeUsarLuces[vehicleid] = 0;
	    DestroyDynamicObject(Luz_1[vehicleid]);
	    DestroyDynamicObject(Luz_2[vehicleid]);
		}
	    return 1;
}

dcmd_sir(playerid, params[])
{

		#pragma unused params
		
		new vehicleid = GetPlayerVehicleID(playerid);

        if(FuerzaPublica(playerid)==0)
        {
        SendClientMessage(playerid, Rojo, "* No eres policia ni médico!");
        return 1;
        }
        
		if(!VehiculosPD_Y_MD(playerid))
		{
		SendClientMessage(playerid, Rojo, "* No estás en un vehículo de policías ó bomberos!");
        return 1;
		}

		if(PlayerInfo[playerid][pMember] == 1)
		{
        if(IsInfernus(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsChettah(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsBullet(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsHuntley(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		
		if(IsFBIRancher(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsLSPD(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz_1[vehicleid] = CreateDynamicObject(19292,0,0,0,0,0,0); // Azul.
        Luz_2[vehicleid] = CreateDynamicObject(19290,0,0,0,0,0,0); // Rojo.
        AttachDynamicObjectToVehicle(Luz_1[vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
        AttachDynamicObjectToVehicle(Luz_2[vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz_1[vehicleid]);
        DestroyDynamicObject(Luz_2[vehicleid]);
        }
		}
		if(IsSFPD(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz_1[vehicleid] = CreateDynamicObject(19292,0,0,0,0,0,0); // Azul.
        Luz_2[vehicleid] = CreateDynamicObject(19290,0,0,0,0,0,0); // Rojo.
        AttachDynamicObjectToVehicle(Luz_1[vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
        AttachDynamicObjectToVehicle(Luz_2[vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz_1[vehicleid]);
        DestroyDynamicObject(Luz_2[vehicleid]);
        }
		}
		if(IsLVPD(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz_1[vehicleid] = CreateDynamicObject(19292,0,0,0,0,0,0); // Azul.
        Luz_2[vehicleid] = CreateDynamicObject(19290,0,0,0,0,0,0); // Rojo.
        AttachDynamicObjectToVehicle(Luz_1[vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
        AttachDynamicObjectToVehicle(Luz_2[vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz_1[vehicleid]);
        DestroyDynamicObject(Luz_2[vehicleid]);
        }
		}
		if(IsGrua(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsPremier(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsVehicleID_552(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		}
		if(PlayerInfo[playerid][pMember] == 2)
		{
        if(IsVehicleID_552(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsVehicleID_498(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsVehicleID_490(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsHuntley(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		
		if(IsVehicleID_455(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz[vehicleid] = CreateDynamicObject(18646,0,0,0,0,0,0);
        AttachDynamicObjectToVehicle(Luz[vehicleid], vehicleid, 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz[vehicleid]);
        }
		}
		if(IsVehicleID_540(playerid))
		{
        if(vLuz[vehicleid] == 0)
        {
		vLuz[vehicleid] = 1;
        Luz_1[vehicleid] = CreateDynamicObject(19292,0,0,0,0,0,0); // Azul.
        Luz_2[vehicleid] = CreateDynamicObject(19290,0,0,0,0,0,0); // Rojo.
        AttachDynamicObjectToVehicle(Luz_1[vehicleid],vehicleid,0.5,-0.3,1.0,0.0,0.0,0.0);
        AttachDynamicObjectToVehicle(Luz_2[vehicleid],vehicleid,-0.5,-0.3,1.0,0.0,0.0,0.0);
        }
        else if(vLuz[vehicleid] == 1)
        {
        vLuz[vehicleid] = 0;
        DestroyDynamicObject(Luz_1[vehicleid]);
        DestroyDynamicObject(Luz_2[vehicleid]);
        }
		}
		}
	    return 1;
}

dcmd_desarmar(playerid, params[])
{
        if (PlayerInfo[playerid][pAdmin] == 7)
		{
	    new	id;
		if(sscanf(params,"d", id))
  		{
  			return SendClientMessage(playerid, -1, "* /desarmar [id]");
  		}
		if(!IsPlayerConnected(id))
		{
		    return SendClientMessage(playerid, -1, "{FF0000}Jugador no conectado.");
		}
		format(string, sizeof(string), "* Has desarmado a %s(%d).", pName(id), id);
        SendClientMessage(playerid, -1, string);
        SafeResetPlayerWeaponsAC(id);
        SendClientMessage(id, -1, "* Fuiste desarmado por un admin.");
        }
        else
        {
        SendClientMessage(playerid, -1, "{FF0000}No tienes los permisos.");
        }
	    return 1;
}
	
dcmd_ip(playerid, params[])
{
        if (PlayerInfo[playerid][pAdmin] == 7)
		{
	    new	id;
		if(sscanf(params,"d", id))
  		{
  			return SendClientMessage(playerid, -1, "* /ip [id]");
  		}
		if(!IsPlayerConnected(id))
		{
		    return SendClientMessage(playerid, -1, "{FF0000}Jugador no conectado.");
		}
		new PlayerIP[80];
		GetPlayerIp(id, PlayerIP, sizeof(PlayerIP));
		format(string, sizeof(string), "Jugador: %s. | IP: %s", pName(id), PlayerIP);
        SendClientMessage(playerid, -1, string);
        }
        else
        {
        SendClientMessage(playerid, -1, "{FF0000}No tienes los permisos.");
        }
	    return 1;
}



//Comandos DCMD Policiales

/*dcmd_scanner(playerid, params[])
{
	#pragma unused params
	new vehicleid = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pMember] == 1)
	{
	    if(GetVehicleModel(vehicleid) == 596 || GetVehicleModel(vehicleid) == 597 || GetVehicleModel(vehicleid) == 598)
        {
		if(Scanner[vehicleid] == 0)
		{
		StopAudioStreamForPlayer(playerid);
        KillTimer(vScanner[playerid]);
		PlayAudioStreamForPlayer(playerid, "http://k007.kiwi6.com/hotlink/rvr1gpwgfs/lapd_scanner.mp3");
        vScanner[playerid] = SetTimerEx("LAPD_Scanner", 611000, true, "d", playerid);
        Scanner[vehicleid] = 1;
		}
		else if(Scanner[vehicleid] == 1)
		{
		StopAudioStreamForPlayer(playerid);
        KillTimer(vScanner[playerid]);
        Scanner[vehicleid] = 0;
		}
		}
		else
		{
		SendClientMessage(playerid, Rojo, "* No estás en un vehículo de policía!");
        return 1;
		}
	    }
	    else
	    {
	    SendClientMessage(playerid, Rojo, "* No eres policía!");
	    return 1;
	    }
	return 1;
}*/

dcmd_multarcoche(playerid, params[])
{
new coche,preciomulta,razonmulta[128],mensajj[256];
if(PlayerInfo[playerid][pMember]!=1) return SendClientMessage(playerid,Rojo,"No eres policía");
if(PlayerInfo[playerid][pDuty] == 0) return SendClientMessage(playerid,Rojo,"No estás en servicio");
coche = vehiculomascercano(playerid);
if(sscanf(params, "ds[128]", preciomulta,razonmulta)) return SendClientMessage(playerid, Blanco, "Uso: /multarcoche [Precio$$] [Razon]");
{
if(CarInfo[coche][cUsos]==1) return SendClientMessage(playerid,Rojo,"No puedes multar vehículos policiales");
CarInfo[coche][cMulta] = preciomulta;
format(CarInfo[coche][cRazonMulta], 128, "%s", razonmulta);
format(mensajj,sizeof(mensajj),"Has multado al vehiculo por $%d, la razón es %s, el jugador deberá pagar al subir.",CarInfo[coche][cMulta],CarInfo[coche][cRazonMulta]);
SendClientMessage(playerid,Amarillo,mensajj);
SaveCar(coche);
}
return 1;
}
dcmd_ultimoocupante(playerid, params[])
{
#pragma unused params
if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid,Rojo,"No eres administrador");
new coche = vehiculomascercano(playerid);
format(string,sizeof(string),"El ultimo ocupante es: %s",CarInfo[coche][cUltimoOcupante]);
SendClientMessage(playerid,Amarillo,string);
return 1;
}
dcmd_rescatar(playerid, params[])
{
new jugador,Float:PossX,Float:PossY,Float:PossZ,Float:PossX2,Float:PossY2,Float:PossZ2;
if(PlayerInfo[playerid][pMember]!=2) return SendClientMessage(playerid,Rojo,"¡No eres bombero!");
if(PlayerInfo[playerid][pDuty] == 0) return SendClientMessage(playerid,Rojo,"¡No estás de servicio!");
if(sscanf(params, "u", jugador)) return SendClientMessage(playerid, Blanco, "Uso: /rescatarbomberos [ID]");
{
if(JugadorChoque[playerid]==0) return SendClientMessage(playerid,Amarillo,"¡El jugador no está herido!");
GetPlayerPos(jugador,PossX,PossY,PossZ);
GetPlayerPos(playerid,PossX2,PossY2,PossZ2);
if(!PlayerToPoint(6.0,playerid,PossX,PossY,PossZ)) return SendClientMessage(playerid,Rojo,"¡No estás cerca del jugador!");
SetPlayerPos(jugador,PossX2,PossY2,PossZ2);
JugadorChoque[jugador] = 0;
LoopingAnim(jugador,"CRACK","crckdeth1",4.1,0,1,1,1,1);
new msjjj[128];
format(msjjj,sizeof(msjjj),"El bombero %s te ha rescatado del vehículo, mantente ahí.",pName(playerid));
SendClientMessage(playerid,Amarillo,msjjj);
format(string,sizeof(string),"Has rescatado a %s.",pName(jugador));
SendClientMessage(playerid,Verde,string);
TogglePlayerControllable(playerid, 1);
}
return 1;
}



dcmd_pagarmulta(playerid, params[])
{
#pragma unused params
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,Amarillo,"No estás en un auto");
new coche = GetPlayerVehicle(playerid);
if(CarInfo[coche][cMulta] >=1)
{
if(SafeGetPlayerMoney(playerid)>=CarInfo[coche][cMulta])
{
SafeGivePlayerMoney(playerid,-CarInfo[coche][cMulta]);
format(string,sizeof(string),"Has pagado la multa pendiente de $%d por la razón: %s",CarInfo[coche][cMulta],CarInfo[coche][cRazonMulta]);
SendClientMessage(playerid,Amarillo,string);
CarInfo[coche][cMulta] = 0;
format(CarInfo[TotalVeh][cRazonMulta], 128, "%s", "Ninguna");
SaveCar(coche);
}
}
return 1;
}


dcmd_dpr(playerid, params[])
{
new jugador,puntos;
if(PlayerInfo[playerid][pAdmin]==0) return SendClientMessage(playerid,Rojo,"No estás autorizado");
if(sscanf(params, "ud", jugador,puntos)) return SendClientMessage(playerid, Blanco, "Uso: /dpr [ID] <puntos>");
{
PlayerInfo[jugador][PuntosPositivos] +=puntos;
format(string,sizeof(string),"Has recibido %d puntos de rol, ahora tienes : %d positivos y %d negativos",puntos,PlayerInfo[jugador][PuntosPositivos],PlayerInfo[jugador][PuntosNegativos]);
SendClientMessage(jugador,Amarillo,string);
format(string,sizeof(string),"Le has dado un punto de rol a %s",pName(jugador));
SendClientMessage(playerid,Amarillo,string);
SaveValue(jugador,"PuntosPositivos",PlayerInfo[jugador][PuntosPositivos]);
}
return 1;
}


dcmd_qpr(playerid, params[])
{
new jugador,puntos;
if(PlayerInfo[playerid][pAdmin]==0) return SendClientMessage(playerid,Rojo,"No estás autorizado");
if(sscanf(params, "ud", jugador,puntos)) return SendClientMessage(playerid, Blanco, "Uso: /qpr [ID] <puntos>");
{
PlayerInfo[jugador][PuntosNegativos] +=puntos;
format(string,sizeof(string),"Has recibido %d puntos de rol NEGATIVO, ahora tienes : %d positivos y %d negativos",puntos,PlayerInfo[jugador][PuntosPositivos],PlayerInfo[jugador][PuntosNegativos]);
SendClientMessage(jugador,Amarillo,string);
format(string,sizeof(string),"Le has dado  un punto de rol NEGATIVO  a %s",pName(jugador));
SendClientMessage(playerid,Amarillo,string);
SaveValue(jugador,"PuntosNegativos",PlayerInfo[jugador][PuntosNegativos]);
}
return 1;
}
dcmd_rpr(playerid, params[])
{
new jugador;
if(PlayerInfo[playerid][pAdmin]==0) return SendClientMessage(playerid,Rojo,"No estás autorizado");
if(sscanf(params, "u", jugador)) return SendClientMessage(playerid, Blanco, "Uso: /rpr [ID] ");
{
PlayerInfo[jugador][PuntosNegativos] = 0;
PlayerInfo[jugador][PuntosPositivos] = 0;
//format(string,sizeof(string),"Has recibido %d puntos de rol NEGATIVO, ahora tienes : %d positivos y %d negativos",puntos,PlayerInfo[playerid][PuntosPositivos],PlayerInfo[playerid][PuntosNegativos]);
//SendClientMessage(jugador,Amarillo,string);
format(string,sizeof(string),"Le has reseteado los puntos de rol a %s",pName(jugador));
SendClientMessage(playerid,Amarillo,string);
SaveValue(jugador,"PuntosNegativos",PlayerInfo[jugador][PuntosNegativos]);
SaveValue(jugador,"PuntosPositivos",PlayerInfo[jugador][PuntosPositivos]);
}
return 1;
}



dcmd_abrirceldas(playerid, params[])
{
#pragma unused params
if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres policía");
if(celdas==0)
{
MoveDynamicObject(celda1,2588.41, -1327.63, 1044.03,4);
MoveDynamicObject(celda2,2592.32, -1327.64, 1044.03,4);
MoveDynamicObject(celda3,2596.34, -1327.66, 1044.03,4);
MoveDynamicObject(celda4,2600.18, -1327.68, 1044.03,4);
MoveDynamicObject(celda5,2604.21, -1327.66, 1044.03,4);
MoveDynamicObject(celda6,2608.11, -1327.70, 1044.03,4);
celdas = 1;
}
return 1;
}


dcmd_cerrarceldas(playerid, params[])
{
#pragma unused params
if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres policía");
if(celdas==1)
{
MoveDynamicObject(celda1,2589.83, -1327.63, 1044.03,1);
MoveDynamicObject(celda2,2593.85, -1327.64, 1044.03,1);
MoveDynamicObject(celda3,2597.79, -1327.66, 1044.03,1);
MoveDynamicObject(celda4,2601.71, -1327.68, 1044.03,1);
MoveDynamicObject(celda5,2605.74, -1327.66, 1044.03,1);
MoveDynamicObject(celda6,2609.73, -1327.70, 1044.03,1);
celdas = 0;
}
return 1;
}


public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
	    if(GetPlayerWeapon(playerid) == 4)
         {
        new Float:health;
    	GetPlayerHealth(damagedid,health);
	    SetPlayerHealth(damagedid, health+amount-15);
	    VecesCuchillo[damagedid]++;
	    if(VecesCuchillo[damagedid]==2)
	    {
        FlashPlayerScreen(damagedid, 0xe70000FF, 75, 1);
        SetPlayerDrunkLevel(damagedid, 50000);
	    SetTimerEx("QuitarEfecto", 12000, 0, "d", damagedid);
	    VecesCuchillo[damagedid] = 0;
	    }
		}

		if(GetPlayerWeapon(playerid) == 5)
	    {
        new Float:health;
    	GetPlayerHealth(damagedid,health);
	    SetPlayerHealth(damagedid, health+amount-10);
	    VecesBate[damagedid]++;
	    if(VecesCuchillo[damagedid]==2)
	    {
        FlashPlayerScreen(damagedid, 0xe70000FF, 75, 1);
        SetPlayerDrunkLevel(damagedid, 50000);
	    SetTimerEx("QuitarEfecto", 12000, 0, "d", damagedid);
	    VecesBate[damagedid] = 0;
	    }
	    }
	    
        if(GetPlayerWeapon(playerid) == 3)
	    {
        new Float:health;
    	GetPlayerHealth(damagedid,health);
	    SetPlayerHealth(damagedid, health+amount-10);
	    VecesPalo[damagedid]++;
	    if(VecesPalo[damagedid]==2)
	    {
        FlashPlayerScreen(damagedid, 0xe70000FF, 75, 1);
        SetPlayerDrunkLevel(damagedid, 50000);
	    SetTimerEx("QuitarEfecto", 12000, 0, "d", damagedid);
	    VecesPalo[damagedid] = 0;
	    }
	    }
	    
	    if(GetPlayerWeapon(playerid) == 0)
	     {
        new Float:health;
    	GetPlayerHealth(damagedid,health);
	    SetPlayerHealth(damagedid, health+amount-5);
	    VecesCombo[damagedid]++;
	    if(VecesCombo[damagedid]==4)
	    {
        FlashPlayerScreen(damagedid, 0xe70000FF, 75, 1);
        SetPlayerDrunkLevel(damagedid, 50000);
	    SetTimerEx("QuitarEfecto", 12000, 0, "d", damagedid);
	    VecesCombo[damagedid] = 0;
	    }
        }

return 1;
}

public Congelar(playerid)
{
    TogglePlayerControllable(playerid, 0);
    ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
	ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
	ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
	ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
    return 1;
}

forward Crack(playerid);
public Crack(playerid)
{
       ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
       ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
	   ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
	   ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
       return 1;
}

public QuitarEfecto(playerid)
{
    SetPlayerDrunkLevel(playerid, 0);
    //TogglePlayerControllable(playerid, 1);
    //ClearAnimations(playerid);
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	KillTimer(Anim[playerid]);
    return 1;
}

public TazedRemove(playerid)
{
	ClearAnimations(playerid);
    SetPlayerDrunkLevel(playerid, 50000);
	SetTimerEx("QuitarEfecto", 100000, 0, "i", playerid);
	Anim[playerid] = SetTimerEx("Crack", 100, 1, "i", playerid);
	ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
    ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
	ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
	ApplyAnimation(playerid,"CRACK","crckdeth2", 4.0, 1, 1, 1, 1, 1, 1);
	SetTimerEx("Congelar", 2000, 0, "i", playerid);
	Taseado[playerid] = 0;
	return 1;
}



//
forward ElNombreEsAntirol(playerid);
public ElNombreEsAntirol(playerid)
{
	/*

		Esta es una revisión de Nombre_Apellido creada por Autorojo para Mixtico Roleplay.
		Fue creada con el fin de usarse en una callback como OnPlayerConnect y OnPlayerRequestClass.

		ElNombreEsAntirol devuelve TRUE si el nombre no contiene guión bajo o contiene más de uno,
		si contiene carácteres inválidos, si contiene minúscula o guión bajo en el inicio del Nombre o el Apellido,
		o si contiene conceptos inválidos en todo el nombre (como troll, puto, marico, etcétera).
		De lo contrario, devolverá FALSE.

										www.Mixtico.net - Autorojo
											www.PHPApps.com.ar

	*/

	new bool:ERROR = false;

	new plname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, plname, sizeof(plname));

	new guionBajo = strfind(plname, "_", true);
	new dobleGuionbajo = strfind(plname, "_", true, guionBajo+1);
	new pC[2], sC[2];

	if(guionBajo != -1 && dobleGuionbajo == -1) // Si solo tiene UN GUION BAJO
	{
		strmid(pC, plname, 0, 1); // Definimos el caracter inicial del nombre
		strmid(sC, plname, guionBajo+1, guionBajo+2); // Definimos el caracter inicial del apellido
	}
	else
	{
		ERROR = true; // Si no tiene guion bajo o tiene más de uno, devuelve true.
		return ERROR;
	}

	new caracterProhibido[][] =
	{
		"<", ">", "[", "]", "(", ")", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ".", ",", ";", ":", "!", "#", "$"
	}; // Definimos los caracteres prohibidos

	new caracterInicialProhibido[][] =
	{
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "_"
	}; // Definimos los caracteres iniciales prohibidos (distingue letras en minuscula o guiones bajos)

	new conceptoProhibido[][] =
	{
		"troll", "puto", "puta", "marico", "marica", "spam", "xd", "hijo", "weon", "huevon", "chupala",
		"batman", "superman", "carl_johnson", "charles_manson"
	}; // Definimos conceptos prohibidos en el nombre de usuario (no distingue mayuscula-minuscula): agrega algunos si quieres.

	new i;
	for(i=0;i<sizeof(caracterProhibido);i++)
	{
		if(strfind(plname, caracterProhibido[i], true) != -1) ERROR = true; // Si se encuentra un caracter prohibido en el nombre, devuelve true.
	}

	for(i=0;i<sizeof(caracterInicialProhibido);i++)
	{
		if(strfind(pC, caracterInicialProhibido[i], false) != -1) ERROR = true; // Si el caracter inicial del nombre es uno que está prohibido, devuelve true.
		if(strfind(sC, caracterInicialProhibido[i], false) != -1) ERROR = true; // Mismo que el anterior, pero con el apellido.
	}

	for(i=0;i<sizeof(conceptoProhibido);i++)
	{
		if(strfind(plname, conceptoProhibido[i], true) != -1) ERROR = true; // Si se encuentra un concepto prohibido en el nombre de usuario, devuelve true.
	}

	return ERROR; // Devuelve el resultado de la revisión.
}
stock CamaraLogueo(playerid)
{
  	new RandomStart = random(7);
  	switch(RandomStart)
	{
	    case 0: {SetPlayerCameraPos(playerid, 1440.1466,-1578.7924,58.7301); 		SetPlayerCameraLookAt(playerid, 1480.8331,-1778.6486,87.0428);}
	    case 1: {SetPlayerCameraPos(playerid, -2831.5222,1113.8793,30.0481); 		SetPlayerCameraLookAt(playerid, -2814.9211,1131.0520,26.2924);}
	    case 2: {SetPlayerCameraPos(playerid, -207.0811,2141.6755,119.4371);    	SetPlayerCameraLookAt(playerid, -262.8133,2257.2371,64.1802);}
	    case 3: {SetPlayerCameraPos(playerid, 1803.2928,-1402.7351,84.1086);     	SetPlayerCameraLookAt(playerid, 1597.0746,-1262.4785,274.3510);}
	    case 4: {SetPlayerCameraPos(playerid, 1221.0970,-1513.5063,88.0689);     	SetPlayerCameraLookAt(playerid, 1453.7445,-1329.4412,327.4604);}
	    case 5: {SetPlayerCameraPos(playerid, 1886.5455,-1236.3918,33.1253);     	SetPlayerCameraLookAt(playerid, 1958.2098,-1205.2679,23.5294);}
	    case 6: {SetPlayerCameraPos(playerid, 208.7260,-1871.0435,8.5029);        	SetPlayerCameraLookAt(playerid, 143.6782,-1945.5010,9.1876);}
	}
	return 1;
}
stock ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}




stock MySQL_NameExists(const account[])
{
	new
	    szQuery[128],
		iRows = 0;

	format(szQuery, sizeof(szQuery), "SELECT `Nombre` FROM `players` WHERE `Nombre` = '%s'", account);
	mysql_query(szQuery);
	mysql_store_result();
	if (mysql_num_rows())
	{
	    iRows = 1;
	}
	else iRows = 0;
	mysql_free_result();
	return iRows;
}
dcmd_cambiarnombre(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] > 2)
    {
        new pID,pname[24],newname[24];
        if(sscanf(params, "ds[24]",pID,newname))return SendClientMessage(playerid,0xFF0000FF,"Uso: /cambiarnombre [ID][Nuevnombre]");
        if(pID == INVALID_PLAYER_ID)return SendClientMessage(playerid,0xFF0000FF,"ID Invalida");

        GetPlayerName(pID,pname,24);
        new query1[256],escapename[24];
        mysql_real_escape_string(newname, escapename);
        format(query1, sizeof(query1), "SELECT `Nombre` FROM `players` WHERE `Nombre` = '%s' LIMIT 1", escapename);
        mysql_query(query1);
        mysql_store_result();
        new rows = mysql_num_rows();
        if(!rows)
        {
            new query[256];
            format(query, sizeof(query), "UPDATE `players` SET `Nombre`= '%s' WHERE `Nombre` ='%s'",escapename,pname);
            mysql_query(query);
            SetPlayerName(pID,escapename);
            new levelsetter[MAX_PLAYER_NAME],adminstring[128];
            GetPlayerName(playerid,levelsetter,sizeof(levelsetter));
            format(adminstring,sizeof(adminstring),"El administrador * %s * ha cambiado tu nombre a %s!",levelsetter, newname);
            SendClientMessage(pID,0xFF0000FF, adminstring);
            SendClientMessage(playerid, 0xFF0000FF, "Has cambiado el nombre.");
        }
        else if(rows == 1)
        {
            SendClientMessage(playerid, 0xFF0000FF, "Este nombre ya existe");
        }
        mysql_free_result();
    }
    else return SendClientMessage(playerid, 0xFF0000FF, "No tienes permiso para usar el comando!");
    return 1;
}
IsAtClothShop(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,207.5627,-103.7291,1005.2578) || PlayerToPoint(25.0,playerid,203.9068,-41.0728,1001.8047))
		{//Binco & Suburban
		    return 1;
		}
		else if(PlayerToPoint(30.0,playerid,214.4470,-7.6471,1001.2109) || PlayerToPoint(50.0,playerid,161.3765,-83.8416,1001.8047))
		{//Zip & Victim
		    return 1;
		}
	}
	return 0;
}
public TiempoPeaje1()
{
      //MoveDynamicObject(peaje1, 0,0,0,0.00, -90.00, 88.72);
      SetDynamicObjectRot(peaje1, 0.00, -90.00, 88.72);
      return 1;
}
public TiempoPeaje2()
{
      //MoveDynamicObject(peaje2, 0,0,0,0.00, 90.00, 86.88);
	  SetDynamicObjectRot(peaje2, 0.00, 90.00, 86.88);
      return 1;
}
public TiempoPeaje3()
{
      //MoveDynamicObject(peaje3, 607.31, -1202.22, 17.90,0.00, 90.00, 19.28);
	  SetDynamicObjectRot(peaje3, 0.00, 90.00, 19.28);
      return 1;
}
public TiempoPeaje4()
{
      //MoveDynamicObject(peaje4, 623.30, -1186.60, 18.97,0.00, 90.00, 28.70);
	  SetDynamicObjectRot(peaje4, 0.00, 90.00, 28.70);
      return 1;
}
public TiempoPeaje5()
{
      //MoveDynamicObject(peaje5, 0,0,0,9.00, -90.00, -10.62);
	  SetDynamicObjectRot(peaje5, 9.00, -90.00, -10.62);
      return 1;
}
public TiempoPeaje6()
{

	  SetDynamicObjectRot(peaje6, -8.52, -90.00, -192.02);
      return 1;
}
public TiempoPeaje7()
{

	  SetDynamicObjectRot(peaje7, 0.00, -0.45, 92.69);
      return 1;
}
public TiempoPeaje8()
{

	  SetDynamicObjectRot(peaje8, 0.00, 0.00, -85.82);
      return 1;
}
public TiempoPeaje9()
{

	  SetDynamicObjectRot(peaje9, 0.00, 90.00, -105.00);
      return 1;
}
public TiempoPeaje10()
{

	  SetDynamicObjectRot(peaje10, 0.00, -90.00, -105.00);
      return 1;
}
public TiempoPeaje11()
{

	  SetDynamicObjectRot(peaje11, 11.00, -90.00, 156.23);
      return 1;
}
public TiempoPeaje12()
{

	  SetDynamicObjectRot(peaje12, 11.00, 86.50, 152.00);
      return 1;
}
public TiempoPeaje13()
{

	  SetDynamicObjectRot(peaje13, -13.00, -84.00, 167.50);
      return 1;
}
public TiempoPeaje14()
{

	  SetDynamicObjectRot(peaje14,4.00, -94.00, -18.00);
      return 1;
}
public TiempoPeajeLV1()
{
      //MoveDynamicObject(peajelv1, 1636.15, -18.22, 36.35, -90.27, 23.00);
	  SetDynamicObjectRot(peajelv1,0.00, -90.27, 23.00);
      return 1;
}
public TiempoPeajeLV2()
{
      //MoveDynamicObject(peajelv2, 0,0,0,0.00, -89.68, 23.40);
	  SetDynamicObjectRot(peajelv2,0.00, -89.68, 23.40);
      return 1;
}
/*public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][pGPS]==0) return SendClientMessage(playerid,Rojo,"No tienes GPS, adquiere uno en un 24/7");
    if(PlayerRoute[playerid][calculating])
    {
        SendClientMessage(playerid,0xFFFF00FF,"Espera antes de escoger otro destino");
        return 1;
    }
    if(PlayerRoute[playerid][Destination] != -1)
    {
        DisableGPS(playerid);
    }
    new PlayerClosest = NearestPlayerNode(playerid);
    new TempDestination = NearestNodeFromPoint(fX,fY,fZ);
    if(PlayerClosest == -1)
    {
        SendClientMessage(playerid,0xFFFF00FF,"Tu actual ubicación es desconocida.");
        return 1;
    }
    if(TempDestination == -1)
    {
        SendClientMessage(playerid,0xFFFF00FF,"Tu destino seleccionado no fue calculado por desconocido.");
        return 1;
    }
    if(CalculatePath(PlayerClosest, TempDestination, playerid, .CreatePolygon = true, .GrabNodePositions = true))
    {
        PlayerRoute[playerid][calculating] = true;
        SendClientMessage(playerid,0xFFFF00FF,"Conectando al satélite espera...");
    }
    else
    {
        SendClientMessage(playerid,0xFFFF00FF,"Ha ocurrido un error.");
    }
    return 1;
}

public OnPlayerClosestNodeIDChange(playerid,old_NodeID,new_NodeID)
{
    if(new_NodeID != -1)
    {
        if(PlayerRoute[playerid][Destination] != -1)
        {
            if(PlayerRoute[playerid][Destination] == new_NodeID)
            {
                SendClientMessage(playerid,0xFFFF00FF,"Has alcanzado tu destino, GPS Apagado");
                DisableGPS(playerid);
            }
            else
            {
                if(!PlayerRoute[playerid][IsInGPS_Polygon])
                {
                    if(!PlayerRoute[playerid][calculating])
                    {

                        if(CalculatePath(new_NodeID, PlayerRoute[playerid][Destination], playerid, .CreatePolygon = true, .GrabNodePositions = true))
                        {
                            DisableGPS(playerid);
                            PlayerRoute[playerid][calculating] = true;
                        }
                    }
                }
            }
        }
    }
    return 1;
}
stock DisableGPS(playerid)
{
    if(PlayerRoute[playerid][Destination] != -1)
    {
        for(new i = 0; i < PlayerRoute[playerid][Lenght]; ++i)
        {
            DestroyPlayerObject(playerid,PlayerRoute[playerid][CreatedObjects][i]);
        }
        PlayerRoute[playerid][Lenght] = 0;
        PlayerRoute[playerid][Destination] = -1;
        gps_RemovePlayer(playerid);
        DestroyDynamicArea(PlayerRoute[playerid][GPS_Polygon]);
        PlayerRoute[playerid][GPS_Polygon] = -1;
        PlayerRoute[playerid][IsInGPS_Polygon] = false;
    }
    return 1;
}

public GPS_WhenRouteIsCalculated(routeid,node_id_array[],amount_of_nodes,Float:distance,Float:Polygon[],Polygon_Size,Float:NodePosX[],Float:NodePosY[],Float:NodePosZ[])//Every processed Queue will be called here
{
    PlayerRoute[routeid][calculating] = false;
    if(amount_of_nodes > 1)
    {
        for(new i = 0; i < amount_of_nodes; ++i)
        {
            PlayerRoute[routeid][CreatedObjects][i] = CreatePlayerObject(routeid,1318,NodePosX[i],NodePosY[i],NodePosZ[i]+4.5,0.0,0.0,0.0,150.0);
        }
        PlayerRoute[routeid][Lenght] = amount_of_nodes;
        PlayerRoute[routeid][Destination] = node_id_array[amount_of_nodes-1];
        PlayerRoute[routeid][GPS_Polygon] = CreateDynamicPolygon(Polygon,.maxpoints = Polygon_Size,.playerid = routeid);
        PlayerRoute[routeid][IsInGPS_Polygon] = IsPlayerInDynamicArea(routeid,PlayerRoute[routeid][GPS_Polygon]) == 1;
        gps_AddPlayer(routeid);
        SendClientMessage(routeid,0xFFFF00FF,"Ruta recibida, suerte!");
    }
    else
    {
        SendClientMessage(routeid,0xFFFF00FF,"El satélite no responde.");
    }
    return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if(areaid == PlayerRoute[playerid][GPS_Polygon])//check if the areas match
    {
        PlayerRoute[playerid][IsInGPS_Polygon] = true;
    }
    return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if(areaid == PlayerRoute[playerid][GPS_Polygon] && PlayerRoute[playerid][IsInGPS_Polygon])
    {
        if(!PlayerRoute[playerid][calculating])
        {
            new PlayerClosest = NearestPlayerNode(playerid);
            if(PlayerClosest != -1)
            {
                if(CalculatePath(PlayerClosest, PlayerRoute[playerid][Destination], playerid, .CreatePolygon = true, .GrabNodePositions = true))
                {
                    DisableGPS(playerid);
                    PlayerRoute[playerid][calculating] = true;
                }
            }
        }
        PlayerRoute[playerid][IsInGPS_Polygon] = false;
    }
    return 1;
}*/

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    foreach(Player, i)
    {
        if(GetPVarType(i, "bboxareaid"))
        {
            new station[256];
            GetPVarString(i, "BoomboxURL", station, sizeof(station));
            if(areaid == GetPVarInt(i, "bboxareaid"))
            {
                PlayAudioStreamForPlayer(playerid, station, GetPVarFloat(i, "bposX"), GetPVarFloat(i, "bposY"), GetPVarFloat(i, "bposZ"), 30.0, 1);
                SendClientMessage(playerid, -1, "* Comienzas a escuchar la música de la radio.");
                return 1;
            }
        }
    }
    return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    foreach(Player, i)
    {
        if(GetPVarType(i, "bboxareaid"))
        {
            if(areaid == GetPVarInt(i, "bboxareaid"))
            {
                StopAudioStreamForPlayer(playerid);
                SendClientMessage(playerid, -1, "* Te alejas demasiado y dejas de escuchar la radio.");
                return 1;
            }
        }
    }
    return 1;
}

/*stock ChatLog(playerid, text[])
{
    new
     File:lFile = fopen("Logs/Chat.txt", io_append),
     logData[178],
        fyear, fmonth, fday,
        fhour, fminute, fsecond;

    getdate(fyear, fmonth, fday);
    gettime(fhour, fminute, fsecond);

    format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] %s: %s \r\n", fday, fmonth, fyear, fhour, fminute, fsecond,pName(playerid), text);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}*/





dcmd_gps(playerid,params[])
{
#pragma unused params
if(PlayerInfo[playerid][pGPS]==0) return SendClientMessage(playerid,Rojo,"No tienes GPS");
ShowPlayerDialog(playerid,DIALOGO_GPS,DIALOG_STYLE_LIST,"GPS de Los Angeles","Autoescuela\nTaller Seville\nTaller Unity\nHospital\nCamioneros\nBarrenderos\nBanco\nDesguace\nDeposito\nCarcel", "Seleccionar", "Cancelar");
UsandoGPS[playerid] = 1;
return 1;
}
dcmd_ajailoff(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid,Rojo,"No eres Administrador");
new pname[24],tiempo;
if(sscanf(params, "s[24]d",pname,tiempo))return SendClientMessage(playerid,0xFF0000FF,"Uso: /ajailoff [Nombre_Apellido] [Tiempo]");
new sqlid = MySQLCheckAccount(pname);
if (sqlid == 0)
{
SendClientMessage(playerid, Gris, "No se encontró el jugador en la Base de Datos. Asegúrate del nombre completo.");
return 1;
}
new nuevojail[256];
format(nuevojail, 128, "%d,%d",	2, tiempo);
new sql[256];
format(sql, 256, "UPDATE players SET Encarcelado = '%s' WHERE id = %d",  nuevojail, sqlid);
mysql_query(sql);
SendClientMessage(playerid, Amarillo, "Cuenta Jaileada.");
			
			
return 1;
}

dcmd_ajailic(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid,Rojo,"No eres Administrador");
new pname[24],tiempo;
if(sscanf(params, "s[24]d",pname,tiempo))return SendClientMessage(playerid,0xFF0000FF,"Uso: /ajailic [Nombre_Apellido] [Tiempo]");
new sqlid = MySQLCheckAccount(pname);
if (sqlid == 0)
{
SendClientMessage(playerid, Gris, "No se encontró el jugador en la base de datos. Asegúrate del nombre completo.");
return 1;
}
new nuevojail[256];
format(nuevojail, 128, "%d,%d",	5, tiempo);
new sql[256];
format(sql, 256, "UPDATE players SET Encarcelado = '%s' WHERE id = %d",  nuevojail, sqlid);
mysql_query(sql);
SendClientMessage(playerid, Amarillo, "Jugador jaileado de forma IC satisfactoriamente.");


return 1;
}



// -----------------------------------------------------------------------------




dcmd_barrerafd(playerid,params[])
{
#pragma unused params
if(PlayerInfo[playerid][pMember]!=2) return SendClientMessage(playerid,Rojo,"No eres bombero");
if(!PlayerToPoint(15.0,playerid,1415.27, -1651.88, 13.29)) return SendClientMessage(playerid,Rojo,"No estás cerca de la barrera");
if(estadobarrera==0)
{
MoveDynamicObject(barrerafd, 1415.24, -1651.82, 13.15, 5.0, 0.00, 5.00, 90.00);
SetDynamicObjectRot(barrerafd, 0.00, 5.00, 90.00);
estadobarrera = 1;
AutoRol(playerid,"le avisa al guardia que levante la barrera");
}
else if(estadobarrera==1)
{
estadobarrera = 0;
MoveDynamicObject(barrerafd, 1415.27, -1651.88, 13.29, 0.00, 90.00, 90.00);
SetDynamicObjectRot(barrerafd, 0.00, 90.00, 90.00);
AutoRol(playerid,"le avisa al guardia que baje la barrera");
}
return 1;
}

/*dcmd_ascensorlspd(playerid,params[])
{
#pragma unused params
if(PlayerInfo[playerid][pMember]!=1) return SendClientMessage(playerid,Rojo,"No eres policía.");
if(!PlayerToPoint(4.0,playerid,1415.27, -1651.88, 13.29)) return SendClientMessage(playerid,Rojo,"No estas en el ascensor");
return 1;
}**/

forward IsInfernus(playerid);
public IsInfernus(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 411)
    {
    return 1;
    }
    return 0;
}
forward IsChettah(playerid);
public IsChettah(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 415)
    {
    return 1;
    }
    return 0;
}
forward IsBullet(playerid);
public IsBullet(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 541)
    {
    return 1;
    }
    return 0;
}
forward IsFBIRancher(playerid);
public IsFBIRancher(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 490)
    {
    return 1;
    }
    return 0;
}
forward IsHuntley(playerid);
public IsHuntley(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 579)
    {
    return 1;
    }
    return 0;
}
forward IsBoxVille(playerid);
public IsBoxVille(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 609)
    {
    return 1;
    }
    return 0;
}
forward IsFlatbed(playerid);
public IsFlatbed(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 455)
    {
    return 1;
    }
    return 0;
}
forward IsCamionBombero(playerid);
public IsCamionBombero(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 544)
    {
    return 1;
    }
    return 0;
}
forward IsVincent(playerid);
public IsVincent(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 540)
    {
    return 1;
    }
    return 0;
}
forward IsLSPD(playerid);
public IsLSPD(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 596)
    {
    return 1;
    }
    return 0;
}
forward IsSFPD(playerid);
public IsSFPD(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 597)
    {
    return 1;
    }
    return 0;
}
forward IsLVPD(playerid);
public IsLVPD(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 598)
    {
    return 1;
    }
    return 0;
}
forward IsGrua(playerid);
public IsGrua(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
    {
    return 1;
    }
    return 0;
}
forward IsPremier(playerid);
public IsPremier(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 426)
    {
    return 1;
    }
    return 0;
}
forward VehiculosPD_Y_MD(playerid);
public VehiculosPD_Y_MD(playerid)
{
    if(IsPlayerConnected(playerid))
    {
	  if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 411 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 415 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 541 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 590 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 579)
      {
      return 1;
	  }
	  else if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 540 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 455 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 552 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 490 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 498)
      {
      return 1;
      }
      else if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 596 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 597 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 598 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 525 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 426)
      {
      return 1;
      }
	}
    return 0;
}
forward IsVehicleID_552(playerid);
public IsVehicleID_552(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 552)
    {
    return 1;
    }
    return 0;
}
forward IsVehicleID_498(playerid);
public IsVehicleID_498(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 498)
    {
    return 1;
    }
    return 0;
}
forward IsVehicleID_490(playerid);
public IsVehicleID_490(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 490)
    {
    return 1;
    }
    return 0;
}
forward IsVehicleID_455(playerid);
public IsVehicleID_455(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 455)
    {
    return 1;
    }
    return 0;
}
forward IsVehicleID_540(playerid);
public IsVehicleID_540(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 540)
    {
    return 1;
    }
    return 0;
}
forward IsBuffalo(playerid);
public IsBuffalo(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 402)
    {
    return 1;
    }
    return 0;
}

forward IsSultan(playerid);
public IsSultan(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
    {
    return 1;
    }
    return 0;
}



stock GetPlayerIDFromName(const playername[], partofname=0)
{
    new i;
    new playername1[64];
    for (i=0;i<MAX_PLAYERS;i++)
    {
        if (IsPlayerConnected(i))
        {
            GetPlayerName(i,playername1,sizeof(playername1));
            if (strcmp(playername1,playername,true)==0)
            {
                return i;
            }
        }
    }
    new correctsigns_userid=-1;
    new tmpuname[128];
    new hasmultiple=-1;
    if(partofname)
    {
        for (i=0;i<MAX_PLAYERS;i++)
        {
            if (IsPlayerConnected(i))
            {
                GetPlayerName(i,tmpuname,sizeof(tmpuname));

                if(!strfind(tmpuname,playername1[partofname],true, 0))
                {
                    hasmultiple++;
                    correctsigns_userid=i;
                }
                if (hasmultiple>0)
                {
                    return -2;
                }
            }
        }
    }
    return correctsigns_userid;
}
forward ActivarDick(playerid);
public ActivarDick(playerid)
{
	  new idjohn = GetPlayerIDFromName("John_Moore");
       PutPlayerInVehicle(idjohn, 1, 0);
      SetPlayerSkin(idjohn, 253);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
forward ActivarDick2(playerid);
public ActivarDick2(playerid)
{
      new idjohn = GetPlayerIDFromName("Robert_Johnson");
       PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 253);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
forward ActivarDick3(playerid);
public ActivarDick3(playerid)
{
      new idjohn = GetPlayerIDFromName("Laurence_Fernandez");
       PutPlayerInVehicle(idjohn, 3, 0);
      SetPlayerSkin(idjohn, 253);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
forward ActivarDick4(playerid);
public ActivarDick4(playerid)
{
      new idjohn = GetPlayerIDFromName("Diego_Willard");
       PutPlayerInVehicle(idjohn, 4, 0);
      SetPlayerSkin(idjohn, 253);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }

forward ActivarDick5(playerid);
public ActivarDick5(playerid)
{
      new idjohn = GetPlayerIDFromName("Luciano_Conti");
       PutPlayerInVehicle(idjohn, 5, 0);
      SetPlayerSkin(idjohn, 71);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      new ObjetoCaddy = CreateObject(18646,0,0,-1000,0,0,0,100);
	  AttachObjectToVehicle(ObjetoCaddy, 5, 0.300000,0.899999,0.300000,0.000000,0.000000,0.000000);
      return 1;
      }
      
      
forward ActivarPoli1(playerid);
public  ActivarPoli1(playerid)
{
      new idjohn = GetPlayerIDFromName("James_Fernandez");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 280);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      SafeGivePlayerWeapon(idjohn,31,999);
      ClearAnimations(idjohn);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);

      return 1;
      }
forward ActivarPoli2(playerid);
public  ActivarPoli2(playerid)
{
      new idjohn = GetPlayerIDFromName("Kirk_Rodriguez");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 280);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      SafeGivePlayerWeapon(idjohn,31,999);
      return 1;
      }
forward ActivarPoli3(playerid);
public  ActivarPoli3(playerid)
{
      new idjohn = GetPlayerIDFromName("Roberto_Rodriguez");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 280);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      SafeGivePlayerWeapon(idjohn,31,999);
      return 1;
      }
forward ActivarPoli4(playerid);
public  ActivarPoli4(playerid)
{
      new idjohn = GetPlayerIDFromName("Walter_Diaz");
       //PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 71);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
forward ActivarPoli5(playerid);
public  ActivarPoli5(playerid)
{
      new idjohn = GetPlayerIDFromName("John_Smith");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 71);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
      forward ActivarPeaje1(playerid);
public  ActivarPeaje1(playerid)
{
      new idjohn = GetPlayerIDFromName("Lorenc_Vitti");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 71);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
      forward ActivarPeaje2(playerid);
public  ActivarPeaje2(playerid)
{
      new idjohn = GetPlayerIDFromName("Mark_Lightman");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 71);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
      
  forward ActivarPeaje3(playerid);
public  ActivarPeaje3(playerid)
{
      new idjohn = GetPlayerIDFromName("Roberto_Rojas");
      // PutPlayerInVehicle(idjohn, 2, 0);
      SetPlayerSkin(idjohn, 188);
      LoopingAnim(idjohn,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
      SetPlayerColor(idjohn, 0xFFFFFF00);
      return 1;
      }
/*public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{

	new Float:TempCarHealth22;
	GetVehicleHealth(GetPlayerVehicleID(playerid), TempCarHealth22);
	if(TempCarHealth22>=700 && JugadorChoque[playerid] == 0)
	{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    tires = encode_tires(0, 0, 0, 0); // fix all tires
    panels = encode_panels(0, 0, 0, 0, 0, 0, 0); // fix all panels //fell off - (3, 3, 3, 3, 3, 3, 3)
    doors = encode_doors(0, 0, 0, 0, 0, 0); // fix all doors //fell off - (4, 4, 4, 4, 0, 0)
    lights = encode_lights(0, 0, 0, 0); // fix all lights
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	}
    return 1;
}*/

//

public BoomBox(playerid)
{
    //new string[128];
    if(!GetPVarType(playerid, "BoomboxObject"))
    {
        foreach(Player, i)
        {
            if(GetPVarType(i, "BoomboxObject"))
            {
                if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "bposX"), GetPVarFloat(i, "bposY"), GetPVarFloat(i, "bposZ")))
                {
                    SendClientMessage(playerid, -1, "{FF0000}Ya hay otra radio cercana, por favor, creala en otro lado.");
                    return 1;
                }
            }
        }

        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z); GetPlayerFacingAngle(playerid, a);
        SetPVarInt(playerid, "BoomboxObject", CreateDynamicObject(2103, x, y, z-1.0, 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
        SetPVarFloat(playerid, "bposX", x); SetPVarFloat(playerid, "bposY", y); SetPVarFloat(playerid, "bposZ", z);
        SetPVarInt(playerid, "bboxareaid", CreateDynamicSphere(x, y, z, 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
        format(string, sizeof(string), "* Has colocado una radio aquí.");
        SendClientMessage(playerid, -1, string);
        foreach(Player, i)
        {
            if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
            {
                PlayAudioStreamForPlayer(i, Song, GetPVarFloat(playerid, "bposX"), GetPVarFloat(playerid, "bposY"), GetPVarFloat(playerid, "bposZ"), 50.0, 1);
            }
        }
        SetPVarString(playerid, "BoomboxURL", Song);
    }
    else
    {
        DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));
        DeletePVar(playerid, "BoomboxObject"); DeletePVar(playerid, "BoomboxURL");
        DeletePVar(playerid, "bposX"); DeletePVar(playerid, "bposY"); DeletePVar(playerid, "bposZ");
        if(GetPVarType(playerid, "bboxareaid"))
        {
            foreach(Player,i)
            {
                if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
                {
                    StopAudioStreamForPlayer(i);
                    SendClientMessage(i, -1, "El jugador que creo la radio, la ha quitado.");
                }
            }
            DeletePVar(playerid, "bboxareaid");
        }
        SendClientMessage(playerid, -1, "* Has quitado la radio.");
    }
    return 1;
}

/*public Velocimetro(playerid)
{
new sstring[256];
new velocidad = GetVehicleSpeed(GetPlayerVehicleID(playerid));
format(sstring, sizeof(sstring), "> Velocidad: ~r~%d ~w~km/h", velocidad);
TextDrawSetString(Velocimetro_1[playerid], sstring);

format(sstring, sizeof(sstring), "> Gasolina: ~r~%d/~w~100", CarInfo[GetPlayerVehicle(playerid)][cGas]);
TextDrawSetString(Velocimetro_2[playerid], sstring);
if(CarInfo[GetPlayerVehicle(playerid)][cUsos] == 0) CarInfo[GetPlayerVehicle(playerid)][cKms] = floatadd(CarInfo[GetPlayerVehicle(playerid)][cKms],floatdiv(velocidad,18000));
}*/

stock GetVehicleSpeed(vehicleid)
{
        if(vehicleid != INVALID_VEHICLE_ID)
        {
                new Float:Pos[3],Float:VS ;
                GetVehicleVelocity(vehicleid, Pos[0], Pos[1], Pos[2]);
                VS = floatsqroot(Pos[0]*Pos[0] + Pos[1]*Pos[1] + Pos[2]*Pos[2])*200;
                return floatround(VS,floatround_round);
        }
        return INVALID_VEHICLE_ID;
}
/*public PlayScannerSound()
{
    for ( new i = 0; i < MAX_PLAYERS; i++ )
	{
	if ( IsPlayerConnected(i) )
	{
	if ( GetPlayerState(i) == PLAYER_STATE_ONFOOT )
	{
	new Float:ScannerPlayerPos[3]; GetPlayerPos(i, ScannerPlayerPos[0], ScannerPlayerPos[1], ScannerPlayerPos[2]);
	if ( IsPlayerInRangeOfPoint(i,
	15.0,   				// Radio del sonido
	ScannerPlayerPos[0],  			// Coordenadas X
	ScannerPlayerPos[1],      		// Coordenadas Y
	ScannerPlayerPos[2]) )			// Coordenadas Z
	{
    new CocheCercano = GetClosestCar(i);
    if ( CocheCercano )
    {
	if ( GetVehicleModel(CocheCercano) == 596 || GetVehicleModel(CocheCercano) == 597 || GetVehicleModel(CocheCercano) == 598 )
	{
	PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/it402xt3xh/police_scanner.mp3", ScannerPlayerPos[0], ScannerPlayerPos[1], ScannerPlayerPos[2], 15.0, 1);
	}
	}
	}
    }
    }
    }
	return 1;
}*/
/*GetDistanceToCar(playerid,carid){
        new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:dis;
        if (!IsPlayerConnected(playerid))return -1;
        GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
        dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
        return floatround(dis);
}
GetClosestCar(playerid){
        if (!IsPlayerConnected(playerid))return -1;new Float:prevdist = 15.0,prevcar; // 15.0 es el radio a escuchar la radio.
        for(new carid = 0; carid < MAX_VEHICLES; carid++) {
                new Float:dist = GetDistanceToCar(playerid,carid);
                if ((dist < prevdist)) {prevdist = dist;prevcar = carid;}
        }
        return prevcar;
}*/
Cinturon_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
   #pragma unused vehicleid
   #pragma unused ispassenger
   Cinturon[playerid] = 0;
   return 1;
}

Cinturon_OnPlayerExitVehicle(playerid, vehicleid)
{
	#pragma unused vehicleid
	if(Cinturon[playerid]==1)
	{

	format(string, sizeof(string),"* %s se quita el cinturon.",pName(playerid));
    ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
    Cinturon[playerid] = 0;

    }
	return 1;
}

new Atrapado[MAX_PLAYERS];
new Float:Danio[MAX_VEHICLES];
stock DB_Escape(text[]) {
	/* credits to Y_Less according to the wiki */

	new
		ret[80 * 2],
		ch,
		i,
		j;

	while ((ch = text[i++]) && j < sizeof (ret))
	{
		if (ch == '\'')
		{
			if (j < sizeof (ret) - 2)
			{
				ret[j++] = '\'';
				ret[j++] = '\'';
			}
		}
		else if (j < sizeof (ret))
		{
			ret[j++] = ch;
		}
		else
		{
			j++;
		}
	}
	ret[sizeof (ret) - 1] = '\0';
	return ret;
}

stock mktime(hour, minute, second, day, month, year)
{
	/* thanks to Y_Less again */
        static
                days_of_month[12] =
                {
                        31,
                        29,
                        31,
                        30,
                        31,
                        30,
                        31,
                        31,
                        30,
                        31,
                        30,
                        31
                },
                lMinute,
                lHour,
                lDay,
                lMonth,
                lYear,
                lMinuteS,
                lHourS,
                lDayS,
                lMonthS,
                lYearS;
        if (year != lYear)
        {
                lYearS = 0;
                for (new j = 1970; j < year; j++)
                {
                        lYearS += 31536000;
                        if ((!(j % 4) && (j % 100)) || !(j % 400)) lYearS += 86400;
                }
                lYear = year;
        }
        if (month != lMonth)
        {
                lMonthS = 0;
                month--;
                for (new i = 0; i < month; i++)
                {
                        lMonthS += days_of_month[i] * 86400;
                        if ((i == 1) && ((!(year % 4) && (year % 100)) || !(year % 400))) lMonthS += 86400;
                }
                lMonth = month;
        }
        if (day != lDay)
        {
                lDayS = day * 86400;
                lDay = day;
        }
        if (hour != lHour)
        {
                lHourS = hour * 3600;
                lHour = hour;
        }
        if (minute != lMinute)
        {
                lMinuteS = minute * 60;
                lMinute = minute;
        }
        return lYearS + lMonthS + lDayS + lHourS + lMinuteS + second;
}
public tempBanPlayer(playerid, iTime, szBannedBy[], szReason[], szIP[]) {
	/* public so you can access it from gamemodes and other scripts */

	new
	    szPlayerNameBanned[MAX_PLAYER_NAME],
	    szQuery[270];

	GetPlayerName(playerid, szPlayerNameBanned, MAX_PLAYER_NAME);

	format(szQuery, sizeof(szQuery), "INSERT INTO bans (name, ip, reason, banlength, bannedby) VALUES('%s', '%s', '%s', %d, '%s')", DB_Escape(szPlayerNameBanned), DB_Escape(szIP), DB_Escape(szReason), iTime, DB_Escape(szBannedBy));
	db_free_result(db_query(dbBans, szQuery));
	format(string,128,"BLOQUEO: El administrador %s ha bloqueado la cuenta de %s por : %d segundos",szBannedBy,szPlayerNameBanned,iTime);
	SendClientMessageToAll(Rojo,string);
	KickWithMessage(playerid,"Has sido baneado temporalmente.");
	return 1;
}

dcmd_unbanip(playerid, params[]) {
	if(isnull(params))
	    return SendClientMessage(playerid, Rojo, "Uso: {FFFFFF}/unbanip [ip]");

	if(!IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin]==0) /* set a PVar in your mode for 'Admin' to integrate this into a GM */
	    return SendClientMessage(playerid, Rojo, "Solo los administradores pueden usar el comando..");

	if(strlen(params) > 24 || strlen(params) < 4)
	    return SendClientMessage(playerid, Rojo, "ID Inválida.");

	new
	    szQuery[64];

	format(szQuery, sizeof(szQuery), "DELETE FROM bans WHERE ip = '%s'", DB_Escape(params));
	db_free_result(db_query(dbBans, szQuery));

	SendClientMessage(playerid, Rojo, "IP Desbaneada..");
	return 1;
}
dcmd_unbanname(playerid, params[]) {
	if(isnull(params))
	    return SendClientMessage(playerid, Rojo, "Uso: {FFFFFF}/unbanname [nombre]");

	if(!IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin]==0) /* set a PVar in your mode for 'Admin' to integrate this into a GM */
	    return SendClientMessage(playerid, Rojo, "Solo los administradores pueden usar el comando..");

	if(strlen(params) > 24 || strlen(params) < 3)
	    return SendClientMessage(playerid, Rojo, "Nombre Inválido.");

	new
	    szQuery[64];

	format(szQuery, sizeof(szQuery), "DELETE FROM bans WHERE name = '%s'", DB_Escape(params));
	db_free_result(db_query(dbBans, szQuery));

	SendClientMessage(playerid, Rojo, "Nombre Desbaneado.");
	return 1;
}
dcmd_bloqueocuenta(playerid, params[]) {
	new
	    iYears,
	    iMonths,
	    iDays,
	    iFinalCalculation,
	    iHours,
	    iWeeks,
	    szReason[32],
	    iMinutes,
	    szIP[19],
	    szPlayerName[MAX_PLAYER_NAME],
	    iTarget;

	if(!IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin]==0) /* set a PVar in your mode for 'Admin' to integrate this into a GM */
	    return SendClientMessage(playerid, Rojo, "Solo los administradores pueden usar el comando..");

	if(sscanf(params, "udddddds", iTarget, iYears, iMonths, iWeeks, iDays, iHours, iMinutes, szReason))
	    return SendClientMessage(playerid, Amarillo, "Uso: {FFFFFF}/bloqueocuenta [id] [años] [meses] [semanas] [dias] [horas] [minutos] [razón]");

	iFinalCalculation = gettime() + mktime(iHours, iMinutes, 0, iDays, iMonths, iYears);

	if(gettime() == iFinalCalculation)
	    return SendClientMessage(playerid, Rojo, "No has colocado las fechas correctas.");

	GetPlayerName(playerid, szPlayerName, MAX_PLAYER_NAME);
	GetPlayerIp(iTarget, szIP, sizeof(szIP));

	tempBanPlayer(iTarget, iFinalCalculation, szPlayerName, szReason, szIP);

	return 1;
}


dcmd_alimpiar(playerid, params[])
{
#pragma unused params
if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, Rojo, "¡No autorizado!");
CleanScreen();
format(string, sizeof(string), "Limpieza de chat por %s.", pName(playerid));
SendClientMessageToAll(Verde,string);
return 1;
}

dcmd_barriolujoso(playerid, params[])
{
#pragma unused params
if(IsPlayerInRangeOfPoint(playerid, 5.0, 1385.4167,-904.2206,36.0386) || IsPlayerInRangeOfPoint(playerid, 5.0, 1369.2947,-907.9342,35.1574) || IsPlayerInRangeOfPoint(playerid, 5.0, 98.7567,-1516.1543,6.6585) || IsPlayerInRangeOfPoint(playerid, 5.0, 92.1396,-1517.3466,5.7683))
{
if(!CasaBarrio(playerid)) return SendClientMessage(playerid,Rojo,"¡No eres dueño de una casa del barrio lujoso!");
if(PlayerToPoint(4.0, playerid,1372.68, -909.76, 34.68))
			{
				
	      		format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje5, 9.00, -10.00, -9.00);
				SetTimer("TiempoPeaje5", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,1381.93, -902.54, 36.03))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje6, -8.52, -10.76, -192.02);
				SetTimer("TiempoPeaje6", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,933.05, -949.05, 40.98))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje7, 0.00, 0.00, 185.00);
				SetTimer("TiempoPeaje7", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,927.90, -949.76, 40.77))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje8, 0.00, 0.00, 4.00);
				SetTimer("TiempoPeaje8", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,1527.52, -420.23, 33.47))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje9, 0.00, 11.00, -105.00);
				SetTimer("TiempoPeaje9", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
				if(PlayerToPoint(4.0, playerid,1527.32, -435.37, 33.47))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje10, 0.00, -11.00, -105.00);
				SetTimer("TiempoPeaje10", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,260.49, -1005.32, 53.56))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje11, 11.00, -20.34, 155.81);
				SetTimer("TiempoPeaje11", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,259.73, -1008.74, 54.40))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje12, 11.00, 20.66, 152.81);
				SetTimer("TiempoPeaje12", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,88.42, -1517.25, 5.18))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje13, -12.89, -16.00, 167.32);
				SetTimer("TiempoPeaje13", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
			if(PlayerToPoint(4.0, playerid,102.43, -1516.72, 6.73))
			{
				format(string, sizeof(string), "* %s le avisa al guardia que lo deje entrar.", pName(playerid));
	      		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	            SetDynamicObjectRot(peaje14, 4.00, -23.00, -18.00);
				SetTimer("TiempoPeaje14", 6000, 0);
	      		SendClientMessage(playerid, Azul,"La barrera de la entrada se cerrara en 7 segundos.");
			}
}
else
{
SendClientMessage(playerid,Rojo,"No estás en la barrera del Barrio Privado.");
return 1;
}
return 1;
}





forward CasaBarrio(playerid);
public CasaBarrio(playerid)
{
new casa = PlayerInfo[playerid][pPhousekey];
if(casa>=1 && casa <=30) return 1;
else if (PlayerInfo[playerid][pMember]==1 || PlayerInfo[playerid][pMember]==9) return 1;
return 0;
}

/*forward LAPD_Scanner(playerid);
public LAPD_Scanner(playerid)
{
       PlayAudioStreamForPlayer(playerid, "http://k007.kiwi6.com/hotlink/rvr1gpwgfs/lapd_scanner.mp3");
       return 1;
}*/

stock UnJailIC(playerid)
{
    if(PlayerInfo[playerid][pJailed] == 1) // Comisaría.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 3) // Comisaría.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 5) // Prisión Federal.
	{
		SetPlayerInterior(playerid, 2);
		SetPlayerPosEx(playerid,2567.9502,-1374.5601,1047.9301);
		SetPlayerFacingAngle(playerid,0.8462);
	}
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	SaveValues(playerid,"Encarcelado");
	return SendClientMessage(playerid, AzulClaro, "* Has cumplido tu condena. Quedas en libertad.");
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
return 0;
}

//Sistema de armas nuevo




dcmd_obtenerarmas(playerid, params[])
{
#pragma unused params
if(PlayerInfo[playerid][pTrafico] == 0) return SendClientMessage(playerid,Rojo,"¡No estás autorizado a utilizar dicho comando!");
if(!PlayerToPoint(6.0,playerid,1308.6034,-55.7202,1002.4958)) return SendClientMessage(playerid,Rojo,"No estás en la entrega de armas.");
if(cantidadarmas==10) return SendClientMessage(playerid,Rojo,"¡El límite es 10 por días de pago (horas ig)!");
ShowPlayerDialog(playerid,DIALOGO_ARMAS,DIALOG_STYLE_LIST,"Fabrica de Armas","AK-47\nDesert Eagle\nUZI\nCargador AK47\nCargador Deagle\nCargador UZI", "Seleccionar", "Cancelar");
return 1;
}


forward EntregarArma(playerid,id);
public EntregarArma(playerid,id)
{
if(cantidadarmas==10) SendClientMessage(playerid,Rojo,"Ya sacaste 10 armas, espera al próximo payday");
if(PlayerInfo[playerid][pTrafico]==1)
{

if(id==0) //AK 47
{
if(SafeGetPlayerMoney(playerid) < 2000) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (2500$)");
DarObjeto(playerid,30,1, 30);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-2000);
}

else if (id==1) //Deagle
{
if(SafeGetPlayerMoney(playerid) < 1500) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (1500$)");
DarObjeto(playerid,24,1,7);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-1500);
}

if(id==2) //UZI
{
if(SafeGetPlayerMoney(playerid) < 1500) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (1500$)");
DarObjeto(playerid,28,1,50);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-1500);
}
else if(id==3) //CAR-AK 47
{
if(SafeGetPlayerMoney(playerid) < 250) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (250$)");
DarObjeto(playerid,52,1, 30);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-250);
}

else if (id==4) //CAR-Deagle
{
if(SafeGetPlayerMoney(playerid) < 150) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (150$)");
DarObjeto(playerid,46,1,7);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-150);
}

else if(id==5) //CAR-UZI
{
if(SafeGetPlayerMoney(playerid) < 150) return Mensaje(playerid,Rojo,"¡No tienes dinero para pagarlo! (150$)");
DarObjeto(playerid,50,1,50);
cantidadarmas++;
format(string,128,"¡Te quedan %d armas/cargadores por retirar!", 10-cantidadarmas);
SendClientMessage(playerid,Rojo,string);
SafeGivePlayerMoney(playerid,-150);
}
}
return 1;
}

dcmd_equipamiento(playerid, params[]){
		#pragma unused params
    	if(!FuerzaPublica(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no forma parte de algún establecimiento estatal.");
	    if(!EstaEnUnEquipamiento(playerid)) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está en un depósito de armamento.");
        if(PlayerInfo[playerid][pMember] == 1){
		    new ELAPD[] = "Chaleco kevlar\nPorra policíaca\nDesert Eagle\nTáser\nEscopeta\nCargador Deagle\nCargador Escopeta";
      		ShowPlayerDialog(playerid,EQUIPAMIENTOLAPD,DIALOG_STYLE_LIST,"Equipamiento",ELAPD,"Equipar","Cancelar");
		}
		else if(PlayerInfo[playerid][pMember] == 2){
		    new ELAED[] = "Extintor de fuego\nMotosierra\nChaleco ignífugo";
      		ShowPlayerDialog(playerid,EQUIPAMIENTOLAED,DIALOG_STYLE_LIST,"Equipamiento",ELAED,"Equipar","Cancelar");
		}
		else if(PlayerInfo[playerid][pMember] == 5){
		    new ELASC[] = "Chaleco Kevlar\nPistola nueve milimetros\nCargador de nueve milímetros";
		    ShowPlayerDialog(playerid,EQUIPAMIENTOLASC, DIALOG_STYLE_LIST,"Equipamiento", ELASC,"Equipar","Cancelar");
		}
		return 1;
	}




forward EstaEnUnEquipamiento(playerid); public EstaEnUnEquipamiento(playerid){
    if(IsPlayerConnected(playerid)){
		if(PlayerToPoint(5.0,playerid,216.1525,184.7244,1003.0313)) { return 1; }
		if(PlayerToPoint(5.0, playerid, 363.7235,197.1782,1019.9844)) { return 1; }
		if(PlayerToPoint(5.0, playerid, 463.8518,245.9035,1025.8660)) { return 1; }
		if(PlayerToPoint(5.0, playerid, 1155.8368,-1340.1055,1349.3860)) { return 1; }
	}
	return 0;
}
forward LevantarseParalizado(playerid); public LevantarseParalizado(playerid){
	ClearAnimations(playerid);
 	TogglePlayerControllable(playerid, 1);
    Paralizado[playerid] = 0;
    return 1;
}
	
	
dcmd_tirari(playerid, params[]){
		#pragma unused params
		if(BolsilloID[playerid][12] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene nada en su mano izquierda.");
		new f = MAX_OBJETOS+1;
		for(new a = 0; a < sizeof(CoordsObjeto); a++){
			if(CoordsObjeto[a][0] == 0.0){
				f = a;
				break;
			}
		}
		if(f > MAX_OBJETOS) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Se ha llegado al límite de objetos tirados, no se pueden tirar más para no sobrecargar el servidor.");
		if(EsArma(BolsilloID[playerid][12])){
	 		ResetPlayerWeapons(playerid);
		}
		IDObjeto[f][0] = BolsilloID[playerid][12];
		IDObjeto[f][1] = BolsilloCantidad[playerid][12];
		IDObjeto[f][2] = BolsilloTipo[playerid][12];
		format(string, sizeof(string), "* %s dejó u%s que sostenía con su mano izquierda sobre el suelo.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][12]));
		ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		GetPlayerPos(playerid, CoordsObjeto[f][0], CoordsObjeto[f][1], CoordsObjeto[f][2]);
		if(IDObjetos[BolsilloID[playerid][12]][0]-1 > 0) {
		Objeto[f] = CreateDynamicObject(IDObjetos[BolsilloID[playerid][12]][0]-1, CoordsObjeto[f][0], CoordsObjeto[f][1], CoordsObjeto[f][2]-1, 93.7, 120.0, 120.0); }
		BolsilloID[playerid][12] = 0;
		BolsilloTipo[playerid][12] = 0;
		BolsilloCantidad[playerid][12] = 0;
		new sql[16];
		format(sql, sizeof(sql), "Bol%dID", 12);
		SaveValue(playerid, sql, BolsilloID[playerid][12]);
		format(sql, sizeof(sql), "Bol%dTipo", 12);
		SaveValue(playerid, sql, BolsilloTipo[playerid][12]);
		format(sql, sizeof(sql), "Bol%dCantidad", 12);
		SaveValue(playerid, sql, BolsilloCantidad[playerid][12]);
		ActualizarObjetos(playerid);
		return 1;
	}
dcmd_tirard(playerid, params[]){
		#pragma unused params
		if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no tiene nada en su mano derecha.");
		new f = MAX_OBJETOS+1;
		for(new a = 0; a < sizeof(CoordsObjeto); a++){
			if(CoordsObjeto[a][0] == 0.0){
				f = a;
				break;
			}
		}
		if(f > MAX_OBJETOS) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Se ha llegado al límite de objetos tirados, no se pueden tirar más para no sobrecargar el servidor.");
		if(EsArma(BolsilloID[playerid][11])){
	 		ResetPlayerWeapons(playerid);
		}
		IDObjeto[f][0] = BolsilloID[playerid][11];
		IDObjeto[f][1] = BolsilloCantidad[playerid][11];
		IDObjeto[f][2] = BolsilloTipo[playerid][11];
		format(string, sizeof(string), "* %s dejó u%s que sostenía con su mano derecha sobre el suelo.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][11]));
		ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		GetPlayerPos(playerid, CoordsObjeto[f][0], CoordsObjeto[f][1], CoordsObjeto[f][2]);
		if(IDObjetos[BolsilloID[playerid][11]][0]-1 > 0) {
		Objeto[f] = CreateDynamicObject(IDObjetos[BolsilloID[playerid][11]][0]-1, CoordsObjeto[f][0], CoordsObjeto[f][1], CoordsObjeto[f][2]-1, 93.7, 120.0, 120.0); }
		BolsilloID[playerid][11] = 0;
		BolsilloTipo[playerid][11] = 0;
		BolsilloCantidad[playerid][11] = 0;
		new sql[16];
		format(sql, sizeof(sql), "Bol%dID", 11);
		SaveValue(playerid, sql, BolsilloID[playerid][11]);
		format(sql, sizeof(sql), "Bol%dTipo", 11);
		SaveValue(playerid, sql, BolsilloTipo[playerid][11]);
		format(sql, sizeof(sql), "Bol%dCantidad", 11);
		SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		ActualizarObjetos(playerid);
		return 1;
	}

	dcmd_recoger(playerid, params[]){
	#pragma unused params
		Mensaje(playerid, COLOR_BLANCO, "Utilice el comando '/recogerd' para recoger el objeto con su mano derecha, o '/recogeri' para recoger el objeto con su mano izquierda.");
		return 1;
	}

	dcmd_recogerd(playerid, params[]){
	#pragma unused params
	    if(BolsilloID[playerid][11] != 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener la mano derecha libre para recoger el objeto del suelo.");
		new f = MAX_OBJETOS+1;
		for(new a = 0; a < sizeof(CoordsObjeto); a++){
			if(IsPlayerInRangeOfPoint(playerid, 5.0, CoordsObjeto[a][0], CoordsObjeto[a][1], CoordsObjeto[a][2])){
				f = a;
				break;
			}
		}
		if(f > MAX_OBJETOS) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está cerca de ningún objeto.");
		else{

			CoordsObjeto[f][0] = 0.0;
			CoordsObjeto[f][1] = 0.0;
			CoordsObjeto[f][2] = 0.0;
			DestroyDynamicObject(Objeto[f]);
			DarObjeto(playerid, IDObjeto[f][0], IDObjeto[f][2], IDObjeto[f][1]);
			format(string, sizeof(string), "* %s tomó u%s del suelo usando su mano derecha.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][11]));
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
			Streamer_Update(playerid);
		}
		return 1;
	}

	dcmd_recogeri(playerid, params[]){
	#pragma unused params
	    if(BolsilloID[playerid][12] != 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted debe tener la mano izquierda libre para recoger el objeto del suelo.");
		new f = MAX_OBJETOS+1;
		for(new a = 0; a < sizeof(CoordsObjeto); a++){
			if(IsPlayerInRangeOfPoint(playerid, 5.0, CoordsObjeto[a][0], CoordsObjeto[a][1], CoordsObjeto[a][2])){
				f = a;
				break;
			}
		}
		if(f > MAX_OBJETOS) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no está cerca de ningún objeto.");
		else{
		    
			CoordsObjeto[f][0] = 0.0;
			CoordsObjeto[f][1] = 0.0;
			CoordsObjeto[f][2] = 0.0;
			DestroyDynamicObject(Objeto[f]);
   			BolsilloID[playerid][12] = IDObjeto[f][0];
			BolsilloCantidad[playerid][12] = IDObjeto[f][1];
			BolsilloTipo[playerid][12] = IDObjeto[f][2];
			ActualizarObjetos(playerid);
			format(string, sizeof(string), "* %s tomó u%s del suelo usando su mano izquierda.", pName(playerid), ObtenerNombreObjeto(BolsilloID[playerid][12]));
			ProxDetector(20.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
			Streamer_Update(playerid);
		}
		return 1;
	}
dcmd_mal(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, ROJO_OSCURO, "* Debes estar bajado del vehículo.");
    new opcion[32];
    new result;
	result = vehiculomascercano(playerid);
    if(sscanf(params, "s[32]", opcion))
	{
        SendClientMessage(playerid, GRIS, "Uso: /mal [Opción]");
        SendClientMessage(playerid, GRIS, "Opciones disponibles: abrir, ver, cerrar");
	    return 1;
	}
	if(!strcmp(opcion, "ver", true))
	{
	
		if(CarInfo[result][aMal] == 0) return SendClientMessage(playerid, ROJO_OSCURO, "* El maletero está cerrado.");
        if(strcmp(CarInfo[result][cOwner], "autoescuela", true) == 0) return 0;
		if(IsABike(result)) return 0;
		consultandomal[playerid] = result;
		MostrarMaletero(result, playerid);
		printf("maletero ver id %d",result);
		return 1;
	}
	if(!strcmp(opcion, "abrir", true))
	{
        if(strcmp(CarInfo[result][cOwner], "autoescuela", true) == 0) return 0;
		if(IsABike(result)) return 0;
	    if(CarInfo[result][cLock] == 1) return SendClientMessage(playerid, ROJO_OSCURO, "* El vehículo deberá estar abierto para poder abrirlo.");
	    if(PlayerHaveKeys(playerid, result) == 1 || (PlayerInfo[playerid][pMember] == CarInfo[result][cUsos] && PlayerInfo[playerid][pMember] != 0))
	    {
	    new motor, luces, alarma, puertas, capo, maletero, objetivo;
	    GetVehicleParamsEx(result+1, motor, luces, alarma, puertas, capo, maletero, objetivo);
	    if(CarInfo[result][aMal] == 0)
	    {
	        CarInfo[result][aMal] = 1;
	        SetVehicleParamsEx(result+1, motor, luces, alarma, puertas, capo, CarInfo[result][aMal], objetivo);
			AutoRol(playerid,"abre el maletero del vehiculo.");
			SaveCar(result);
			printf("maletero abrir id %d",result);
			return 1;
	    }
	    }
	    else { Mensaje(playerid, COLOR_ERRORES, "* Usted no tiene las llaves del vehículo"); }
	}
	if(!strcmp(opcion, "cerrar", true))
	{
        if(strcmp(CarInfo[result][cOwner], "autoescuela", true) == 0) return 0;
		if(IsABike(result)) return 0;
	    if(CarInfo[result][cLock] == 1) return SendClientMessage(playerid, ROJO_OSCURO, "* El vehículo deberá estar abierto para poder abrirlo.");
	    if(PlayerHaveKeys(playerid, result) == 1 || (PlayerInfo[playerid][pMember] == CarInfo[result][cUsos] && PlayerInfo[playerid][pMember] != 0))
	    {
	    new motor, luces, alarma, puertas, capo, maletero, objetivo;
	    GetVehicleParamsEx(result+1, motor, luces, alarma, puertas, capo, maletero, objetivo);
	    if(CarInfo[result][aMal] == 1)
	    {
	        CarInfo[result][aMal] = 0;
	        SetVehicleParamsEx(result+1, motor, luces, alarma, puertas, capo, 0, objetivo);
			AutoRol(playerid,"cierra el maletero del vehiculo.");
			SaveCar(result);
			printf("maletero cerrar id %d",result);
			return 1;
	    }
	    }
	    else { Mensaje(playerid, COLOR_ERRORES, "* Usted no tiene las llaves del vehículo"); }
	}
	return 1;
}
	dcmd_editarcolor(playerid, params[]){
	    if(EditandoColor[playerid] == 0) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no se encuentra modificando su vehículo en un taller");
	        if(!sscanf(params, "ii", params[0], params[1])){
	            if(IsPlayerInAnyVehicle(playerid)){
	                if(params[0] < 0 || params[0] > 256) return Mensaje(playerid, ROJO_OSCURO, "* El color debe estar entre 0 y 256.");
	        		if(params[1] < 0 || params[1] > 256) return Mensaje(playerid, ROJO_OSCURO, "* El color debe estar entre 0 y 256.");
					new vehicleid; vehicleid = GetPlayerVehicleID(playerid);
					CarInfo[vehicleid][cColorOne] = params[0];
					CarInfo[vehicleid][cColorTwo] = params[1];
					ChangeVehicleColor(vehicleid, params[0], params[1]);
					SaveCar(vehicleid);
		    		format(string, sizeof(string), "* Cambiaste los colores del vehículo a %d y %d.", params[0], params[1]);
		    		Mensaje(playerid, CELESTE, string);
	    			EditandoColor[playerid] = 0;
					Mensaje(playerid, NARANJA, "Los mecánicos estuvieron trabajando durante un tiempo tu vehículo, cambiando el color de éste.");
					Modificando[playerid] = 0;
				} else return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no se encuentra en ningún vehículo.");
			} else return Mensaje(playerid, COLOR_ERRORES, "[USO] '/editarcolor' [Color 1] [Color 2]");
			return 1;
	}
dcmd_menutaller(playerid, params[]){
#pragma unused params
	    if(EnTaller[playerid] != 1) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted no se encuentra dentro de un taller.");
	    if(Modificando[playerid] == 1) return Mensaje(playerid, COLOR_ERRORES, "[ERROR] Usted se encuentra actualmente modificando el vehículo");
		ShowMenuForPlayer(MenuTaller, playerid);
		Modificando[playerid] = 1;
		return 1;
	}
dcmd_taller(playerid, params[]){
#pragma unused params
        if(EstaAfueraTaller(playerid)){
 			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
    			new idcoche = GetPlayerVehicleID(playerid);
       			new Float:X, Float:Y, Float:Z, Float:Angulo;
       			new passengers[5];

       			GetVehiclePassengers(idcoche, passengers);
		        GetVehiclePos(idcoche, X, Y, Z);
		        GetVehicleZAngle(idcoche, Angulo);
				TallerX[idcoche] = X; TallerY[idcoche] = Y; TallerZ[idcoche] = Z; TallerAngulo[idcoche] = Angulo;
				SetPlayerInterior(playerid, 3);
				LinkVehicleToInterior(idcoche, 3);
				SetVehiclePos(idcoche, 614.198608,-124.396858,997.992187);

				if(passengers[1] != -1) {
				PutPlayerInVehicle(passengers[1], idcoche, 1);
				SetPlayerInterior(passengers[1], 3);
				SetPlayerVirtualWorld(passengers[1], idcoche);
				EnTaller[passengers[1]] = 1;
				TogglePlayerControllable(passengers[1], 0);
				SetPlayerCameraPos(passengers[1],610.7142,-129.6326,999.0937);
                SetPlayerCameraLookAt(passengers[1],2242.000,2415.000,15.000); }

				if(passengers[2] != -1) {
				PutPlayerInVehicle(passengers[2], idcoche, 2);
				SetPlayerInterior(passengers[2], 3);
				SetPlayerVirtualWorld(passengers[2], idcoche);
				EnTaller[passengers[2]] = 1;
				TogglePlayerControllable(passengers[2], 0);
				SetPlayerCameraPos(passengers[2],610.7142,-129.6326,999.0937);
                SetPlayerCameraLookAt(passengers[2],2242.000,2415.000,15.000); }

				if(passengers[3] != -1) {
				PutPlayerInVehicle(passengers[3], idcoche, 3);
				SetPlayerInterior(passengers[3], 3);
				SetPlayerVirtualWorld(passengers[3], idcoche);
				EnTaller[passengers[3]] = 1;
				TogglePlayerControllable(passengers[3], 0);
				SetPlayerCameraPos(passengers[3],610.7142,-129.6326,999.0937);
                SetPlayerCameraLookAt(passengers[3],2242.000,2415.000,15.000); }

				if(passengers[4] != -1) {
				PutPlayerInVehicle(passengers[4], idcoche, 4);
				SetPlayerInterior(passengers[4], 3);
				SetPlayerVirtualWorld(passengers[4], idcoche);
				EnTaller[passengers[4]] = 1;
				TogglePlayerControllable(passengers[4], 0);
				SetPlayerCameraPos(passengers[4],610.7142,-129.6326,999.0937);
                SetPlayerCameraLookAt(passengers[4],2242.000,2415.000,15.000);}

    			SetVehicleZAngle(idcoche, 91.528572);
				SetPlayerVirtualWorld(playerid, idcoche);
				SetVehicleVirtualWorld(idcoche, idcoche);
  				EnTaller[playerid] = 1;
  				SetPlayerCameraPos(playerid,610.7142,-129.6326,999.0937);
                SetPlayerCameraLookAt(playerid,2242.000,2415.000,15.000);
		  		TogglePlayerControllable(playerid, 0);
		  		Mensaje(playerid, CELESTE, "Usted acaba de ingresar al taller, para abrir el menú, utilice el comando '/menutaller'.");
		  		Mensaje(playerid, COLOR_BLANCO, "Para salir del taller, use nuevamente el comando '/taller'.");
      		}
		}
  		else {
  		    if(EnTaller[playerid] == 1){
  		        if(Modificando[playerid] == 0) {
	  		    new idcoche = GetPlayerVehicleID(playerid);
				SetVehiclePos(idcoche, TallerX[idcoche], TallerY[idcoche], TallerZ[idcoche]);
	   			SetVehicleZAngle(idcoche, TallerAngulo[idcoche]);
				SetPlayerVirtualWorld(playerid, 0);
				SetVehicleVirtualWorld(idcoche, 0);
				SetPlayerInterior(playerid, 0);
				LinkVehicleToInterior(idcoche, 0);
				EnTaller[playerid] = 0;
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, 1);
				new passengers[5];
				GetVehiclePassengers(idcoche, passengers);

				if(passengers[1] != -1) {
				PutPlayerInVehicle(passengers[1], idcoche, 1);
				SetPlayerInterior(passengers[1], 0);
				SetPlayerVirtualWorld(passengers[1], 0);
				TogglePlayerControllable(passengers[1], 1);
				SetCameraBehindPlayer(passengers[1]); }

				if(passengers[2] != -1) {
				PutPlayerInVehicle(passengers[2], idcoche, 2);
				SetPlayerInterior(passengers[2], 0);
				SetPlayerVirtualWorld(passengers[2], 0);
				TogglePlayerControllable(passengers[2], 1);
				SetCameraBehindPlayer(passengers[2]); }

				if(passengers[3] != -1) {
				PutPlayerInVehicle(passengers[3], idcoche, 3);
				SetPlayerInterior(passengers[3], 0);
				SetPlayerVirtualWorld(passengers[3], 0);
				TogglePlayerControllable(passengers[3], 1);
				SetCameraBehindPlayer(passengers[3]); }

				if(passengers[4] != -1) {
				PutPlayerInVehicle(passengers[4], idcoche, 4);
				SetPlayerInterior(passengers[4], 0);
				SetPlayerVirtualWorld(passengers[4], 0);
				TogglePlayerControllable(passengers[4], 1);
				SetCameraBehindPlayer(passengers[4]); }

				Mensaje(playerid, CELESTE, "Usted acaba de salir del taller.");
				HideMenuForPlayer(MenuTaller, playerid);
				}
				else return Mensaje(playerid, Rojo, "¡Estás modificando el vehículo aún");
            }
            else return Mensaje(playerid, Rojo, "¡No estás en el taller!");
        }
		return 1;
	}
stock MostrarArmario(casa, playerid){
    new dialog[1024], string[128];
	for(new i = 0; i < 7; i++){
	    if(i == 0){
		    if(CasaInfo[casa][hArmID][0] != 0) format(dialog, sizeof(dialog), "{FFFFFF}1) - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(CasaInfo[casa][hArmID][i]), CasaInfo[casa][hArmCantidad][i]);
		    else format(dialog, sizeof(dialog), "{FFFFFF}1) - Armario vacío.");
		    continue;
		}
		if(i == 5){
			strcat(dialog, "\n|--------------------------------------------------------------|");
			if(BolsilloID[playerid][11] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano derecha - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][11]), BolsilloCantidad[playerid][11]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano derecha - desocupada.");
  			strcat(dialog, string);
  			continue;
		}
		if(i == 6){
			if(BolsilloID[playerid][12] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano izquierda - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][12]), BolsilloCantidad[playerid][12]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano izquierda - desocupada.");
  			strcat(dialog, string);
  			break;
		}
		if(CasaInfo[casa][hArmID][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%d) - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", i+1, ObtenerNombreObjeto(CasaInfo[casa][hArmID][i]), CasaInfo[casa][hArmCantidad][i]);
  		else format(string, sizeof(string), "\n{FFFFFF}%d) - Armario vacío.", i+1);
  		strcat(dialog, string);
	}
	ShowPlayerDialog(playerid, ARMARIO, DIALOG_STYLE_LIST, "{FFFFFF}Armario", dialog, "Seleccionar", "Salir");
}
stock MostrarMaletero(vehicleid, playerid)
{

	
    new dialog[1024];
	for(new i = 0; i < 7; i++)
	{
	    if(i == 0)
		{
		    if(CarInfo[vehicleid][aMalID][0] != 0) format(dialog, sizeof(dialog), "{FFFFFF}1) - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(CarInfo[vehicleid][aMalID][i]), CarInfo[vehicleid][aMalCantidad][i]);
		    else format(dialog, sizeof(dialog), "{FFFFFF}1) - Maletero vacío.");
		    continue;
		}
		if(i == 5)
		{
			strcat(dialog, "\n|--------------------------------------------------------------|");
			if(BolsilloID[playerid][11] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano derecha - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][11]), BolsilloCantidad[playerid][11]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano derecha - desocupada.");
  			strcat(dialog, string);
  			continue;
		}
		if(i == 6)
		{
			if(BolsilloID[playerid][12] != 0) format(string, sizeof(string), "\n{FFFFFF}%Mano izquierda - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", ObtenerNombreObjeto(BolsilloID[playerid][12]), BolsilloCantidad[playerid][12]);
  			else format(string, sizeof(string), "\n{FFFFFF}Mano izquierda - desocupada.");
  			strcat(dialog, string);
  			break;
		}
		if(CarInfo[vehicleid][aMalID][i] != 0) format(string, sizeof(string), "\n{FFFFFF}%d) - {FFFF00}%s {FFFFFF}({00FF00}%d{FFFFFF})", i+1, ObtenerNombreObjeto(CarInfo[vehicleid][aMalID][i]), CarInfo[vehicleid][aMalCantidad][i]);
  		else format(string, sizeof(string), "\n{FFFFFF}%d) - Maletero vacío.", i+1);
  		strcat(dialog, string);
	}
	ShowPlayerDialog(playerid, MALETERO, DIALOG_STYLE_LIST, "{FFFFFF}Maletero", dialog, "Seleccionar", "Salir");
}
stock CamaraAlAzar(playerid, lugar){
	switch(lugar){
		case 0: { PlayCameraMover(playerid, FortCarson); }
		case 1: { PlayCameraMover(playerid, LA1); }
		case 2: { PlayCameraMover(playerid, LA2); }
		case 3: { PlayCameraMover(playerid, LA3); }
		case 4: { PlayCameraMover(playerid, LA4); }
	}
	return 1;
}
forward ActualizarBalas(playerid); public ActualizarBalas(playerid) {
		if(EsArma(BolsilloID[playerid][11])) {
		new sql[16];
		new municion;
		new arma;
		arma = GetPlayerWeapon(playerid);
		if(arma == 0) return 1;
		municion = GetPlayerAmmo(playerid);
		BolsilloCantidad[playerid][11] = municion;
		format(sql, sizeof(sql), "Bol%dCantidad", 11);
		SaveValue(playerid, sql, BolsilloCantidad[playerid][11]);
		}
		return 1;
		}

