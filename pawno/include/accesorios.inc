#include <a_samp>
#include <globalvars>
#include <funciones>
#include <streamer>
#define DIALOG_EQUIPO 29522
#define DIALOG_EQUIPO2 29523
#define MAX_COPOBJS 200






Policias_OnDialogResponse(playerid, dialogid, response, listitem)
{
if(response == 1 && dialogid == DIALOG_EQUIPO)
	{
		
		switch(listitem)
		{
           case 0:
            {
     		DarObjeto(playerid,3,1,1);	//Porra
            DarObjeto(playerid, 23,7,1);  //Taser
     		format(string, 128, "* %s toma su equipamiento como cadete reglamentario.", pName(playerid));
     		ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
			}
            case 1:
            {
			if(PlayerInfo[playerid][pRank]==1) return SendClientMessage(playerid,Rojo,"¡Siendo cadete no puedes tomar este equipamiento!");
			DarObjeto(playerid, 24,7,1);  //Eagle
			DarObjeto(playerid, 3,1,1);	//Porra
			format(string, 128, "* %s retira su equipo de oficial del casillero reglamentario.", pName(playerid));
			ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
			   
			}
            case 2:
            {
            /*SafeGivePlayerWeapon(playerid, 23, 500); //Tazer
            SafeGivePlayerWeapon(playerid, 25, 500); //Shotgun
            SafeGivePlayerWeapon(playerid, 29, 500); //MP5
            SafeGivePlayerWeapon(playerid, 31, 500);	  // M4
            SafeGivePlayerWeapon(playerid, 17, 20);
            SafeGivePlayerWeapon(playerid, 41, 500);   //SPray*/
            SetPlayerSkin(playerid,285);
            format(string, 128, "* %s toma el equipamiento SWAT", pName(playerid));
            ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
			}
            case 3:
            {
			//SafeGivePlayerWeapon(playerid, 24, 500);  //Eagle
			//SafeGivePlayerWeapon(playerid, 41, 500);   //SPray
			format(string, 128, "* %s toma el equipamiento de detective.", pName(playerid));
            ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
            
			}
			case 4:
            {
            
            //SafeGivePlayerWeapon(playerid, 24, 500);  //Eagle
			//SafeGivePlayerWeapon(playerid, 41, 500);   //SPray
			SetPlayerSkin(playerid,282);
            format(string, 128, "* %s retira su equipo de gala del casillero reglamentario.", pName(playerid));
            ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
            
			}
		}
		
		if(response == 1 && dialogid == DIALOG_EQUIPO2)
	    {

		switch(listitem)
		{
           case 0:
            {
     		SafeGivePlayerWeapon(playerid, 42, 900);	//Porra
     		format(string, 128, "* %s retira un extintor de la mesa.", pName(playerid));
     		ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);
			}
		}
		}
		
		
	}
return 1;
}









enum cpInfo
{
	cpType,
	cpCreated,
    Float:cpX,
    Float:cpY,
    Float:cpZ,
    cpObject,
	cpDepartament,
};
new ObjectsInfo[MAX_COPOBJS][cpInfo];

Accesorios_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	new tmp[128];
	
	if (strcmp(cmd,"/cono",true) == 0)
	{
		if(FuerzaPublica(playerid)==0) { SendClientMessage(playerid, Rojo, "* No eres policia o médico!"); return 1; }
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /cono [objeto]");
			SendClientMessage(playerid, AzulClaro, "Objetos disponible: 1.-Clavos, 2.-Cono, 3.-Barrera, 4.-Valla, 5.-Barril");
			SendClientMessage(playerid, AzulClaro, "6.-BarreraMediana, 7.-BarreraPequeña, 8.-CaminoCerrado, 9.-Desvio");
			SendClientMessage(playerid, AzulClaro, "10.-EscaleraChica, 11.-EscaleraGrande");
			return 1;
		}
		
		if(strcmp(tmp, "1", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(1,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
		else if(strcmp(tmp, "2", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(2,plocx,plocy,plocz-0.2,ploca,PlayerInfo[playerid][pMember]);
	    }
		else if(strcmp(tmp, "3", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(3,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
		else if(strcmp(tmp, "4", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(4,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "5", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(5,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "6", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(6,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "7", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(7,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "8", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(8,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "9", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(9,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "10", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(10,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
	    else if(strcmp(tmp, "11", true) == 0)
		{
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			GetPlayerPos(playerid, plocx, plocy, plocz);
			GetPlayerFacingAngle(playerid,ploca);
			CreateCopObject(11,plocx,plocy,plocz,ploca,PlayerInfo[playerid][pMember]);
	    }
		else
		{
			SendClientMessage(playerid, Blanco, "USO: /cono [objeto]");
			SendClientMessage(playerid, AzulClaro, "Objetos disponible: 1.-Clavos, 2.-Cono, 3.-Barrera, 4.-Valla, 5.-Barril");
			SendClientMessage(playerid, AzulClaro, "6.-BarreraMediana, 7.-BarreraPequeña, 8.-CaminoCerrado, 9.-Desvio");
			SendClientMessage(playerid, AzulClaro, "10.-EscaleraChica, 11.-EscaleraGrande");
		}
		return 1;
	}
	if (strcmp(cmd,"/qcono",true) == 0)
	{
		if(FuerzaPublica(playerid)==0) { SendClientMessage(playerid, Rojo, "* No eres policia o médico!"); return 1; }
        DeleteClosestObject(playerid);
	    return 1;
	}
	if (strcmp(cmd,"/limpiar",true) == 0)
	{
		if(FuerzaPublica(playerid)==0) { SendClientMessage(playerid, Rojo, "* No eres policia o médico!"); return 1; }
        DeleteAllObjects(playerid);
	    return 1;
	}
	/*if (strcmp(cmd,"/equipo",true) == 0)
	{
		if(!IsACop(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
	    if(PlayerInfo[playerid][pMember] == 1 && !PlayerToPoint(8,playerid,216.1525,184.7244,1003.0313)) { SendClientMessage(playerid, Rojo, "* No estás en los vestuarios!"); return 1; }
        ShowPlayerDialog(playerid,DIALOG_EQUIPO,DIALOG_STYLE_LIST,"Escoge tu equipo","1.-[LSPD] Cadete\n2.-[LSPD] Oficial\n3.-[LSPD] SWAT\n4.-[LSPD] Detective\n5.-[LSPD] Uniforme de Gala", "Equipar", "Cancelar");
	    return 1;
	}
	if (strcmp(cmd,"/equipofd",true) == 0)
	{
		if(!IsABombero(playerid)) return SendClientMessage(playerid, Rojo, "* No eres policia o médico!");
	    if(PlayerInfo[playerid][pMember] == 9 && !PlayerToPoint(8,playerid,469.2409,240.4124,1025.8359)) { SendClientMessage(playerid, Rojo, "* No estás en los vestuarios!"); return 1; }
        ShowPlayerDialog(playerid,DIALOG_EQUIPO2,DIALOG_STYLE_LIST,"Escoge tu equipo","1.-[LSFD] Extintor", "Equipar", "Cancelar");
	    return 1;
	}*/
	/*if (strcmp(cmd,"/equipo", true) == 0)
	{
		if (!IsACop(playerid) && !IsAMedic(playerid)) { SendClientMessage(playerid, Rojo, "* No eres médico ni policía!"); return 1; }
		else if(PlayerInfo[playerid][pMember] == 1 && !PlayerToPoint(8,playerid,254.9470,76.6220,1003.6406)) { SendClientMessage(playerid, Rojo, "* No estás en los vestuarios!"); return 1; }
		else if(IsAMedic(playerid) && !PlayerToPoint(8,playerid,-345.1156,166.4304,1035.1298)) { SendClientMessage(playerid, Rojo, "* No estás en los vestuarios!"); return 1; }
		else if(PlayerInfo[playerid][pMember] == 1 && !PlayerToPoint(8,playerid,255.3840,76.6392,1003.6406)) { SendClientMessage(playerid, Rojo, "* No estás en los vestuarios!"); return 1; }
        
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp) || !IsNumeric(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /equipo [ID]");
			if(IsACop(playerid))
				SendClientMessage(playerid, Blanco, "1. Taser, 2. Desert Eagle, 3. Escopeta, 4. M4A1, 5. MP5, 6. Rifle, 7. Equipo especial, 8. SprayCan, 9. Porra");
			else
				SendClientMessage(playerid, Blanco, "1. Extintor");
			return 1;
		}
		
		new id,gun,ammo;
		id = strval(tmp);
		switch(id)
		{
			case 1:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 23, 50);
					gun = 23;
					ammo = 50;
				}
				else
				{
					SafeGivePlayerWeapon(playerid, 42, 500);
					gun = 0;
					ammo = 0;
				}
			}
			case 2:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 24, 50);
					gun = 24;
					ammo = 50;
				}
			}
			case 3:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 25, 40);
					gun = 25;
					ammo = 40;
				}
			}
			case 4:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 31, 300);	
					gun = 31;
					ammo = 300;
				}
			}
			case 5:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 29, 300);
					gun = 29;
					ammo = 300;
				}
			}
			case 6:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 34, 100);
					gun = 34;
					ammo = 100;
				}
			}
			case 7:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 16, 10);
					gun = 16;
					ammo = 10;
				}
			}
			case 8:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 41, 500);
					gun = 41;
					ammo = 500;
				}
			}
			case 9:
			{
				if(IsACop(playerid))
				{
					SafeGivePlayerWeapon(playerid, 3, 1);
					gun = 3;
					ammo = 1;
				}
			}
		}
		format(string, sizeof(string), "* Sacaste el equipaje especial de la taquilla.");
		SendClientMessage(playerid, Verde, string);
		GM_SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 100.0);
		if( gun != 0 && ammo != 0)
		{
			new hour,minute,second,year,month,day,gunname[30];
			GetWeaponName(gun,gunname,sizeof(gunname));
			gettime(hour,minute,second);
			getdate(year, month, day);
			new query[128];
			format(query, sizeof(query), "INSERT INTO `logarmas` (`Emisor`, `Receptor`, `Desc`, `Fecha`) VALUES ('Taquilla', '%s', '/equipo | %s | %d','%d:%d:%d | %d-%d-%d')", pNameEx(playerid), gunname, ammo,hour,minute,second,day,month,year);
			mysql_query(query);
		}
		return 1;
	}*/
	
	return 0;
}

forward Accesorios_OnPlayerUpdate(playerid);
public Accesorios_OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        for(new i = 0; i < sizeof(ObjectsInfo); i++)
  	    {
  	        if(IsPlayerInRangeOfPoint(playerid, 3.0, ObjectsInfo[i][cpX], ObjectsInfo[i][cpY], ObjectsInfo[i][cpZ]))
            {
  	            if(ObjectsInfo[i][cpCreated] == 1 && ObjectsInfo[i][cpType] == 1)
  	            {
  	                new panels, doors, lights, tires;
  	                new carid = GetPlayerVehicleID(playerid);
		            GetVehicleDamageStatus(carid, panels, doors, lights, tires);
		            tires = encode_tires(1, 1, 1, 1);
		            UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
  	                return 0;
  	            }
  	        }
  	    }
  	}

	return 1;
}

stock CreateCopObject(tipo, Float:x,Float:y,Float:z,Float:Angle, departament)
{
	switch(tipo)
	{
		case 1:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.7;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(2899, x, y, z-0.9, 0, 0, Angle-90);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 2:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1238, x, y, z-0.5, 0, 0, Angle-90);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 3:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.3;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1423, x, y, z-0.3, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 4:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1422, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
			case 5:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1237, x, y, z-1.0, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 6:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1459, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 7:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1427, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 8:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(3091, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 9:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1425, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 10:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1428, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
		case 11:
		{
			for(new i = 0; i < sizeof(ObjectsInfo); i++)
			{
				if(ObjectsInfo[i][cpCreated] == 0)
				{
					ObjectsInfo[i][cpType]=tipo;
					ObjectsInfo[i][cpCreated]=1;
					ObjectsInfo[i][cpX]=x;
					ObjectsInfo[i][cpY]=y;
					ObjectsInfo[i][cpZ]=z-0.5;
					ObjectsInfo[i][cpObject] = CreateDynamicObject(1437, x, y, z-0.5, 0, 0, Angle);
					ObjectsInfo[i][cpDepartament]=departament;
					return 1;
				}
			}
		}
	}
  	return 0;
}

stock DeleteAllObjects(playerid)
{
    for(new i = 0; i < sizeof(ObjectsInfo); i++)
  	{
  	    if(ObjectsInfo[i][cpCreated] == 1 && ObjectsInfo[i][cpDepartament] == PlayerInfo[playerid][pMember])
  	    {
			ObjectsInfo[i][cpType]=0;
  	        ObjectsInfo[i][cpCreated]=0;
            ObjectsInfo[i][cpX]=0.0;
            ObjectsInfo[i][cpY]=0.0;
            ObjectsInfo[i][cpZ]=0.0;
            DestroyDynamicObject(ObjectsInfo[i][cpObject]);
			ObjectsInfo[i][cpDepartament]=0;
  	    }
	}
    return 0;
}

stock DeleteClosestObject(playerid)
{
    for(new i = 0; i < sizeof(ObjectsInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 2.0, ObjectsInfo[i][cpX], ObjectsInfo[i][cpY], ObjectsInfo[i][cpZ]) && ObjectsInfo[i][cpDepartament] == PlayerInfo[playerid][pMember])
        {
  	        if(ObjectsInfo[i][cpCreated] == 1)
            {
				ObjectsInfo[i][cpType]=0;
                ObjectsInfo[i][cpCreated]=0;
                ObjectsInfo[i][cpX]=0.0;
                ObjectsInfo[i][cpY]=0.0;
                ObjectsInfo[i][cpZ]=0.0;
                DestroyDynamicObject(ObjectsInfo[i][cpObject]);
				ObjectsInfo[i][cpDepartament]=0;
                return 1;
  	        }
  	    }
  	}
    return 0;
}

encode_tires(tires1, tires2, tires3, tires4)
{
	return tires1 | (tires2 << 1) | (tires3 << 2) | (tires4 << 3);
}

stock IsAtVestuarios(playerid)
{
	if(IsACop(playerid))
	{
		if(PlayerToPoint(8.0,playerid,267.1019,119.0340,1004.6172)) return 1;
	}
	if(IsAMedic(playerid))
	{
		if(PlayerToPoint(8.0,playerid,-345.1156,166.4304,1035.1298)) return 1;
	}
	return 0;
}
