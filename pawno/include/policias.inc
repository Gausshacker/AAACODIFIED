#include <a_samp>
#include <globalvars>
#include <funciones>
#include <objetospolicias>
Policia_OnGameModeInit()
{
	CreateDynamic3DTextLabel("Azotea", Amarillo, 277.8429,125.2676,1008.8203, 5);
	CreateDynamic3DTextLabel("Garaje", Amarillo, 214.4302,118.3369,999.5156, 5);
	CreateDynamicPickup(1314, 23, 2580.0894,-1325.8868,1047.9634);
}

Policia_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128];
	new tmp[128];
   	new idx;
   	cmd = strtokex(cmdtext, idx);
	new giveplayerid;
	new moneys;

	if(strcmp(cmd, "/quitar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(IsACop(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	        {
	            new x_nr[128];
				x_nr = strtokex(cmdtext, idx);
				if(!strlen(x_nr))
				{
					SendClientMessage(playerid, Blanco, "USO: /quitar [objeto] [IdJugador/ParteDelNombre]");
			  		SendClientMessage(playerid, AzulClaro, "Nombres disponibles: Conduccion, Aviacion, Navegacion, Drogas, Semillas, Objetos (no materiales)");
					return 1;
				}
			    if(strcmp(x_nr,"conduccion",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar conduccion [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
						        format(string, sizeof(string), "* Has retirado a %s su Licencia de Conducci�n.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El agente %s te ha retirado la licencia de conducir, no podr�s sacarla en 3 d�as.", pName(playerid));
						        SendClientMessage(giveplayerid, Azul, string);
								PlayerInfo[giveplayerid][pCarLic] = 0;
								SaveValues(giveplayerid,"Licencias");
							}
							else
							{
							    SendClientMessage(playerid, Rojo, "* Jugador no cercano!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Gris, "* Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"aviacion",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar aviacion [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
						        format(string, sizeof(string), "* Has retirado a %s su Licencia de Aviacion.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El Agente %s te ha retirado la Licencia de Aviacion.", pName(playerid));
						        SendClientMessage(giveplayerid, Azul, string);
						        PlayerInfo[giveplayerid][pFlyLic] = 0;
								SaveValues(giveplayerid,"Licencias");
							}
							else
							{
							    SendClientMessage(playerid, Rojo, "* El jugador no est� cerca tuya!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"navegacion",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar navegacion [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
						        format(string, sizeof(string), "* Has retirado a %s su Licencia de Navegacion.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El agente %s te ha retirado la Licencia de Navegacion.", pName(playerid));
						        SendClientMessage(giveplayerid, Azul, string);
						        PlayerInfo[giveplayerid][pBoatLic] = 0;
								SaveValues(giveplayerid,"Licencias");
					        }
					        else
							{
							    SendClientMessage(playerid, Rojo, "* El jugador no est� cerca tuya!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"drogas",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar drogas [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
							    format(string, sizeof(string), "* Has retirado a %s sus Drogas.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El agente %s te ha retirado las Drogas.", pName(playerid));
						        SendClientMessage(giveplayerid, Azul, string);
						        PlayerInfo[giveplayerid][pDrogaP][0]=0;
						        PlayerInfo[giveplayerid][pDrogaP][1]=0;
						        PlayerInfo[giveplayerid][pDrogaP][2]=0;
						        PlayerInfo[giveplayerid][pDrogaNP][0]=0;
						        PlayerInfo[giveplayerid][pDrogaNP][1]=0;
								SaveValues(giveplayerid,"Preparada");
								SaveValues(giveplayerid,"NoPreparada");
							}
					        else
							{
							    SendClientMessage(playerid, Rojo, "* El jugador no est� cerca tuya!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"semillas",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar semillas [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
							    format(string, sizeof(string), "* Has retirado a %s sus semillas.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El agente %s te ha retirado las semillas.", pName(playerid));
        						SendClientMessage(giveplayerid, Azul, string);
						        PlayerInfo[giveplayerid][pSemillas][0]=0;
						        PlayerInfo[giveplayerid][pSemillas][1]=0;
								SaveValues(giveplayerid,"Semillas");
							}
					        else
							{
							    SendClientMessage(playerid, Rojo, "* El jugador no est� cerca tuya!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
					    return 1;
					}
				}
                else if(strcmp(x_nr,"objetos",true) == 0)
				{
				    tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, Blanco, "USO: /quitar objetos [IdJugador/ParteDelNombre]");
						return 1;
					}
					if(!IsNumeric(tmp))
					giveplayerid = ReturnUser(tmp,playerid);
					else giveplayerid = strval(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 5.0)
							{
							    format(string, sizeof(string), "* Has retirado a %s el material robado.", pName(giveplayerid));
						        SendClientMessage(playerid, Azul, string);
						        format(string, sizeof(string), "* El agente %s te ha retirado el material robado.", pName(playerid));
        						SendClientMessage(giveplayerid, Azul, string);
						        if (PlayerInfo[giveplayerid][pJob] == 11) {PlayerInfo[giveplayerid][pMaterialTrabajo]=0;}
								SaveValues(giveplayerid,"Inventario");
							}
					        else
							{
							    SendClientMessage(playerid, Rojo, "* El jugador no est� cerca tuya!");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "* Jugador no conectado!");
					    return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* Nombre desconocido!");
					return 1;
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, Rojo, "* No eres Polic�a!");
	            return 1;
	        }
	    }
	    return 1;
	}

	if(strcmp(cmd, "/sacarobjetos", true) ==0)
	{
		if(IsACop(playerid))
         {
         RemoveItems(playerid);

		}


	  return 1;
	  }

	if(strcmp(cmd, "/escudomanos", true) ==0)
	{
		if(IsACop(playerid))
         {
         PutRiotShieldOnArm(playerid);

		}


	  return 1;
	  }
	  if(strcmp(cmd, "/escudoatras", true) ==0)
	{
		if(IsACop(playerid))
         {
         PutRiotShieldOnBack(playerid);

		}


	  return 1;
	  }
	  if(strcmp(cmd, "/linterna", true) ==0)
	{
		if(IsACop(playerid))
         {
         GiveFlashLight(playerid);

		}


	  return 1;
	  }


	if(strcmp(cmd, "/detener", true) ==0)
	{
		if(IsACop(playerid))
		{
			tmp = strtokex(cmdtext, idx);
	        if (!strlen(tmp))
	        {
	        	SendClientMessage(playerid, Amarillo, "USO: /detener [ID Jugador] [Asiento]");
	        	return 1;
	        }
	        new suspect = strval(tmp);

	        tmp = strtokex(cmdtext, idx);
	        if (!strlen(tmp))
	        {
	        	SendClientMessage(playerid, Amarillo, "USO: /detener [ID Jugador] [Asiento]");
	        	return 1;
	        }
	        new seat = strval(tmp);
	        new car = GetPlayerVehicleID(playerid);
			if(IsPlayerConnected(suspect))
			{
				if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
					    if(PlayerInfo[suspect][pEsposado] > 0)
						{
						    if(seat == 2 || seat == 3)
						    {
								format(string, sizeof(string), "* Has sido detenido por %s .", pName(playerid));
								SendClientMessage(suspect, AzulClaro, string);
								format(string, sizeof(string), "* Has detenido a %s .", pName(suspect));
								SendClientMessage(playerid, AzulClaro, string);
								format(string, sizeof(string), "* %s detiene a %s.", pName(playerid), pName(suspect));
								ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
								GameTextForPlayer(suspect, "~r~Detenido", 2500, 3);
								TogglePlayerControllable(suspect, 0);
								PutPlayerInVehicle(suspect,car,seat);
							}
							else
							{
							    SendClientMessage(playerid, Gris, "* Solo puedes eligir los asientos traseros. (2 o 3)");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, Gris, "* Debe estar esposarlo para poder detenerlo !");
						    return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, Gris, "* Debes estar en el veh�culo para detenerlo !");
						return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, Gris, "* Est�s muy lejos del veh�culo o sospechoso!");
					return 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, Gris, "  No formas parte de las Fuerzas del Estado !");
		}
		return 1;
	}
	if(strcmp(cmd,"/solicitarabogado",true)==0)
	{
	if(IsPlayerConnected(playerid))
	{
	if(IsACop(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	{
	for(new i; i < MAX_PLAYERS; i++)
	{
	if(PlayerInfo[i][pJob] == 12 && IsPlayerConnected(i))
	{
	format(string, sizeof(string), "%s - N�mero: %d - Abogado ", pName(i), PlayerInfo[i][pPnumber]);
	SendClientMessage(playerid,Gris,string);
	}
	}
	}
	}
	return 1;
	}
	/*if(strcmp(cmd,"/cachear",true)==0)
	{
       	if(IsPlayerConnected(playerid))
    	{
        	if(IsACop(playerid))
	       	{
	       		tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /cachear [Armas/Pertenencias] [IdJugador/ParteDelNombre]");
					return 1;
				}
				new Float:Pos[3];
	            GetPlayerPos(giveplayerid, Pos[0], Pos[1], Pos[2]);
	            if(PlayerToPoint(5.0, playerid, Pos[0], Pos[1], Pos[2]))
	            {
	            MostrarBolsillos(playerid, giveplayerid);
	            format(string, sizeof(string), "* %s comenz� a cachear a %s en busca de objetos ilegales.", pName(playerid), pName(giveplayerid));
	            ProxDetector(20.0, playerid, string, ROSA, ROSA, ROSA, ROSA, ROSA);
		  return 1;
	}
      		}
      	}
      	return 1;
    }*/

	if(strcmp(cmd, "/arrestar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(IsACop(playerid))
			{
				if(PlayerInfo[playerid][pDuty] == 0)
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en servicio!");
				    return 1;
				}

		        /*if(!PlayerToPoint(6.0, playerid,2580.0894,-1325.8868,1047.9634) && !PlayerToPoint(6.0, playerid,198.0276,178.9221,1003.0234))
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en las c�rceles de la LSPD!");
				    return 1;
				}*/
				if(!EstaEnCarceles(playerid))
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en las c�rceles de LSPD!");
				    return 1;
				}
				new jailtype;
				if(PlayerToPoint(6.0, playerid,198.0853,158.8262,1003.0234)) jailtype = 1;
				else if(PlayerToPoint(6.0, playerid,197.9805,178.2182,1003.0234)) jailtype = 3;
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /arrestar [Minutos] [IdJugador/ParteDelNombre]");
					// Hacer sistema de 0 = calabozo, 1 = prisi�n.
					return 1;
				}
				new time = strval(tmp);
				if(time < 1 || time > 120) { SendClientMessage(playerid, Rojo, "* El tiempo debe ser entre 60 y 120!"); return 1; }

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /arrestar [Minutos] [IdJugador/ParteDelNombre]");
					// Hacer sistema de 0 = calabozo, 1 = prisi�n.
					return 1;
				}
				new suspect;
				if(!IsNumeric(tmp))
				suspect = ReturnUser(tmp,suspect);
				else suspect = strval(tmp);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
						format(string, sizeof(string), "* Arrestaste a %s!", pName(suspect));
						SendClientMessage(playerid, Azul, string);

						GameTextForPlayer(suspect, "~r~Arrestado", 5000, 5);
						SafeResetPlayerWeaponsAC(suspect);

						format(string, sizeof(string), "<< El agente %s ha arrestado a %s. >>", pName(playerid),pName(suspect));
						SendFamilyMessage(PlayerInfo[playerid][pMember], Naranja, string);

						if(jailtype == 1) SetPlayerPosEx(suspect,198.1577,161.6520,1003.0300/*2583.8286,-1325.6830,1047.9634*/);
						else SetPlayerPosEx(suspect,198.6588,174.9467,1003.0325/*198.7396,175.0663,1003.0234*/);
						PlayerInfo[suspect][pJailTime] = time;
						PlayerInfo[suspect][pJailed] = jailtype;
						SaveValues(suspect,"Encarcelado"),
						SetPlayerSkin(suspect,8);
						PlayerInfo[suspect][pSkin] = 8;
						SaveValue(suspect,"Ropa",PlayerInfo[suspect][pSkin]);
						format(string, sizeof(string), "* Te han arrestado por %d minutos. Usa /reloj para ver cuanto queda.", time);
						SendClientMessage(suspect, Azul, string);
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "* No est� cerca el sospechoso.");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, Naranja, "* Arrestar a alguien sin una placa oficial es contra la ley.");
			    return 1;
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/arrestarp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(IsACop(playerid)) // PARA MARSHAL TAMBI�N.
			{
				if(PlayerInfo[playerid][pDuty] == 0)
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en servicio!");
				    return 1;
				}

				if(!EstaEnPrision(playerid))
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en la Prisi�n Federal!");
				    return 1;
				}
				new jailtype;
				if(PlayerToPoint(6.0, playerid,2579.9175,-1325.8849,1047.9603)) jailtype = 5;
				//else if(PlayerToPoint(6.0, playerid,197.9805,178.2182,1003.0234)) jailtype = 3;
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /arrestarp [Horas (3-99)] [IdJugador/ParteDelNombre]");
					SendClientMessage(playerid, Blanco, "* 99 horas es cadena perpetua (avisar a un admin para CK).");
					return 1;
				}
				new time = strval(tmp);
				if(time < 3 || time > 99) { SendClientMessage(playerid, Rojo, "* El tiempo debe ser entre 3 y 99!"); return 1; }

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /arrestarp [Horas (3-99)] [IdJugador/ParteDelNombre]");
					return 1;
				}
				new suspect;
				if(!IsNumeric(tmp))
				suspect = ReturnUser(tmp,suspect);
				else suspect = strval(tmp);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
						format(string, sizeof(string), "* Arrestaste a %s!", pName(suspect));
						SendClientMessage(playerid, Azul, string);

						GameTextForPlayer(suspect, "~r~Arrestado", 5000, 5);
						SafeResetPlayerWeaponsAC(suspect);

						format(string, sizeof(string), "<< El agente %s ha arrestado en la federal a %s por %d a�os. >>", pName(playerid),pName(suspect), time);
						SendFamilyMessage(PlayerInfo[playerid][pMember], Naranja, string);

						if(jailtype == 5) SetPlayerPosEx(suspect,2583.8286,-1325.6830,1047.9634);
						//else SetPlayerPosEx(suspect,198.6588,174.9467,1003.0325);
						PlayerInfo[suspect][pJailTime] = time;
						PlayerInfo[suspect][pJailed] = jailtype;
						SaveValues(suspect,"Encarcelado"),
						SetPlayerSkin(suspect,8);
						PlayerInfo[suspect][pSkin] = 8;
						SaveValue(suspect,"Ropa",PlayerInfo[suspect][pSkin]);
						format(string, sizeof(string), "* Te han arrestado por %d horas. Usa /reloj para ver cuanto queda.", time);
						SendClientMessage(suspect, Azul, string);
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "* No est� cerca el sospechoso.");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, Naranja, "* Arrestar a alguien sin una placa oficial es contra la ley.");
			    return 1;
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/acondena", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(IsACop(playerid)) // PARA MARSHAL TAMBI�N.
			{
				if(PlayerInfo[playerid][pDuty] == 0)
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en servicio!");
				    return 1;
				}

				if(!EstaEnPrision(playerid))
				{
				    SendClientMessage(playerid, Rojo, "* No est�s en la Prisi�n Federal!");
				    return 1;
				}
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /acondena [Horas (1-20)] [IdJugador/ParteDelNombre]");
					return 1;
				}
				new time = strval(tmp);
				if(time < 1 || time > 20) { SendClientMessage(playerid, Rojo, "* El tiempo debe ser entre 3 y 99!"); return 1; }

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /acondena [Horas (1-20)] [IdJugador/ParteDelNombre]");
					return 1;
				}
				new suspect;
				if(!IsNumeric(tmp))
				suspect = ReturnUser(tmp,suspect);
				else suspect = strval(tmp);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
					if(PlayerInfo[suspect][pJailed] != 5)
					{
                    SendClientMessage(playerid, Rojo, "* Ese jugador no esta cumpliendo una condena.");
					return 1;
				    }
						format(string, sizeof(string), "* Has aumentado la condena de %s.", pName(suspect));
						SendClientMessage(playerid, Azul, string);
						SendClientMessage(suspect, Azul, "* Tu condena fue aumentada.");
						format(string, sizeof(string), "<< El agente %s ha aumentado la condena de %s a %d a�os. >>", pName(playerid),pName(suspect), time);
						SendFamilyMessage(PlayerInfo[playerid][pMember], Azul, string);
						PlayerInfo[suspect][pJailTime] += time;
					}
				}
				else
				{
				    SendClientMessage(playerid, Rojo, "* No est� cerca el sospechoso.");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, Naranja, "* Arrestar a alguien sin una placa oficial es contra la ley.");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/multa", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(IsACop(playerid) == 1)
			{
				if(PlayerInfo[playerid][pDuty] == 0)
				{
					SendClientMessage(playerid, Rojo, "* No est�s en Servicio!");
					return 1;
				}

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /multa [IdJugador/ParteDelNombre] [Precio] [Raz�n]");
					return 1;
				}

				if(!IsNumeric(tmp))
				giveplayerid = ReturnUser(tmp,playerid);
				else giveplayerid = strval(tmp);

				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /multa [IdJugador/ParteDelNombre] [Precio] [Raz�n]");
					return 1;
				}
				moneys = strval(tmp);
				if(moneys < 1 || moneys > 99999) { SendClientMessage(playerid, Rojo, "* La multa tiene que estar entre 1$ y 99999$!"); return 1; }

				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						if(GetDistanceBetweenPlayers(playerid, giveplayerid) < 7.0)
						{
							new length = strlen(cmdtext);
							while ((idx < length) && (cmdtext[idx] <= ' '))
							{
								idx++;
							}
							new offset = idx;
							new result[128];
							while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
							{
								result[idx - offset] = cmdtext[idx];
								idx++;
							}
							result[idx - offset] = EOS;

							if(!strlen(result))
							{
								SendClientMessage(playerid, Blanco, "USO: /multa [IdJugador/ParteDelNombre] [Precio] [Raz�n]");
								return 1;
							}

							format(string, sizeof(string), "* Entregas a %s una multa de %d$. Raz�n: %s", pName(giveplayerid), moneys, (result));
							SendClientMessage(playerid, Azul, string);
							format(string, sizeof(string), "* Oficial %s te ha entegado una multa de %d$. Raz�n: %s", pName(playerid), moneys, (result));
							SendClientMessage(giveplayerid, Azul, string);
							SendClientMessage(giveplayerid, Azul, "�Utilice /aceptarmulta para pagar la multa!");
							PlayerInfo[giveplayerid][pMultaMoney] = moneys;
							PlayerInfo[giveplayerid][pMultaID] = playerid;
							return 1;
						}
						else
						{
							SendClientMessage(playerid, Rojo, "* Debes estar cerca del sujeto!");
							return 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* Debes estar cerca del sujeto!");
					return 1;
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/aceptarmulta", true) == 0)
	{
	if(PlayerInfo[playerid][pMultaID] == NOEXISTE) return Mensaje(playerid, COLOR_ERRORES, "* �No te han ofrecido una multa!");
	SafeGivePlayerMoney(playerid, -PlayerInfo[playerid][pMultaMoney]);
	format(string, sizeof(string), "* %s ha pagado tu multa de %d$.", pName(giveplayerid), PlayerInfo[playerid][pMultaMoney]);
	SendClientMessage(PlayerInfo[playerid][pMultaID], AzulClaro, string);
	PlayerInfo[giveplayerid][pMultaMoney] = 0;
	PlayerInfo[giveplayerid][pMultaID] = NOEXISTE;
	SendClientMessage(giveplayerid, Verde, "* Has pagado la multa.");
	}
	if(strcmp(cmd, "/megafono", true) == 0 || strcmp(cmd, "/m", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new tmpcar = GetPlayerVehicle(playerid);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, Blanco, "USO: (/m)egafono [Chat Meg�fono]");
				return 1;
			}
			if(IsAMedic(playerid))
			{
			    if(CarInfo[tmpcar][cUsos] != 2)
			    {
			        SendClientMessage(playerid, Rojo, "* Este coche no tiene un meg�fono instalado!");
			        return 1;
			    }
			    format(string, sizeof(string), "[Param�dico %s:o< %s]", pName(playerid), result);
				printf("(Megafono) %s dice: %s", pName(playerid), result);
			    ProxDetector(50.0, playerid, string,Amarillo,Amarillo,Amarillo,Amarillo,Amarillo);
				return 1;
			}
			if(IsABombero(playerid))
			{
			    if(CarInfo[tmpcar][cUsos] != 9)
			    {
			        SendClientMessage(playerid, Rojo, "* Este coche no tiene un meg�fono instalado!");
			        return 1;
			    }
			    format(string, sizeof(string), "[Bombero %s:o< %s]", pName(playerid), result);
				printf("(Megafono) %s dice: %s", pName(playerid), result);
			    ProxDetector(50.0, playerid, string,Amarillo,Amarillo,Amarillo,Amarillo,Amarillo);
				return 1;
			}
			if(IsACop(playerid))
			{
				if(CarInfo[tmpcar][cUsos] != 1 && CarInfo[tmpcar][cUsos] != 6)
				{
					SendClientMessage(playerid, Rojo, "* Este coche no tiene un meg�fono instalado!");
					return 1;
				}
				format(string, sizeof(string), "[Oficial %s:o< %s]", pName(playerid), result);
				printf("(Megafono) %s dice: %s", pName(playerid), result);
				ProxDetector(50.0, playerid, string,Amarillo,Amarillo,Amarillo,Amarillo,Amarillo);
				return 1;
			}
			else
			{
			    SendClientMessage(playerid, Rojo, "* No sabes utilizar el meg�fono.");
				return 1;
			}
		}
		return 1;
	}
if(strcmp(cmd, "/dpl", true) == 0)
	{
		if (PlayerInfo[playerid][pMember] == 1)
		{
			cmd = strtokex(cmdtext, idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid, Blanco, "USO: /dpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}
			new tmpidplayer;
			if(!IsNumeric(cmd))
			tmpidplayer = ReturnUser(cmd,playerid);
			else tmpidplayer = strval(cmd);

			if (!IsPlayerConnected(tmpidplayer))
			{
				SendClientMessage(playerid, Rojo, "* El jugador no est� conectado");
				return 1;
			}

			cmd = strtokex(cmdtext, idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid, Blanco, "USO: /dpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}
			new tmppuntoslic;
			new mensaje[80];

			tmppuntoslic = strval(cmd);
			if (tmppuntoslic < 1 || tmppuntoslic > 3)
			{
				SendClientMessage(playerid, Blanco, "USO: /dpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}

			PlayerInfo[tmpidplayer][pCarLicPoints] += tmppuntoslic;
			SaveValues(tmpidplayer,"Licencias");
			format (mensaje, 80, "Le diste a %s, %d puntos a su licencia", pName(tmpidplayer), tmppuntoslic);
			SendClientMessage (playerid, AzulClaro, mensaje);
			format (mensaje, 80, "Su licencia queda con %d puntos", PlayerInfo[tmpidplayer][pCarLicPoints]);
			SendClientMessage (playerid, AzulClaro, mensaje);
			format (mensaje, 80, "El agente %s te dio %d puntos a tu licencia", pName(playerid), tmppuntoslic);
			SendClientMessage (tmpidplayer, AzulClaro, mensaje);
			format (mensaje, 80, "Tu licencia queda con %d puntos", PlayerInfo[tmpidplayer][pCarLicPoints]);
			SendClientMessage (tmpidplayer, AzulClaro, mensaje);
		}
		else
		{
			SendClientMessage(playerid, Rojo, "* No eres polic�a.");
		}
		return 1;
	}
	if(strcmp(cmd, "/qpl", true) == 0)
	{
		if (PlayerInfo[playerid][pMember] == 1)
		{
			cmd = strtokex(cmdtext, idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid, Blanco, "USO: /qpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}
			new tmpidplayer;
			if(!IsNumeric(cmd))
			tmpidplayer = ReturnUser(cmd,playerid);
			else tmpidplayer = strval(cmd);

			if (!IsPlayerConnected(tmpidplayer))
			{
				SendClientMessage(playerid, Rojo, "* El jugador no est� conectado");
				return 1;
			}

			cmd = strtokex(cmdtext, idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid, Blanco, "USO: /qpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}
			new tmppuntoslic;
			new mensaje[80];

			tmppuntoslic = strval(cmd);
			if (tmppuntoslic < 1 || tmppuntoslic > 3)
			{
				SendClientMessage(playerid, Blanco, "USO: /qpl [IdJugador/ParteDelNombre] [1/2/3]");
				return 1;
			}
			if (tmppuntoslic > PlayerInfo[tmpidplayer][pCarLicPoints])
			{
				SendClientMessage(playerid, RojoIntenso, "* Al jugador no le quedan tantos puntos en su licencia");
				return 1;
			}
			PlayerInfo[tmpidplayer][pCarLicPoints] -= tmppuntoslic;
			SaveValues(tmpidplayer,"Licencias");
			format (mensaje, 80, "Quitaste a %s, %d puntos a su licencia", pName(tmpidplayer), tmppuntoslic);
			SendClientMessage (playerid, AzulClaro, mensaje);
			format (mensaje, 80, "Su licencia queda con %d puntos", PlayerInfo[tmpidplayer][pCarLicPoints]);
			SendClientMessage (playerid, AzulClaro, mensaje);
			format (mensaje, 80, "El agente %s te quit� %d puntos a tu licencia", pName(playerid), tmppuntoslic);
			SendClientMessage (tmpidplayer, AzulClaro, mensaje);
			format (mensaje, 80, "Tu licencia queda con %d puntos", PlayerInfo[tmpidplayer][pCarLicPoints]);
			SendClientMessage (tmpidplayer, AzulClaro, mensaje);
		}
		else
		{
			SendClientMessage(playerid, Rojo, "* No eres polic�a.");
		}
		return 1;
	}
	if(strcmp(cmd,"/dlicarmas",true)==0)
	{
		if(PlayerInfo[playerid][pMember] == 1 && PlayerInfo[playerid][pRank] >= 5)
		{
			cmd = strtokex(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,Blanco,"USO: /dlicarmas [IdJugador/ParteDelNombre] [Precio]");
				return 1;
			}
			new id;
			if(!IsNumeric(cmd))
			id = ReturnUser(cmd);
			else id = strval(cmd);
			tmp = strtokex(cmdtext,idx);
            if(!strlen(tmp))
            {
				SendClientMessage(playerid,Blanco,"USO: /dlicarmas [IdJugador/ParteDelNombre] [Precio]");
                return 1;
            }
            moneys = strval(tmp);
            if(moneys < 1 || moneys > 99999) { SendClientMessage(playerid, Rojo, "* Precio invalido"); return 1; }

			if(IsPlayerConnected(id))
			{
				new Ano,Mes,Dia;
				getdate(Ano,Mes,Dia);
				format(string,128,"El oficial %s te entreg� la licencia de armas con fecha %02d/%02d/%d. Caduca al mes.",pName(playerid),Mes,Dia,Ano);
				SendClientMessage(id,Verde,string);
				SendClientMessage(playerid,Verde,"Entregaste la licencia correctamente");
				PlayerInfo[id][pGunLic] = 1;
				PlayerInfo[id][pGunLicD] = Dia;
				PlayerInfo[id][pGunLicM] = Mes;
				SaveValues(id, "LArmas");
                SafeGivePlayerMoney(id,-moneys);
			}
			else SendClientMessage(playerid,Rojo,"* Jugador no conectado.");
		}
		return 1;
	}
	if(strcmp(cmd,"/qlicarmas",true)==0)
	{
		if(PlayerInfo[playerid][pMember] == 1 && PlayerInfo[playerid][pRank] >= 2)
		{
			cmd = strtokex(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,Blanco,"USO: /qlicarmas [IdJugador/ParteDelNombre]");
				return 1;
			}
			new id;
			if(!IsNumeric(cmd))
			id = ReturnUser(cmd);
			else id = strval(cmd);
			if(IsPlayerConnected(id))
			{
				if(PlayerInfo[id][pGunLic]==1)
				{
					format(string,128,"El oficial %s te quit� la licencia de armas");
					SendClientMessage(id,Verde,string);
					SendClientMessage(playerid,Verde,"Quitaste la licencia correctamente");
					PlayerInfo[id][pGunLic] = 0;
					PlayerInfo[id][pGunLicD] = 0;
					PlayerInfo[id][pGunLicM] = 0;
					SaveValues(id, "LArmas");
				}
				else SendClientMessage(playerid,Rojo,"* El jugador no tiene licencia de armas.");
			}
			else SendClientMessage(playerid,Rojo,"* Jugador no conectado.");
		}
		return 1;
	}
	if(strcmp(cmd, "/desarrestar", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(IsACop(playerid))
		{
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /desarrestar [IdJugador/ParteDelNombre]");
			return 1;
		}
		new arrestado = ReturnUser(tmp);
		if(PlayerInfo[playerid][pDuty] == 0)
		{
		    SendClientMessage(playerid, Rojo, "* No est�s en servicio!");
			return 1;
		}
		if(!EstaEnCarceles(playerid))
		{
			SendClientMessage(playerid, Rojo, "* No est�s en las c�rceles de LSPD!");
		    return 1;
		}
		if(!IsNumeric(tmp))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* ID Err�nea.");
			return 1;
		}
		if(!IsPlayerConnected(arrestado))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* Jugador no conectado.");
			return 1;
		}
		if(PlayerInfo[arrestado][pJailed] == 0)
		{
		    SendClientMessage(playerid, Rojo, "* Jugador no encarcelado.");
			return 1;
		}
		UnjailPlayerIC2(arrestado);
		new str[128];
		format(str, sizeof(str), "* Has sido puesto en libertad por el oficial %s.", pName(playerid));
		SendClientMessage(arrestado, -1, str);
		format(str, sizeof(str), "* Has liberado a %s.", pName(arrestado));
		SendClientMessage(playerid, -1, str);
		}
		return 1;
	}
	if(strcmp(cmd, "/liberarp", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(IsACop(playerid)) // PARA MARSHAL TAMBI�N.
		{
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /liberarp [IdJugador/ParteDelNombre]");
			return 1;
		}
		new arrestado = ReturnUser(tmp);
		if(PlayerInfo[playerid][pDuty] == 0)
		{
		    SendClientMessage(playerid, Rojo, "* No est�s en servicio!");
			return 1;
		}
		if(!EstaEnPrision(playerid))
		{
			SendClientMessage(playerid, Rojo, "* No est�s en las c�rceles de la Prisi�n Federal!");
		    return 1;
		}
		if(!IsNumeric(tmp))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* ID Err�nea.");
			return 1;
		}
		if(!IsPlayerConnected(arrestado))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* Jugador no conectado.");
			return 1;
		}
		if(PlayerInfo[arrestado][pJailed] == 0)
		{
		    SendClientMessage(playerid, Rojo, "* Jugador no encarcelado.");
			return 1;
		}
		UnjailPlayerIC2(arrestado);
		new str[128];
		format(str, sizeof(str), "* Has sido puesto en libertad por el oficial %s.", pName(playerid));
		SendClientMessage(arrestado, -1, str);
		format(str, sizeof(str), "* Has liberado a %s.", pName(arrestado));
		SendClientMessage(playerid, -1, str);
		}
		return 1;
	}
		if(strcmp(cmd, "/presos", true) == 0)
	    {
        if(!IsACop(playerid)) // PARA MARSHAL TAMBI�N.
		{
		SendClientMessage(playerid, Rojo, "* No eres polic�a.");
		return 1;
		}
		
		if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid, Verde, "___________ |- Presos -| ___________");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pJailed] == 5)
				    {
						format(string, 256, "%s", pName(i));
						SendClientMessage(playerid, Rojo, string);
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/condena", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(IsACop(playerid)) // PARA MARSHAL TAMBI�N.
		{
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /condena [IdJugador/ParteDelNombre]");
			return 1;
		}
		new arrestado = ReturnUser(tmp);
		if(!IsNumeric(tmp))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* ID Err�nea.");
			return 1;
		}
		if(!IsPlayerConnected(arrestado))
	   	{
	   	    SendClientMessage(playerid, Rojo, "* Jugador no conectado.");
			return 1;
		}
		if(PlayerInfo[arrestado][pJailed] == 0)
		{
		    SendClientMessage(playerid, Rojo, "* Jugador no encarcelado.");
			return 1;
		}
		new str[128];
		format(str, sizeof(str), "Condena de %s: %d horas.", pName(arrestado), PlayerInfo[arrestado][pJailTime]);
		SendClientMessage(playerid, Rojo, str);
		}
		return 1;
	}
	return 0;
}

/*UnjailPlayerIC(playerid)
{
    if(PlayerInfo[playerid][pJailed] == 1) // Comisar�a.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 3) // Comisar�a.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 5) // Prisi�n Federal.
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
	return SendClientMessage(playerid, AzulClaro, "* Has cumplido tu condena. Vuelves a ser libre!");
}*/

UnjailPlayerIC2(playerid)
{
	if(PlayerInfo[playerid][pJailed] == 1) // Comisar�a.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 3) // Comisar�a.
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,232.6397,144.2108,1003.0234);
		SetPlayerFacingAngle(playerid,271.1205);
	}
	else if(PlayerInfo[playerid][pJailed] == 5) // Prisi�n Federal.
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
	return 1;
}

forward EstaEnCarceles(playerid);
public EstaEnCarceles(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(IsPlayerInRangeOfPoint(playerid,5.0,198.0853,158.8262,1003.0234) || IsPlayerInRangeOfPoint(playerid,5.0,197.9805,178.2182,1003.0234))
		{
		    return 1;
		}
	}
	return 0;
}

forward EstaEnPrision(playerid);
public EstaEnPrision(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(IsPlayerInRangeOfPoint(playerid,5.0,2579.9175,-1325.8849,1047.9603))
		{
		    return 1;
		}
	}
	return 0;
}
