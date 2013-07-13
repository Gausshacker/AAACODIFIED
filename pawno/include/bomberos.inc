#include <a_samp>
#include <globalvars>
#include <funciones>
#include <cuentas>
#define MAX_INFORMESCOCHES 50
enum icInfo
{
	iPaciente,
	iEstado,
	Float:iX,
	Float:iY,
	Float:iZ,
	
	iTimer,
	iBombero,
}

new InformesCoches[MAX_INFORMESCOCHES][icInfo];
new string4[256];
Bomberos_OnGameModeInit()
{
	//CreateDynamic3DTextLabel("Azotea", Amarillo, -368.6265,140.1281,1035.6298, 5);
	for(new i; i < MAX_INFORMESCOCHES; i++)
	{
		InformesCoches[i][iPaciente] = -1;
		InformesCoches[i][iBombero] = -1;
	}
}

Bomberos_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128];
	new tmp[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/informesbomberos", true) == 0)
	{
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
		if(!IsABombero(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Bombero!"); return 1; }
		SendClientMessage(playerid, Amarillo, "Informes disponibles:");
		for(new i = 0; i < MAX_INFORMESCOCHES; i++)
		{
			if(InformesCoches[i][iEstado] > 0)
			{
				if(InformesCoches[i][iEstado] == 1)
				{
					format(string, 128, "%d. En espera...", i);
					SendClientMessage(playerid, Rojo, string);
				}
				else if(InformesCoches[i][iEstado] == 2)
				{
					format(string, 128, "%d. En Camino...", i);
					SendClientMessage(playerid, Verde, string);
				}
			}
		}
		SendClientMessage(playerid, Blanco, "USO: /informebombero [ID]");
		return 1;
	}
	
	if(strcmp(cmd, "/informebombero", true) == 0)
	{
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
		if(!IsABombero(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Bombero"); return 1; }
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp) || !IsNumeric(tmp)) { SendClientMessage(playerid, Blanco, "USO: /informebombero [ID]"); return 1; }
		new id = strval(tmp);
		if(InformesCoches[id][iEstado] != 1) { SendClientMessage(playerid, Rojo, "* Informe inválido. Usa /informes para mayor información."); return 1; }
		SendClientMessage(playerid, Naranja, "[INFORMES]: Te hemos marcado la posición de la emergencia en el GPS.");
		SetPlayerCheckpoint(playerid, InformesCoches[id][iX], InformesCoches[id][iY], InformesCoches[id][iZ], 8.0);
		PlayerInfo[playerid][pCheckpoint] = 16;
		InformesCoches[id][iEstado] = 2;
		InformesCoches[id][iBombero] = playerid;
		return 1;
	}
	if(strcmp(cmd, "/cascofd", true) == 0)
	{
	if(!IsABombero(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Bombero"); return 1; }
	SetPlayerAttachedObject(playerid,0,19330,2,0.158999,-0.051000,0.001999,2.899992,-6.700007,-5.399991,1.000000,1.000000,1.000000);//You can change this however you want, use sa-mp wiki for more info, right now is HockeyMask2
	EditAttachedObject(playerid, 0);
	return 1;
	}
	if(strcmp(cmd, "/quitarcascofd", true) == 0)
	{
	if(!IsABombero(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Bombero"); return 1; }
	RemovePlayerAttachedObject(playerid, 0);
	EditAttachedObject(playerid, 0);
	return 1;
	}
    if(strcmp(cmd, "/gorropd", true) == 0)
	{
	if(!IsACop(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Policia"); return 1; }
	SetPlayerAttachedObject(playerid,0,18636,2,0.158999,-0.051000,0.001999,2.899992,-6.700007,-5.399991,1.000000,1.000000,1.000000);//You can change this however you want, use sa-mp wiki for more info, right now is HockeyMask2
	EditAttachedObject(playerid, 0);
	return 1;
	}
	if(strcmp(cmd, "/quitargorropd", true) == 0)
	{
	if(!IsACop(playerid)) { SendClientMessage(playerid, Rojo, "* No eres Policia"); return 1; }
	RemovePlayerAttachedObject(playerid, 0);
	//EditAttachedObject(playerid, 0);
	return 1;
	}
	if(strcmp(cmd, "/subirambomberos", true) == 0)
	{
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
	    if(!IsABombero(playerid))
	    {
	        SendClientMessage(playerid, Rojo, "* Debes ser médico!");
	        return 1;
	    }
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid, Rojo, "* Debes estar en una Ambulancia!");
	        return 1;
	    }
	    if((CarInfo[GetPlayerVehicle(playerid)][cUsos]!=PlayerInfo[playerid][pMember]) || GetVehicleModel(GetPlayerVehicleID(playerid)) != 416)
	    {
	        SendClientMessage(playerid, Rojo, "Debes estar en una Ambulancia!");
	        return 1;
	    }
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /subiram [IdJugador/ParteDelNombre]");
	        return 1;
	    }
		new id;
		if(!IsNumeric(tmp))
		id = ReturnUser(tmp,playerid);
		else id = strval(tmp);
	    if(GetDistanceBetweenPlayers(playerid, id) >= 10)
	    {
	        SendClientMessage(playerid, Rojo, "* Debes estar más cerca!");
	        return 1;
	    }

		new vid = GetPlayerVehicleID(playerid);
		PutPlayerInVehicle(id, vid, 3);
		format(string,sizeof(string), "* %s ha subido al herido %s a la ambulancia.",pName(playerid),pName(id));
		ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);
		TogglePlayerControllable(id, 0);
		return 1;
	}
	
	if(strcmp(cmd, "/bajarambomberos", true) == 0)
	{
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
	    if(IsABombero(playerid))
	    {
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp) || !IsNumeric(tmp))
			{
			    SendClientMessage(playerid, Blanco, "USO: /bajaram [IdJugador/ParteDelNombre]");
			    return 1;
			}
			new id;
			if(!IsNumeric(tmp))
			id = ReturnUser(tmp,playerid);
			else id = strval(tmp);
			if(GetDistanceBetweenPlayers(playerid, id) > 10)
			{
			    SendClientMessage(playerid, Rojo, "* Debes estar más cerca!");
			    return 1;
			}
			if(IsPlayerInAnyVehicle(id))
			{
			    TogglePlayerControllable(id, 1);
				new Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
				SetPlayerPos(id, X,Y,Z+1.5);
				TogglePlayerControllable(id, 1);
				format(string,sizeof(string), "* %s baja la camilla de la ambulancia y la empuja hacia emergencias.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				format(string, sizeof(string), "* %s te ha bajado de la ambulancia. (( Sigue al Bombero ))", pName(playerid));
				SendClientMessage(id, Azul, string);
				
			}
			else
			{
			    SendClientMessage(playerid, Rojo, "* Esa persona no está en la ambulancia!");
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, Rojo, "* No eres Bombero!");
		    return 1;
		}
		return 1;
	}

	if(strcmp(cmd, "/curarbomberos", true) == 0)
	{
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
	    if(!IsABombero(playerid))
	    {
	        SendClientMessage(playerid, Rojo, "* Debes ser bombero");
	        return 1;
	    }
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /curar [IdJugador/ParteDelNombre]");
	        return 1;
	    }
		new id;
		if(!IsNumeric(tmp))
		id = ReturnUser(tmp,playerid);
		else id = strval(tmp);
	    if(GetDistanceBetweenPlayers(playerid, id) >= 10)
	    {
	        SendClientMessage(playerid, Rojo, "* Debes estar más cerca de la persona que deseas curar!");
	        return 1;
	    }
		new Float:health;
		GetPlayerHealth(id,health);
		if(health != 100.0)
		{
			format(string,sizeof(string), "¡Enhorabuena! El Bombero %s ha logrado curar las heridas de %s.",pName(playerid),pName(id));
			if(GetPlayerInterior(playerid) > 0){
			ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			else {
			ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			GM_SetPlayerHealth(id, 100.0);
		}
		else
		{
			SendClientMessage(playerid, Rojo, "* Esa persona no está herida.");
		}
		return 1;
	}
	
	/*if(strcmp(cmd, "/rehabilitar", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /rehabilitar [PlayerID]");
			return 1;
		}
		
		new player;
		player = ReturnUser(tmp);
		
		if(PlayerInfo[player][pAbstinencia] > 0)
		{
			PlayerInfo[player][pAbstinencia] = 0;
			SaveValue(player, "Abstinencia", PlayerInfo[player][pAbstinencia]);
			format(string, 128, "* El paramédico %s curó tu sindrome de abstienencia producido por consumo excesivo de crack.", pName(playerid));
			SendClientMessage(player, Amarillo, string);
			format(string, 128, "* Curaste de abstinencia a %s.", pName(player));
			SendClientMessage(playerid, Amarillo, string);
		}
		return 1;
	}*/
	
	if(strcmp(cmd, "/reanimarbomberos", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
			if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estas en servicio!"); return 1; }
			if(!IsABombero(playerid))
			{
				SendClientMessage(playerid, Rojo, "* Debes ser Bombero!");
				return 1;
			}
		}
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /reanimarbomberos [IdJugador/ParteDelNombre]");
	        return 1;
	    }
		new id;
		id = ReturnUser(tmp);

	    if(GetDistanceBetweenPlayers(playerid, id) >= 10)
	    {
	        SendClientMessage(playerid, Rojo, "* Debes estar más cerca de la persona que deseas reanimar!");
	        return 1;
	    }
		
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
			if(id == playerid)
			{
				SendClientMessage(playerid, Rojo, "* No te puedes reanimar a ti mismo!");
				return 1;
			}
		}
		
		if(JugadorChoque[id] == 1)
		{
			format(string,sizeof(string), "¡Enhorabuena! El Bombero %s ha logrado reanimar al herido %s.",pName(playerid),pName(id));
			if(GetPlayerInterior(playerid) > 0){
			ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			else {
			ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			GM_SetPlayerHealth(id, 20.0);
			TogglePlayerControllable(id, 1);
			JugadorChoque[id] = 0;
			//PlayerInfo[id][pHerido] = 0;
			//SaveValue(id, "Herido", 0);
			
			for(new i; i < MAX_INFORMESCOCHES; i++)
			{
				if(InformesCoches[i][iPaciente] == id)
				{
					InformesCoches[i][iEstado] = 0;
					//KillTimer(InformesCoches[i][iTimer]);
					DisablePlayerCheckpoint(InformesCoches[i][iBombero]);
					break;
				}
			}
			
		}
		else
		{
			SendClientMessage(playerid, Rojo, "* Esa persona no está herida.");
		}
		return 1;
	}
	
	return 0;
}

/*Bomberos_OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused killerid
	#pragma unused reason
	if(juega_paintball[playerid] == 0 || PlayerInfo[playerid][pJailed] == 1 || PlayerInfo[playerid][pFixDeathCar] == 1)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pTmpSpawnx], PlayerInfo[playerid][pTmpSpawny], PlayerInfo[playerid][pTmpSpawnz]);
		PlayerInfo[playerid][pTmpInt] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pTmpVw] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][1] = 1;
		SaveValue(playerid, "Herido", PlayerInfo[playerid][pHerido]);
		SetTimerEx("DetectarClassSelection",5000,0,"i",playerid);
	}
	return 1;
}*/

/*forward DetectarClassSelection(playerid);
public DetectarClassSelection(playerid)
{
    if (GetPlayerState(playerid) == PLAYER_STATE_WASTED )
    {
        //SendClientMessage(playerid,Rojo,"Seleccion de clase");
		SetPlayerPos(playerid, PlayerInfo[playerid][pTmpSpawnx], PlayerInfo[playerid][pTmpSpawny], PlayerInfo[playerid][pTmpSpawnz]);
        SpawnPlayer(playerid);
    }
    return 1;
}*/
/*Bomberos_OnPlayerSpawn(playerid)
{
	if(PlayerInfo[playerid][pHerido] == 1)
	{
		if(PlayerInfo[playerid][pDuty] == 0)
		{
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		}
		else
		{
			SetPlayerSkin(playerid, PlayerInfo[playerid][pUniforme]);
		}
		SetPlayerPosEx(playerid, PlayerInfo[playerid][pTmpSpawnx], PlayerInfo[playerid][pTmpSpawny], PlayerInfo[playerid][pTmpSpawnz]);
		SetPlayerInterior(playerid, PlayerInfo[playerid][pTmpInt]);
		SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pTmpVw]);
		TogglePlayerControllable(playerid, 0);
		Bombero(playerid);
		SetTimerEx("Animacion", 2000, 0, "d", playerid);
	}
	return 1;
}*/

Bomber_OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerInfo[playerid][pCheckpoint] == 16)
	{
		SendClientMessage(playerid, Verde, "* Has llegado a tiempo al lugar de la emergencia.");
		for(new i; i < MAX_INFORMESCOCHES; i++)
		{
			if(InformesCoches[i][iBombero] == playerid)
			{
				//KillTimer(InformesCoches[i][iTimer]);
				InformesCoches[i][iEstado] = 0;
				InformesCoches[i][iPaciente] = -1;
				InformesCoches[i][iBombero] = -1;
				
				break;
			}
		}
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	return 0;
}

/*Bombero(playerid)
{
	for(new i; i < MAX_INFORMESCOCHES; i++)
	{
		if(InformesCoches[i][iEstado] == 0)
		{
			new Float:PosJugadorX,Float:PosJugadorY,Float:PosJugadorZ,zone[128];
			GetPlayerPos(playerid,PosJugadorX,PosJugadorY,PosJugadorZ);
			InformesCoches[i][iPaciente] = playerid;
			InformesCoches[i][iX] = PosJugadorX;
			InformesCoches[i][iY] = PosJugadorY;
			InformesCoches[i][iZ] = PosJugadorZ;
			InformesCoches[i][iEstado] = 1;
			//InformesCoches[i][iTimer] = SetTimerEx("PlayerDeath_Bomberos", 180000, 0, "i", playerid);
			GetPlayer2DZone(i, zone, 128);
			format(string, 128, "[INFORMES]: Se ha producido un choque automovilístico. Para atenderlo: /informebombero %d [%s]", i, pName(InformesCoches[i][iPaciente]));
			format(string4, 256, "[EMERGENCIA]: Se ha producido un choque automovilístico. En la zona de %s ", zone);
			TogglePlayerControllable(InformesCoches[i][iPaciente],0);
            new engine, lights, alarm, doors, bonnet, boot, objective;
            new arrayid = GetPlayerVehicle(i);
	        CarInfo[arrayid][cBroken] = 1;
			CarInfo[arrayid][cStarted] = 0;
			GetVehicleParamsEx(CarInfo[arrayid][cId], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(CarInfo[arrayid][cId], 0, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleHealth(CarInfo[arrayid][cId], 380);
			SaveCar(arrayid);
			//	SendClientMessage(i, Naranja, "* El vehículo ha dejado de funcionar, llama a un mecánico para poder repararlo.");
			new panels, tires;
  	        new carid = GetPlayerVehicleID(playerid);
		    GetVehicleDamageStatus(carid, panels, doors, lights, tires);
		    tires = encode_tires(1, 1, 1, 1);
		    panels = encode_panels(1,1,1,1,1,1,1);
		    UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);

			break;
		}
	}
	SendFamilyMessage(9, Rojo, string);
	SendFamilyMessage(2, Celeste, string4);
	if(PremiumValido(playerid, 2))
	{
		SendClientMessage(playerid, Amarillo, "* Los bomberos están en camino. ((Si no llegan en 3 minutos serás teleportado))");
	}
	else
	{
        SendClientMessage(playerid, Amarillo, "* Has tenido un choque automovilistico, debes rolear, los bomberos llegarán a rescatarte.");
        SendClientMessage(playerid, Amarillo, "* ADVERTENCIA: Si abandonas el vehículo sin rolear serás sancionado.");
		SendClientMessage(playerid, Amarillo, "* Los bomberos están en camino.");
		JugadorChoque[playerid] = 1;
	}
	return 1;
}*/
Bomberos_OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][pHerido]==1 && IsPlayerInAnyVehicle(playerid))
	{
    PutPlayerInVehicle(playerid, vehicleid, 0);
    SendClientMessage(playerid,Amarillo,"No puedes abandonar el coche estando herido");
	}
	return 1;
}
forward PlayerDeath_Bomberos(playerid);
public PlayerDeath_Bomberos(playerid)
{
	PlayerInfo[playerid][pHerido] = 0;
	SaveValue(playerid, "Herido", 0);
	TogglePlayerControllable(playerid, 1);
	for(new i; i < MAX_INFORMESCOCHES; i++)
	{
		if(InformesCoches[i][iPaciente] == playerid && InformesCoches[i][iEstado] == 1)
		{
			InformesCoches[i][iEstado] = 0;
			break;
		}
		else if(InformesCoches[i][iPaciente] == playerid && InformesCoches[i][iEstado] == 2)
		{
			DisablePlayerCheckpoint(InformesCoches[i][iBombero]);
			SendClientMessage(InformesCoches[i][iBombero], Rojo, "* Te has demorado mucho. Misión abortada.");
			InformesCoches[i][iEstado] = 0;
			InformesCoches[i][iBombero] = NOEXISTE;
			break;
		}
	}
	new bomberos;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsABombero(i))
		{
			bomberos=1;
			break;
		}
	}
	if(PlayerInfo[playerid][pJailed] == 1)
	{
		SendClientMessage(playerid, Naranja, "* Has quedado inconsciente. No recuerdas nada... Un patrulla te trajo de vuelta a prisión.");
		SetPlayerPos(playerid, 2583.8286,-1325.6830,1047.9634);
		SetPlayerInterior(playerid, 2);
		SetPlayerVirtualWorld(playerid, 0);		
	}
	else if(bomberos == 1 && GetPlayerInterior(playerid) == 0)
	{
		if(PremiumValido(playerid, 3))
		{
			SendClientMessage(playerid, Naranja, "* Has quedado inconsciente y te han llevado al hospital.");
		}
		else if(PremiumValido(playerid, 2))
		{

			SendClientMessage(playerid, Naranja, "* Has quedado inconsciente y te han llevado al hospital.");
		}
		else
		{
			
			SendClientMessage(playerid, Naranja, "* Has quedado inconsciente y te han llevado al hospital. ");
		}
		SetPlayerPos(playerid, 1184.0231,-1323.8063,13.3217);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else
	{
		SendClientMessage(playerid, Naranja, "* Has quedado inconsciente y una ambulancia te trajo hasta el hospital. No recuerdas nada.");
		SetPlayerPos(playerid, 1184.0231,-1323.8063,13.3217);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	return 1;
}

Bomberos_PlayerDisconnect(playerid)
{	
	for(new i; i < MAX_INFORMESCOCHES; i++)
	{
		if(InformesCoches[i][iPaciente] == playerid && InformesCoches[i][iEstado] == 1)
		{
			//KillTimer(InformesCoches[i][iTimer]);
			InformesCoches[i][iEstado] = 0;
			break;
		}
		else if(InformesCoches[i][iPaciente] == playerid && InformesCoches[i][iEstado] == 2)
		{
			//KillTimer(InformesCoches[i][iTimer]);
			DisablePlayerCheckpoint(InformesCoches[i][iBombero]);
			SendClientMessage(InformesCoches[i][iBombero], Naranja, "(( El jugador se desconectó. Misión abortada. ))");
			InformesCoches[i][iEstado] = 0;
			InformesCoches[i][iBombero] = NOEXISTE;
			break;
		}
	}
	return 1;
}


