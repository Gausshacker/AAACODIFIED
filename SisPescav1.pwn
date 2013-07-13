//Sistema de pesca v1

//----------------------------------//
pFishes,
pBiggestFish,
pFishSkill,
//----------------------------------//
enum pFishing
{
	pFish1[20],
	pFish2[20],
	pFish3[20],
	pFish4[20],
	pFish5[20],
	pWeight1,
	pWeight2,
	pWeight3,
	pWeight4,
	pWeight5,
	pFid1,
	pFid2,
	pFid3,
	pFid4,
	pFid5,
	pLastFish,
	pFishID,
	pLastWeight,
};
new Fishes[MAX_PLAYERS][pFishing];
new FishNamesNumber = 23;
new FishNames[23][20] = {
{"Chaqueta"},
{"Sardina"},
{"Pulpo"},
{"Besugo"},
{"Pantalones"},
{"Trucha"},
{"Salmon"},
{"Lata"},
{"Atun"},
{"Dorado"},
{"Zapatillas"},
{"Bonito"},
{"Lenguado"},
{"Basura"},
{"Tuna"},
{"Lubina"},
{"Mero"},
{"Pargo"},
{"Tortuga"},
{"Pez Gato"},
{"Monedero"},
{"Condon usado"},
{"Pez Espada"}
};
//----------------------------------//
Fishes[playerid][pLastFish] = 0; Fishes[playerid][pFishID] = 0;
//---------------------------------//
new Pescando[MAX_PLAYERS];
new ZonaPesca[MAX_PLAYERS];
new Pescados[MAX_PLAYERS];
new TiroCanna[MAX_PLAYERS];
//-------------------------------//
IsAtFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerToPoint(1.0,playerid,403.8266,-2088.7598,7.8359) || PlayerToPoint(1.0,playerid,398.7553,-2088.7490,7.8359))
		{
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,396.2197,-2088.6692,7.8359) || PlayerToPoint(1.0,playerid,391.1094,-2088.7976,7.8359))
		{
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,383.4157,-2088.7849,7.8359) || PlayerToPoint(1.0,playerid,374.9598,-2088.7979,7.8359))
		{
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,369.8107,-2088.7927,7.8359) || PlayerToPoint(1.0,playerid,367.3637,-2088.7925,7.8359))
		{
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,362.2244,-2088.7981,7.8359) || PlayerToPoint(1.0,playerid,354.5382,-2088.7979,7.8359))
		{
		    return 1;
		}
	}
	return 0;
}
//-----------------------------------------//
forward ResetPesca(playerid);
public ResetPesca(playerid)
{
	Pescando[playerid] = 0;
	Pescados[playerid] = 0;
	return 1;
}

forward PlayerPesca(playerid);
public PlayerPesca(playerid)
{
	new zona = IsAtFishPlace(playerid);
	if(Pescados[playerid] == 10)
	{
	    SendClientMessage(playerid, Naranja, "No hay peces a la vista, vuelve en media hora.");
		TiroCanna[playerid] = 0;
		TogglePlayerControllable(playerid, 1);
	    return 1;
	}
	switch (zona)
	{
		case 1:
		{
		    SendClientMessage(playerid, Naranja, "Ha picado un pez pequeño, con un valor de 5$.");
		    SafeGivePlayerMoney(playerid, 5);
		}
		case 2:
		{
		    SendClientMessage(playerid, Naranja, "Ha picado un pez de tamaño medio, con un valor de 15$.");
		    SafeGivePlayerMoney(playerid, 15);
		}
		case 3:
		{
		    SendClientMessage(playerid, Naranja, "¡Ha picado un gran pez! Tiene un valor de 40$.");
		    SafeGivePlayerMoney(playerid, 40);
		}
	}
	TiroCanna[playerid] = 0;
	Pescados[playerid]++;
	TogglePlayerControllable(playerid, 1);
	PlayerInfo[playerid][pFishSkill]++;
	return 1;
}
public ClearFishes(playerid)
{
    new string[128];
	if(IsPlayerConnected(playerid))
	{
	    Fishes[playerid][pFid1] = 0; Fishes[playerid][pFid2] = 0; Fishes[playerid][pFid3] = 0;
		Fishes[playerid][pFid4] = 0; Fishes[playerid][pFid5] = 0;
		Fishes[playerid][pWeight1] = 0; Fishes[playerid][pWeight2] = 0; Fishes[playerid][pWeight3] = 0;
		Fishes[playerid][pWeight4] = 0; Fishes[playerid][pWeight5] = 0;
		format(string, sizeof(string), "Nada");
		strmid(Fishes[playerid][pFish1], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish2], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish3], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish4], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish5], string, 0, strlen(string), 255);
	}
	return 1;
}

//------------------------------[COMANDO /PESCAR]------------------------//
if(strcmp(cmd,"/pescar", true)==0)
	{
	    tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid, Blanco, "USO: /pescar [zona de pesca]");
	        SendClientMessage(playerid, Blanco, "Zonas Disponibles: 1. Muelle, 2. Bahía, 3. Alta mar.");
	        return 1;
		}
		if(Pescando[playerid] == 1)
		{
		    SendClientMessage(playerid, Naranja, "Debes esperar 30 minutos entre cada sesión de pesca, /dejarpescar para finalizar.");
		    return 1;
		}
		new zona;
		zona = strval(tmp);
		if(zona == 1)
		{
			SendClientMessage(playerid, Blanco, "Ve al muelle, /usarcaña para comenzar.");
			SetPlayerCheckpoint(playerid, 383.4134,-2088.7979,7.8359, 17.0);
			ZonaPesca[playerid] = 1;
			Pescando[playerid] = 1;
			return 1;
		}
		else if(zona == 2)
		{
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 473)
		    {
		        SendClientMessage(playerid, Rojo, "¡Debes usar una Dinghy para pescar en la bahía!");
		        return 1;
		    }
			SendClientMessage(playerid, Blanco, "Ve a la bahía, /usarcaña para comenzar.");
			SetPlayerCheckpoint(playerid, 3079.8074,-1605.9281,0.1431, 30.0);
			ZonaPesca[playerid] = 2;
			Pescando[playerid] = 1;
			return 1;
		}
		else if(zona == 3)
		{
  			if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 453)
		    {
		        SendClientMessage(playerid, Rojo, "¡Debes usar un Reefer para pescar en alta mar!");
		        return 1;
		    }
			SendClientMessage(playerid, Blanco, "Ve a alta mar, /usarcaña para comenzar.");
			SetPlayerCheckpoint(playerid, 3600.4846,-1685.2477,0.2599, 30.0);
			ZonaPesca[playerid] = 3;
			Pescando[playerid] = 1;
			return 1;
		}
		else
		{
		    SendClientMessage(playerid, Blanco, "USO: /pescar [1|2|3]");
		    return 1;
		}
	}
	
//----------------------------[COMANDO /USARCAÑA]-----------------------------------//
if(strcmp(cmd,"/usarcaña", true) == 0)
	{
	    if(IsAtFishPlace(playerid) == 0)
	    {
	        return 1;
	    }
	    if(Pescando[playerid] == 0)
	    {
	        SendClientMessage(playerid, Blanco, "Primero deberás usar /pescar.");
	        return 1;
	    }
		if (TiroCanna[playerid] == 1)
		{
			SendClientMessage(playerid, Blanco, "Espera a que piquen.");
			return 1;
		}
		GetPlayerName(playerid, sendername, 128);
		Replace(sendername, "_", " ");
		format(string, sizeof(string), "%s lanza el anzuelo y sostiene la caña.", sendername);
		ProxDetector(30.0, playerid, string, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES, COLOR_ACCIONES);
		new zona = IsAtFishPlace(playerid);
		if(zona == ZonaPesca[playerid])
		{
		    TiroCanna[playerid] = 1;
		    if(zona == 1)
		    {
		        SetTimerEx("PlayerPesca", 10000, 0, "i", playerid);
		        SendClientMessage(playerid, Blanco, "Espera a que piquen.");
		        TogglePlayerControllable(playerid, 0);
		        return 1;
		    }
		    if(zona == 2)
		    {
		        SetTimerEx("PlayerPesca", 10000, 0, "i", playerid);
		        SendClientMessage(playerid, Blanco, "Espera a que piquen.");
		        TogglePlayerControllable(playerid, 0);
		        return 1;
		    }
		    if(zona == 3)
		    {
		        SetTimerEx("PlayerPesca", 10000, 0, "i", playerid);
		        SendClientMessage(playerid, Blanco, "Espera a que piquen.");
		        TogglePlayerControllable(playerid, 0);
		        return 1;
		    }
		}
		return 1;
	}
//---------------------------------[DEJARDEPESCAR]----------------------------------------//
if(strcmp(cmd,"/dejarpescar", true) == 0)
	{
 		if(Pescando[playerid] == 0)
	    {
	        SendClientMessage(playerid, Rojo, "No estás pescando.");
	        return 1;
	    }
	    if(TiroCanna[playerid] == 1)
	    {
	        SendClientMessage(playerid, Blanco, "Espera a que piquen.");
	        return 1;
	    }
	    SendClientMessage(playerid, Naranja, "Has acabado de pescar.");
	    SetTimerEx("ResetPesca", 1800000, 0, "i", playerid);
	    ZonaPesca[playerid] = 0;
	    TiroCanna[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	    return 1;
	}
//--------------------------------[CANTIDADPESCADA]----------------------------------//
if(strcmp(cmd,"/cantpesca",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFishes] > 5)
	        {
	            SendClientMessage(playerid, Rojo, "¡Has pescado demasiado hoy, espera un rato para volver a pescar!");
	            return 1;
	        }
	        if(Fishes[playerid][pWeight1] > 0 && Fishes[playerid][pWeight2] > 0 && Fishes[playerid][pWeight3] > 0 && Fishes[playerid][pWeight4] > 0 && Fishes[playerid][pWeight5] > 0)
	        {
	            SendClientMessage(playerid, Rojo, "¡Ya has pescado 5 peces, vende / tira alguno primero!");
	            return 1;
	        }
	        new Veh = GetPlayerVehicleID(playerid);
	        if((IsAtFishPlace(playerid)) || IsABoat(Veh))
	        {
	            new Caught;
	            new rand;
	            new fstring[MAX_PLAYER_NAME];
	            new Level = PlayerInfo[playerid][pFishSkill];
  				if (FishTimer[playerid] != 0)
				{
					SendClientMessage(playerid, Rojo, "¡No vas pescar más por el momento!");
					return 1;
				}
				FishTimer[playerid] = 1;
    			SetTimerEx("ResetFishTimer", 5000, 0, "i", playerid);
	            if(Level >= 0 && Level <= 50) { Caught = random(20)-7; }
	            else if(Level >= 51 && Level <= 100) { Caught = random(50)-20; }
	            else if(Level >= 101 && Level <= 200) { Caught = random(100)-50; }
	            else if(Level >= 201 && Level <= 400) { Caught = random(160)-60; }
	            else if(Level >= 401) { Caught = random(180)-70; }
	            rand = random(FishNamesNumber);
	            if(Caught <= 0)
	            {
	                SendClientMessage(playerid, Rojo, "¡No pican!");
	                return 1;
	            }
	            else if(rand == 0)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado una Chaqueta y la tiraste al agua!");
	                return 1;
	            }
	            else if(rand == 4)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado un Pantalón y lo tiraste al agua!");
	                return 1;
	            }
	            else if(rand == 7)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado una Lata y la tiraste al agua!");
	                return 1;
	            }
	            else if(rand == 10)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado un par de Zapatos y lo tiraste al agua!");
	                return 1;
	            }
	            else if(rand == 13)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado algo de Basura y la tiraste al agua!");
	                return 1;
	            }
	            else if(rand == 21)
	            {
	                SendClientMessage(playerid, Naranja, "¡Has pescado un condon usado, miras alrededor y decides quedartelo!");
	                Condom[playerid] ++;
				    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				    format(string, sizeof(string), "¡Has tirado los peces!");
				    SendClientMessage(playerid, Rojo, string);
	                return 1;
	            }
	            else if(rand == 20)
	            {
	                new mrand = random(20);
	                format(string, sizeof(string), "* Has pescado un Monedero, tiene %d$.", mrand);
					SendClientMessage(playerid, Naranja, string);
	                SafeGivePlayerMoney(playerid, mrand);
	                return 1;
	            }
		        if(Fishes[playerid][pWeight1] == 0)
		        {
		        	PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish1], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight1] = Caught;
					format(string, sizeof(string), "* Has pescado: %s, que pesa %d GRA.", Fishes[playerid][pFish1], Caught);
					SendClientMessage(playerid, Naranja, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 1;
					Fishes[playerid][pFid1] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish])
					{
					    format(string, sizeof(string), "* Tu viejo record de %d g ha sido superado, el nuevo record es: %d g.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, Naranja, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
     			}
		        else if(Fishes[playerid][pWeight2] == 0)
		        {
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish2], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight2] = Caught;
					format(string, sizeof(string), "* Has pescado: %s, que pesa %d GRA.", Fishes[playerid][pFish2], Caught);
					SendClientMessage(playerid, Naranja, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 2;
					Fishes[playerid][pFid2] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish])
					{
					    format(string, sizeof(string), "* Tu viejo record de %d g ha sido superado, el nuevo record es: %d g.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, Naranja, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight3] == 0)
		        {
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish3], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight3] = Caught;
					format(string, sizeof(string), "* Has pescado: %s, que pesa %d GRA.", Fishes[playerid][pFish3], Caught);
					SendClientMessage(playerid, Naranja, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 3;
					Fishes[playerid][pFid3] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish])
					{
					    format(string, sizeof(string), "* Tu viejo record de %d g ha sido superado, el nuevo record es: %d g.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, Naranja, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight4] == 0)
		        {
		            PLayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish4], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight4] = Caught;
					format(string, sizeof(string), "* Has pescado: %s, que pesa %d GRA.", Fishes[playerid][pFish4], Caught);
					SendClientMessage(playerid, Naranja, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 4;
					Fishes[playerid][pFid4] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish])
					{
					    format(string, sizeof(string), "* Tu viejo record de %d GRA ha sido superado, el nuevo record es: %d Gra.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, Naranja, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight5] == 0)
		        {
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish5], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight5] = Caught;
					format(string, sizeof(string), "* Has pescado: %s, que pesa %d GRA.", Fishes[playerid][pFish5], Caught);
					SendClientMessage(playerid, Naranja, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 5;
					Fishes[playerid][pFid5] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish])
					{
					    format(string, sizeof(string), "* Tu viejo record de %d GRA ha sido superado, el nuevo record es: %d Gra.", InfoJugador[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, Naranja, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else
		        {
		            SendClientMessage(playerid, Verde, " No tienes espacio para peces!");
		            return 1;
		        }
	            if(PlayerInfo[playerid][pFishSkill] == 50)
				{ SendClientMessage(playerid, Rojo, "* Tu nivel de pesca es ahora 2, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 250)
				{ SendClientMessage(playerid, Rojo, "* Tu nivel de pesca es ahora 3, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 500)
				{ SendClientMessage(playerid, Rojo, "* Tu nivel de pesca es ahora 4, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 1000)
				{ SendClientMessage(playerid, Rojo, "* Tu nivel de pesca es ahora 5, you can now catch Heavier Fishes."); }
	        }
	        else
	        {
	            SendClientMessage(playerid, Rojo, "   No estas en la zona de pesca (Big Wheel Rods) o en el barco de pesca!");
	            return 1;
	        }
	    }
	    return 1;
 	}
	if(strcmp(cmd,"/peceslol",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        SendClientMessage(playerid, Blanco, "|__________________ Peces __________________|");
	        format(string, sizeof(string), "** (1) Pez: %s.   Peso: %d.", Fishes[playerid][pFish1], Fishes[playerid][pWeight1]);
			SendClientMessage(playerid, Blanco, string);
			format(string, sizeof(string), "** (2) Pez: %s.   Peso: %d.", Fishes[playerid][pFish2], Fishes[playerid][pWeight2]);
			SendClientMessage(playerid, Blanco, string);
			format(string, sizeof(string), "** (3) Pez: %s.   Peso: %d.", Fishes[playerid][pFish3], Fishes[playerid][pWeight3]);
			SendClientMessage(playerid, Blanco, string);
			format(string, sizeof(string), "** (4) Pez: %s.   Peso: %d.", Fishes[playerid][pFish4], Fishes[playerid][pWeight4]);
			SendClientMessage(playerid, Blanco, string);
			format(string, sizeof(string), "** (5) Pez: %s.   Peso: %d.", Fishes[playerid][pFish5], Fishes[playerid][pWeight5]);
			SendClientMessage(playerid, Blanco, string);
			SendClientMessage(playerid, Blanco, "|____________________________________________|");
		}
	    return 1;
 	}
 	if(strcmp(cmd,"/tirarpeces",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /tirarpez [pez]");
				return 1;
			}
			new fishid = strval(tmp);
			if(fishid < 1 || fishid > 5) { SendClientMessage(playerid, Rojo, "NÚMERO DE PEZ: mínimo 1 y máximo 5!"); return 1; }
			else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, Naranja, "¡No has pescado un pez con numero(1)!"); return 1; }
			else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, Naranja, "¡No has pescado un pez con numero(2)!"); return 1; }
			else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, Naranja, "¡No has pescado un pez con numero(3)!"); return 1; }
			else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, Naranja, "¡No has pescado un pez con numero(4)!"); return 1; }
			else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, Naranja, "¡No has pescado un pez con numero(5)!"); return 1; }
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
   			Fishes[playerid][pFishID] = 0;
		}
		return 1;
	}
 	if(strcmp(cmd,"/tirarpez",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(Fishes[playerid][pLastFish] > 0)
	        {
	            ClearFishID(playerid, Fishes[playerid][pLastFish]);
	            Fishes[playerid][pLastFish] = 0;
	            Fishes[playerid][pFishID] = 0;
	        }
	        else
	        {
	            SendClientMessage(playerid, Rojo, "¡Aun no has pescado nada!");
	            return 1;
	        }
	    }
	    return 1;
 	}
 	if(strcmp(cmd,"/tirarpesca",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(Fishes[playerid][pWeight1] > 0 || Fishes[playerid][pWeight2] > 0 || Fishes[playerid][pWeight3] > 0 || Fishes[playerid][pWeight4] > 0 || Fishes[playerid][pWeight5] > 0)
	        {
	            ClearFishes(playerid);
				Fishes[playerid][pLastFish] = 0;
				Fishes[playerid][pFishID] = 0;
	        }
	        else
	        {
	            SendClientMessage(playerid, Rojo, "¡Aun no has pescado nada!");
	            return 1;
	        }
	    }
	    return 1;
 	}
//----------------------------------------------------------------------------------------//
