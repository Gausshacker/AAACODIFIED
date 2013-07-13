#include <a_samp>
#include <colores>
#include <globalvars>

Cmds_OnInit()
{
	CreateDynamic3DTextLabel("Puesto de perritos calientes de Reggie", Amarillo, 1197.3617,-1730.4441,13.5702+0.2, 20);
	CreateDynamic3DTextLabel("Pulsa ENTER para más información", Gris, 1197.3617,-1730.4441,13.5702, 20);
	
	Ayuda = CreateMenu("Dialogo", 1, 200.0,200.0,200.0,0);
	AddMenuItem(Ayuda, 0, "Que hacer?");
	AddMenuItem(Ayuda, 0, "Transporte y Trabajo");
	AddMenuItem(Ayuda, 0, "Vivienda");
	AddMenuItem(Ayuda, 0, "Salir");
}

Cmds_OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:menuid = GetPlayerMenu(playerid);
	if(menuid == Ayuda)
	{
		switch(row)
		{
			case 0:
			{
				ClearChatbox(playerid,2);
				format(string, 128, "%s dice: Disculpe, soy nuevo en la ciudad ¿Qué debería hacer?", pName(playerid));
				SendClientMessage(playerid, Blanco, string);
				ClearChatbox(playerid,1);
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: Debería ir al ayuntamiento, para conseguir los papeles de residencia...");
				SendClientMessage(playerid, Blanco, "... y de paso contratar un seguro médico por si ocurre algún accidente.");
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: El ayuntamiento está en Pershing Square, justo al este desde aquí.");
				ShowMenuForPlayer(Ayuda, playerid);
			}
			case 1:
			{
				ClearChatbox(playerid,2);
				format(string, 128, "%s dice: ¿Sabe dónde puedo encontrar transporte y un empleo?", pName(playerid));
				SendClientMessage(playerid, Blanco, string);
				ClearChatbox(playerid,1);
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: Aquí mismo tiene una parada de taxis, no son caros, son muy amables y...");
				SendClientMessage(playerid, Blanco, "... además le podrán ayudar a encontrar lo que necesite, como por ejemplo un empleo.");
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: Para solicitar un empleo, busque a la persona encargada y procure causarle una buena impresión.");
				ShowMenuForPlayer(Ayuda, playerid);
			}
			case 2:
			{
				ClearChatbox(playerid,2);
				format(string, 128, "%s dice: ¿Dónde puedo encontrar una vivienda?", pName(playerid));
				SendClientMessage(playerid, Blanco, string);
				ClearChatbox(playerid,1);
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: Puede alquilar una habitación de hotel, o bien puede buscar una casa en alquiler y pedir un contrato.");
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: Dormir bajo un techo es importante, si duermes en la calle seguramente te atraquen mientras...");
				SendClientMessage(playerid, Blanco, "... duermes o cojas alguna enfermedad.");
				ShowMenuForPlayer(Ayuda, playerid);
			}
			case 3:
			{
				ClearChatbox(playerid,2);
				format(string, 128, "%s dice: No quiero nada, esos perritos tienen mala pinta...", pName(playerid));
				SendClientMessage(playerid, Blanco, string);
				ClearChatbox(playerid,1);
				SendClientMessage(playerid, Blanco, "Reggie Smith dice: No le culpo, yo tampoco me comería esta bazofia. Adiós y ¡buena suerte!");
				HideMenuForPlayer(Ayuda, playerid);
				TogglePlayerControllable(playerid, 1);
			}
		}
	}
}

Cmds_OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128];
	new idx;
	cmd = strtokex(cmdtext, idx);

	if(strcmp(cmd, "/stats", true) == 0)
	{
		GetPlayerStats(playerid,playerid);
		return 1;
	}
	if(strcmp(cmd, "/premium", true) == 0)
	{
		if(GetPlayerPremium(playerid) == 0) return 1;
		VerPremium(playerid,playerid);
		return 1;
	}
	if(strcmp(cmd, "/mitrabajo", true) == 0)
	{
		if(PlayerInfo[playerid][pMember] == 1) // LSPD
		{
			ClearChatbox(playerid,1);
			format(string,sizeof(string),"LSPD - Comandos:");
			SendClientMessage(playerid,AzulClaro,string);
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio, /(d)epartamentos, /m(megáfono), /forzar");
			SendClientMessage(playerid,Blanco,"/deservicio, /uniforme, /marcar, /poner, /sacar, /limpiar, /equipo, /dlicarmas, /qlicarmas, /dpl, /qpl");
			SendClientMessage(playerid,Blanco,"/quitar, /cachear, /arrestar, /desarrestar, /multa, /cuerda, /soltar, /esposar, /detener, /revisarcinturon");
			SendClientMessage(playerid,Blanco,"/dlicarmas, /qlicarmas, /solicitarabogado, /taser, /qtaser, /multarcoche, /sir, /barraluces, /scanner,");
			SendClientMessage(playerid,Blanco,"/abrirceldas, /cerrarceldas, /entrarcarcel, /salircarcel, /escop (BALAS DE GOMA) /multarcoche");
			SendClientMessage(playerid,Blanco,"/arrestarp, /liberarp, /presos, /condena, /acondena, /bloquearpeajes, /abrirpeajes, /cochecarcel, /salircochecarcel");
			SendClientMessage(playerid,Blanco,"/poner /qcono /qtodosconos");
		}
		else if(PlayerInfo[playerid][pMember] == 2) // LSMD
		{
			ClearChatbox(playerid,1);
			format(string,sizeof(string),"Médicos  - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio, /(d)epartamentos, /m(megáfono), /marcar");
			SendClientMessage(playerid,Blanco,"/deservicio, /uniforme, /marcar, /poner, /sacar, /limpiar, /equipo");
			SendClientMessage(playerid,Blanco,"/informes, /informe, /(subir/bajar)am, /reanimar, /curar,/aincendio");
			SendClientMessage(playerid,AzulClaro,"Bomberos - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio, /(d)epartamentos, /m(megáfono), /rescatarbomberos");
			SendClientMessage(playerid,Blanco,"/deservicio, /uniforme, /marcar, /equipo /informesbomberos");
			SendClientMessage(playerid,Blanco,"/informebombero /curarbomberos /reanimarbomberos /gfd /efd ");
			SendClientMessage(playerid,Blanco,"/fuego /sacarfuego /sacartfuego (TODOS) /barrerafd  ");
			SendClientMessage(playerid,Blanco,"/poner /qcono /qtodosconos");
		}
		else if(PlayerInfo[playerid][pMember] == 3) // LSTD
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"LSTD - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio");
			SendClientMessage(playerid,Blanco,"/tarifa,/mtaxi");
		}
		else if(PlayerInfo[playerid][pMember] == 4) // LNEWS
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"LSNEWS - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio");			
			SendClientMessage(playerid,Blanco,"/(n)oticias, /directo");
		}
		else if(PlayerInfo[playerid][pMember] == 5) // LASC	
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"LASC - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio");			
			SendClientMessage(playerid,Blanco,"/mostrar [credencial] /equipamiento");
		}
		else if(PlayerInfo[playerid][pMember] == 6) // Sheriff
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Sheriff - Comandos:");
			SendClientMessage(playerid,Blanco,"/(f)acción, /(r)adio, /(d)epartamentos, /m(megáfono), /forzar");
			SendClientMessage(playerid,Blanco,"/deservicio, /uniforme, /marcar, /poner, /sacar, /limpiar, /equipo, /qpl");
			SendClientMessage(playerid,Blanco,"/quitar, /cachear, /arrestar, /multa, /cuerda, /soltar, /esposar, /detener");
		}
		else if(PlayerInfo[playerid][pJob] == 0) { SendClientMessage(playerid,Naranja,"* No tienes ningún trabajo actualmente."); return 1; }
		else if(PlayerInfo[playerid][pJob] == 1) // Mecanico
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Mecánico - Comandos:");
			SendClientMessage(playerid,Blanco,"/reparar /rellenar /repintar /modificar /grua");
			new habilidad = PlayerInfo[playerid][pHabilidadMecanico];
			new restante;
			if(habilidad < 10)
			{
				restante = 10 - habilidad;
			}
			else if(habilidad < 20)
			{
					restante = 20 - habilidad;
			}
			else if(habilidad < 50)
			{
					restante = 50 - habilidad;
			}
			else if(habilidad < 100)
			{
				restante = 100 - habilidad;
			}
			else if(habilidad >= 100)
			{
				restante = 0;
			}
			SendClientMessage(playerid,AzulClaro,"Mecánico - Habilidad:");
			format(string, 128, "Tienes %d puntos de habilidad. Te faltan %d para el proximo nivel.", habilidad, restante);
			SendClientMessage(playerid, AmarilloClaro, string);
		}
		else if(PlayerInfo[playerid][pJob] == 2) // Granjero
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Granjero - Comandos:");
			SendClientMessage(playerid,Blanco,"/cosechar /recolectar /trigo /dejarcosechar /vendertrigo /equipocosecha");
		}
		else if(PlayerInfo[playerid][pJob]== 15){SendClientMessage(playerid,Blanco,"[Trabajo] /venderlic");}
		else if(PlayerInfo[playerid][pJob] == 3) // Pescador
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Pescador - Comandos:");
			SendClientMessage(playerid,Blanco,"/pescar /dejarpescar /mispeces /venderpeces");
			SendClientMessage(playerid,Blanco,"/equipopesca /tirarcaña /tirarredes /infomarea");
			new habilidad = PlayerInfo[playerid][pHabilidadPescador];
			new restante;
			if(habilidad < 100)
			{
				restante = 100 - habilidad;
			}
			else if(habilidad < 300)
			{
				restante = 300 - habilidad;
			}
			else if(habilidad >= 300)
			{
				restante = 0;
			}
			SendClientMessage(playerid,AzulClaro,"Pescador - Habilidad:");
			format(string, 128, "Tienes %d puntos de habilidad. Te faltan %d para el proximo nivel.", habilidad, restante);
			SendClientMessage(playerid, AmarilloClaro, string);
		}
		else if(PlayerInfo[playerid][pJob] == 4) // LimpiaCalles
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Limpia Calles - Comandos:");
			SendClientMessage(playerid,Blanco,"/limpiarcalles /dejardelimpiar");
		}
		else if(PlayerInfo[playerid][pJob] == 5) // Basurero
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Basurero - Comandos:");
			SendClientMessage(playerid,Blanco,"/recogerbasura /dejarderecoger");
		}
		else if(PlayerInfo[playerid][pJob] == 6) // Pizzero
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Pizzero - Comandos:");
			SendClientMessage(playerid,Blanco,"/pizza (recoger/repartir/abandonar/vender)");
		}
		else if(PlayerInfo[playerid][pJob] == 7) // Repartidor
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Repartidor - Comandos:");
			SendClientMessage(playerid,Blanco,"/pedidos /atenderpedido");
		}
		else if(PlayerInfo[playerid][pJob] == 8) // Vendedor Ambulante
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Vendedor Ambulante - Comandos:");
			SendClientMessage(playerid,Blanco,"/ambulante (comenzar/abandonar/vender)");
		}
		else if(PlayerInfo[playerid][pJob] == 9) // Detective
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Detective - Comandos:");
			SendClientMessage(playerid,Blanco,"/contratar /contrato (aceptar/rechazar/dejar/ver) /buscar");
		}
		else if(PlayerInfo[playerid][pJob] == 10) // Vendedor de Seguros
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Vendedor de Seguros - Comandos:");
			SendClientMessage(playerid,Blanco,"/venderseguro");
		}
		else if(PlayerInfo[playerid][pJob] == 14) // LSTD
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"LSTD - Comandos:");
			SendClientMessage(playerid,Blanco,"/tarifa,/mtaxi /aceptar taxi");
		}
		else if(PlayerInfo[playerid][pJob] == 11) // Ladron
		{
			ClearChatbox(playerid,1);
			SendClientMessage(playerid,AzulClaro,"Ladrón - Comandos:");
			SendClientMessage(playerid,Blanco,"/atracar /robar (objetos|radio) /forzar /empeñar");
			SendClientMessage(playerid,Blanco,"/puente /llamar desguace /verbilletera || NUEVO: /atracar (negocio)");
            new habilidad = PlayerInfo[playerid][pHabilidadLadron];
			new restante;
			if(habilidad < 30)
			{
				restante = 30 - habilidad;
			}
			else if(habilidad < 50)
			{
				restante = 50 - habilidad;
			}
			else if(habilidad >= 50)
			{
				restante = 0;
			}
			SendClientMessage(playerid,AzulClaro,"Ladrón - Habilidad:");
			format(string, 128, "Tienes %d puntos de habilidad. Te faltan %d para el proximo nivel.", habilidad, restante);
			SendClientMessage(playerid, AmarilloClaro, string);
		}
		return 1;
	}
	
		if(strcmp(cmd, "/ayuda", true) == 0)
 		{
   		ClearChatbox(playerid,1);
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_BÁSICOS_] {809BC4}/tirararma, /recogerarma /me, /ame, /do, /headmove, /animaciones, /reloj.");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_INVENTARIO_] {809BC4}/stats, /inventario, /maletero, /armario, /ceder, /tirar, /gafas.");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_NEGOCIOS_] {809BC4}/comprar, /comprarnegocio, /puertanegocio, /scajafuerte, /dcajafuerte ");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_TELEFONO_] {809BC4}/llamar, /sms, /agenda, /contestar, /colgar, /tlfactivo");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_FRECUENCIAS_] {809BC4}/frecuencias, /fr");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_OTROS_] {809BC4}/ayudacasa, /ayudacoche, ayudafaccion, /mitrabajo");
   		SendClientMessage(playerid, AzulClaro, "{00C200}[_PREMIUM_] {809BC4}/premium, /tlftoggle, /nevera");
   		return 1;
  		}
		
		if(strcmp(cmd, "/ayudacoche", true) == 0)
	    {

			ClearChatbox(playerid,1);
			SendClientMessage(playerid, AzulClaro, "COCHES: - /kms, /gas, /llenar, /llenarlata, /usarlata  /vm. BLOQUEAR /bloqueo. LLAVES /verllaves.");
			SendClientMessage(playerid, AzulClaro, "COCHES: - /vendercoche /luces - /intermitentes - /(cerrar)maletero - /capo - /capota - /casco .");
			return 1;
		}
		if(strcmp(cmd, "/ayudacasa", true) == 0)
	    {

			ClearChatbox(playerid,1);
			SendClientMessage(playerid, AzulClaro, "CASAS: /alquilable, /alquiler, /desalojar, /desalojartodos /alquilar /comprarcasa, /puerta /estadotimbre");
			return 1;
		}
		if(strcmp(cmd, "/ayudafaccion", true) == 0)
	    {

			ClearChatbox(playerid,1);
            SendClientMessage(playerid, AzulClaro, "FACCION: /reclutar, /expulsar, /miembros /mitrabajo");
            SendClientMessage(playerid, AzulClaro, "HQ: /puerta /scajafuerte /dcajafuerte");
			return 1;
		}
		

	return 0;
}
