#include <a_samp>
#include <globalvars>
#include <funciones>
#include <colores>
#include <streamer>
#pragma tabsize 0
new LocalOOC[MAX_PLAYERS];
new Text3D:pDef[MAX_PLAYERS];
new def[MAX_PLAYERS];
new Intento[MAX_PLAYERS];
new Lenguaje[MAX_PLAYERS];
Texto_OnPlayerText(playerid, text[])
{
	new abreviatura[20];
	switch(Lenguaje[playerid])
	{
		case 0: abreviatura = "Nada";
		case 1: abreviatura = "ITA";
		case 2: abreviatura = "RUS";
		case 3: abreviatura = "ARB";
		case 4: abreviatura = "GER";
		case 5: abreviatura = "ESP";
		case 6: abreviatura = "JAP";
		case 7: abreviatura = "FRA";
	}
	if(strlen(text) > 100)
	{
		new string2[128];
		format(string2,256,"... %s.",text[100]);
		strdel(text,100,strlen(text));
		if(Usando[playerid] == 1)
		{
			format(string, sizeof(string), "[Extraño:%d] dice: %s", extranoid[playerid], text);
		}
		else if(strcmp(abreviatura, "nada", true) == 0)
		{
			format(string, sizeof(string), "%s dice: %s", pName(playerid), text);
		}
		else
		{
			format(string, sizeof(string), "[%s] %s dice: %s", abreviatura, pName(playerid), text);
		}
		if(GetPlayerInterior(playerid) > 0)
		{
			ProxDetector(9.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);
			ProxDetector(9.0, playerid, string2,Chat1, Chat2, Chat3, Chat4, Chat5);
		}
		else
		{
			ProxDetector(20.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);
			ProxDetector(20.0, playerid, string2,Chat1, Chat2, Chat3, Chat4, Chat5);
		}
	}	
	if(strlen(text) < 100)
	{
		if(strcmp(abreviatura, "nada", true) == 0 && Usando[playerid] == 1)
		{
			format(string, sizeof(string), "[Extraño:%d] dice: %s", extranoid[playerid], text);
		}
		else if(strcmp(abreviatura, "nada", true) == 0)
		{
			format(string, sizeof(string), "%s dice: %s", pName(playerid), text);
		}
		else
		{
   		format(string, sizeof(string), "[%s] %s dice: %s", abreviatura, pName(playerid), text);
		}
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(9.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);}
		else {
		ProxDetector(20.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);}
	}
	if(gPlayerUsingLoopingAnim[playerid] == 0 && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_NONE)
	{
		new time;
		time = strlen(text) * 50;
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,1,0,0,time,1,1);
		SetTimerEx("LimpiarAnimacion", time, 0, "d", playerid);
	}
	return 1;
}

forward LimpiarAnimacion(playerid);
public LimpiarAnimacion(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1);
}

Texto_OnPlayerConnect(playerid)
{
	DestroyDynamic3DTextLabel(pDef[playerid]);
	PlayerInfo[playerid][pAme] = NOEXISTE;
	def[playerid] = NOEXISTE;
	Lenguaje[playerid] = 0;
	LocalOOC[playerid] = 0;
	Intento[playerid] = 0;
}

Texto_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], tmp[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	
	if(strcmp(cmd, "/suerte", true) == 0 || strcmp(cmd, "/su", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(Intento[playerid] < gettime())
	        {
				new posibilidad = random(100);
				if(posibilidad < 50)
				{
					format(string, sizeof(string), "¡%s ha tenido suerte!", pName(playerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,VerdeClaro, VerdeClaro, VerdeClaro, VerdeClaro, VerdeClaro);}
					else {
					ProxDetector(20.0, playerid, string,VerdeClaro, VerdeClaro, VerdeClaro, VerdeClaro, VerdeClaro);}
				}
				if(posibilidad >= 50)
				{
					format(string, sizeof(string), "%s no ha tenido suerte. ", pName(playerid));
					if(GetPlayerInterior(playerid) > 0) {
					ProxDetector(12.0, playerid, string,Rojo, Rojo, Rojo, Rojo, Rojo);}
					else {
					ProxDetector(20.0, playerid, string,Rojo, Rojo, Rojo, Rojo, Rojo);}
				}
				Intento[playerid]= gettime() + 30;
				printf("%s", string);
			}
			else
			{
				format(string, 128, "* Usa /suerte en %d segundos.", Intento[playerid] - gettime());
				SendClientMessage(playerid, Rojo, string);
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: /me [Acción]");
				return 1;
			}
			if(Usando[playerid] == 1) {
			if(strlen(result) > 100)
			{
		    	new string2[128];
		    	format(string2,256,"... %s.",result[100]);
		    	strdel(result,100,strlen(result));
		    	format(string,128,"[Extraño:%d] %s",extranoid[playerid],result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado,Morado,Morado,Morado,Morado);
				ProxDetector(12.0, playerid, string2,Morado,Morado,Morado,Morado,Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado,Morado,Morado,Morado,Morado);
				ProxDetector(20.0, playerid, string2,Morado,Morado,Morado,Morado,Morado);}
			}
			else if(strlen(result) < 100)
			{
				format(string, sizeof(string), "[Extraño:%d]  %s", extranoid[playerid], result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado,Morado,Morado,Morado,Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado,Morado,Morado,Morado,Morado);}
			}
			}
			else if(strlen(result) > 100)
			{
		    	new string2[128];
		    	format(string2,256,"... %s.",result[100]);
		    	strdel(result,100,strlen(result));
		    	format(string,128,"%s %s",pName(playerid),result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado,Morado,Morado,Morado,Morado);
				ProxDetector(12.0, playerid, string2,Morado,Morado,Morado,Morado,Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado,Morado,Morado,Morado,Morado);
				ProxDetector(20.0, playerid, string2,Morado,Morado,Morado,Morado,Morado);}
			}
			else
			{
				format(string, sizeof(string), "%s %s", pName(playerid),result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string,Morado,Morado,Morado,Morado,Morado);}
				else {
				ProxDetector(20.0, playerid, string,Morado,Morado,Morado,Morado,Morado);}
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/lenguaje", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Gris, "USO: /lenguaje [id]");
				SendClientMessage(playerid, Gris, "0, Inglés; 1, Italiano");
				SendClientMessage(playerid, Gris, "2, Ruso; 3, Árabe");
				SendClientMessage(playerid, Gris, "4, Alemán; 5, Español");
				SendClientMessage(playerid, Gris, "6, Japonés; 7,Francés");
				return 1;
			}
			if(strcmp(result, "0", true)==0)
			{
			    Lenguaje[playerid] = 0;
			}
			if(strcmp(result, "1", true)==0)
			{
			    Lenguaje[playerid] = 1;
			}
			if(strcmp(result, "2", true)==0)
			{
			    Lenguaje[playerid] = 2;
			}
			if(strcmp(result, "3", true)==0)
			{
			    Lenguaje[playerid] = 3;
			}
			if(strcmp(result, "4", true)==0)
			{
			    Lenguaje[playerid] = 4;
			}
			if(strcmp(result, "5", true)==0)
			{
			    Lenguaje[playerid] = 5;
			}
			if(strcmp(result, "6", true)==0)
			{
			    Lenguaje[playerid] = 6;
			}
			if(strcmp(result, "7", true)==0)
			{
			    Lenguaje[playerid] = 7;
			}
			SendClientMessage(playerid, Verde, "Ahora estás hablando en otro idioma.");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/yo", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if(def[playerid] != NOEXISTE)
			{
				format(string,sizeof(string),"Descripción personal: %s",PlayerInfo[playerid][pAme]);
				SendClientMessage(playerid, Naranja, string);
				SendClientMessage(playerid, Amarillo, "Utiliza primero /yob, luego /yo para cambiarlo");
				return 1;
			}
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
				SendClientMessage(playerid, Blanco, "USO: /yo [DESCRIPCION]");
				return 1;
			}
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			format(PlayerInfo[playerid][pAme], 128, "* %s *", result);
			def[playerid] = 1;
			pDef[playerid] = CreateDynamic3DTextLabel(PlayerInfo[playerid][pAme], Morado, X, Y, Z + 2, 15.0, playerid);
			SendClientMessage(playerid, Naranja, PlayerInfo[playerid][pAme]);
		}
	}
	
	if(strcmp(cmd, "/yob", true) == 0)
	{
		DestroyDynamic3DTextLabel(pDef[playerid]);
		def[playerid] = NOEXISTE;
		PlayerInfo[playerid][pAme] = NOEXISTE;
	}
	
	if(strcmp(cmd, "/cme", true) == 0 || strcmp(cmd, "/do", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: /cme [Acción]");
				return 1;
			}
			if(Usando[playerid] == 1) {
			if(strlen(result) > 100)
			{
		    	new string2[128];
		    	format(string2,256,"... %s.",result[100]);
		    	strdel(result,100,strlen(result));
			format(string, 128, "[Extraño:%d]  %s", extranoid[playerid],result);
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);
			ProxDetector(12.0, playerid, string2, Verde,Verde,Verde,Verde,Verde);}
			else {
			ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);
			ProxDetector(12.0, playerid, string2, Verde,Verde,Verde,Verde,Verde);}
			}
			else if(strlen(result) < 100)
			{
				format(string, 128, "[Extraño:%d]  %s", extranoid[playerid], result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
				else {
				ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			}
			return 1;
			}
			else if(strlen(result) > 100)
			{
		    	new string2[128];
		    	format(string2,256,"... %s.",result[100]);
		    	strdel(result,100,strlen(result));
			
				format(string, 128, "[ID:%d] %s", playerid, result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);
				ProxDetector(12.0, playerid, string2, Verde,Verde,Verde,Verde,Verde);}
				else {
				ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);
				ProxDetector(12.0, playerid, string2, Verde,Verde,Verde,Verde,Verde);}
			}

			else if(strlen(result) < 100)
			{
				format(string, 128, "[ID:%d] %s", playerid, result);
				if(GetPlayerInterior(playerid) > 0) {
				ProxDetector(12.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
				else {
				ProxDetector(20.0, playerid, string, Verde,Verde,Verde,Verde,Verde);}
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/cerca", true) == 0 || strcmp(cmd, "/c", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: /(c)erca [Chat Cercano]");
				return 1;
			}
			new abreviatura[20];
			switch(Lenguaje[playerid])
			{
				case 0: abreviatura = "Nada";
				case 1: abreviatura = "ITA";
				case 2: abreviatura = "RUS";
				case 3: abreviatura = "ARB";
				case 4: abreviatura = "GER";
				case 5: abreviatura = "ESP";
				case 6: abreviatura = "JAP";
				case 7: abreviatura = "FRA";
			}
			if(Usando[playerid] == 1)
			{
			format(string, sizeof(string), "[Extraño:%d] susurra: %s", extranoid[playerid], result);
			}
			else if(strcmp(abreviatura, "nada", true) == 0)
			{
				format(string, sizeof(string), "%s susurra: %s", pName(playerid), result);
			}
			else
			{
				format(string, sizeof(string), "[%s] %s susurra: %s", abreviatura, pName(playerid), result);
			}
			if(IsPlayerInAnyVehicle(playerid))
			{
				for(new i=0;i<MAX_PLAYERS;i++)
				{
					if(GetPlayerVehicleID(playerid)==GetPlayerVehicleID(i))
					{
						SendClientMessage(i,Blanco,string);
					}
				}
			}
			else{if(GetPlayerInterior(playerid) > 0) ProxDetector(2.0, playerid, string,Chat1,Chat2,Chat3,Chat4,Chat5); else ProxDetector(4.0, playerid, string,Chat1,Chat2,Chat3,Chat4,Chat5);}
			printf("%s susurra:", pName(playerid), result);
		}
		return 1;
	}
	if(strcmp(cmd, "/local", true) == 0 || strcmp(cmd, "/l", true) == 0 || strcmp(cmd, "/decir", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: (/l)ocal [chat local]");
				return 1;
			}
			new abreviatura[20];
			switch(Lenguaje[playerid])
			{
				case 0: abreviatura = "Nada";
				case 1: abreviatura = "ITA";
				case 2: abreviatura = "RUS";
				case 3: abreviatura = "ARB";
				case 4: abreviatura = "GER";
				case 5: abreviatura = "ESP";
				case 6: abreviatura = "JAP";
				case 7: abreviatura = "FRA";
			}
			if(Usando[playerid] == 1)
			{
			format(string, sizeof(string), "[Extraño:%d] dice: %s", extranoid[playerid], result);
			}
			else if(strcmp(abreviatura, "nada", true) == 0)
			{
				format(string, sizeof(string), "%s dice: %s", pName(playerid), result);
			}
			else
			{
				format(string, sizeof(string), "[%s] %s dice: %s", abreviatura, pName(playerid), result);
			}
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(12.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);}
			else {
			ProxDetector(20.0, playerid, string,Chat1, Chat2, Chat3, Chat4, Chat5);}
			print(string);
		}
		return 1;
	}	
	if(strcmp(cmd, "/gritar", true) == 0 || strcmp(cmd, "/gr", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: (/gr)itar [Chat Local]");
				return 1;
			}
			new abreviatura[20];
			switch(Lenguaje[playerid])
			{
				case 0: abreviatura = "Nada";
				case 1: abreviatura = "ITA";
				case 2: abreviatura = "RUS";
				case 3: abreviatura = "ARB";
				case 4: abreviatura = "GER";
				case 5: abreviatura = "ESP";
				case 6: abreviatura = "JAP";
				case 7: abreviatura = "FRA";
			}
			if(Usando[playerid] == 1)
			{
			format(string, sizeof(string), "[Extraño:%d] grita: ¡%s!", extranoid[playerid], result);
			}
			else if(strcmp(abreviatura, "nada", true) == 0)
			{
				format(string, sizeof(string), "%s grita: ¡%s!", pName(playerid), result);
			}
			else
			{
				format(string, sizeof(string), "[%s] %s grita: ¡%s!", abreviatura, pName(playerid), result);
			}
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(20.0, playerid, string, Blanco,Blanco,Blanco,Chat1,Chat2);}
			else {
			ProxDetector(30.0, playerid, string, Blanco,Blanco,Blanco,Chat1,Chat2);}
			if(gPlayerUsingLoopingAnim[playerid] == 0 && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_NONE)
			{
				OnePlayAnim(playerid,"RIOT","RIOT_shout",4.0,0,0,0,0,0);
			}
			printf("%s grita: %s", pName(playerid), result);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/b", true) == 0)//local ooc
	{
	    if(IsPlayerConnected(playerid))
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
			if(LocalOOC[playerid] == 1 && PlayerInfo[playerid][pAdmin] == 0)
			{
			    format(string, 128, "¡Canal /b permitido cada 5 segundos! (PREMIUM: 3 segundos)");
				SendClientMessage(playerid, Rojo, string);
			    return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, Blanco, "USO: /b [Chat Local OOC]");
				return 1;
			}
			format(string, sizeof(string), "[FJ|ID: %d] %s : (( %s ))", playerid, pName(playerid), result);
			if(GetPlayerInterior(playerid) > 0) {
			ProxDetector(20.0, playerid, string,COLOR_OOCA,COLOR_OOCB,COLOR_OOCC,COLOR_OOCD,COLOR_OOCE);}
			else {
			ProxDetector(20.0, playerid, string,COLOR_OOCA,COLOR_OOCB,COLOR_OOCC,COLOR_OOCD,COLOR_OOCE);}
			LocalOOC[playerid]=1;
			if(PlayerInfo[playerid][pPremiumTipo] == 0) { SetTimerEx("ResetOOC", 5000, 0, "d", playerid); } else { SetTimerEx("ResetOOC", 3000, 0, "d", playerid); }
			printf("(OOC) %s dice: %s", pName(playerid), string);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/f", true) == 0 || strcmp(cmd, "/familia", true) == 0)
	{

	  if(PlayerInfo[playerid][pMember]==0) return SendClientMessage(playerid,Rojo,"No eres de facción");
		
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
			SendClientMessage(playerid, Blanco, "USO: /f [Chat Facción]");
			return 1;
		}
		if(PlayerInfo[playerid][pMember] == 1)
		{
     new Rango[45];
    if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 0) Rango = "Cadete";
	else if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 1) format(Rango,sizeof(Rango),"%d",PlayerInfo[playerid][pRank]);
	else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 1) Rango = "Cadete";
	else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial I";
	else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial II";
	else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial III";
	else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento I";
	else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento II";
	else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective I";
	else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective II";
	else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective III";
	else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente I";
	else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente II";
	else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán I";
	else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán II";
	else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán III";
	else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 1) Rango = "Comandante";
	else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe I";
	else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe II";
	else if(PlayerInfo[playerid][pRank] == 18 && PlayerInfo[playerid][pMember] == 1) Rango = "Jefe de Policia";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 2)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero I";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero II";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero III";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 2) Rango = "Técnico";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 2) Rango = "Ingeniero";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 2) Rango = "Capitan de bomberos";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe de bomberos";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de bomberos ";
		else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 2) Rango = "Pasante";
		else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 2) Rango = "Paramedico";
		else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 2) Rango = "Enfermera";
		else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico";
		else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico general";
		else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe médico";
		else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe del hospital";
		else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de hospital";
		else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 2) Rango = "Director de LAED";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 5)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 5) Rango = "Político (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 5) Rango = "Secretario/a";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 5) Rango = "Fiscal";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 5) Rango = "Guardaespaldas";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 5) Rango = "Juez";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 5) Rango = "Sub-director";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 5) Rango = "Director";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 4)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 4) Rango = "Becario (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 4) Rango = "Becario";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 4) Rango = "Reportero";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 4) Rango = "Redactor";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 4) Rango = "Jefe de redacción";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 4) Rango = "Gestor de fuentes";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 4) Rango = "Presentador";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 4) Rango = "Sub-director";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 4) Rango = "Director";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 50)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 50) Rango = "Asociado (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 50) Rango = "Mademan";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 50) Rango = "Soldier";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 50) Rango = "Old Soldier";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 50) Rango = "Advisor";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 50) Rango = "Captain";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 50) Rango = "Consigliere";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 50) Rango = "Street Boss";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 50) Rango = "The Boss";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 6)
		{
			new Rango[20];
			if(PlayerInfo[playerid][pRank] > 0 && PlayerInfo[playerid][pRank] < 6) Rango = "Ayudante";
			else if(PlayerInfo[playerid][pRank] == 6) Rango = "Sheriff";
			format(string, sizeof(string), "**((%s %s: %s ))**", Rango, pName(playerid), result);
		}
		else format(string, sizeof(string), "**(( %s: %s ))**", pName(playerid), result);
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 6)
		{
			SendFamilyMessage(1, Celeste, string);
			SendFamilyMessage(6, Celeste, string);
		}
		else
		{
			SendFamilyMessage(PlayerInfo[playerid][pMember], Celeste, string);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/fr", true) == 0)
	{
		if(PlayerInfo[playerid][pWalkies] == 0 || PlayerInfo[playerid][pFrecuencia] == 0)
		{
			SendClientMessage(playerid, Rojo, "* Debes tener el equipo de radio y estar conectado a una frecuencia.");
			return 1;
		}
	
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
			SendClientMessage(playerid, Blanco, "USO: /fr [Canal de Radio]");
			return 1;
		}
		
		format(string, sizeof(string), "** %s: %s. ", pName(playerid), result);

		for(new i ; i < MAX_PLAYERS; i++)
		{		
			if(!IsPlayerConnected(i)) continue;
			
			if(PlayerInfo[i][pWalkies] == 0) continue;
			
			if(PlayerInfo[i][pFrecuencia] == PlayerInfo[playerid][pFrecuencia])
			{
				SendClientMessage(i, AzulOscuro, string);
				continue;
			}
		}
		
		format(string, sizeof(string), "[RADIO: %d]: %s. ",playerid, result);
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(2.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		else {
		ProxDetector(4.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		
		return 1;
	}
	
	if(strcmp(cmd, "/r", true) == 0 || strcmp(cmd, "/radio", true) == 0)
	{
		if(FuerzaPublica(playerid)==0)
		{
		return SendClientMessage(playerid,Rojo,"¡No eres de una fuerza pública!");
		}
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 5)
		{
			if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* ¡No estás de servicio! (/deservicio)"); return 1; }
		}
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
			SendClientMessage(playerid, Blanco, "USO: /r [Canal de Radio]");
			return 1;
		}
		if(PlayerInfo[playerid][pMember] == 1)
		{
		new Rango[45];
    if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 0) Rango = "Ninguno";
	else if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 1) format(Rango,sizeof(Rango),"%d",PlayerInfo[playerid][pRank]);
	else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 1) Rango = "Cadete";
	else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial I";
	else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial II";
	else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial III";
	else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento I";
	else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento II";
	else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective I";
	else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective II";
	else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective III";
	else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente I";
	else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente II";
	else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán I";
	else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán II";
	else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán III";
	else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 1) Rango = "Comandante";
	else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe I";
	else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe II";
	else if(PlayerInfo[playerid][pRank] == 18 && PlayerInfo[playerid][pMember] == 1) Rango = "Jefe de Policia";
			format(string, sizeof(string), "**%s %s: %s ", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 2)
		{
			new Rango[25];
		if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero I";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero II";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero III";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 2) Rango = "Técnico";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 2) Rango = "Ingeniero";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 2) Rango = "Capitan de bomberos";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe de bomberos";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de bomberos ";
		else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 2) Rango = "Pasante";
		else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 2) Rango = "Paramedico";
		else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 2) Rango = "Enfermera";
		else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico";
		else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico general";
		else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe médico";
		else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe del hospital";
		else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de hospital";
		else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 2) Rango = "Director de LAED";
			format(string, sizeof(string), "** %s %s: %s. ", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 4)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 4) Rango = "Becario (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 4) Rango = "Becario";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 4) Rango = "Reportero";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 4) Rango = "Redactor";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 4) Rango = "Jefe de redacción";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 4) Rango = "Gestor de fuentes";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 4) Rango = "Presentador";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 4) Rango = "Sub-director";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 4) Rango = "Director";
			format(string, sizeof(string), "** %s %s: %s.", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 5)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 5) Rango = "Político (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 5) Rango = "Secretario/a";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 5) Rango = "Fiscal";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 5) Rango = "Guardaespaldas";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 5) Rango = "Juez";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 5) Rango = "Sub-director";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 5) Rango = "Director";
			format(string, sizeof(string), "** %s %s: %s.", Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 6)
		{
			new Rango[20];
			if(PlayerInfo[playerid][pRank] > 0 && PlayerInfo[playerid][pRank] < 6) Rango = "Ayudante";
			else if(PlayerInfo[playerid][pRank] == 6) Rango = "Sheriff";
			format(string, sizeof(string), "** %s %s: %s. ", Rango, pName(playerid), result);
		}
		else format(string, sizeof(string), "** %s: %s. ", pName(playerid), result);
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 6)
		{
			SendFamilyMessageOnDuty(PlayerInfo[playerid][pMember], 0x8D8DFF00, string);
		}
		else SendFamilyMessage(PlayerInfo[playerid][pMember], 0x8D8DFF00, string);
		format(string, sizeof(string), "[RADIO: %d]: %s. ",playerid,result);
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(3.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		else {
		ProxDetector(5.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		return 1;
	}
	
	if(strcmp(cmd, "/d", true) == 0 || strcmp(cmd, "/departamento", true) == 0)
	{
		if(FuerzaPublica(playerid) == 0) { SendClientMessage(playerid, Rojo, "* No eres de fuerza publica");	return 1; }
		if(PlayerInfo[playerid][pDuty] == 0) { SendClientMessage(playerid, Rojo, "* No estás de servicio! (/deservicio)");	return 1; }	
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
			SendClientMessage(playerid, Blanco, "USO: /d [Canal de Radio]");
			return 1;
		}
		if(PlayerInfo[playerid][pMember] == 1)
		{
		new Rango[45];
	if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 0) Rango = "Ninguno";
	else if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 1) format(Rango,sizeof(Rango),"%d",PlayerInfo[playerid][pRank]);
	else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 1) Rango = "Cadete";
	else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial I";
	else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial II";
	else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 1) Rango = "Oficial III";
	else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento I";
	else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 1) Rango = "Sargento II";
	else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective I";
	else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective II";
	else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 1) Rango = "Detective III";
	else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente I";
	else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 1) Rango = "Teniente II";
	else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán I";
	else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán II";
	else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 1) Rango = "Capitán III";
	else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 1) Rango = "Comandante";
	else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe I";
	else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 1) Rango = "Subjefe II";
	else if(PlayerInfo[playerid][pRank] == 18 && PlayerInfo[playerid][pMember] == 1) Rango = "Jefe de Policia";
			format(string, sizeof(string), "** [DEPARTAMENTO ESTATAL] %s %s: %s. ",  Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 2)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero I";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero II";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 2) Rango = "Bombero III";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 2) Rango = "Técnico";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 2) Rango = "Ingeniero";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 2) Rango = "Capitan de bomberos";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe de bomberos";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de bomberos ";
		else if(PlayerInfo[playerid][pRank] == 9 && PlayerInfo[playerid][pMember] == 2) Rango = "Pasante";
		else if(PlayerInfo[playerid][pRank] == 10 && PlayerInfo[playerid][pMember] == 2) Rango = "Paramedico";
		else if(PlayerInfo[playerid][pRank] == 11 && PlayerInfo[playerid][pMember] == 2) Rango = "Enfermera";
		else if(PlayerInfo[playerid][pRank] == 12 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico";
		else if(PlayerInfo[playerid][pRank] == 13 && PlayerInfo[playerid][pMember] == 2) Rango = "Medico general";
		else if(PlayerInfo[playerid][pRank] == 14 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe médico";
		else if(PlayerInfo[playerid][pRank] == 15 && PlayerInfo[playerid][pMember] == 2) Rango = "Subjefe del hospital";
		else if(PlayerInfo[playerid][pRank] == 16 && PlayerInfo[playerid][pMember] == 2) Rango = "Jefe de hospital";
		else if(PlayerInfo[playerid][pRank] == 17 && PlayerInfo[playerid][pMember] == 2) Rango = "Director de LAED";
		format(string, sizeof(string), "** [DEPARTAMENTO ESTATAL] %s %s: %s. ",  Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 5)
		{
		new Rango[25];
		if(PlayerInfo[playerid][pRank] == 0 && PlayerInfo[playerid][pMember] == 5) Rango = "Político (sin rango)";
		else if(PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pMember] == 5) Rango = "Secretario/a";
		else if(PlayerInfo[playerid][pRank] == 2 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pMember] == 5) Rango = "Abogado";
		else if(PlayerInfo[playerid][pRank] == 4 && PlayerInfo[playerid][pMember] == 5) Rango = "Fiscal";
		else if(PlayerInfo[playerid][pRank] == 5 && PlayerInfo[playerid][pMember] == 5) Rango = "Guardaespaldas";
		else if(PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pMember] == 5) Rango = "Juez";
		else if(PlayerInfo[playerid][pRank] == 7 && PlayerInfo[playerid][pMember] == 5) Rango = "Sub-director";
		else if(PlayerInfo[playerid][pRank] == 8 && PlayerInfo[playerid][pMember] == 5) Rango = "Director";
		format(string, sizeof(string), "** [DEPARTAMENTO ESTATAL] %s %s: %s. ",  Rango, pName(playerid), result);
		}
		else if (PlayerInfo[playerid][pMember] == 6)
		{
			new Rango[20];
			if(PlayerInfo[playerid][pRank] > 0 && PlayerInfo[playerid][pRank] < 6) Rango = "Ayudante";
			else if(PlayerInfo[playerid][pRank] == 6) Rango = "Sheriff";
			format(string, sizeof(string), "** [DEPARTAMENTO ESTATAL] %s %s: %s. ",  Rango, pName(playerid), result);
		}
		SendFamilyMessage(1, 0xFF8282AA, string);
		SendFamilyMessage(2, 0xFF8282AA, string);
		SendFamilyMessage(9, 0xFF8282AA, string);
		SendFamilyMessage(32, 0xFF8282AA, string);
		SendFamilyMessage(5, 0xFF8282AA, string);
		SendFamilyMessage(6, 0xFF8282AA, string);
		format(string, sizeof(string), "[RADIO: %d] %s. ",playerid, result);
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(3.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		else {
		ProxDetector(5.0, playerid, string, Chat1, Chat2, Chat3, Chat4, Chat5);}
		return 1;
	}

	if(strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
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
				SendClientMessage(playerid, Blanco, "USO: (/a)dmin [Texto]");
				return 1;
			}
			new Rango[24];
			if(PlayerInfo[playerid][pAdmin] == 1) Rango = "Colaborador";
			if(PlayerInfo[playerid][pAdmin] == 2) Rango = "Moderador";
			if(PlayerInfo[playerid][pAdmin] == 3) Rango = "GO 1";
			if(PlayerInfo[playerid][pAdmin] == 4) Rango = "GO 2";
            			if(PlayerInfo[playerid][pAdmin] == 5) Rango = "GO 3";
            			if(PlayerInfo[playerid][pAdmin] == 6) Rango = "Administrador";
            			if(PlayerInfo[playerid][pAdmin] == 7) Rango = "Dueño";
			format(string, sizeof(string), "[%d|FJ|%s] %s: %s", playerid, Rango, pName(playerid), result);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				ABroadCast(Rosa, string, 1);
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/pm", true) == 0 || strcmp(cmd, "/mp", true) == 0 || strcmp(cmd, "/w", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] == 0){
		if(PlayerInfo[playerid][pPmEspera] > 0) { SendClientMessage(playerid,Rojo,"* ¡Espera para mandar otro mensaje privado!"); return 1;} }
		new player1;
		tmp = strtokex(cmdtext, idx);
	    if(!strlen(tmp)) return
		SendClientMessage(playerid, Blanco, "USO: /mp [IdJugador/ParteDelNombre] [Mensaje (OOC)]");
		if(!IsNumeric(tmp))
		player1 = ReturnUser(tmp);
	   	else player1 = strval(tmp);
		
		//if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[player1][pAdmin] == 0) { SendClientMessage(playerid, Rojo, "* ¡Solo puedes usar MP's con administradores"); return 1; }

 		if(IsPlayerConnected(player1))
	 	{
			if(PlayerInfo[playerid][pAdmin] == 0){
			if(PlayerInfo[player1][pHidePms] > 0) { SendClientMessage(playerid,Rojo,"* ¡El jugador tiene los mensajes privados desconectados!"); return 1; }}
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
			if(!strlen(result)) return 	SendClientMessage(playerid, Blanco, "USO: /pm [IdJugador/ParteDelNombre] [Mensaje (OOC)]");
			
			format(string,sizeof(string),"* MP enviado a %s(%d): (( %s ))", pName(player1), player1, (result));
			SendClientMessage(playerid, Amarillo, string);
			
			format(string,sizeof(string),"* MP de %s(%d): (( %s ))", pName(playerid), playerid, (result));
			SendClientMessage(player1, AmarilloClaro, string);
			
			for(new x=0; x<MAX_PLAYERS; x++)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
				{
				format(string,sizeof(string),"[RECON] %s(%d) ha enviado un privado a %s(%d)", pName(playerid), playerid, pName(player1), player1);
				SendClientMessage(x, Amarillo, string);
				format(string,sizeof(string),"Mensaje: (( %s ))",(result));
				SendClientMessage(x, AmarilloClaro, string);
				}
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == player1)
				{
				format(string,sizeof(string),"[RECON] %s(%d) ha recibido un privado de %s(%d)", pName(player1), player1, pName(playerid), playerid);
				SendClientMessage(x, Amarillo, string);
				format(string,sizeof(string),"Mensaje: (( %s ))",(result));
				SendClientMessage(x, AmarilloClaro, string);
				}
				if(PlayerInfo[x][pBigEars] == 1)
				{
				format(string,sizeof(string),"[PMS] %s(%d) ha enviado un privado a %s(%d)", pName(playerid), playerid, pName(player1), player1);
				SendClientMessage(x, Amarillo, string);
				format(string,sizeof(string),"Mensaje: (( %s ))",(result));
				SendClientMessage(x, AmarilloClaro, string);
				}
			}
			
			PlayerInfo[playerid][pPmEspera] = 1;
			SetTimerEx("ResetPM", 5000, 0, "i", playerid);
		}
		else { SendClientMessage(playerid,Rojo,"ERROR: Jugador no conectado."); return 1; }
		return 1;
	}
	
	return 0;
}

forward ResetPM(playerid);
public ResetPM(playerid)
{
	PlayerInfo[playerid][pPmEspera] = 0;
	return 1;
}

forward ResetOOC(playerid);
public ResetOOC(playerid)
{
	LocalOOC[playerid] = 0;
	return 1;
}
