
#include <a_samp> // Funciones basicas del SAMP

#define MDIALOGID 9000 // Dialog del catalogo

enum cmInfo
{
	mNombre[60],
	mObjectId,
	mPrecio,
	Float:cmX,
	Float:cmY,
	Float:cmZ,
	Float:cmAngle,
	Float:mRX,
	Float:mRY,
	Float:mRZ,
}
#define CATALOGO_MUEBLES 2
new CMuebles[CATALOGO_MUEBLES][cmInfo] =
{
	{"Nevera", 1816, 500, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
	{"Sillón", 1817, 500, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000}
};

LoadMuebles()
{
	new sql[80], row[512], count, meliminado;
	format(sql, sizeof(sql), "SELECT COUNT(*) FROM muebles");
	mysql_query(sql);
	mysql_store_result();
	mysql_fetch_row(row);
	count = strval(row);
	
	for (new i=1; i<=count; i++)
	{
		format(sql, sizeof(sql), "SELECT * FROM muebles WHERE id=%d LIMIT 1", i);
	    mysql_query(sql);
	    mysql_store_result();
     	mysql_fetch_row(row);
		split(row, arrCoords, '|');
		meliminado = strval(arrCoords[9]);
		if(meliminado == 0)
		{
			AMuebles[i][mId] = strval(arrCoords[0]);
			AMuebles[i][mX] = strval(arrCoords[1]);
			AMuebles[i][mY] = floatstr(arrCoords[2]);
			AMuebles[i][mZ] = floatstr(arrCoords[3]);
			AMuebles[i][mAngle] = floatstr(arrCoords[4]);
			AMuebles[i][mOwner] = strval(arrCoords[5]);
			AMuebles[i][mMueble] = strval(arrCoords[6]);
			AMuebles[i][mVW] = strval(arrCoords[7]);
			AMuebles[i][mOculto] = strval(arrCoords[8]);
			AMuebles[i][mEliminado] = 0;
			if(AMuebles[i][mOculto] == 0)
			{
				new CMuebleID = AMuebles[i][mMueble];
				new Float:tX,Float:tY,Float:tZ,Float:tRZ;
				tX = floatadd(CMuebles[CMuebleID][cmX],AMuebles[i][mX]);
				tY = floatadd(CMuebles[CMuebleID][cmY],AMuebles[i][mY]);
				tZ = floatadd(CMuebles[CMuebleID][cmZ],AMuebles[i][mZ]);
				tRZ = floatadd(CMuebles[CMuebleID][mRZ],AMuebles[i][mAngle]);
				AMuebles[i][mObject] = CreateDynamicObject(CMuebles[CMuebleID][mObjectId], tX, tY, tZ, CMuebles[CMuebleID][mRX], CMuebles[CMuebleID][mRY], tRZ, AMuebles[i][mVW]);				
			}
			TotalMuebles++;
		}
	}
	mysql_free_result();
	printf("Muebles cargados: %d (MAX: %d)", TotalMuebles, MAX_MUEBLES);
}

MostrarMueble(msqlId)
{
	new i = GetAMuebleByID(msqlId);
	new CMuebleID = AMuebles[i][mMueble];
	new Float:tX,Float:tY,Float:tZ,Float:tRZ;
	tX = floatadd(CMuebles[CMuebleID][cmX],AMuebles[i][mX]);
	tY = floatadd(CMuebles[CMuebleID][cmY],AMuebles[i][mY]);
	tZ = floatadd(CMuebles[CMuebleID][cmZ],AMuebles[i][mZ]);
	tRZ = floatadd(CMuebles[CMuebleID][mRZ],AMuebles[i][mAngle]);
	AMuebles[i][mObject] = CreateDynamicObject(CMuebles[CMuebleID][mObjectId], tX, tY, tZ, CMuebles[CMuebleID][mRX], CMuebles[CMuebleID][mRY], tRZ, AMuebles[i][mVW]);
}

SaveMueble(msqlId)
{
	new amueble = GetAMuebleByID(msqlId);
	new sql[512];
	format(sql, sizeof(sql), "UPDATE muebles SET Owner=%d,X=%f,Y=%f,Z=%f,Angle=%f,Mueble=%d,VW=%d,Oculto=%d,Eliminado=%d WHERE id=%d",
		AMuebles[amueble][mOwner],
		AMuebles[amueble][mX],
		AMuebles[amueble][mY],
		AMuebles[amueble][mZ],
		AMuebles[amueble][mAngle],
		AMuebles[amueble][mMueble],
		AMuebles[amueble][mVW],
		AMuebles[amueble][mOculto],
		AMuebles[amueble][mEliminado],
		AMuebles[amueble][mId]);
	mysql_query(sql);
}

stock GetAMuebleByID(id)
{
	for(new i; i < MAX_MUEBLES; i++)
	{
		if(AMuebles[i][mId] == id)	return i;
	}
	return -1;
}

Muebles_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], tmp[128], idx;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/muebles", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(PlayerInfo[playerid][pAdmin] < 1) return 1;
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /muebles [Ver|Poner|Mover|Quitar|Vender]");
			return 1;
		}

		if(strcmp(tmp, "Ver", true) == 0)
		{
			SendClientMessage(playerid,Azul, "______|- MUEBLES -|______");
			for(new i; i < MAX_MUEBLES_PER_PLAYER; i++)
			{
				if(PlayerInfo[playerid][pMuebles][i] != NOEXISTE)
				{
					new muebleid = GetAMuebleByID(PlayerInfo[playerid][pMuebles][i]);
					if(AMuebles[muebleid][mEliminado] == 0)
					{
						format(string,sizeof(string),"Slot %d: %s",i+1,CMuebles[AMuebles[muebleid][mMueble]][mNombre]);
						if(AMuebles[muebleid][mOculto] == 1) strcat(string," - Sin poner");
						SendClientMessage(playerid,Blanco,string);
					}
				}
			}
		}
		else if(strcmp(tmp, "Poner", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /muebles poner [1/2/3/4/5]");
				return 1;
			}
			new slot, muebleid;
			slot = strval(tmp);
			switch(slot)
			{
				case 1..MAX_MUEBLES_PER_PLAYER:
				{
					muebleid = GetAMuebleByID(PlayerInfo[playerid][pMuebles][slot-1]);
				}
				default:
				{
					SendClientMessage(playerid, Blanco, "USO: /muebles poner [1/2/3/4/5]");
					return 1;
				}
			}
					
			if(muebleid != -1)
			{
				new house = GetPlayerHouse(playerid);
				if(house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0)
				{
					if (PlayerToPoint(100.0, playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
					{
						if(AMuebles[muebleid][mOculto] == 0) { SendClientMessage(playerid, Rojo, "* Ese mueble ya está colocado, quitalo primero!"); return 1;}
						new Float:muX,Float:muY,Float:muZ,Float:muAngle;
						GetPlayerPos(playerid,muX,muY,muZ);
						GetPlayerFacingAngle(playerid,muAngle);
						AMuebles[muebleid][mX] = muX;
						AMuebles[muebleid][mY] = muY;
						AMuebles[muebleid][mZ] = muZ;
						AMuebles[muebleid][mAngle] = muAngle;
						AMuebles[muebleid][mVW] = CasaInfo[house][hId];
						AMuebles[muebleid][mOculto] = 0;
						SaveMueble(AMuebles[muebleid][mId]);
						MostrarMueble(AMuebles[muebleid][mId]);
						SendClientMessage(playerid, Verde, "* Has colocado el mueble!");
					}
					else
					{
						SendClientMessage(playerid, Rojo, "* No estás en tu casa.");
						return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* Tienes que ser el propietario de la casa!");
					return 1;
				}				
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes ningun mueble en ese slot!");
				return 1;
			}
		}
		else if(strcmp(tmp, "Mover", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /muebles mover [1/2/3/4/5]");
				return 1;
			}
			new slot, muebleid;
			slot = strval(tmp);
			switch(slot)
			{
				case 1..MAX_MUEBLES_PER_PLAYER:
				{
					muebleid = GetAMuebleByID(PlayerInfo[playerid][pMuebles][slot-1]);
				}
				default:
				{
					SendClientMessage(playerid, Blanco, "USO: /muebles mover [1/2/3/4/5]");
					return 1;
				}
			}
					
			if(muebleid != -1)
			{
				new house = GetPlayerHouse(playerid);
				if(house != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[house][hOwner], true) == 0)
				{
					if (PlayerToPoint(100.0, playerid,CasaInfo[house][hSx],CasaInfo[house][hSy],CasaInfo[house][hSz]) 
                        && GetPlayerVirtualWorld(playerid)==CasaInfo[house][hId])
					{
						if(AMuebles[muebleid][mOculto] == 1) { SendClientMessage(playerid, Rojo, "* Ese mueble no está colocado, colocalo primero!"); return 1;}
						new CMuebleID = AMuebles[muebleid][mMueble];
						new Float:muX,Float:muY,Float:muZ,Float:muAngle;
						GetPlayerPos(playerid,muX,muY,muZ);
						GetPlayerFacingAngle(playerid,muAngle);
						AMuebles[muebleid][mX] = muX;
						AMuebles[muebleid][mY] = muY;
						AMuebles[muebleid][mZ] = muZ;
						AMuebles[muebleid][mAngle] = muAngle;
						SaveMueble(AMuebles[muebleid][mId]);
						new Float:tX,Float:tY,Float:tZ,Float:tRZ;
						tX = floatadd(CMuebles[CMuebleID][cmX],AMuebles[muebleid][mX]);
						tY = floatadd(CMuebles[CMuebleID][cmY],AMuebles[muebleid][mY]);
						tZ = floatadd(CMuebles[CMuebleID][cmZ],AMuebles[muebleid][mZ]);
						SetDynamicObjectPos(AMuebles[muebleid][mObject], tX, tY, tZ);
						tRZ = floatadd(CMuebles[CMuebleID][mRZ],AMuebles[muebleid][mAngle]);
						SetDynamicObjectRot(AMuebles[muebleid][mObject],CMuebles[CMuebleID][mRX], CMuebles[CMuebleID][mRY], tRZ);
						SendClientMessage(playerid, Verde, "* Has movido el mueble!");
					}
					else
					{
						SendClientMessage(playerid, Rojo, "* No estás en tu casa.");
						return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* Tienes que ser el propietario de la casa!");
					return 1;
				}				
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes ningun mueble en ese slot!");
				return 1;
			}
		}
		else if(strcmp(tmp, "Quitar", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Blanco, "USO: /muebles quitar [1/2/3/4/5]");
				return 1;
			}
			new slot, muebleid;
			slot = strval(tmp);
			switch(slot)
			{
				case 1..MAX_MUEBLES_PER_PLAYER:
				{
					muebleid = GetAMuebleByID(PlayerInfo[playerid][pMuebles][slot-1]);
				}
				default:
				{
					SendClientMessage(playerid, Blanco, "USO: /muebles quitar [1/2/3/4/5]");
					return 1;
				}
			}
					
			if(muebleid != -1)
			{
				if(AMuebles[muebleid][mOculto] == 1) { SendClientMessage(playerid, Rojo, "* Ese mueble ya está quitado!"); return 1;}
				AMuebles[muebleid][mOculto] = 1;
				SaveMueble(AMuebles[muebleid][mId]);
				DestroyDynamicObject(AMuebles[muebleid][mObject]);
				SendClientMessage(playerid, Verde, "* Has quitado el mueble!");
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No tienes ningun mueble en ese slot!");
				return 1;
			}
		}
		else if(strcmp(tmp, "Vender", true) == 0)
		{
			if(NegocioInfo[PlayerInfo[playerid][pNegocio]][nType] == 11 && GetPlayerInterior(playerid) != 0)
			{
				tmp = strtokex(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, Blanco, "USO: /muebles vender [1/2/3/4/5]");
					return 1;
				}
				new slot, muebleid;
				slot = strval(tmp);
				switch(slot)
				{
					case 1..MAX_MUEBLES_PER_PLAYER:
					{
						muebleid = GetAMuebleByID(PlayerInfo[playerid][pMuebles][slot-1]);
					}
					default:
					{
						SendClientMessage(playerid, Blanco, "USO: /muebles vender [1/2/3/4/5]");
						return 1;
					}
				}
						
				if(muebleid != -1)
				{
					if(AMuebles[muebleid][mOculto] == 0) { SendClientMessage(playerid, Rojo, "* Quita primero el mueble de tu casa!"); return 1;}
					AMuebles[muebleid][mEliminado] = 1;
					SaveMueble(AMuebles[muebleid][mId]);
					
					for(new i; i < MAX_MUEBLES_PER_PLAYER; i++)
					{
						if(PlayerInfo[playerid][pMuebles][i] == AMuebles[muebleid][mId])
						{
							PlayerInfo[playerid][pMuebles][i] = NOEXISTE;
							break;
						}
					}
					SaveValues(playerid,"Muebles");
					new CMuebleID = AMuebles[muebleid][mMueble];
					new money = floatround(floatmul(CMuebles[CMuebleID][mPrecio],0.25),floatround_round);
					SafeGivePlayerMoney(playerid,money);
					format(string,sizeof(string),"* Has vendido tu '%s' por %d$.",CMuebles[CMuebleID][mNombre], money);
					SendClientMessage(playerid, Verde, string);
				}
				else
				{
					SendClientMessage(playerid, Rojo, "* No tienes ningun mueble en ese slot!");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, Rojo, "* No estas en la tienda de muebles!");
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, Blanco, "USO: /muebles [Ver|Poner|Mover|Quitar|Vender]");
			return 1;
		}
		return 1;
	}
	return 0;
}

MostrarCatalogoMuebles(playerid)
{
	new muebles[512], item[64];
	for(new i; i < CATALOGO_MUEBLES; i ++)
	{
		format(item,sizeof(item),"%s (%d$)", CMuebles[i][mNombre], CMuebles[i][mPrecio]);
	    strcat(muebles, item);
	    strcat(muebles, "\n");
	}	ShowPlayerDialog(playerid, MDIALOGID, DIALOG_STYLE_LIST, "Catálogo de muebles", muebles, "Comprar", "Cancelar");
}

Muebles_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
    if(dialogid == MDIALOGID)
    {
        if(response == 0)
        {
            TogglePlayerControllable(playerid, 1);
        }
		if(response)
		{
			if(CMuebles[listitem][mPrecio] > SafeGetPlayerMoney(playerid)) { SendClientMessage(playerid,Rojo,"* No tienes suficiente dinero"); TogglePlayerControllable(playerid, 1); return 1;}
			
			new slot = NOEXISTE;
			for(new i; i < MAX_MUEBLES_PER_PLAYER; i++)
			{
				if(PlayerInfo[playerid][pMuebles][i] == NOEXISTE) 
				{
					slot = i;
					break;
				}
			}
			if(slot == NOEXISTE) { SendClientMessage(playerid,Rojo,"* Ya tienes todos los slots de muebles ocupados"); TogglePlayerControllable(playerid, 1); return 1;}
			
			AMuebles[TotalMuebles][mOwner] = PlayerInfo[playerid][pSQLID];
			AMuebles[TotalMuebles][mMueble] = listitem;
			AMuebles[TotalMuebles][mOculto] = 1;
			
			new sql[128];
			format(sql, 128, "INSERT INTO `muebles` (`Owner`, `Mueble`, `Oculto`) VALUES (%d, %d, %d);", AMuebles[TotalMuebles][mOwner], AMuebles[TotalMuebles][mMueble], AMuebles[TotalMuebles][mOculto]);
			mysql_query(sql);
			
			new row[64];
			mysql_query("SELECT id FROM muebles ORDER BY id DESC LIMIT 1");
			mysql_store_result();
			mysql_fetch_row(row);
			new SQLID = strval(row);
			mysql_free_result();
			AMuebles[TotalMuebles][mId] = SQLID;
			TotalMuebles++;
			
			PlayerInfo[playerid][pMuebles][slot] = SQLID;
			SaveValues(playerid,"Muebles");

			SafeGivePlayerMoney(playerid,-CMuebles[listitem][mPrecio]);
			format(string,sizeof(string), "* Has comprado '%s' por %d$, usa /muebles en tu casa.",CMuebles[listitem][mNombre],CMuebles[listitem][mPrecio]);
			SendClientMessage(playerid,Verde,string);
			TogglePlayerControllable(playerid, 1);
		}
		return 1;
    }
	return 0;
}
