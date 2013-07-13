/* 
   Old School v2 "The future is here"
*/
#define REVISION (78) // Acorde al día de vida de la fase oficial (Contando desde el 04/01/2011)
//-------------------------------------------------------------->>
//--[FUNCIONES-VARIABLES-DEFINES]--
#include <a_samp> // Funciones basicas del SAMP
#undef MAX_PLAYERS
#define MAX_PLAYERS  (120)
#include <streamer> // Streamer de objetos, pickups, 3dtext...
#include <globalvars> // Todas las variables existentes
#include <funciones> // Funciones globales
#include <colores> // Defines de colores
#include <fader> // Efectos de pantalla
//--[SISTEMAS VARIOS]--
#include <ayuda> // Comandos de ayuda
#include <texto> // Sistema de Chat
#include <coches> // Sistema de Coches
#include <Autoescuela> // La Autoescuela
#include <AdminSystem> // Sistema de Administracion
#include <armas> // Sistema de abastecimiento de armas (Vendedor corrupto de la policia)
#include <radios> // Sistema de audio
//#include <objetos> // Objetos
#include <deathac> // Anticheat
#include <horas> // Horas en punto
#include <velocimetro> // Velocimetro para vehiculos
#include <drogas> // Sistema de Plantaciones y Consumo
#include <guns> // Poner armas en la espalda y otros
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
#include <gangzones> // GangZones para bandas
//--[EVENTOS]--
#include <paintball> // Paintball
#include <cartas> // Cartas
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
#include <medicos> // Faccion - Medicos
#include <gps> // Sistema /marcar, para medicos y policias
#include <taxis> // Taxistas
#include <misiones> // Misiones
//--[OBJETOS-ATTACH]--
#include <puntero> //laser de armas
#include <nieve>
#include <gafas> // gafas de sol.
#include <cascos> // casco de moto
#include <sirenas> // Sirenas
#include <bandana> // Bandanas
//-------------------------------------------------------------->>
main()
{
	print("\n----------------------------------");
	printf(" 	OLD SCHOOL v2.0.%d		   ",REVISION);
	print("-------[The Future is here]-------\n");
}

public OnGameModeInit()
{
	Streamer_TickRate(75);
	MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	Vehicles_OnGameModeInit();
	Negocios_OnGameModeInit();
	Armas_OnGameModeInit();
	LoadAgenda();
	Admin_OnGameModeInit();
	Sis_Cos_OnGameModeInit();
	Sis_Pes_OnGameModeInit();
	CargarParkings();
	Casas_OnGameModeInit();
	Medicos_OnGameModeInit();
	Policia_OnGameModeInit();
	//Objetos_Init();
	Taxis_OnGameModeInit();
	AC_OnInit();
	DetectarHora();
	Autoesc_OnGameModeInit();
	Velocimetro_OnGameModeInit();
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
	puntero_OnGameModeInit();
	Loteria_OnInit();
	Carreras_OnGameModeInit();
	Low_OnGMInit();
    ResetElevatorQueue();
	Elevator_Initialize();
	LoadMuebles();
	LoadGangZones();
	
	printf("Objetos: %d (Streamed)", CountDynamicObjects());
	printf("Text3ds: %d (Streamed)", CountDynamic3DTextLabels());
	printf("Pickups: %d (Streamed)", CountDynamicPickups());
	
	Audio_SetPack("osrp_pack", true);
	
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(1);
	
	new GMTEXT[20];
	#if REVISION > 99
	format(GMTEXT,sizeof(GMTEXT),"OS-RP v2.0.%d",REVISION);
	#else
	format(GMTEXT,sizeof(GMTEXT),"OS-RP v2.0.0%d",REVISION);
	#endif
	SetGameModeText(GMTEXT);
	
	SetTimer("TimerDeUnMinuto",60000,1);
	SetTimer("SintonizarEx",1000,1);
	SetTimer("CheatsDetection", 1000, 1);
	SetTimer("ResetEnActividad",5000,1);
	
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
	
	for(new i; i < MAX_INTERIOR_ENTERS; i++)
	{
		CreateDynamicPickup(InteriorInfo[i][PickupID], 23, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ]);
		CreateDynamic3DTextLabel(InteriorInfo[i][texto], Amarillo, InteriorInfo[i][itX], InteriorInfo[i][itY], InteriorInfo[i][itZ] + 0.5, 30);
	}
	return 1;
}

public OnGameModeExit()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        SavePos(i);
	    }
	}
	Drogas_OnExit();
	Seifader_OnExit();
	return 1;
}

public OnPlayerConnect(playerid)
{
//    if(IsValidNPC(playerid) || IsPlayerNPC(playerid)) return 1;
	Cuentas_OnPlayerConnect(playerid);
    SetCameraPosAtStart(playerid);
	Armas_OnPlayerConnect(playerid);
    Vehicles_OnPlayerConnect(playerid);
	Slide_OnPlayerConnect(playerid);
	Velocimetro_OnPlayerConnect(playerid);
	Texto_OnPlayerConnect(playerid);
	Tlf_OnPlayerConnect(playerid);
	Reporteros_OnPlayerConnect(playerid);
	Anims_OnPlayerConnect(playerid);
	puntero_OnPlayerConnect(playerid);

	
	SetPlayerColor(playerid, 0xFFFFFF00);
	format(string, 128, "Bienvenido a Old-School RP versión 2.0.%d", REVISION);
	SendClientMessage(playerid, Verde, string);
	
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
	Cuentas_OnPlayerRequestClass(playerid);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return Cuentas_OnPlayerRequestSpawn(playerid);
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][pJugando] == 0) {SendClientMessage(playerid,Rojo,"Conectate primero"); return 1;}
	printf("Comando: %s Por: %s", cmdtext, pName(playerid));
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
	if(Cartas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Paintball_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Reporteros_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Puertas_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Anims_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Gafas_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(Cascos_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(Sirena_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(MisBand_OnPlayerCommandText(playerid,cmdtext)) return 1;
	if(puntero_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(nieve_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Lot_OnPlayerCommandText(playerid, cmdtext)) return 1;
    if(Carreras_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Bandana_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Low_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Ascensor_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Muebles_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Velocimetro_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Speedcap_OnPlayerCommandText(playerid, cmdtext)) return 1;
	if(Gangs_OnPlayerCommandText(playerid, cmdtext)) return 1;
	
    new cmd[128];
	new tmp[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/salir", true) == 0)
	{
		Comando_Salir(playerid);
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
				format(string, sizeof(string), "* %s Tira el dado y cae sobre %d", pName(playerid),dice);
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

	if(strcmp(cmd, "/fumar", true) == 0)
	{
		if(PlayerInfo[playerid][pCigarrillos] > 0 && PlayerInfo[playerid][pEncendedor] > 0)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
			ApplyAnimation(playerid,"SMOKING","M_smk_in",4.0,0,1,1,1,1,1);
			format(string, 128, "* %s enciende uno de sus cigarrillos.", pName(playerid));
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			else {
			ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			PlayerInfo[playerid][pCigarrillos] --;
			PlayerInfo[playerid][pEncendedor] --;
			SaveValues(playerid, "Inventario");
		}
		else
		{
			SendClientMessage(playerid, Rojo, "No tienes cigarrillos o el mechero se te ha acabado.");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/llamar", true) == 0)
	{
		if(PlayerInfo[playerid][pPnumber] == 0) return SendClientMessage(playerid,RojoIntenso,"No tienes telefono movil");
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
		    SendClientMessage(playerid, Blanco, "USO: /llamar [número/servicio]");
		    SendClientMessage(playerid, Blanco, "Servicios disponibles: Pizza, Taxi, Mecanico, Anuncios, Emergencias");
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
				SendClientMessage(playerid,Amarillo, "(Teléfono): Transporte público de Los Santos.");
				SendClientMessage(playerid,Amarillo,"(Teléfono): Todos nuestros taxistas están ocupados.");
				Taxistas=0;
			}
			else
			{
				SendClientMessage(playerid,Amarillo,"(Teléfono): Transporte público de Los Santos.");
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
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: Indique el servicio que necesita, ¿Policia o Medico?");
			PlayerInfo[playerid][pUsandoTelefono] = 911;
			return 1;
		}
		else if (strcmp(tmp,"Anuncios", true) == 0)
		{
			if(PlayerInfo[playerid][pBank] < 200) return SendClientMessage(playerid, Rojo, "* No tienes suficiente dinero en el banco para hacer anuncios.");
			if(GetPlayerLevel(playerid) < 3) return SendClientMessage(playerid, Rojo, "* Nivel insuficiente!");
			if(AnuncioTimer == 1){ SendClientMessage(playerid, Gris, "Comunicando..."); return SendClientMessage(playerid, AmarilloClaro, "Parece ser que la agencia de anuncios está ocupada en estos momentos, intentalo de nuevo más tarde!");}
			SendClientMessage(playerid, Amarillo, "Servicio de publicidad de Los Santos");
			SendClientMessage(playerid, AmarilloClaro, "Ingrese un texto que quiera anunciar. Le costara $200");
			PlayerInfo[playerid][pUsandoTelefono] = 575;
			return 1;
		}
		else if (strcmp(tmp,"mecanico",true)==0)
        {
			if(GetPlayerInterior(playerid) > 0) return SendClientMessage(playerid,Naranja,"* No puedes pedir un mecanico estando en un interior");
            SendClientMessage(playerid,Amarillo,"(Teléfono): Talleres de Los Santos.");
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
		else if(strcmp(tmp,"armas",true)==0 && CocheOcupado == 0 && PlayerInfo[playerid][pMember] > 30 && PlayerInfo[playerid][pMember] < 41 && PlayerInfo[playerid][pRank] > 4)
		{
		    CocheOcupado = 1;
		    PlayerInfo[playerid][pHablandoArmas] = 1;
		    SendClientMessage(playerid, Amarillo, "(Teléfono): ¿Qué pipa necesitas ahora?");
		    SendClientMessage(playerid, Amarillo, "(Teléfono): Tengo 9mm ($600), Mac10 ($1200), Escopeta ($800), Navaja ($50), Katana ($5000),");
			SendClientMessage(playerid, Amarillo, "(Teléfono): Molotov ($1000), Eagle ($700), Recortada ($1000), Spas10 ($10000), MP5 ($3000), AK47 y M4");
			SendClientMessage(playerid, Amarillo, "(Teléfono): AK47 ($8000), M4 ($12000), Sniper ($25000)");
		    SendClientMessage(playerid, Gris, "PISTA: Escribe 'Nada' para cancelar la compra.");
            return 1;
		}
        
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
						if(PlayerInfo[i][pMember] == 9 && Programa[playerid]==1 && Programa[playerid]==1)
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
				    SendClientMessage(playerid,Rojo,"Los Teléfonos de Los Santos News están apagados o ya estas llamándolos!");
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
		if(PlayerInfo[playerid][pHablandoArmas] == 1)
		{
		    IncomingCall(playerid, "Nada");
		}
		else
		{
			ColgarTelefono(playerid);
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
				SendClientMessage(playerid, AzulClaro, "Nombres disponibles: Reparar, Rellenar, Pintura, Multa, Trabajo, Seguro, Directo, Taxi, Mecanico, Dinero");
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
			else if(strcmp(x_job, "taxi", true) == 0)
			{
				if(PlayerInfo[playerid][pEstadoTaxista] == 1)
				{
					if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Naranja, "* No estás en el taxi.");
					if(!IsATeamCar(GetPlayerVehicle(playerid), 3)) return SendClientMessage(playerid, Naranja, "* No estás en el taxi.");
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
                PlayerInfo[playerid][pHambre]--;
				SaveValue(playerid,"Hambre",PlayerInfo[playerid][pHambre]);
				ComprobarBarrita(playerid);
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
				PlayerInfo[playerid][pHambre]--;
				SaveValue(playerid,"Hambre",PlayerInfo[playerid][pHambre]);
				ComprobarBarrita(playerid);
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
				PlayerInfo[playerid][pHambre]--;
				SaveValue(playerid,"Hambre",PlayerInfo[playerid][pHambre]);
				ComprobarBarrita(playerid);
				new Float:health;
                GetPlayerHealth(playerid, health);
                GM_SetPlayerHealth(playerid, health + 15);
            }
			else if(strcmp(x_job,"trabajo", true) == 0)
			{
				if(PlayerInfo[playerid][pMember] > 0 && PlayerInfo[playerid][pMember] < 11)
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

	if(strcmp(cmd,"/guardararma", true) == 0)
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
	}

	if(strcmp(cmd,"/tomararma", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(IsACaravana(playerid)) { SendClientMessage(playerid, Rojo, "* La caravana no tiene armario."); return 1;}
			new counter = 0;
			new house = GetPlayerHouse(playerid);
            if((house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0) || IsACop(playerid))
			{
   				if (PlayerToPoint(100.0, playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
				{
                    new tmpslot;
            
                    cmd = strtokex (cmdtext, idx);
                    if (!strlen(cmd))
                    {
                        SendClientMessage(playerid, Blanco, "USO: /tomararma [1-10]");
                        return 1;
                    }

                    tmpslot = strval (cmd);
                    if (tmpslot < 1 || tmpslot > 10)
                    {
                        SendClientMessage(playerid, Rojo, "* Espacio inválido. USO: /tomararma [1-10]");
                        return 1;
                    }
                    
                    if (CasaInfo[house][hGun][tmpslot-1] == NOEXISTE)
                    {
                        SendClientMessage(playerid, Rojo, "* En este espacio no hay nada.");
                        return 1;
                    }

                    new buffer[128];
                    new gunName[100];
                    SafeGivePlayerWeapon(playerid, CasaInfo[house][hGun][tmpslot-1], CasaInfo[house][hAmmo][tmpslot-1]);
                    GetWeaponName(CasaInfo[house][hGun][tmpslot-1], gunName, sizeof(gunName));

                    format(buffer, sizeof(buffer), "* Has cogido una %s (BALAS: %i) del armario.", gunName, CasaInfo[house][hAmmo][tmpslot-1]);
                    SendClientMessage(playerid, Verde, buffer);
                    CasaInfo[house][hGun][tmpslot-1] = NOEXISTE;
                    CasaInfo[house][hAmmo][tmpslot-1] = NOEXISTE;
					SaveCasa(house);
					counter++;
					
					new hour,minute,second,year,month,day;
					gettime(hour,minute,second);
					getdate(year, month, day);
					new query[250];
					format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('Armario %d', '%s', '/tomararma | %s | %d','%d:%d:%d | %d-%d-%d')", CasaInfo[house][hId], pNameEx(playerid), gunName, CasaInfo[house][hAmmo][tmpslot-1],hour,minute,second,day,month,year);
					mysql_query(query);
					return 1;
                }
            }
    
            new result;
            new tmpslot;
            
            cmd = strtokex (cmdtext, idx);
            if (!strlen(cmd))
            {
                SendClientMessage(playerid, Blanco, "USO: /tomararma [1-8]");
                return 1;
            }

            tmpslot = strval (cmd);
            if (tmpslot < 1 || tmpslot > 8)
            {
                SendClientMessage(playerid, Rojo, "* Espacio inválido. USO: /tomararma [1-8]");
                return 1;
            }
            
            tmpslot--;
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
                    SendClientMessage(playerid, Rojo, "* No hay ningún vehículo cerca de ti o no estás en tu casa.");
                }

                case 1:
                {

                    if(Maletero[result]==0)
                    {
                        SendClientMessage(playerid, Rojo, "* El maletero no está abierto!");
                        return 1;
                    }

                    if (CarInfo[result][cSlot][tmpslot] == NOEXISTE)
                    {
                        SendClientMessage(playerid, Rojo, "* En este espacio no hay nada.");
                        return 1;
                    }

                    new buffer[128];
                    new gunName[100];
                    SafeGivePlayerWeapon(playerid, CarInfo[result][cSlot][tmpslot], CarInfo[result][cAmmo][tmpslot]);
                    GetWeaponName(CarInfo[result][cSlot][tmpslot], gunName, sizeof(gunName));

                    format(buffer, sizeof(buffer), "* Has cogido una %s (BALAS: %i) del maletero del vehículo.", gunName, CarInfo[result][cAmmo][tmpslot]);
                    SendClientMessage(playerid, Verde, buffer);
                    CarInfo[result][cSlot][tmpslot] = NOEXISTE;
                    CarInfo[result][cAmmo][tmpslot] = NOEXISTE;
					SaveCar(result);
					
					new hour,minute,second,year,month,day;
					gettime(hour,minute,second);
					getdate(year, month, day);
					new query[1024];
					format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('Maletero %d', '%s', '/tomararma | %s | %d','%d:%d:%d | %d-%d-%d')", CarInfo[result][cCarKey], pNameEx(playerid), gunName, CarInfo[result][cAmmo][tmpslot],hour,minute,second,day,month,year);
					mysql_query(query);
                }

                default:
                {
                    SendClientMessage(playerid, Naranja, "* Más de un coche detectado cerca, por favor acérquese más a su vehículo.");
                }
            }
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
	
	if(strcmp(cmd, "/ceder", true) == 0)
	{
		new giveplayerid;
		cmd = strtokex(cmdtext, idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid, Blanco, "USO: /ceder [Objetos]");
			SendClientMessage(playerid, Blanco, "Objetos disponibles: Coche, Arma, Semillas, DrogaP, DrogaNP, Parafernalia, Cigarrillo, Botella, Mechero,");
			SendClientMessage(playerid, Blanco, "Dado, Cartas, Telefono, Productos.");
			return 1;
		}
		
		if(strcmp(cmd,"Dado", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder dado [JugadorID/Nombre]");
				return 1;
			}
			
			giveplayerid = ReturnUser(tmp);
			if(GetDistanceBetweenPlayers(playerid, giveplayerid) <= 8)
			{
				if(PlayerInfo[playerid][pDado] > 0)
				{
					PlayerInfo[giveplayerid][pDado] ++;
					PlayerInfo[playerid][pDado] --;
					format(string, 128, "* %s le ha pasado un dado a %s.", pName(playerid), pName(giveplayerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					else {
					ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					SaveValues(playerid, "Inventario");
					SaveValues(giveplayerid, "Inventario");
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes dado!");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* Están muy alejados!");
				return 1;
			}
		}
		else if(strcmp(cmd,"Mechero", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder mechero [JugadorID/Nombre]");
				return 1;
			}
			
			giveplayerid = ReturnUser(tmp);
			if(GetDistanceBetweenPlayers(playerid, giveplayerid) <= 8)
			{
				if(PlayerInfo[playerid][pEncendedor] > 0)
				{
					PlayerInfo[giveplayerid][pEncendedor] += PlayerInfo[playerid][pEncendedor];
					PlayerInfo[playerid][pEncendedor] = 0;
					format(string, 128, "* %s le ha pasado un mechero a %s.", pName(playerid), pName(giveplayerid));
					ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
					SaveValues(playerid, "Inventario");
					SaveValues(giveplayerid, "Inventario");
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes mechero!");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* Están muy alejados!");
				return 1;
			}
		}
		else if(strcmp(cmd,"Cartas", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder cartas [JugadorID/Nombre]");
				return 1;
			}
			
			giveplayerid = ReturnUser(tmp);
			if(GetDistanceBetweenPlayers(playerid, giveplayerid) <= 8)
			{
				if(PlayerInfo[playerid][pCartas] > 0)
				{
					PlayerInfo[giveplayerid][pCartas] ++;
					PlayerInfo[playerid][pCartas] --;
					format(string, 128, "* %s le ha pasado una baraja de cartas a %s.", pName(playerid), pName(giveplayerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					else {
					ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					SaveValues(playerid, "Inventario");
					SaveValues(giveplayerid, "Inventario");
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes cartas!");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* Están muy alejados!");
				return 1;
			}
		}
		else if(strcmp(cmd,"arma",true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder arma [Jugador ID / Nombre]");
				return 1;
			}
	        giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
		    {
  				if (GetDistanceBetweenPlayers(playerid, giveplayerid) <= 8)
				{
					new gunname[100];
					new gunID = GetPlayerWeapon(playerid);
					new gunAmmo = GetPlayerAmmo(playerid);
					new plyWeapons[12];
					new plyAmmo[12];
					if(gunID != 0)
					{
						if(!PlayerHaveWeapon(playerid, gunID))
						{
							SafeResetPlayerWeaponsAC(playerid);
							printf("%s (ID:%d) está intentando pasar armas ilegales.",pName(playerid), playerid);
							format(string, 128, "* %s (ID:%d) está intentando pasar armas ilegales.",pName(playerid), playerid);
							ABroadCast(RojoIntenso, string, 1);
							return 1;
						}
						GetWeaponName(gunID, gunname, sizeof(gunname));
						for(new slot = 0; slot != 12; slot++)
						{
							new wep, ammo;
							GetPlayerWeaponData(playerid, slot, wep, ammo);
							if(wep != gunID)
							{
								GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
							}
						}
						EnActividad[playerid] = 1;
						EnActividad[giveplayerid] = 1;
						SafeGivePlayerWeapon(giveplayerid,gunID,gunAmmo);
						format(string, sizeof(string),"Le cedes un arma a %s", pName(giveplayerid));
						SendClientMessage(playerid,Verde, string);
						format(string, sizeof(string),"Has recibido un arma de %s", pName(playerid));
						SendClientMessage(giveplayerid,Verde, string);
						format(string, sizeof(string), "* %s le pasó algo a %s.", pName(playerid), pName(giveplayerid));
						ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
						SafeResetPlayerWeaponsAC(playerid);
						for(new slot = 0; slot != 12; slot++)
						{
							SafeGivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
						}
						new hour,minute,second,year,month,day;
						gettime(hour,minute,second);
						getdate(year, month, day);
						new query[250];
						format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('%s', '%s', '/ceder arma | %s | %d','%d:%d:%d | %d-%d-%d')", pNameEx(playerid), pNameEx(giveplayerid), gunname, gunAmmo,hour,minute,second,day,month,year);
						mysql_query(query);
						return 1;
					}
					else return SendClientMessage(playerid,Naranja,"* No has seleccionado nada para cerder. ");
				}
				else return SendClientMessage(playerid,Naranja,"* No estás cerca de este jugador!");
			} 
			else return SendClientMessage(playerid,Gris,"* Nombre/ID del Jugador invalido.");
		}
		else if(strcmp(cmd, "Semillas", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			
			if(strcmp(tmp, "Marihuana", true) == 0)
			{	
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
					return 1;
				}
				new cantidad;
				cantidad = strval(tmp);
				
				if(PlayerInfo[playerid][pSemillas][0] >= cantidad)
				{
					tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
					{
						SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
						return 1;
					}
					PlayerInfo[giveplayerid][pSemillas][0] += cantidad;
					PlayerInfo[playerid][pSemillas][0] -= cantidad;
					format(string, 128, "* %s le pasó semillas a %s", pName(playerid), pName(giveplayerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					else {
					ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes semillas suficientes.");
					return 1;
				}
			}
			else if(strcmp(tmp, "Coca", true) == 0)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
					return 1;
				}
				new cantidad;
				cantidad = strval(tmp);
				
				if(PlayerInfo[playerid][pSemillas][1] >= cantidad)
				{
					tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
					{
						SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
						return 1;
					}
					PlayerInfo[giveplayerid][pSemillas][1] += cantidad;
					PlayerInfo[playerid][pSemillas][1] -= cantidad;
					format(string, 128, "* %s le pasó semillas a %s", pName(playerid), pName(giveplayerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
					else {
					ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes semillas suficientes.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder Semillas [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			SaveValues(giveplayerid, "Semillas");
			SaveValues(playerid, "Semillas");
		}
		else if(strcmp(cmd, "DrogaNP", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaNP [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			
			new droga;
			if(strcmp(tmp, "Marihuana", true) == 0)
			{	
				droga = 0;
			}
			else if(strcmp(tmp, "Coca", true) == 0)
			{
				droga = 1;
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaNP [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaNP [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			new cantidad;
			cantidad = strval(tmp);
			
			if(PlayerInfo[playerid][pDrogaNP][droga] >= cantidad)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder DrogaNP [Marihuana/Coca] [Cantidad] [PlayerID/Nombre]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				PlayerInfo[giveplayerid][pDrogaNP][droga] += cantidad;
				PlayerInfo[playerid][pDrogaNP][droga] -= cantidad;
				format(string, 128, "* %s le pasó droga sin preparar a %s", pName(playerid), pName(giveplayerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes drogas sin preparar suficientes.");
				return 1;
			}
			
			SaveValues(giveplayerid, "NoPreparada");
			SaveValues(playerid, "NoPreparada");
		}
		else if(strcmp(cmd, "DrogaP", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaP [Marihuana/Cocaina/Crack] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			
			new droga;
			if(strcmp(tmp, "Marihuana", true) == 0)
			{	
				droga = 0;
			}
			else if(strcmp(tmp, "Cocaina", true) == 0)
			{
				droga = 1;
			}
			else if(strcmp(tmp, "Crack", true) == 0)
			{
				droga = 2;
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaP [Marihuana/Cocaina/Crack] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder DrogaP [Marihuana/Cocaina/Crack] [Cantidad] [PlayerID/Nombre]");
				return 1;
			}
			new cantidad;
			cantidad = strval(tmp);
			
			if(PlayerInfo[playerid][pDrogaP][droga] >= cantidad)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder DrogaP [Marihuana/Cocaina/Crack] [Cantidad] [PlayerID/Nombre]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				PlayerInfo[giveplayerid][pDrogaP][droga] += cantidad;
				PlayerInfo[playerid][pDrogaP][droga] -= cantidad;
				format(string, 128, "* %s le pasó droga prepararada a %s", pName(playerid), pName(giveplayerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes drogas preparada suficientes.");
				return 1;
			}
			
			SaveValues(giveplayerid, "Preparada");
			SaveValues(playerid, "Preparada");
		}
		else if(strcmp(cmd, "Parafernalia", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder Parafernalia [Cocaina/Crack] [PlayerID/Nombre]");
				return 1;
			}
			
			new droga;
			if(strcmp(tmp, "Cocaina", true) == 0)
			{
				droga = 0;
			}
			else if(strcmp(tmp, "Crack", true) == 0)
			{
				droga = 1;
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder Parafernalia [Cocaina/Crack] [PlayerID/Nombre]");
				return 1;
			}
			
			new cantidad;
			cantidad = 1;
			
			if(PlayerInfo[playerid][pParafernalia][droga] >= cantidad)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder Parafernalia [Cocaina/Crack] [PlayerID/Nombre]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				PlayerInfo[giveplayerid][pParafernalia][droga] += cantidad;
				PlayerInfo[playerid][pParafernalia][droga] -= cantidad;
				format(string, 128, "* %s le pasó parafernalia a %s", pName(playerid), pName(giveplayerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes drogas preparada suficientes.");
				return 1;
			}
			SaveValues(giveplayerid, "Parafernalia");
			SaveValues(playerid, "Parafernalia");
		}
		else if(strcmp(cmd, "Cigarrillo", true) == 0 || strcmp(cmd, "Botella", true) == 0)
		{
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_WINE)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /ceder [Cigarrillo/Botella] [PlayerID/Nombre]");
					return 1;
				}
				
				giveplayerid = ReturnUser(tmp);
				if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
				{
					SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
					return 1;
				}
				
				SetPlayerSpecialAction(giveplayerid, GetPlayerSpecialAction(playerid));
				SetPlayerSpecialAction(playerid, 0);
				format(string, 128, "* %s le pasó algo a %s", pName(playerid), pName(giveplayerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			return 1;
		}
		else if(strcmp(cmd, "telefono", true) == 0)
		{
			tmp = strtokex(cmdtext,idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,Blanco,"USO: /ceder Telefono [JugadorID/ParteDelNombre]"); 
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID && PlayerInfo[playerid][pPnumber] != 0 && PlayerInfo[giveplayerid][pPnumber] == 0)
			{
				PlayerInfo[giveplayerid][pPnumber] = PlayerInfo[playerid][pPnumber];
				PlayerInfo[playerid][pPnumber] = 0;
				format(string,sizeof(string),"* Has cedido a %s tu número de teléfono",pName(giveplayerid));
				SendClientMessage(playerid,AzulClaro,string);
				format(string,sizeof(string),"* %s te ha cedido su número de teléfono: %d",pName(playerid),PlayerInfo[giveplayerid][pPnumber]);
				SendClientMessage(giveplayerid,AzulClaro,string);
			}
			else return SendClientMessage(playerid,Rojo,"* Introduce una ID válida. O si es válida este usuario ya tiene teléfono");
			return 1;
		}
		else if(strcmp(cmd, "coche", true) == 0)
		{
			tmp = strtokex(cmdtext,idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder coche [1/2/3/4/5] [IdJugador/ParteDelNombre]");
				SendClientMessage(playerid, AzulClaro, "Solo llaves de coches prestadas.");
				return 1;
			}
			
			new tmpllave = strval(tmp);
			if ((tmpllave < 1) && (tmpllave > 5))
			{
				SendClientMessage(playerid, Rojo, "* Llaves entre 1 y 5. USO: /ceder coche [1/2/3/4/5] [IdJugador/ParteDelNombre]");
				return 1;
			}
			
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder coche [1/2/3/4/5] [IdJugador/ParteDelNombre]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
			{
				SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
				return 1;
			}
			if(giveplayerid == playerid)
			{
				SendClientMessage(playerid, Rojo, "* No puedes hacer eso a ti mismo!");
				return 1;
		    }
			new LLaveAPrestar = PlayerInfo[playerid][pPCarKey][tmpllave-1];
			
			if(LLaveAPrestar == NOEXISTE) return SendClientMessage(playerid, Rojo, "* No tienes ninguna llave en ese slot!");
			
			if(PlayerInfo[giveplayerid][pPCochePrestado][0] == LLaveAPrestar) return SendClientMessage(playerid, Rojo, "* El jugador ya tiene una copia de las llaves!");
			if(PlayerInfo[giveplayerid][pPCochePrestado][1] == LLaveAPrestar) return SendClientMessage(playerid, Rojo, "* El jugador ya tiene una copia de las llaves!");
			if(PlayerInfo[giveplayerid][pPCochePrestado][2] == LLaveAPrestar) return SendClientMessage(playerid, Rojo, "* El jugador ya tiene una copia de las llaves!");
			if(PlayerInfo[giveplayerid][pPCochePrestado][3] == LLaveAPrestar) return SendClientMessage(playerid, Rojo, "* El jugador ya tiene una copia de las llaves!");
			if(PlayerInfo[giveplayerid][pPCochePrestado][4] == LLaveAPrestar) return SendClientMessage(playerid, Rojo, "* El jugador ya tiene una copia de las llaves!");
			
			if(PlayerInfo[giveplayerid][pPCochePrestado][0] == NOEXISTE) PlayerInfo[giveplayerid][pPCochePrestado][0] = LLaveAPrestar;
			else if(PlayerInfo[giveplayerid][pPCochePrestado][1] == NOEXISTE) PlayerInfo[giveplayerid][pPCochePrestado][1] = LLaveAPrestar;
			else if(PlayerInfo[giveplayerid][pPCochePrestado][2] == NOEXISTE) PlayerInfo[giveplayerid][pPCochePrestado][2] = LLaveAPrestar;
			else if(PlayerInfo[giveplayerid][pPCochePrestado][3] == NOEXISTE) PlayerInfo[giveplayerid][pPCochePrestado][3] = LLaveAPrestar;
			else if(PlayerInfo[giveplayerid][pPCochePrestado][4] == NOEXISTE) PlayerInfo[giveplayerid][pPCochePrestado][4] = LLaveAPrestar;
			else return SendClientMessage(playerid, Naranja, "* Ese jugador ya tiene todos los slots de llaves prestadas ocupados!");

			format(string, 128, "* %s te ha dado una copia de las llaves de su coche. (mira /stats)", pName(playerid));
			SendClientMessage(giveplayerid, Amarillo, string);
			format(string, 128, "* Le has dado unas llaves de tu coche a %s. Usa /quitarllave cuando quieras retirarsela.", pName(giveplayerid));
			SendClientMessage(playerid, Amarillo, string);
			format(string, 128, "* %s le pasó unas llaves de su coche a %s", pName(playerid), pName(giveplayerid));
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			else {
			ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}

			SaveValues(giveplayerid, "CochesPrestados");
			return 1;
		}	
		else if(strcmp(cmd, "productos", true) == 0)
		{
			tmp = strtokex(cmdtext,idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder productos [Cantidad] [IdJugador/ParteDelNombre]");
				return 1;
			}
			new Cantidad = strval(tmp);
			if (Cantidad < 1)
			{
				SendClientMessage(playerid, Rojo, "* Minimo un producto!");
				return 1;
			}
			tmp = strtokex(cmdtext,idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /ceder productos [Cantidad] [IdJugador/ParteDelNombre]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
			{
				SendClientMessage(playerid, Rojo, "* Deben estar más cerca.");
				return 1;
			}
			if(giveplayerid == playerid)
			{
				SendClientMessage(playerid, Rojo, "* No puedes hacer eso a ti mismo!");
				return 1;
		    }	
			if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[playerid][pProductos] >= Cantidad)
				{
					PlayerInfo[playerid][pProductos] -= Cantidad;
					PlayerInfo[giveplayerid][pProductos] += Cantidad;
					format(string,sizeof(string),"* %s te ha cedido %d productos.",pName(playerid),Cantidad);
					SendClientMessage(giveplayerid,AzulClaro,string);
					format(string,sizeof(string),"* Has cedido %d productos a %s.",Cantidad,pName(giveplayerid));
					SendClientMessage(playerid,AzulClaro,string);
                    SaveValue(playerid, "Productos", PlayerInfo[playerid][pProductos]);
                    SaveValue(giveplayerid, "Productos", PlayerInfo[giveplayerid][pProductos]);
				}
				else SendClientMessage(playerid, Naranja, "* No tienes suficientes productos!");
			}
			else SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
			return 1;
		}			
		else
		{
			SendClientMessage(playerid, Blanco, "USO: /ceder [Coche|Arma|Semillas|DrogaP|DrogaNP|Parafernalia|Cigarrillo|Botella|Productos]");
			return 1;
		}
		return 1;
	}
	
	if(strcmp(cmd, "/tirar", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /tirar [Armas|Chaleco|Llaves|Llave|DrogaP|DrogaNP|Semillas|Parafernalia|Cigarrillo|Botella]");
			return 1;
		}
		
		if(strcmp(tmp, "llaves", true) == 0)
		{
			for(new i = 0; i < MAX_PRESTADOS; i++)
			{
				PlayerInfo[playerid][pPCochePrestado][i] = NOEXISTE;
			}	
			format(string, sizeof(string), "* %s ha tirado todas sus llaves al suelo.",pName(playerid));
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			else {
			ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			SaveValues(playerid, "Coches");
			SaveValues(playerid, "CochesPrestados");
			return 1;
		}
		else if(strcmp(tmp, "armas", true) == 0)
		{
			EnActividad[playerid] = 1;
			SafeResetPlayerWeaponsAC(playerid);
			format(string, sizeof(string), "* %s ha tirado todas sus armas al suelo.", pName(playerid));
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			else {
			ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			return 1;
		}
		else if(strcmp(tmp, "chaleco", true) == 0)
		{
			new Float:armour;
			GetPlayerArmour(playerid,armour);
			if(armour > 0.0)
			{
				SetPlayerArmour(playerid,0.0);
				format(string, sizeof(string), "* %s se quita el chaleco.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else SendClientMessage(playerid,Rojo,"* No tienes chaleco!");
			return 1;
		}
		else if(strcmp(tmp, "llave", true) == 0)
		{
			cmd = strtokex(cmdtext, idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar llave [1/2/3/4/5]");
				SendClientMessage(playerid, Blanco, "Solo llaves de coches prestadas.");
				return 1;
			}
			
			new tmpllave = strval(cmd);
			if ((tmpllave < 1) && (tmpllave > 5))
			{
				SendClientMessage(playerid, Rojo, "* Llaves entre 1 y 5. USO: /tirar llave [1/2/3/4/5]");
				return 1;
			}
		
			PlayerInfo[playerid][pPCochePrestado][tmpllave-1] = NOEXISTE;
	
			SendClientMessage(playerid, Rojo, "* Te has deshecho de la llave");
			SaveValues(playerid, "Coches");
			SaveValues(playerid, "CochesPrestados");
			return 1;
		}
		else if(strcmp(tmp, "Botella", true) == 0 || strcmp(tmp, "Cigarrillo", true) == 0)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
		else if(strcmp(tmp, "drogap", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar DrogaP [Marihuana/Cocaina/Crack]");
				return 1;
			}
			
			if(strcmp(tmp, "Marihuana", true) == 0)
			{
				PlayerInfo[playerid][pDrogaP][0] = 0;
				format(string, 128, "* %s tira toda su marihuana al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else if(strcmp(tmp, "Cocaina", true) == 0)
			{
				PlayerInfo[playerid][pDrogaP][1] = 0;
				format(string, 128, "* %s tira toda la cocaina al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else if(strcmp(tmp, "Crack", true) == 0)
			{
				PlayerInfo[playerid][pDrogaP][2] = 0;
				format(string, 128, "* %s tira todo el crack al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar DrogaP [Marihuana/Coca/Crack]");
				return 1;
			}
			SaveValues(playerid, "Preparada");
		}
		else if(strcmp(tmp, "droganp", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar DrogaNP [Marihuana/Coca]");
				return 1;
			}
			
			if(strcmp(tmp, "Marihuana", true) == 0)
			{
				PlayerInfo[playerid][pDrogaNP][0] = 0;
				format(string, 128, "* %s tira toda su marihuana al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else if(strcmp(tmp, "Coca", true) == 0)
			{
				PlayerInfo[playerid][pDrogaNP][1] = 0;
				format(string, 128, "* %s tira toda la coca al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar DrogaP [Marihuana/Coca]");
				return 1;
			}
			SaveValues(playerid, "NoPreparada");
		}
		else if(strcmp(tmp, "semillas", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar Semillas [Marihuana/Coca]");
				return 1;
			}
			
			if(strcmp(tmp, "Marihuana", true) == 0)
			{
				PlayerInfo[playerid][pSemillas][0] = 0;
				format(string, 128, "* %s tira todas las semillas de marihuana al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else if(strcmp(tmp, "Coca", true) == 0)
			{
				PlayerInfo[playerid][pSemillas][1] = 0;
				format(string, 128, "* %s tira todas las semillas de coca al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar Semillas [Marihuana/Coca]");
				return 1;
			}
			SaveValues(playerid, "Semillas");
		}
		else if(strcmp(tmp, "Parafernalia", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar Parafernalia [Cocaina/Crack]");
				return 1;
			}
			
			if(strcmp(tmp, "cocaina", true) == 0)
			{
				PlayerInfo[playerid][pParafernalia][0] = 0;
				format(string, 128, "* %s tira la parafernalia para cocaina al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else if(strcmp(tmp, "crack", true) == 0)
			{
				PlayerInfo[playerid][pParafernalia][1] = 0;
				format(string, 128, "* %s tira la parafernalia para crack al suelo.", pName(playerid));
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
			}
			else
			{
				SendClientMessage(playerid, Blanco, "USO: /tirar Parafernalia [Cocaina/Crack]");
				return 1;
			}
			SaveValues(playerid, "Parafernalia");
		}
		else
		{
			SendClientMessage(playerid, Blanco, "USO: /tirar [Armas|Chaleco|Llaves|Llave|DrogaP|DrogaNP|Semillas|Parafernalia|Cigarrillo|Botella]");
			return 1;
		}
	}
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

	if(PlayerInfo[playerid][pHablandoArmas] == 1)
	{
		IncomingCall(playerid, text);
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
		else
		{
			SendClientMessage(playerid, Rosa, "EMERGENCIAS: No le entiendo, ¿Policia o Medico?");
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
		SetTimerEx("ResetearTimerAnuncios",300000,0,"");
		return 0;
	}
	
   	if ( Casas_OnPlayerText(playerid,text) ) return 0;
        
	if ( Tlf_OnPlayerText(playerid, text) ) return 0;
	
	if ( Comidas_OnPlayerText(playerid, text) ) return 0;
	
	if ( Reporteros_OnPlayerText(playerid, text) ) return 0;
    
	if ( Park_OnPlayerText(playerid, text) ) return 0;

	AFK_OnPlayerText(playerid);
	Texto_OnPlayerText(playerid, text);

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
	AntiDesertEagleDriveBy(playerid, newstate);
	
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(Vehicles_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Admin_OnPlayerKeyStateChange(playerid, newkeys)) return 1;
	else if(Uniform_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Drogas_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Guns_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Puertas_OnPlayerKeyStateChange(playerid, newkeys)) return 1;
	else if(Anims_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Sirena_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
    else if(Carreras_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Low_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	else if(Ascensor_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) return 1;
	if((newkeys & KEY_SECONDARY_ATTACK))
	{
		if(Comando_Entrar(playerid) == 0) return Comando_Salir(playerid);
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	Vehicle_OnPlayerExitVehicle(playerid, vehicleid);
	Autoesc_OnPlayerExitVehicle(playerid, vehicleid);
    Pizza_OnPlayerExitVehicle(playerid,vehicleid);
	PlayerInfo[playerid][pFixDeathCar] = 1;
	SetTimerEx("FixDeathCar", 5000, 0, "i", playerid);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	Vehicles_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    Pizza_OnPlayerEnterVehicle(playerid,vehicleid, ispassenger);
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(Basura_OnPlayerEnterCheckpoint(playerid)) return 1;
	if(Sis_Cos_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Sis_Pes_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(LimpiaC_OnPlayerEnterCheckpoint(playerid)) return 1; 
	if(Armas_OnPlayerEnterCheckpoint(playerid)) return 1; 
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
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    Carreras_OnPlayerEnterRaceCheck(playerid);
    return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)
{
	
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{

	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	Vehicles_OnVehicleDeath(vehicleid, killerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	EnActividad[playerid] = 1;
	ResetearVariablesArmas(playerid);
	Admin_OnPlayerDeath(playerid);
	Radio_OnPlayerDeath(playerid);
	Anims_OnPlayerDeath(playerid);
	Paintball_OnPlayerDeath(playerid);
	MisBand_OnPlayerDeath(playerid);
	Medicos_OnPlayerDeath(playerid, killerid, reason);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	SaveValues(playerid, "Armas");
	SaveValues(playerid, "Ammo");
	RefreshPos(playerid);
	Speedcap_OnPlayerUpdate(playerid);
	Accesorios_OnPlayerUpdate(playerid);
	Taxis_OnPlayerUpdate(playerid);
	Tunning_OnPlayerUpdate(playerid);
	Autoesc_OnPlayerUpdate(playerid);
	laser_OnPlayerUpdate(playerid);
	Admin_OnPlayerUpdate(playerid);
	Radio_OnPlayerUpdate(playerid);
	Gangs_OnPlayerUpdate(playerid);
	
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if(Health > 100 && PlayerInfo[playerid][pAdminDuty] == 0)
	{
		SetPlayerHealth(playerid, 100);
	}

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	AFK_OnPlayerDisconnect(playerid);
	ResetearVariablesArmas(playerid);
	MisBand_OnPlayerDisconnect(playerid);
	puntero_OnPlayerDisconnect(playerid);
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
	SavePos(playerid);
	Vehicles_OnPlayerDisconnect(playerid, reason);
	Admin_OnPlayerDisconnect(playerid);
	Slide_OnPlayerDisconnect(playerid, reason);
	Radio_OnPlayerDisconnect(playerid);
	Medicos_PlayerDisconnect(playerid);
	Autoesc_OnPlayerDisconnect(playerid, reason);
	Velocimetro_OnPlayerDisconnect(playerid);
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
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	Ascensor_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Cuentas_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Radio_OnDialogResponse(playerid, dialogid, response, listitem);
	Autoesc_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Tunning_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	ATMS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Sirena_OnDialogResponse(playerid, dialogid, response, listitem);
	Lot_OnDialogResponse(playerid, dialogid, response, inputtext);
	Muebles_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	Gangs_OnDialogResponse(playerid, dialogid, response, listitem);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	EnActividad[playerid] = 0;
	AFK_OnPlayerSpawn(playerid);
	Cuentas_OnPlayerSpawn(playerid);
	GM_SetPlayerHealth(playerid, 100);
	DisablePlayerCheckpoint(playerid);
	PlayerInfo[playerid][pCheckpoint] = 0;
    Sis_Pes_OnPlayerSpawn(playerid);
	Paintball_OnPlayerSpawn(playerid);
	Reporteros_OnPlayerSpawn(playerid);
	Anims_OnPlayerSpawn(playerid);
	nieve_OnPlayerSpawn(playerid);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetTimerEx("MirarConexion", 5000, 0, "d", playerid);
	Medicos_OnPlayerSpawn(playerid);
	ShowGangZonesToPlayer(playerid);
	
	if(PlayerInfo[playerid][pTut] == 0)
	{
		TogglePlayerControllable(playerid,0);
		PlayerInfo[playerid][pTut] = 1;
		SaveValue(playerid,"Tutorial",PlayerInfo[playerid][pTut]);
		ClearChatbox(playerid,25);
		GameTextForPlayer(playerid, "Bienvenido a Los Santos", 6000, 1);
		SetPlayerCameraPos(playerid, 1900, -1611, 150);
		SetPlayerCameraLookAt(playerid, 1899, -1610, 150);
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
				return 1;
			}
			else
			{
				GameTextForPlayer(playerid, "~r~Cerrado", 5000, 1);
			}
            break;
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
			ShowMenuForPlayer(ATM, playerid);
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
				if(nevando == 1){SetPlayerAttachedObject( playerid, INDEX_NIEVE, 18863, 1, 36.512592, 3.075343, 6.010456, 359.854156, 351.700927, 7.929049, 1.000000, 1.000000, 1.000000 );}
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
	if(!Audio_IsClientConnected(playerid))
	{
		ShowPlayerDialog(playerid, 1011, DIALOG_STYLE_MSGBOX, ">> Fallo de conexión del plugin de audio!", "\n No se ha podido realizar la conexión con el servidor de audio.\n Si aún no dispones de él te recomendamos visitar www.oldschool.es/audio\n para disfrutar de sus funciones. Si lo tienes pero no has podido conectar,\n solicita soporte en el foro.\n", "Aceptar", "Salir");
	}
	return 1;
}

public Audio_OnClientConnect(playerid)
{
    // Transfer the audio pack when the player connects
    Audio_TransferPack(playerid);
}

public Audio_OnSetPack(audiopack[])
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Transfer the audio pack to all players when it is set
        Audio_TransferPack(i);
    }
    return 1;
}

forward TimerDeUnMinuto();
public TimerDeUnMinuto()
{
	Plantacion();
	ConsumirGasolina();
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
					PlayerInfo[tmpplayer][pJailTime]--;
					SaveValues(tmpplayer,"Encarcelado");
				}
				else if(PlayerInfo[tmpplayer][pJailTime] == 0)
				{
					UnjailPlayerIC(tmpplayer);
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

public OnPlayerSelectedMenuRow(playerid, row)
{
	Cmds_OnPlayerSelectedMenuRow(playerid, row);
	Docu_OnPlayerSelectedMenuRow(playerid, row);
	ATMS_OnPlayerSelectedMenuRow(playerid, row);
	Neg_OnPlayerSelectedMenuRow(playerid, row);
	Comidas_OnPlayerSelectedMenuRow(playerid, row);
	new Menu:menuid = GetPlayerMenu(playerid);
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
