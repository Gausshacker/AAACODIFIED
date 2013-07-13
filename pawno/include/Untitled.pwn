 if(strcmp(cmd, "/adminhelp", true) == 0 || strcmp(cmd, "/ah", true) == 0 || strcmp(cmd, "/ahelp", true) == 0)
 {
     if(PlayerInfo[playerid][pAdmin] >= 1)
     {

   switch(PlayerInfo[playerid][pAdmin])
   {
    case 1:
    {
     Mensaje(playerid, Verde, "|______________________________________________________________|");
     Mensaje(playerid, Blanco,"{00BE00}[_COLABORADORES_] {FFFFFF}/ah - /rduda - /hide - /darskin - /daruniforme - /hchatadmin");
    }
    case 2:
    {
     SendClientMessage(playerid, Verde, "|________________________________________________________________________________________________________________________________________________________________________________|");
format(string, sizeof(string), "{00BE00}[_MOD_1_] {FFFFFF}/hchatadmin - /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero");
SendClientMessage(playerid, Blanco, string);
format(string, sizeof(string), "{00BE00}[_MOD_1_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /hide - /editgz");
SendClientMessage(playerid, Blanco, string);
format(string, sizeof(string), "{00BE00}[_MOD_1_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
SendClientMessage(playerid, Blanco,string);
format(string, sizeof(string), "{00BE00}[_MOD_1_] {FFFFFF}/afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /adminbloqueo - /healcar - /oldcar - /verllaves - /premiums");
SendClientMessage(playerid, Blanco, string);
    }
    case 3:
    {
     SendClientMessage(playerid, Verde, "|________________________________________________________________________________________________________________________________________________________________________________|");
     SendClientMessage(playerid, Blanco, "{00BE00}[_MOD_2_] {FFFFFF}/hchatadmin - /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero - /editgz");
     SendClientMessage(playerid, Blanco, "{00BE00}[_MOD_2_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /hide - /premiums");
     SendClientMessage(playerid, Blanco, "{00BE00}[_MOD_2_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
     SendClientMessage(playerid, Blanco, "{00BE00}[_MOD_2_] {FFFFFF}/repair - /sethp - /setarmor - /setdinero - /dardinero - /ad - /xgoto - /darequipo - /getcar - /gotocar - /asetcar - /desconectartodos");
     SendClientMessage(playerid, Blanco, "{00BE00}[_MOD_2_] {FFFFFF}/resetllavescoches - /afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /adminbloqueo - /healcar - /oldcar - /verllaves");
    }
    case 4:
    {
     SendClientMessage(playerid, Verde, "|________________________________________________________________________________________________________________________________________________________________________________|");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_3_] {FFFFFF}/hchatadmin -  /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero - /editgz");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_3_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /hide - /premiums");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_3_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_3_] {FFFFFF}/repair - /sethp - /setarmor - /setdinero - /dardinero - /ad - /xgoto - /darequipo - /getcar - /gotocar - /asetcar - /desconectartodos");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_3_] {FFFFFF}/resetllavescoches - /afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /adminbloqueo - /healcar - /oldcar - /verllaves");
    }
    case 5:
    {
     SendClientMessage(playerid, Rosa, "|________________________________________________________________________________________________________________________________________________________________________________|");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_4_] {FFFFFF}/hchatadmin -  /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero - /editgz");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_4_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /hide - /premiums");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_4_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_4_] {FFFFFF}/repair - /sethp - /setarmor - /setdinero - /dardinero - /ad - /xgoto - /darequipo - /getcar - /gotocar - /asetcar - /desconectartodos");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_4_] {FFFFFF}/resetllavescoches - /afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /adminbloqueo - /healcar - /oldcar - /verllaves");
    }
    case 6:
    {
     SendClientMessage(playerid, Verde, "|________________________________________________________________________________________________________________________________________________________________________________|");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_5_] {FFFFFF}/hchatadmin - /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero - /editgz");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_5_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /hide - /premiums");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_5_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_5_] {FFFFFF}/repair - /sethp - /setarmor - /setdinero - /dardinero - /ad - /xgoto - /darequipo - /getcar - /gotocar - /asetcar - /desconectartodos");
     SendClientMessage(playerid, Blanco, "{00BE00}[_GO_5_] {FFFFFF}/resetllavescoches - /afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /adminbloqueo - /healcar - /oldcar - /verllaves");
    }
    case 7:
    {
     SendClientMessage(playerid, Verde, "|________________________________________________________________________________________________________________________________________________________________________________|");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/hchatadmin -  /daruniforme - /adminservicio - /slap - /ajail - /kick - /ban - /banip - /reeducar - /advertir - /mark - /gotomark - /ir - /vermaletero");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/(borrar)dudas - /rduda - /borrarduda - /(borrar)reportes - /verreporte - /borrarreporte - /goto - /teleplayer - /editgz");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/setint - /setvw - /mover - /spec - /verarmas - /con(gelar) - /carinfo - /privados - /pms - /versms - /ao - /check - /verinventario");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/repair - /sethp - /setarmor - /setdinero - /dardinero - /ad - /xgoto - /darequipo - /getp - /getcar - /gotocar - /verllaves");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/crearcoche - /asetcar - /crearcasa - /editcasa - /creanergocio - /editneg - /resetllavescoches - /adminbloqueo - /desconectartodos");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/setstat - /sethabilidad - /haceradmin - /afindcar - /afixpos - /resitecar - /findadmincar - /findteamcar - /healcar - /oldcar - /ip - /desarmar");
     SendClientMessage(playerid, Blanco, "{00BE00}[_DUEÑO_] {FFFFFF}/editaraudio - /crearparking - /editparking - /hacerpremium - /verpremium - /premiums - /atach - /qatach - /rcmd - /dpr - /qpr - /rpr");
    }
   }
  }
  else { SendClientMessage(playerid,Rojo,"* ¡No eres miembro del staff!"); }

  return 1;
 }
