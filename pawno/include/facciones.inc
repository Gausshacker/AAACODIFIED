#include <a_samp>
#include <globalvars>
#include <colores>
#include <funciones>

Facciones_OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[128];
	new cmd[128];
	new idx;
	new jugador;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/darequipo", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] == 0 || PlayerInfo[playerid][pAdmin] == 1)
		{
			SendClientMessage(playerid, Rojo, "* No formas parte del staff.");
			return 1;
		}
		
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darequipo [IdJugador/ParteDelNombre] [EquipoID]");
			return 1;
		}
		
		if(!IsNumeric(tmp))
		jugador = ReturnUser(tmp,playerid);
	   	else jugador = strval(tmp);
		
		if(!IsPlayerConnected(jugador))
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar conectado.");
		    return 1;
		}
		
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp) || !IsNumeric(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darequipo [IdJugador/ParteDelNombre] [EquipoID]");
			return 1;
		}
		
		new equipo;
		equipo = strval(tmp);
		
		format(string, sizeof(string), "* Un miembro del staff te ha puesto dentro del equipo número %d", equipo);
		SendClientMessage(jugador, Amarillo, string);
		
		format(string, sizeof(string), "* Has puesto correctamente el equipo %d a %s(%d)", equipo, pName(jugador),jugador);
		SendClientMessage(playerid, Amarillo, string);
		
		printf("ADMINLOG: %s ha puesto %s a el equipo '%d'",pName(playerid),pName(jugador),equipo);
		
		PlayerInfo[jugador][pMember] = equipo;
		PlayerInfo[jugador][pRank] = 1;
		
		SaveValue(jugador, "Faccion", PlayerInfo[jugador][pMember]);
		SaveValue(jugador, "Rango", PlayerInfo[jugador][pRank]);
		
		return 1;
	}
	
	if(strcmp(cmd, "/darrango", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 6 && PlayerInfo[playerid][pEsLider] != 1)
		{
			SendClientMessage(playerid, Rojo, "* No eres miembro del staff o no eres un líder de facción.");
			return 1;
		}

		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darrango [IdJugador/ParteDelNombre] [Rango]");
			return 1;
		}

		if(!IsNumeric(tmp))
		jugador = ReturnUser(tmp,playerid);
		else jugador = strval(tmp);

		if(!IsPlayerConnected(jugador))
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar conectado.");
		    return 1;
		}
		
		if((PlayerInfo[playerid][pMember] != PlayerInfo[jugador][pMember]) && PlayerInfo[playerid][pAdmin] < 2)
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe ser de tu mismo equipo.");
		    return 1;
		}

		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp) || !IsNumeric(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darrango [IdJugador/ParteDelNombre] [Rango]");
			return 1;
		}

		new rango;
		rango = strval(tmp);

		if(rango == 0 || rango > 18) { SendClientMessage(playerid, Rojo, "* ¡Rangos entre 1 y 17!"); return 1; }
		
		format(string, sizeof(string), "* Un miembro del staff o un líder te ha promovido a rango %d", rango);
		SendClientMessage(jugador, Amarillo, string);

		format(string, sizeof(string), "* Has promovido correctamente a rango %d a %s(%d)", rango, pName(jugador) ,jugador);
		SendClientMessage(playerid, Amarillo, string);

		printf("USERLOG: %s ha dado a %s el rango '%d'",pName(playerid),pName(jugador),rango);

		
		PlayerInfo[jugador][pRank] = rango;
		SaveValue(jugador, "Rango", PlayerInfo[jugador][pRank]);

		return 1;
	}
	if(strcmp(cmd, "/darlider", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 6 && PlayerInfo[playerid][pEsLider] != 1)
		{
			SendClientMessage(playerid, Rojo, "* No eres miembro del staff o no eres un líder de facción.");
			return 1;
		}

		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darlider [IdJugador/ParteDelNombre]");
			return 1;
		}

		if(!IsNumeric(tmp))
		jugador = ReturnUser(tmp,playerid);
		else jugador = strval(tmp);

		if(!IsPlayerConnected(jugador))
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar conectado.");
		    return 1;
		}

		

		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp) || !IsNumeric(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /darlider [IdJugador/ParteDelNombre] ");
			return 1;
		}

	

		format(string, sizeof(string), "* Un miembro del staff o un líder te ha promovido a lider de tu facción");
		SendClientMessage(jugador, Amarillo, string);

		format(string, sizeof(string), "* Has promovido correctamente a lider  a %s(%d)",  pName(jugador) ,jugador);
		SendClientMessage(playerid, Amarillo, string);
		PlayerInfo[jugador][pEsLider] = 1;
		SaveValue(jugador, "EsLider", PlayerInfo[jugador][pEsLider]);

		return 1;
	}
	if(strcmp(cmd, "/reclutar", true) == 0)
	{
	
        if(PlayerInfo[playerid][pMember] == 0)
		{
			SendClientMessage(playerid, Rojo, "* No eres de ninguna facción.");
			return 1;
		}
	    if(PlayerInfo[playerid][pEsLider] != 1)
		{
			SendClientMessage(playerid, Rojo, "* No eres un líder de facción.");
			return 1;
		}
	
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /reclutar [IdJugador/ParteDelNombre]");
			return 1;
	    }
	    
		if(!IsNumeric(tmp))
		jugador = ReturnUser(tmp,playerid);
		else jugador = strval(tmp);

		if(!IsPlayerConnected(jugador))
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar conectado.");
		    return 1;
		}
		
		if(PlayerInfo[jugador][pMember] != 0)
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe ser civil.");
		    return 1;
		}
		
		if(PlayerInfo[playerid][pMember] > 0 && PlayerInfo[playerid][pMember] < 11)
		{
			if(PlayerInfo[jugador][pJob] > 0)
			{
				format(string, sizeof(string), "* No puedes reclutar a %s(%d). Tiene que dejar su trabajo para ingresar en una facción publica.", pName(jugador), jugador);
				SendClientMessage(playerid, Naranja, string);
				
				format(string, sizeof(string), "* %s(%d) quiere reclutarte para una facción publica, pero antes deberas dejar tu trabajo actual. (/dejartrabajo)", pName(playerid),playerid);
				SendClientMessage(playerid, Naranja, string);
				return 1;
			}
		}
		
		PlayerInfo[jugador][pMember] = PlayerInfo[playerid][pMember];
		PlayerInfo[jugador][pRank] = 1;
		SaveValue(jugador, "Faccion", PlayerInfo[jugador][pMember]);
		SaveValue(jugador, "Rango", PlayerInfo[jugador][pRank]);
	    
		format(string, sizeof(string), "* Has reclutado correctamente a %s(%d).", pName(jugador), jugador);
		SendClientMessage(playerid, Amarillo, string);
		format(string, sizeof(string), "* Has sido reclutado a la faccion número %d", PlayerInfo[jugador][pMember]);
		SendClientMessage(jugador, Amarillo, string);
		printf("USERLOG: %s ha reclutado a %s a la faccion '%d'",pName(playerid),pName(jugador),PlayerInfo[jugador][pMember]);
	    return 1;
	}
	
	if(strcmp(cmd, "/expulsar", true) == 0)
	{
        if(PlayerInfo[playerid][pMember] == 0)
		{
			SendClientMessage(playerid, Rojo, "* No eres de ninguna facción.");
			return 1;
		}
	    if(PlayerInfo[playerid][pEsLider] != 1)
		{
			SendClientMessage(playerid, Rojo, "* No eres un líder de facción.");
			return 1;
		}

	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /expulsar [IdJugador/ParteDelNombre]");
			return 1;
	    }

		if(!IsNumeric(tmp))
		jugador = ReturnUser(tmp,playerid);
		else jugador = strval(tmp);

		if(!IsPlayerConnected(jugador))
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar conectado.");
		    return 1;
		}

		if(PlayerInfo[jugador][pMember] != PlayerInfo[playerid][pMember])
		{
		    SendClientMessage(playerid, Rojo, "* El jugador debe estar en tu facción.");
		    return 1;
		}
	
		if(PlayerInfo[jugador][pDuty] == 1)
		{
			PlayerInfo[jugador][pDuty] = 0;
			SaveValue(jugador, "EnServicio", PlayerInfo[jugador][pDuty]);
			SetPlayerSkin(jugador, PlayerInfo[jugador][pSkin]);
		}
		PlayerInfo[jugador][pUniforme] = 0;
		SaveValue(jugador, "Uniforme", 0);
		PlayerInfo[jugador][pMember] = 0;
		PlayerInfo[jugador][pRank] = 0;
		SaveValue(jugador, "Faccion", PlayerInfo[jugador][pMember]);
		SaveValue(jugador, "Rango", PlayerInfo[jugador][pRank]);

		format(string, sizeof(string), "* Has expulsado correctamente a %s(%d).", pName(jugador), jugador);
		SendClientMessage(playerid, Amarillo, string);
		format(string, sizeof(string), "* Has sido expulsado de la faccion número %d", PlayerInfo[playerid][pMember]);
		SendClientMessage(jugador, Amarillo, string);
		printf("USERLOG: %s ha expulsado a %s de la faccion '%d'",pName(playerid),pName(jugador),PlayerInfo[playerid][pMember]);
		SetPlayerSkin(jugador, PlayerInfo[jugador][pSkin]);
		
	    return 1;
	}
//Comandos para facciones ilegales OFICIALES. Versión v1
//Comandos en BETA, HEHEHEHE. Cavar<3
//Para la Versión v2 se podría implementar un sistema de tráfico de armas to reshulon.
new Text:Venda[MAX_PLAYERS];
 Venda[playerid] = TextDrawCreate(641.0,11.0,"_");
 TextDrawUseBox(Venda[playerid],1);
 TextDrawBoxColor(Venda[playerid],0x000000ff);
 TextDrawTextSize(Venda[playerid],-60.0,-10.0);
 TextDrawAlignment(Venda[playerid],0);
 TextDrawBackgroundColor(Venda[playerid],0x000000ff);
 TextDrawFont(Venda[playerid],3);
 TextDrawLetterSize(Venda[playerid],1.0,48.0);
 TextDrawColor(Venda[playerid],0xffffffff);
 TextDrawSetOutline(Venda[playerid],1);
 TextDrawSetProportional(Venda[playerid],1);
 TextDrawSetShadow(Venda[playerid],1);
new sendername[64], giveplayer[64];
//----------------------------[ATAR]-----------------------//
if(strcmp(cmd, "/atar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pMember] == 50)
			{
	   			tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /atar [IdJugador/ParteDelNombre]");
					return 1;
				}
				jugador = ReturnUser(tmp);
			    if(IsPlayerConnected(jugador))
				{
				    if(jugador != INVALID_PLAYER_ID)
				    {
					    if(PlayerTied[jugador] > 0)
					    {
					        SendClientMessage(playerid, Rojo, "¡Jugador ya atado!");
					        return 1;
					    }
						if(GetDistanceBetweenPlayers(playerid, jugador) < 5.0)
						{
						    new car = GetPlayerVehicleID(playerid);
						    if(jugador == playerid) { SendClientMessage(playerid, COLOR_GREY, "¡No puedes hacerte eso a tí mismo!"); return 1; }
						    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(jugador, car))
						    {
						       	 	GetPlayerName(jugador, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        		format(string, sizeof(string), "* %s te ha atado y te ha puesto una venda en los ojos.", sendername);
								SendClientMessage(jugador, COLOR_ACCIONES, string);
								format(string, sizeof(string), "* Has atado a %s y le ha puesto una venda en los ojos!", giveplayer);
								SendClientMessage(playerid, COLOR_ACCIONES, string);
								format(string, sizeof(string), "* %s ata a %s y le pone una venda en los ojos, asi no podrá escapar.", sendername ,giveplayer);
								ProxDetector(30.0, playerid, string, COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES);
								GameTextForPlayer(jugador, "~r~Atado", 2500, 3);
								TogglePlayerControllable(jugador, 0);
								PlayerTied[jugador] = 1;
								TextDrawShowForPlayer(jugador,Venda[jugador]);
						    }
						    else
						    {
						        SendClientMessage(playerid, Rojo, "¡Jugador no está en un vehículo, o tú no eres el conductor!");
						        return 1;
						    }
						}
						else
						{
						    SendClientMessage(playerid, Blanco, "¡Jugador no cercano!");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "¡No eres de una facción ilega!");
			}
		}
		return 1;
	}
//------------------------------------------[DESATAR]-------------------------//
	if(strcmp(cmd, "/desatar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pMember] == 50)
			{
			    tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp)) {
				SendClientMessage(playerid, Blanco, "USO: /desatar [IdJugador/ParteDelNombre]");
				return 1;
				}
				jugador = ReturnUser(tmp);
				if(IsPlayerConnected(jugador))
				{
					if(jugador != INVALID_PLAYER_ID)
					{
					    if(GetDistanceBetweenPlayers(playerid, jugador < 5.0))
						{
						    if(jugador == playerid) { SendClientMessage(playerid, COLOR_ERRORES, "¡No puedes hacerte eso a ti mismo!"); return 1; }
							if(PlayerTied[jugador])
							{
							    format(string, sizeof(string), "* Has sido rescatado por %s.", pName(playerid));
								SendClientMessage(jugador, COLOR_ACCIONES, string);
								format(string, sizeof(string), "* Desataste a %s y le quitaste la venda de los ojos.", pName(jugador));
								SendClientMessage(playerid, COLOR_ACCIONES, string);
								GameTextForPlayer(jugador, "~g~Desatado", 2500, 3);
								TogglePlayerControllable(jugador, 1);
								PlayerTied[jugador] = 0;
								TextDrawHideForPlayer(jugador,Venda[jugador]);
							}
							else
							{
							    SendClientMessage(playerid, Rojo, "¡Este jugador no está atado!");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, Rojo, "¡Jugador no cercano!");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "¡No eres de una facción ilegal!");
			}
		}
		return 1;
	}
//------------------------------[MOLOTOVS]----------------------------------------//
	if(strcmp(cmd, "/hacermolotov", true) == 0)
	{
	    if(PlayerInfo[playerid][pRank]<3) { SendClientMessage(playerid, Rojo, "¡Necesitas ser rango dos en una facción!"); return 1; }
	    if(GetPlayerInterior(playerid) > 0)
	    {
	        if(Molotovs[playerid] == 1) { SendClientMessage(playerid, Rojo, "¡Hoy ya has hecho molotovs!"); return 1; }
	        if(BolsilloID[playerid][12] == 76 && PlayerInfo[playerid][pLataFuel] >= 5)
	        {
				if(BolsilloID[playerid][11] == 0) return Mensaje(playerid, COLOR_ERRORES, "¡Debes tener la mano derecha libre para los molotovs!");
				PlayerInfo[playerid][pLataFuel]-=5;
				Molotovs[playerid]++;
				SendClientMessage(playerid, AzulClaro,"¡Has creado una molotov!");
				BolsilloID[playerid][11] = 18;
				BolsilloCantidad[playerid][11] = 1;
				BolsilloTipo[playerid][11] = 1;
				SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
			}
			else
			{
			    SendClientMessage(playerid, Rojo, "¡Te falta un componente!");
			    SendClientMessage(playerid, Blanco,"AYUDA: Los componentes son: Encendedor mano izquierda, botella, gasolina 5lt.");
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, Rojo, "¡Ves a un lugar más discreto!");
		    SendClientMessage(playerid, Blanco,"AYUDA: ¡En el interior de una casa!");
		    return 1;
		}
		return 1;
	}
//-----------------------------------------------------------------------------------------------------------------------------//
	if(strcmp(cmd, "/miembros", true) == 0)
	{
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
			if(PlayerInfo[playerid][pMember] == 0)
			{
				SendClientMessage(playerid, Rojo, "* Debes ser miembro de una faccion.");
				return 1;
			}
			new Faccion[15];
			if(PlayerInfo[playerid][pMember] == 1) Faccion = "LSPD";
			else if(PlayerInfo[playerid][pMember] == 2) Faccion = "LAED";
			else if(PlayerInfo[playerid][pMember] == 3) Faccion = "LSTD";
			else if(PlayerInfo[playerid][pMember] == 4) Faccion = "LSNEWS";
			else if(PlayerInfo[playerid][pMember] == 5) Faccion = "Senado";
			else if(PlayerInfo[playerid][pMember] == 6) Faccion = "Sheriff";
			else if(PlayerInfo[playerid][pMember] == 91) Faccion = "RCA";
			else if(101 > PlayerInfo[playerid][pMember] > 4) format(Faccion,sizeof(Faccion),"%d",PlayerInfo[playerid][pMember]);
						
	        		format(string, sizeof(string), "Miembros Online (%s):",Faccion);
			SendClientMessage(playerid, Verde, string);
			if(PlayerInfo[playerid][pMember] < 3 || PlayerInfo[playerid][pMember] == 6)
			{
				for(new i; i < MAX_PLAYERS; i++)
				{
					if(PlayerInfo[i][pMember] == PlayerInfo[playerid][pMember] && IsPlayerConnected(i))
					{
						format(string, sizeof(string), "%s - Rango: %d - De Servicio:  ", pName(i), PlayerInfo[i][pRank]);
                        if(PlayerInfo[i][pDuty] > 0)
							strcat(string, "Sí");
						else
							strcat(string, "No");
                         if(PlayerInfo[i][pEsLider] > 0)
							strcat(string, "  | Lider: Sí");
						else
							strcat(string, "  | Lider: No");
						SendClientMessage(playerid, Amarillo, string);
					}
				}
			}
			else
			{
				for(new i; i < MAX_PLAYERS; i++)
				{
					if(PlayerInfo[i][pMember] == PlayerInfo[playerid][pMember] && IsPlayerConnected(i))
					{
						format(string, sizeof(string), "%s - Rango: %d", pName(i), PlayerInfo[i][pRank]);
						SendClientMessage(playerid, Amarillo, string);
					}
				}
			}
	    }
	    else
	    {
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				new id;
				id = strval(tmp);
				if(id <= 0)
				{
					SendClientMessage(playerid, Rojo, "* Solo numeros mayores a 0.");
					return 1;
				}
				
				new Faccion[15];
				if(id == 1) Faccion = "LSPD";
				else if(id == 2) Faccion = "LSMD";
				else if(id == 3) Faccion = "LSTD";
				else if(id == 4) Faccion = "LSNEWS";
				else if(id == 5) Faccion = "Senado";
				else if(id == 6) Faccion = "Sheriff";
				else if(id == 9) Faccion = "Bomberos";
				else if(id > 10) format(Faccion,sizeof(Faccion),"%d",id);
						
				format(string, sizeof(string), "Miembros Online (%s):",Faccion);
				SendClientMessage(playerid, Verde, string);
				if(id < 3 || id == 6 || id == 9)
				{
					for(new i; i < MAX_PLAYERS; i++)
					{
						if(PlayerInfo[i][pMember] == id && IsPlayerConnected(i))
						{
							format(string, sizeof(string), "%s - Rango: %d - De Servicio: ", pName(i), PlayerInfo[i][pRank]);
							if(PlayerInfo[i][pDuty] > 0)
								strcat(string, "Sí");
							else
								strcat(string, "No");
							SendClientMessage(playerid, Amarillo, string);
						}
					}
				}
				else
				{
					for(new i; i < MAX_PLAYERS; i++)
					{
						if(PlayerInfo[i][pMember] == id && IsPlayerConnected(i))
						{
							format(string, sizeof(string), "%s - Rango: %d", pName(i), PlayerInfo[i][pRank]);
							SendClientMessage(playerid, Amarillo, string);
						}
					}
				}
			} 
			else { SendClientMessage(playerid, Rojo, "* ¡No formas parte de la administración!"); return 1; }
		}
		return 1;
	}
	return 0;
}
