#include <a_samp>
#include <globalvars>
#include <funciones>
#include <colores>

new EnHora;
new Ingresos[MAX_PLAYERS];
new Cobros[MAX_PLAYERS];

DetectarHora()
{
	new hora, minuto, segundo;
	gettime(hora, minuto, segundo);
	SetWorldTime(hora);
	SetTimer("HoraEnPunto", 30000, 1);
	
	Textdraw0 = TextDrawCreate(609.000000, 28.000000, "__");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 1);
	TextDrawLetterSize(Textdraw0, 0.560000, 0.599999);
	TextDrawColor(Textdraw0, -1);
	TextDrawSetOutline(Textdraw0, 0);
	TextDrawSetProportional(Textdraw0, 1);
	TextDrawSetShadow(Textdraw0, 1);
	TextDrawUseBox(Textdraw0, 1);
	TextDrawBoxColor(Textdraw0, 255);
	TextDrawTextSize(Textdraw0, 545.000000, 16.000000);

	Textdraw1 = TextDrawCreate(550.000000, 30.000000, "__");
	TextDrawBackgroundColor(Textdraw1, 255);
	TextDrawFont(Textdraw1, 1);
	TextDrawLetterSize(Textdraw1, 0.560000, 0.199999);
	TextDrawColor(Textdraw1, -1);
	TextDrawSetOutline(Textdraw1, 0);
	TextDrawSetProportional(Textdraw1, 1);
	TextDrawSetShadow(Textdraw1, 1);
	TextDrawUseBox(Textdraw1, 1);
	TextDrawBoxColor(Textdraw1, -16777116);
	TextDrawTextSize(Textdraw1, 604.000000, 16.000000);

	Textdraw2 = TextDrawCreate(550.000000, 30.000000, "__");
	TextDrawBackgroundColor(Textdraw2, 255);
	TextDrawFont(Textdraw2, 1);
	TextDrawLetterSize(Textdraw2, 0.560000, 0.199999);
	TextDrawColor(Textdraw2, -1);
	TextDrawSetOutline(Textdraw2, 0);
	TextDrawSetProportional(Textdraw2, 1);
	TextDrawSetShadow(Textdraw2, 1);
	TextDrawUseBox(Textdraw2, 1);
	TextDrawBoxColor(Textdraw2, 16711935);
	TextDrawTextSize(Textdraw2, 563.000000, 19.000000);

	Textdraw3 = TextDrawCreate(550.000000, 30.000000, "__");
	TextDrawBackgroundColor(Textdraw3, 255);
	TextDrawFont(Textdraw3, 1);
	TextDrawLetterSize(Textdraw3, 0.560000, 0.199999);
	TextDrawColor(Textdraw3, -1);
	TextDrawSetOutline(Textdraw3, 0);
	TextDrawSetProportional(Textdraw3, 1);
	TextDrawSetShadow(Textdraw3, 1);
	TextDrawUseBox(Textdraw3, 1);
	TextDrawBoxColor(Textdraw3, 16711935);
	TextDrawTextSize(Textdraw3, 582.000000, 19.000000);

	Textdraw4 = TextDrawCreate(550.000000, 30.000000, "__");
	TextDrawBackgroundColor(Textdraw4, 255);
	TextDrawFont(Textdraw4, 1);
	TextDrawLetterSize(Textdraw4, 0.560000, 0.199999);
	TextDrawColor(Textdraw4, -1);
	TextDrawSetOutline(Textdraw4, 0);
	TextDrawSetProportional(Textdraw4, 1);
	TextDrawSetShadow(Textdraw4, 1);
	TextDrawUseBox(Textdraw4, 1);
	TextDrawBoxColor(Textdraw4, 16711935);
	TextDrawTextSize(Textdraw4, 604.000000, 19.000000);
	return 1;
}

forward HoraEnPunto();
public HoraEnPunto() //Payday()
{
	new hora, minuto, segundo;
	gettime(hora, minuto, segundo);
	if(minuto == 0)
	{
		if(EnHora == 1) { EnHora = 0; return 0; }
		EnHora=1;
		if(hora == 0 || hora == 12) { ReabastecerNegocios(); }
		SetWorldTime(hora);
		cantidadarmas = 0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(!IsPlayerConnected(i) || PlayerInfo[i][pJugando] == 0) continue;
			format(string, 128, "* Hora %02d:00", hora);
			SendClientMessage(i, Blanco, string);
			if(PlayerInfo[i][pMinuto] >= 20)
			{
				ComprobarNivel(i);
				ComprobarContrato(i);
				Abstinencia(i);
			}			
			Sueldo(i);
			AccionesNegocios(i);
		}
		return 1;
	}
	EnHora=0;
	return 0;
}

Horas_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], tmp[128], idx;
	cmd = strtokex(cmdtext, idx);
	if(strcmp(cmd, "/reloj", true) == 0)
	{
		new hora, minuto, segundo;
		gettime(hora, minuto, segundo);
		format(tmp, 128, "%02d:%02d", hora, minuto);
		GameTextForPlayer(playerid, tmp, 5000, 1);
		format(string, sizeof(string), "* %s consulta su reloj.", pName(playerid));
		if(GetPlayerInterior(playerid) > 0) {
		ProxDetector(12.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
		else {
		ProxDetector(20.0, playerid, string,Morado, Morado, Morado, Morado, Morado);}
		ApplyAnimation(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,0,0,0,0);
		if(PlayerInfo[playerid][pJailed] == 2)
	    {		
			format(string,sizeof(string),"* Faltan %d Minuto(s) para que acabe tu encarcelamiento OOC.",PlayerInfo[playerid][pJailTime]);
			SendClientMessage(playerid,Amarillo,string);
		}
		if(PlayerInfo[playerid][pJailed] == 1 || PlayerInfo[playerid][pJailed] == 3)
	    {		
			format(string,sizeof(string),"* Faltan %d Minuto(s) para que acabe tu encarcelamiento IC.",PlayerInfo[playerid][pJailTime]);
			SendClientMessage(playerid,Amarillo,string);
		}
                if(PlayerInfo[playerid][pJailed] == 5)
	    {		
			format(string,sizeof(string),"* Faltan %d Hora(s) para que acabe tu encarcelamiento IC.",PlayerInfo[playerid][pJailTime]);
			SendClientMessage(playerid,Amarillo,string);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/tiempo", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
			SendClientMessage(playerid, Rojo, "* No formas parte del Staff! ");
			return 1;
		}
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtokex(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, Gris, "USO: /tiempo [Tiempo del dia] (0-23)");
				return 1;
			}
			new HoraActual = strval(tmp);
	        SetWorldTime(HoraActual);
			format(string, sizeof(string), "* Tiempo ajustado a %d Horas.", HoraActual);
			SendClientMessageToAll(Blanco, string);
		}
		return 1;
	}
	return 0;
}



Abstinencia(playerid)
{
	if(PlayerInfo[playerid][pAbstinencia] == 2)
	{
		format(string, 128, "* %s comienza a temblar", pName(playerid));
		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
		new Float:Vida;
		GetPlayerHealth(playerid, Vida);
		SetPlayerHealth(playerid, Vida-25);
		ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1,1,1,1,1,1);
		TogglePlayerControllable(playerid, 0);
		SetTimerEx("Descongelar", 60000, 0, "d", playerid);
		SetPlayerDrunkLevel(playerid, 1560);
	}
}

Sueldo(playerid)
{
	if(PlayerInfo[playerid][pMinuto] < 20)
	{
		SendClientMessage(playerid, Naranja, "* No has jugado lo suficiente como para recibir los ingresos.");
	}
	Ingresos[playerid] = 0;
	Cobros[playerid] = 0;
	SendClientMessage(playerid, Blanco, "________ FACTURA DE PAGO ________");
	if(PlayerInfo[playerid][pMinuto] >= 20)
	{
		if(PlayerInfo[playerid][pMember] > 10 || PlayerInfo[playerid][pMember] == 0)
        {
            if (PlayerInfo[playerid][pJob] > 0)
            {
                new sueldo;
                switch(PlayerInfo[playerid][pJob])
                {

                    case 4, 5, 6, 8: sueldo=100;
                    case 9:             sueldo=500;
                    case 7:             sueldo=380;
                    case 10:            sueldo=300;
                    default:            sueldo=0;
                }
                sueldo += 50 * (GetPlayerLevel(playerid) - 1);
                if (sueldo>0)
                {
					new agregado;
					if(PremiumValido(playerid,1))
					{
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,2))
					{
						agregado = 350;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,3))
					{
						agregado = 500;
						sueldo += agregado;
					}
					if(agregado > 0)
					{
						format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
						SendClientMessage(playerid, Blanco,string);
					}
                    Ingresos[playerid]+=sueldo;
                    format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                    SendClientMessage(playerid, Blanco,string);
                }
            }
        }
		else
		{
			switch(PlayerInfo[playerid][pMember])
			{
				case 1:
				{
                    new sueldo;
					switch(PlayerInfo[playerid][pRank])
					{
						case 1: sueldo=150;
						case 2: sueldo=350;
						case 3: sueldo=550;
						case 4: sueldo=650;
						case 5: sueldo=700;
						case 6: sueldo=700;
						case 7: sueldo=690;
						case 8: sueldo=720;
						case 9: sueldo=780;
						case 10: sueldo=860;
						case 11: sueldo=890;
						case 12: sueldo=990;
						case 13: sueldo=1020;
						case 14: sueldo=1050;
						case 15: sueldo=1525;
						case 16: sueldo=2005;
						case 17: sueldo=2750;
                        case 18: sueldo=3505;

					}
     			if (sueldo>0)
        		{
						new agregado;
						sueldo += 50 * (GetPlayerLevel(playerid) - 1);
						if(PremiumValido(playerid,1))
						{
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
						}
						else if(PremiumValido(playerid,2))
						{
						agregado = 350;
						sueldo += agregado;
						}
						else if(PremiumValido(playerid,3))
						{
						agregado = 500;
						sueldo += agregado;
						}
						if(agregado > 0)
						{
							format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
							SendClientMessage(playerid, Blanco,string);
						}
                        Ingresos[playerid]+=sueldo;
                        format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                        SendClientMessage(playerid, Blanco,string);
      			}
				}
				case 2, 6, 31:
				{
                    new sueldo;
					switch(PlayerInfo[playerid][pRank])
					{
						case 1: sueldo=250;
						case 2: sueldo=500;
						case 3: sueldo=500;
						case 4: sueldo=500;
						case 5: sueldo=600;
						case 6: sueldo=1000;
						case 7: sueldo=2000;
						case 8: sueldo=2500;
						case 9: sueldo=250;
						case 10: sueldo=500;
						case 11: sueldo=500;
						case 12: sueldo=500;
						case 13: sueldo=600;
						case 14: sueldo=1000;
						case 15: sueldo=2000;
						case 16: sueldo=2500;
						case 17: sueldo=3000;
						
					}
                    if (sueldo>0)
                    {
						new agregado;
						sueldo += 50 * (GetPlayerLevel(playerid) - 1);
                      if(PremiumValido(playerid,1))
					   {
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
					   }
					   else if(PremiumValido(playerid,2))
					    {
						agregado = 350;
					    sueldo += agregado;
					}
					    else if(PremiumValido(playerid,3))
					{
						agregado = 500;
						sueldo += agregado;
					}
						if(agregado > 0)
						{
							format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
							SendClientMessage(playerid, Blanco,string);
						}
                        Ingresos[playerid]+=sueldo;
                        format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                        SendClientMessage(playerid, Blanco,string);
                    }
				}
				case 3, 4:
				{
                    new sueldo;
					switch(PlayerInfo[playerid][pRank])
					{
						case 1: sueldo=750;
						case 2: sueldo=1000;
						case 3: sueldo=1300;
						case 4: sueldo=1500;
						case 5: sueldo=1750;
						case 6: sueldo=2000;
					}
                    if (sueldo>0)
                    {
						new agregado;
						sueldo += 50 * (GetPlayerLevel(playerid) - 1);
						if(PremiumValido(playerid,1))
						{
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
						}
						else if(PremiumValido(playerid,2))
						{
						agregado = 350;
						sueldo += agregado;
						}
						else if(PremiumValido(playerid,3))
						{
						agregado = 500;
						sueldo += agregado;
						}
						if(agregado > 0)
						{
							format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
							SendClientMessage(playerid, Blanco,string);
						}
                        Ingresos[playerid]+=sueldo;
                        format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                        SendClientMessage(playerid, Blanco,string);
                    }
				}
				case 5:
				{
				    new sueldo;
					switch(PlayerInfo[playerid][pRank])
					{
						case 1: sueldo=200;
						case 2: sueldo=290;
						case 3: sueldo=380;
						case 4: sueldo=470;
						case 5: sueldo=560;
						case 6: sueldo=650;
						case 7: sueldo=740;
						case 8: sueldo=1130;
						case 9: sueldo=1520;
						case 10: sueldo=2010;

					}
					new agregado;
                    sueldo += 50 * (GetPlayerLevel(playerid) - 1);
					if(PremiumValido(playerid,1))
					{
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,2))
					{
						agregado = 350;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,3))
					{
						agregado = 500;
						sueldo += agregado;
					}
					if(agregado > 0)
					{
						format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
						SendClientMessage(playerid, Blanco,string);
					}    
                    Ingresos[playerid]+=sueldo;
                    format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                    SendClientMessage(playerid, Blanco,string);
				}
				default:
				{
					new sueldo=1000;
					new agregado;
					sueldo += 50 * (GetPlayerLevel(playerid) - 1);
					if(PremiumValido(playerid,1))
					{
						agregado = (sueldo / 100) * 5;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,2))
					{
						agregado = 350;
						sueldo += agregado;
					}
					else if(PremiumValido(playerid,3))
					{
						agregado = 500;
						sueldo += agregado;
					}
					if(agregado > 0)
					{
						format(string,sizeof(string)," [+] Bonificación - $%d",agregado);
						SendClientMessage(playerid, Blanco,string);
					}  
                    Ingresos[playerid]+=sueldo;
                    format(string,sizeof(string)," [+] Sueldo - $%d",sueldo);
                    SendClientMessage(playerid, Blanco,string);
				}
			}
		}
		if(PlayerInfo[playerid][pPhousekey] != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[GetPlayerHouse(playerid)][hOwner], true) == 0)
		{
			new inqs = 0;
			for (new i=0;i<MAX_PLAYERS;i++)
			{
				if (PlayerInfo[i][pJugando] == 1 && PlayerInfo[i][pPhousekey]==PlayerInfo[playerid][pPhousekey] && i != playerid && IsPlayerConnected(i))
				{
					inqs++;
				}
			}
			if(inqs > 0)
			{
				Ingresos[playerid] += CasaInfo[GetPlayerHouse(playerid)][hPAlq]*inqs;
				format(string,sizeof(string)," [+] Alquiler de la casa - $%d", CasaInfo[GetPlayerHouse(playerid)][hPAlq]*inqs);
				SendClientMessage(playerid, Blanco, string);
			}
		}
		if(Ingresos[playerid] > 0)
		{
			format(string, 128, " - Ingresos totales: $%d", Ingresos[playerid]);
			SendClientMessage(playerid, Blanco, string);
			SendClientMessage(playerid, Blanco, "________________________________");
		}
	}
	if(PlayerInfo[playerid][pFacturaTelefono] > 0)
	{
		format(string, 128, " [-] Factura de teléfono: $%d", (PlayerInfo[playerid][pFacturaTelefono]* 20));
		SendClientMessage(playerid, Blanco, string);
		Cobros[playerid] += (PlayerInfo[playerid][pFacturaTelefono]* 20) ;
		PlayerInfo[playerid][pFacturaTelefono] = 0;
	}
	if(PlayerInfo[playerid][pPhousekey] != NOEXISTE && strcmp(pNameEx(playerid), CasaInfo[GetPlayerHouse(playerid)][hOwner], true) != 0)
	{
        new h= GetPlayerHouse(playerid);
		format(string, 128, " [-] Alquiler de vivienda: $%d", CasaInfo[h][hPAlq]);
		SendClientMessage(playerid, Blanco, string);
		Cobros[playerid] += CasaInfo[h][hPAlq];
        if (strcmp(CasaInfo[h][hOwner],"El Estado",true)!=0 && ReturnUser(CasaInfo[h][hOwner]) == INVALID_PLAYER_ID && CasaInfo[h][hPAlq]>0)
        {  //Jugador no conectado
            new sql[128], row[128];
            format(sql,sizeof(sql),"SELECT Banco FROM Players WHERE Nombre='%s'",CasaInfo[h][hOwner]);
            mysql_query(sql);
            mysql_store_result();
            mysql_fetch_row(row);
            new banco = strval(row) + CasaInfo[h][hPAlq];
            format(sql,sizeof(sql),"UPDATE Players SET Banco=%d WHERE Nombre='%s'",banco,CasaInfo[h][hOwner]); 
            mysql_query(sql);
			mysql_free_result();
        }
    }
	if(Cobros[playerid] > 0)
	{
		format(string, 128, " - Cobros totales: $%d", Cobros[playerid]);
		SendClientMessage(playerid, Blanco, "________________________________");
	}
	format(string, 128, " - Ingreso final: $%d", Ingresos[playerid] - Cobros[playerid]);
	SendClientMessage(playerid, Blanco, string);
	new final = Ingresos[playerid] - Cobros[playerid];
	PlayerInfo[playerid][pBank]+=final;
    PlayerInfo[playerid][pMinuto]=0;
	return 1;
}

ComprobarNivel(playerid)
{
	PlayerInfo[playerid][pRespeto]++;
	if(GetPlayerScore(playerid) != GetPlayerLevel(playerid))
	{
		SetPlayerScore(playerid, GetPlayerLevel(playerid));
		format(string, 128, "~w~Eres nivel ~g~%d", GetPlayerLevel(playerid));
		GameTextForPlayer(playerid, string, 3000, 1);
	}
	SaveValue(playerid, "Respeto", PlayerInfo[playerid][pRespeto]);
	return 1;
}

ReabastecerNegocios()
{
	for(new i; i < MAX_NEGOCIOS; i++)
	{
		if(NegocioInfo[i][nType] == 6){NegocioInfo[i][nProd] = 8000;}
		if(NegocioInfo[i][nType] == 7){NegocioInfo[i][nProd] = 300000;}
		SaveNegocio(i);
	}
}

ComprobarContrato(playerid)
{
	if(PlayerInfo[playerid][pJob] > 0)
	{
		if(PlayerInfo[playerid][pContrato] > 0)
		{
			PlayerInfo[playerid][pContrato] --;
			SaveValue(playerid, "Contrato", PlayerInfo[playerid][pContrato]);
		}
	}
}

AccionesNegocios(playerid)
{
if(PlayerInfo[playerid][pPbiskey] != NOEXISTE)
{
new acciones = NegocioInfo[PlayerInfo[playerid][pPbiskey]][nCosto]/400;
PlayerInfo[playerid][pBank] += acciones;
format(string, sizeof(string), "  Acciones de \"%s\": $%d",NegocioInfo[PlayerInfo[playerid][pPbiskey]][nName], acciones);
SendClientMessage(playerid, Amarillo, string);
}
return 1;
}

