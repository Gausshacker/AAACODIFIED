#include <a_samp>
#include <globalvars>
#include <colores>
#include <funciones>
#include <deathac>




new PreguntadoA[MAX_PLAYERS];
new LicOffer[MAX_PLAYERS];

new Preguntado[MAX_PLAYERS];

LicFalsas_OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[128];
    new tmp[128];
    new idx;
    cmd = strtokex(cmdtext, idx);


	if(strcmp(cmd, "/venderlic", true)==0)
    {
        if(PlayerInfo[playerid][pJob]!=15) { SendClientMessage(playerid,Rojo,"No eres Traficante de Licencias"); return 1; }
        new pname[24];
        new pnome[34];
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /venderlic [playerid] [Licencia]");
			return 1;
		}
		new playa;
		playa = ReturnUser(tmp);
		if(!IsPlayerConnected(playa)) { SendClientMessage(playerid,Rojo,"Ese jugador no esta Jugando!"); return 1; }
		if(GetDistanceBetweenPlayers(playerid,playa) > 7.0) { SendClientMessage(playerid,Rojo,"Ese jugador no esta cerca"); return 1; }
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
		    SendClientMessage(playerid, Blanco, "USO: /venderlic [playerid] [Licencia]");
		    SendClientMessage(playerid, Blanco, "Licencias: Conduccion, Armas");
		    return 1;
		}
		if(strcmp(tmp,"Conduccion",true)==0)
		{
		    if(PlayerInfo[playerid][pCarLic]==0)
		    {
		        Preguntado[playa]=1;
				LicOffer[playa] = playerid;
				SendClientMessage(playa,Verde,"Te han ofrecido una licencia de conducción falsa.");
	   			SendClientMessage(playa,Verde,"Usa /aceptar Licencia");
	   			SendClientMessage(playerid,Amarillo,"Le has ofrecido la licencia de conducción.");
			}
		}
		if(strcmp(tmp,"Armas",true)==0)
		{
  			if(PlayerInfo[playerid][pGunLic]==0)
		    {
		        PreguntadoA[playa]=1;
				LicOffer[playa] = playerid;
				SendClientMessage(playa,Verde,"Te ofrecen una licencia de armas ilegal..");
	   			SendClientMessage(playa,Verde,"Usa /aceptar Licencia si quieres comprarla");
	   			SendClientMessage(playerid,Amarillo,"Le has ofrecido una licencia de armas");
			}
		}
		GetPlayerName(playerid,pname,24);
		GetPlayerName(playa,pnome,24);
		format(string,256,"  %s le ha ofrecido una licencia a %s", pname, pnome);
		ProxDetector(30.0, playerid, string, Morado, Morado, Morado, Morado, Morado);
		return 1;
	}
    
    return 0;
}



