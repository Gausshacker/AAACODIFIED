//SISTEMAS DE ROBOS - V1
//Robo al 24/7.
//Robo al banco (pendiente).
//-----------------------------------[ATRACAR 24/7]-------------------------------------------//
new timesrobbed[MAX_PLAYERS];
timesrobbed[playerid] = 0;//colocar en OnPlayerConnect


if(strcmp(cmd, "/atracar", true) == 0)
	{
        if(PlayerToPoint(3, playerid,-28.0,-89.7,1003.5))
		{
			if(timesrobbed[playerid] == 1)
			{
			    SendClientMessage(playerid, Rojo, "¡No puedes atracar 24/7 más de una vez por día!");
			}
			if(timesrobbed[playerid] == 0)
		    {
		        TogglePlayerControllable(playerid, 0);
		        SetTimerEx("Controlar",60000,0,"i",playerid);
		        SendClientMessage(playerid, Rojo,"¡Estás atracando, tardaras 20 segundos!");
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new robmoney = random(400);
          		ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0);
		        timesrobbed[playerid]+=1;
				format(string,sizeof(string), "* %s apunta su arma a la cabeza del dependiente e intenta robar la caja del 24/7.", sendername);
				ProxDetector(30.0, playerid, string, COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES,COLOR_ACCIONES);
  				format(string, sizeof(string), "** Has conseguido robar %d$!",robmoney);
   				SendClientMessage(playerid, Rojo,string);
				SafeGivePlayerMoney(playerid, robmoney);
				SendClientMessage(playerid, Rojo,"¡Has terminado de atracar el 24/7!");
				format(string, sizeof(string), "CENTRAL LAPD: El 24/7 en Los Angeles ha sido atracado!.");
				EnviarMensjeRadioPD(1, 0xFF8282AA, string);
				SendClientMessage(playerid, Rojo, "Has sido visto en las cámaras de seguridad! ¡CORRE ESCAPA!");
 			}
		}
		return 1;
	}

