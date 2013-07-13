#include <a_samp>
#include <globalvars>
#include <funciones>
//#include <streamer>
#define MAX_LUZOBJS 200

new vLuz[MAX_VEHICLES];

enum lpInfo
{
	lpType,
	lpCreated,
        Float:lpX,
        Float:lpY,
        Float:lpZ,
        lpObject,
};
new LucesInfo[MAX_LUZOBJS][lpInfo];

Luces_OnPlayerCommandText(playerid, cmdtext[])
{

        new vehicleid = GetPlayerVehicleID(playerid);
	
	if (strcmp(cmdtext,"/barraluces",true) == 0)
	{
		if(PlayerInfo[playerid][pMember] != 1)
                {
                SendClientMessage(playerid, Rojo, "* No eres policia!");
                return 1;
                }
                if(GetVehicleModel(vehicleid) != 411 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 415 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 541 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 560 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 402 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 579 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 596 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 597 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 598)
	        {
                SendClientMessage(playerid, Rojo, "* No estás en un vehículo de policia!");
                return 1;
		}

                if(IsInfernus(playerid))
		{
                if(vLuz[vehicleid] == 1)
                {
                SendClientMessage(playerid, Rojo, "* Este vehículo ya tiene una luz!");
                return 1;
		}
		vLuz[vehicleid] = 1;
	        new Float:VPos[4];
                GetVehiclePos(GetPlayerVehicleID(playerid),VPos[0],VPos[1],VPos[2]);
                CreateLuzObject(1,VPos[0],VPos[1],VPos[2],PlayerInfo[playerid][pMember]);
		}
                return 1;
                }
		
		/*if(GetVehicleModel(vehicleid) == 0)
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
	}*/
	if (strcmp(cmdtext,"/qluces",true) == 0)
	{
            if(PlayerInfo[playerid][pMember] != 1)
            {
            SendClientMessage(playerid, Rojo, "* No eres policia!");
            return 1;
            }
            DeleteClosestLuces(playerid);
	    return 1;
	}
	/*if (strcmp(cmd,"/limpiar",true) == 0)
	{
		if(FuerzaPublica(playerid)==0) { SendClientMessage(playerid, Rojo, "* No eres policia o médico!"); return 1; }
        DeleteAllObjects(playerid);
	    return 1;
	}*/
	return 0;
}

stock CreateLuzObject(tipo, Float:x,Float:y,Float:z)
{
	switch(tipo)
	{
		case 1:
		{
			for(new i = 0; i < sizeof(LucesInfo); i++)
			{
				if(LucesInfo[i][lpCreated] == 0)
				{
					LucesInfo[i][lpType]=tipo;
					LucesInfo[i][lpCreated]=1;
					LucesInfo[i][lpX]=x;
					LucesInfo[i][lpY]=y;
                                        LucesInfo[i][lpZ]=z;
                                        vLuz[vehicleid] = 1;
					LucesInfo[i][lpObject] = CreateObject(18646, x, y, z, 0.0, 0.0, 0.0);
                                        AttachObjectToVehicle(LucesInfo[i][lpObject], GetPlayerVehicleID(i), 0.409729004, 0.526367188, 0.206963539, 0, 0, 0);
					return 1;
				}
			}
		}
		/*case 2:
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
		}*/
	}
  	return 0;
}

/*stock DeleteAllObjects(playerid)
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
}*/

stock DeleteClosestLuces(playerid)
{
    for(new i = 0; i < sizeof(LucesInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 2.0, LucesInfo[i][lpX], LucesInfo[i][lpY], LucesInfo[i][lpZ]) && LucesInfo[i][lpDepartament] == PlayerInfo[playerid][pMember])
        {
  	        if(LucesInfo[i][lpCreated] == 1)
            {
		LucesInfo[i][lpType]=0;
                LucesInfo[i][lpCreated]=0;
                LucesInfo[i][lpX]=0.0;
                LucesInfo[i][lpY]=0.0;
                LucesInfo[i][lpZ]=0.0;
                vLuz[vehicleid] = 0;
                DestroyObject(LucesInfo[i][lpObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

forward IsInfernus(playerid);
public IsInfernus(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 411)
    {
    return 1;
    }
    return 0;
}