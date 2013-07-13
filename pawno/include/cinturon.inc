#include <a_samp>
#include <colores>
#include <globalvars>
#include <funciones>

new Cinturon[MAX_PLAYERS];
new TimerStack;
new Float:VehicleHealthStack[700][3];
//new tmp[128];

forward VehicleDamageToPlayerHealth(playerid, vehicleid);
forward VehicleDamageToPlayerHealth2(playerid, vehicleid);
forward DisablePlayerKnockout(playerid);
forward IsACopSkin(playerid);




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

forward ComprobarAccidentes(); public ComprobarAccidentes(){
	for(new i=0; i < sizeof(AutoInfo); i++){
	    foreach(new j : Player){
		    if(IsPlayerConnected(j) && IsPlayerInAnyVehicle(j) && GetPlayerVehicleID(j) == i){
				new Float:vida2, Float:danio, string[128];
				GetVehicleHealth(i, vida2);
				danio = CarInfo[GetPlayerVehicle(i)][cDamage] - vida2;
                CarInfo[GetPlayerVehicle(i)][cDamage] = vida2;
			    new zona[128];
				GetPlayer2DZone(j, zona, 128);
			    if(danio > 250){
			        if(ConectadosDeEmergencias > 0){
			            ApplyAnimation(j, "PED", "CAR_dead_RHS", 4.0, 1, 0, 0, 0, 0, 1);
 						if(GetPlayerVehicleSeat(j) == 0){
                            ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
							TogglePlayerControllable(j, 0);
						    TogglePlayerControllable(j, 0);
						    Atrapado[j] = 1;
       						foreach(new j2 : Player){
								new Float:X, Float:Y, Float:Z;
								GetPlayerPos(j, X, Y, Z);
								if(FuerzaPublica(playerid)){
								    SetPlayerCheckpoint(j, X, Y, Z, 5.0);
								}
						    }
						    Mensaje(j, ROJO, "Usted ha quedado atrapado a causa de un grave accidente, deberá esperar hasta que vengan funcionarios de emergencia.");
							Mensaje(j, ROJO, "No se desconecte, ya que en éstos momentos hay funcionarios de emergencia disponibles, si lo hace, será sancionado.");
				    		format(string, sizeof(string), "* [ENTORNO] Se puede oír un grave estruendo producido por una colisión vehicular.");
							new Float:x,Float:y,Float:z;
							GetPlayerPos(j, x,y,z);
							foreach(new a : Player){
						    	if(IsPlayerConnected(a)){
									if(IsPlayerInRangeOfPoint(a, 20.0,x,y,z)){
								  		Mensaje(a, COLOR_ENTORNO, string);
		            					break;
									}
								}
							}
							format(string, sizeof(string), "** [CENTRAL] Se necesitan unidades de emergencias y policiales en la zona de %s, debido a un accidente. **", zona);
							SendFamilyMessage(1, COLOR_RADIO, string); SendFamilyMessage(2, COLOR_RADIO, string);
							for(new i2; i2 < MAX_INFORMES; i2++){
								new Float:X, Float:Y, Float:Z;
								GetPlayerPos(j, X, Y, Z);
								if(InformeInfo[i2][iEstado] == 0){
									InformeInfo[i2][iPaciente] = j;
									InformeInfo[i2][iX] = X;
									InformeInfo[i2][iY] = Y;
									InformeInfo[i2][iZ] = Z;
									InformeInfo[i2][iEstado] = 3;
									break;
								}
							}
							return 1;
						}
						else{
						    TogglePlayerControllable(j, 0);
						    TogglePlayerControllable(j, 0);
						    Atrapado[j] = 1;
							Mensaje(j, ROJO, "Usted ha quedado atrapado a causa de un grave accidente, deberá esperar hasta que vengan funcionarios de emergencia.");
							Mensaje(j, ROJO, "No se desconecte, ya que en éstos momentos hay funcionarios de emergencia disponibles, si lo hace, será sancionado.");
                            ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
                            break;
						}
					}
					else{
					    Mensaje(j, VERDE, "Usted no se ha quedado atrapado debido a que no hay funcionarios de emergencia disponibles.");
                        if(GetPlayerVehicleSeat(j) == 0){
						    ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
						}
						else{
						    ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
		    			}
						break;
					}
				}
				if(danio > 60 && danio < 90){
			        ApplyAnimation(j, "PED", "CAR_dead_RHS", 4.0, 1, 0, 0, 0, 0, 1);
					if(GetPlayerVehicleSeat(j) == 0){
					    ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
					    format(string, sizeof(string), "* [ENTORNO] Se puede oír un grave estruendo producido por una colisión vehicular.");
						new Float:x,Float:y,Float:z;
						GetPlayerPos(j, x,y,z);
						foreach(new a : Player){
						    if(IsPlayerConnected(a)){
								if(IsPlayerInRangeOfPoint(a, 20.0,x,y,z)){
								  	Mensaje(a, COLOR_ENTORNO, string);
		            				break;
								}
							}
						}
					}
					else{
					    ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
	    			}
					return 1;
		 		}
		 		else if(danio > 90 && danio < 250){
			        new suerte = random(3);
			        if(suerte == 1){
				        if(ConectadosDeEmergencias > 0){
					        if(GetPlayerVehicleSeat(j) == 0){
					            ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
							    TogglePlayerControllable(j, 0);
						    	TogglePlayerControllable(j, 0);
						    	Atrapado[j] = 1;
							    foreach(new j2 : Player){
									new Float:X, Float:Y, Float:Z;
									GetPlayerPos(j, X, Y, Z);
									if(FuerzaPublica(j))){
									    SetPlayerCheckpoint(j, X, Y, Z, 5.0);
									}
							    }
							    Mensaje(j, ROJO, "Usted ha quedado atrapado a causa de un grave accidente, deberá esperar hasta que vengan funcionarios de emergencia.");
								Mensaje(j, ROJO, "No se desconecte, ya que en éstos momentos hay funcionarios de emergencia disponibles, si lo hace, será sancionado.");
							    format(string, sizeof(string), "* [ENTORNO] Se puede oír un grave estruendo producido por una colisión vehicular.");
                                new Float:x,Float:y,Float:z;
								GetPlayerPos(j, x,y,z);
								foreach(new b : Player){
						    		if(IsPlayerConnected(b)){
										if(IsPlayerInRangeOfPoint(b, 20.0,x,y,z)){
									  		Mensaje(b, COLOR_ENTORNO, string);
		            						break;
										}
									}
								}
								format(string, sizeof(string), "** [CENTRAL] Se necesitan unidades de emergencias y policiales en la zona de %s, debido a un accidente. **", zona);
								SendFamilyMessage(1, COLOR_RADIO, string); SendFamilyMessage(9, COLOR_RADIO, string);
							    for(new i2; i2 < MAX_INFORMES; i2++){
								    new Float:X, Float:Y, Float:Z;
									GetPlayerPos(j, X, Y, Z);
									if(InformeInfo[i2][iEstado] == 0){
										InformeInfo[i2][iPaciente] = j;
										InformeInfo[i2][iX] = X;
										InformeInfo[i2][iY] = Y;
										InformeInfo[i2][iZ] = Z;
										InformeInfo[i2][iEstado] = 3;
										break;
									}
								}
								return 1;
							}
							else{
							    TogglePlayerControllable(j, 0);
						    	TogglePlayerControllable(j, 0);
							    Atrapado[j] = 1;
								Mensaje(j, ROJO, "Usted ha quedado atrapado a causa de un grave accidente, deberá esperar hasta que vengan funcionarios de emergencia.");
								Mensaje(j, ROJO, "No se desconecte, ya que en éstos momentos hay funcionarios de emergencia disponibles, si lo hace, será sancionado.");
                                ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
							}
							return 1;
						}
						else{
						    ApplyAnimation(j, "PED", "CAR_dead_RHS", 4.0, 1, 0, 0, 0, 0, 1);
							Mensaje(j, VERDE, "Usted no se ha quedado atrapado debido a que no hay funcionarios de emergencia disponibles.");
                            if(GetPlayerVehicleSeat(j) == 0){
							    ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
							}
							else{
							    ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
							}
						}
					}
					else{
					    ApplyAnimation(j, "PED", "CAR_dead_RHS", 4.0, 1, 0, 0, 0, 0, 1);
					    if(GetPlayerVehicleSeat(j) == 0){
						    ApplyAnimation(j, "PED", "CAR_tune_radio", 4.0, 1, 0, 0, 0, 0, 1);
						    format(string, sizeof(string), "* [ENTORNO] Se puede oír un grave estruendo producido por una colisión vehicular.");
                            new Float:x,Float:y,Float:z;
							GetPlayerPos(j, x,y,z);
							foreach(new a : Player){
						    	if(IsPlayerConnected(a)){
									if(IsPlayerInRangeOfPoint(a, 20.0,x,y,z)){
								  		Mensaje(a, COLOR_ENTORNO, string);
		            					break;
									}
								}
							}
						}
						else{
		    				ApplyAnimation(j, "PED", "CAR_sitp", 4.0, 1, 0, 0, 0, 0, 1);
						}
						return 1;
					}
					return 1;
			    }
			}
		}
	}
	return 1;
}

new Float:CarHealth[MAX_PLAYERS];
/*Cinturon_OnPlayerUpdate(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) == 1)
	{
		new Float:TempCarHealth;
		GetVehicleHealth(GetPlayerVehicleID(playerid), TempCarHealth);
		new Float:Difference = floatsub(CarHealth[playerid], TempCarHealth);
		if((floatcmp(CarHealth[playerid], TempCarHealth) == 1) && (floatcmp(Difference,100.0) == 1))
		{
		    Difference = floatdiv(Difference, 10.0);
            format(string, 128, "* %s ha colisionado y se encuentra inmovible.", pName(playerid));
			ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
			TogglePlayerControllable(playerid, 0);
			PlayerInfo[playerid][pHerido] = 1;
		    Bombero(playerid);
		}
		CarHealth[playerid] = TempCarHealth;
	}
	else
	{
		CarHealth[playerid] = 0.0;
	}
    return 1;
}*/



Cinturon_OnPlayerCommandText(playerid, cmdtext[])
{
	//new string[128];
	new vehicleid = GetPlayerVehicleID(playerid);
	new giveplayerid;
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
			format(string, sizeof(string), "*[Extraño:%d] se ha colocado el cinturón", extranoid[playerid]);
			}
			else
			{
			format(string, sizeof(string),"* %s se coloca el cinturón.",pName(playerid));
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
			format(string, sizeof(string), "*[Extraño:%d] se ha quitado el cinturón", extranoid[playerid]);
			}
			else
			{
			format(string, sizeof(string),"* %s se ha quitado el cinturón.",pName(playerid));
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

        dcmd(revisarcinturon, 15, cmdtext);

        /*if (strcmp("/revisarcinturon", cmdtext, true, 9) == 0)
	{
        new idx;
        new tmp[256];
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp))
	{
	SendClientMessage(playerid, COLOR_CORAL, "USO: /revisarcinturon [JugadorID]");
	return 1;
	}
	giveplayerid = ReturnUser(tmp);
	if(PlayerInfo[playerid][pMember] != 1)
	{
	SendClientMessage(playerid, COLOR_CORAL, "Usted no es un policía.");
  	return 1;
	}
	if(IsPlayerConnected(giveplayerid))
	{
	if(giveplayerid != INVALID_PLAYER_ID)
	{
	new Float:x, Float:y, Float:z;
	new PlayerName[24];
	GetPlayerPos(giveplayerid, x, y, z);
	GetPlayerName(giveplayerid, PlayerName, 24);
	if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[giveplayerid] == 1)
	{
	format(string, sizeof(string), "%s está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El oficial %s ha comprobado que llevas puesto el cinturón de seguridad.", pName(playerid));
	SendClientMessage(giveplayerid, -1, string);
        format(string, sizeof(string),"* %s comprueba si %s lleva puesto el cinturón de seguridad.", pName(playerid), pName(giveplayerid));
       	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
 	return 1;
	}
	else if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[giveplayerid] == 0)
	{
	format(string, sizeof(string), "%s no está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El oficial %s ha comprobado que no llevas puesto el cinturón de seguridad.", pName(playerid));
	SendClientMessage(giveplayerid, -1, string);
        format(string, sizeof(string),"* %s comprueba si %s lleva puesto el cinturón de seguridad.",pName(playerid), pName(giveplayerid));
       	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
	return 1;
 	}
	else
	{
 	SendClientMessage(playerid, COLOR_CORAL, "Usted no está cerca de ese jugador.");
	return 1;
	}
	}
	else
	{
   	SendClientMessage(playerid, COLOR_CORAL, "El ID que ha introducido no existe.");
   	return 1;
	}
	}
	else
	{
	}
	}*/

	/*if (strcmp("/revisarcinturon", cmdtext, true, 9) == 0)
	{
	    new idx;
	    new tmp[128];
		tmp = strtok(cmdtext, idx);
	   	if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_CORAL, "USO: /revisarcinturon [jugador]");
			return 1;
		}
		giveplayerid = ReturnUser(tmp);
		if(PlayerInfo[playerid][pMember] == 1)
		{
			if(IsPlayerConnected(giveplayerid))
			{
		    	if(giveplayerid != INVALID_PLAYER_ID)
				{
					new Float:x, Float:y, Float:z;
					new PlayerName[24];
					GetPlayerPos(giveplayerid, x, y, z);
					GetPlayerName(giveplayerid, PlayerName, 24);
					if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[giveplayerid] == 1)
					{
						format(string, sizeof(string), "* %s tiene puesto el cinturón.", PlayerName);
					    SendClientMessage(playerid, COLOR_GREEN, string);
					    return 1;
					}
					else if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[giveplayerid] == 0)
					{
						format(string, sizeof(string), "* %s no tiene puesto el cinturón.", PlayerName);
						SendClientMessage(playerid, COLOR_GREEN, string);
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_CORAL, "No estás cerca del jugador");
						return 1;
					}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_CORAL, "Ese jugador no existe");
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_CORAL, "Jugador no conectado");
		    return 1;
		}
                }
                else
		{
		    SendClientMessage(playerid, COLOR_CORAL, "No eres policia");
		    return 1;
		}
        }*/
	return 0;
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
 
        new Float:x, Float:y, Float:z;
	new PlayerName[24];
	GetPlayerPos(id, x, y, z);
	GetPlayerName(id, PlayerName, 24);
	if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[id] == 1)
	{
	format(string, sizeof(string), "%s está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El oficial %s ha comprobado que llevas puesto el cinturón de seguridad.", pName(playerid));
	SendClientMessage(id, -1, string);
        format(string, sizeof(string),"* %s comprueba si %s lleva puesto el cinturón de seguridad.", pName(playerid), pName(id));
       	ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
 	return 1;
	}
	else if(PlayerToPoint(6.0, playerid, x, y, z) && Cinturon[id] == 0)
	{
	format(string, sizeof(string), "%s no está usando su cinturón de seguridad.", PlayerName);
	SendClientMessage(playerid, COLOR_GREEN, string);
        format(string, sizeof(string), "El oficial %s ha comprobado que no llevas puesto el cinturón de seguridad.", pName(playerid));
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


public DisablePlayerKnockout(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid, COLOR_GREEN, "Te has recobrado del shock.");
	KillTimer(TimerStack);
	return 1;
}



public IsACopSkin(playerid)
{
	if(GetPlayerSkin(playerid) == 280 || GetPlayerSkin(playerid) == 281 || GetPlayerSkin(playerid) == 282 || GetPlayerSkin(playerid) == 283 || GetPlayerSkin(playerid) == 288 || GetPlayerSkin(playerid) == 284 || GetPlayerSkin(playerid) == 285 || GetPlayerSkin(playerid) == 286 || GetPlayerSkin(playerid) == 287)
	{
		return 1;
	}
	return 0;
}

