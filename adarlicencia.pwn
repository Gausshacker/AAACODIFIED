	if(strcmp(cmd, "/adarlicencia", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if (InfoJugador[playerid][pAdmin] >= 6)
	        {
	            new x_nr[128];
				x_nr = strtokex(cmdtext, idx);
				if(!strlen(x_nr)) {
				    SendClientMessage(playerid, Blanco, "USO: /adarlicencia [nombre] [IdJugador/ParteDelNombre]");
				    SendClientMessage(playerid, Blanco, "Nombres disponibles: Conduccion, Aviacion, Navegacion, Pesca, Armas.");
					return 1;
				}
			    if(strcmp(x_nr,"conduccion",true) == 0)
				{
		            tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, Blanco, "USO: /adarlicencia conduccion [IdJugador/ParteDelNombre]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "* Has entregado la licencia de conducir a %s.",giveplayer);
					        SendClientMessage(playerid, AzulClaro, string);
					        format(string, sizeof(string), "* Admin %s te ha dado la licencia de conducir.",sendername);
					        SendClientMessage(giveplayerid, AzulClaro, string);
					        InfoJugador[giveplayerid][pCarLic] = 3;
					        return 1;
				        }
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"aviacion",true) == 0)
				{
		            tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, Blanco, "USO: /adarlicencia aviacion [IdJugador/ParteDelNombre]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "* Has entregado la licencia de vuelo a %s.",giveplayer);
					        SendClientMessage(playerid, AzulClaro, string);
					        format(string, sizeof(string), "* Admin %s te ha dado la licencia de vuelo.",sendername);
					        SendClientMessage(giveplayerid, AzulClaro, string);
					        InfoJugador[giveplayerid][pFlyLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"navegacion",true) == 0)
				{
		            tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, Blanco, "USO: /adarlicencia navegacion [IdJugador/ParteDelNombre]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "* Has entregado la licencia de navegación a %s.",giveplayer);
					        SendClientMessage(playerid, AzulClaro, string);
					        format(string, sizeof(string), "* Admin %s te ha dado la licencia de navegacion.",sendername);
					        SendClientMessage(giveplayerid, AzulClaro, string);
					        InfoJugador[giveplayerid][pBoatLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"pesca",true) == 0)
				{
		            tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, Blanco, "USO: /adarlicencia pesca [IdJugador/ParteDelNombre]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "* Has entregado una licencia de pesca a %s.",giveplayer);
					        SendClientMessage(playerid, AzulClaro, string);
					        format(string, sizeof(string), "* Admin %s te ha dado la licencia de pesca.",sendername);
					        SendClientMessage(giveplayerid, AzulClaro, string);
					        InfoJugador[giveplayerid][pFishLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, Blanco, "¡Jugador no conectado!");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"armas",true) == 0)
				{
		            tmp = strtokex(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, Blanco, "USO: /adarlicencia armas [IdJugador/ParteDelNombre]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "* Has entregado una licencia de armas a %s.",giveplayer);
					        SendClientMessage(playerid, AzulClaro, string);
					        format(string, sizeof(string), "* Admin %s te ha dado la Licencia de Armas.",sendername);
					        SendClientMessage(giveplayerid, AzulClaro, string);
					        InfoJugador[giveplayerid][pGunLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, Rojo, "¡Jugador no conectado!");
					    return 1;
					}
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, Rojo, "¡No puedes usar este comando!");
	            return 1;
	        }
	    }
	    return 1;
 	}
