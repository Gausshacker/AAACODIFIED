#include <a_samp>
#include <globalvars>
#include <colores>
#include <funciones>
#include <detective>
#include <taxis>
#include <mSelection>
#pragma tabsize 0
//---[INTRO]---
//where the player will spawn
#define player_x (1987.195312)
#define player_y (-2262.616943)
#define player_z (13.546882)
#define player_angle (271,356)
//note: for a better effect, let the camera be a few meters away from the player
#define camera_x (1982.0007)
#define camera_y (-2249.000)
#define camera_z (15.000)
#define moving_speed 50 //ATTENTION; THESE ARE MILISECONDS
//------------

new skinlist = mS_INVALID_LISTID;

new PlayerText:TituloRegistro[MAX_PLAYERS];
new PlayerText:EdadRegistro[MAX_PLAYERS];
new PlayerText:SexoRegistro[MAX_PLAYERS];
new PlayerText:OrigenRegistro[MAX_PLAYERS];
new PlayerText:IngresarDatosRegistro[MAX_PLAYERS];
new Text:TituloTuto[MAX_PLAYERS], Text:Linea1Tuto[MAX_PLAYERS], Text:Linea2Tuto[MAX_PLAYERS], Text:Linea3Tuto[MAX_PLAYERS];

new
Text:Film_1,
Text:Film_2,
Text:Version,
Text:Title,
Text:Subtitle;
new Text:Ciudad, Text:Prohibida;
//

new EdadTemporal[MAX_PLAYERS] = 0;
new SexoTemporal[MAX_PLAYERS] = 0 ; // 1- MASCULINO 2 .- FEMENINO
new OrigenTemporal[MAX_PLAYERS] = 0;

#define Dialogo_Bienvenida 502
#define Dialogo_IngresarEdad 503
#define Dialogo_IngresarSexo 504
#define Dialogo_IngresarOrigen 505
#define Dialogo_IngresarDatos 506


new Registrado[MAX_PLAYERS];

forward MySQLCreateAccount(newplayersname[], newpassword[]);
forward MySQLCheckAccount(sqlplayersname[]);
forward MySQLUpdatePlayerIntSingle(sqlplayerid, sqlvalname[], sqlupdateint);
forward MySQLUpdatePlayerIntSingle2(sqlplayerid, sqlvalname[], sqlupdateint,sqlupdateint2);
public MySQLCheckAccount(sqlplayersname[]) // by Luk0r
{
	new query[128];
	new escstr[MAX_PLAYER_NAME];
	mysql_real_escape_string(sqlplayersname, escstr);
	format(query, sizeof(query), "SELECT id FROM players WHERE LOWER(Nombre) = LOWER('%s') LIMIT 1", escstr);
	mysql_query(query);
	mysql_store_result();
	if (mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		mysql_fetch_row(strid);
		new InTiD = strval(strid);
		return InTiD;
	}
}
public MySQLUpdatePlayerIntSingle(sqlplayerid, sqlvalname[], sqlupdateint) // by Luk0r
{
	new query[128];
	format(query, sizeof(query), "UPDATE players SET %s=%d WHERE id=%d", sqlvalname, sqlupdateint, sqlplayerid);
	mysql_query(query);
	return 1;
}
public MySQLUpdatePlayerIntSingle2(sqlplayerid, sqlvalname[], sqlupdateint,sqlupdateint2) // by Luk0r
{
	new query[128];
	format(query, sizeof(query), "UPDATE players SET %s=%d,%d WHERE id=%d", sqlvalname, sqlupdateint,sqlupdateint2, sqlplayerid);
	mysql_query(query);
	return 1;
}
public MySQLCreateAccount(newplayersname[], newpassword[]) // by Luk0r
{
	new query[128];
	new sqlplyname[64];
	new sqlpassword[64];
	mysql_real_escape_string(newplayersname, sqlplyname);
	mysql_real_escape_string(newpassword, sqlpassword);
	format(query, sizeof(query), "INSERT INTO players (Nombre, Password) VALUES ('%s', '%s')", sqlplyname, sqlpassword);
	mysql_query(query);
	new newplayersid = MySQLCheckAccount(newplayersname);
	if (newplayersid != 0)
	{
		return newplayersid;
	}
	return 0;
}

forward IsValid(playerid, campo[], cadena[]);
public IsValid(playerid, campo[], cadena[])
{
	if(IsPlayerNPC(playerid)) return 1;
	new tmp[100];
	new row[60];
	format(tmp, 100, "SELECT %s FROM players WHERE Nombre = '%s' LIMIT 1", campo, pNameEx(playerid));
	mysql_query(tmp);
	mysql_store_result();
	mysql_fetch_row(row);

	if(strcmp(row, cadena, true) == 0)
	{
		return 1;
	}
	mysql_free_result();
	return 0;
}

forward ExisteCuenta(playerid);
public ExisteCuenta(playerid)
{
	new query[128];
	new escstr[MAX_PLAYER_NAME];
	mysql_real_escape_string(pNameEx(playerid), escstr);
	format(query, sizeof(query), "SELECT id FROM players WHERE LOWER(Nombre) = LOWER('%s') LIMIT 1", escstr);
	mysql_query(query);
	mysql_store_result();
	if (mysql_num_rows()==0)
	{
		mysql_free_result();
		return 0;
	}
	else
	{
		new strid[32];
		mysql_fetch_row(strid);
		new InTiD = strval(strid);
		mysql_free_result();
		return InTiD;
	}
}

Cuentas_OnPlayerRequestClass(playerid)
{

	if(!IsPlayerNPC(playerid) && PlayerInfo[playerid][pJugando] == 0)
	{
		if(Registrado[playerid] == 0)
		 {

		  format(string, sizeof(string), "¡Bienvenido %s! Escribe una contraseña para registrarte.", pName(playerid));
			ShowPlayerDialog(playerid, 1900, DIALOG_STYLE_PASSWORD, "Bienvenido!", string, "Registrar", "Cancelar");
		   return 1;
		   }
		format(string,sizeof(string),"\n  Bienvenido de vuelta %s!\n\n Ingresa la contraseña de tu personaje debajo:\n",pName(playerid));
		ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_PASSWORD, "Inicio de sesión - Ciudad Latina Juego de Rol", string, "Log-in", "Cancelar");
		return 0;
	}
	TextDrawShowForPlayer(playerid, Film_1);
	TextDrawShowForPlayer(playerid, Film_2);
	TextDrawShowForPlayer(playerid, Subtitle);
	TextDrawShowForPlayer(playerid, Title);
	TextDrawShowForPlayer(playerid, Version);

	return 1;
}
Cuentas_OnGamemodeInit()
{
skinlist = LoadModelSelectionMenu("skins.txt");
    Ciudad = TextDrawCreate(36.000000, 430.000000, "Ciudad");
	TextDrawBackgroundColor(Ciudad, 255);
	TextDrawFont(Ciudad, 2);
	TextDrawLetterSize(Ciudad, 0.290000, 1.200000);
	TextDrawColor(Ciudad, -1);
	TextDrawSetOutline(Ciudad, 0);
	TextDrawSetProportional(Ciudad, 1);
	TextDrawSetShadow(Ciudad, 1);

	Prohibida = TextDrawCreate(79.000000, 430.000000, "Latina");
	TextDrawBackgroundColor(Prohibida, 255);
	TextDrawFont(Prohibida, 2);
	TextDrawLetterSize(Prohibida, 0.290000, 1.200000);
	TextDrawColor(Prohibida, 0x66797FFF);
	TextDrawSetOutline(Prohibida, 0);
	TextDrawSetProportional(Prohibida, 1);
	TextDrawSetShadow(Prohibida, 1);

// ==================      TextDrawX       ================ //
	Film_1 = TextDrawCreate(642.000000,1.000000,"_");//abajo
	TextDrawUseBox(Film_1,1);
	TextDrawBoxColor(Film_1,0x000000ff);
	TextDrawTextSize(Film_1,-61.000000,7.000000);
	TextDrawBackgroundColor(Film_1,0x000000ff);
	TextDrawFont(Film_1,3);
	TextDrawLetterSize(Film_1,0.700000,10.700009);
	TextDrawColor(Film_1,0xffffffff);
	TextDrawSetOutline(Film_1,1);
	TextDrawSetProportional(Film_1,1);
	TextDrawSetShadow(Film_1,1);

	Film_2 = TextDrawCreate(642.000000,341.000000,"_");//arriba
    TextDrawUseBox(Film_2,1);
    TextDrawBoxColor(Film_2,0x000000ff);
    TextDrawTextSize(Film_2,-36.000000,2.000000);
    TextDrawBackgroundColor(Film_2,0x000000ff);
    TextDrawFont(Film_2,3);
    TextDrawLetterSize(Film_2,1.300000,18.500022);
    TextDrawColor(Film_2,0xffffffff);
    TextDrawSetOutline(Film_2,1);
    TextDrawSetProportional(Film_2,1);
    TextDrawSetShadow(Film_2,1);


	Title = TextDrawCreate(189.000000, 35.000000,"CiudadLatina");
	TextDrawAlignment(Title,0);
	TextDrawBackgroundColor(Title,0x000000ff);
	TextDrawFont(Title,1);
	TextDrawLetterSize(Title,0.900000,1.999998);
	TextDrawColor(Title,0xffffffff);
	TextDrawSetOutline(Title,1);
	TextDrawSetProportional(Title,1);
	TextDrawSetShadow(Title,1);

	Subtitle = TextDrawCreate(316.000000,53.000000,"Role Play");
	TextDrawAlignment(Subtitle,0);
	TextDrawBackgroundColor(Subtitle,0x000000ff);
	TextDrawFont(Subtitle,2);
	TextDrawLetterSize(Subtitle,0.299999,1.000000);
	TextDrawColor(Subtitle,0xAFAFAFAA);
	TextDrawSetOutline(Subtitle,1);
	TextDrawSetProportional(Subtitle,1);
	TextDrawSetShadow(Subtitle,1);

	Version = TextDrawCreate(374.000000,63.000000,"1.2.0");
	TextDrawAlignment(Version,0);
	TextDrawBackgroundColor(Version,0x000000ff);
	TextDrawFont(Version,1);
	TextDrawLetterSize(Version,0.299999,1.099999);
    TextDrawColor(Version,0xffffffff);
    TextDrawSetOutline(Version,1);
    TextDrawSetProportional(Version,1);
	TextDrawSetShadow(Version,1);
}
Cuentas_OnPlayerConnect(playerid)
{
	LimpiarVariables(playerid);
	if(ExisteCuenta(playerid))
	{
		Registrado[playerid] = 1;
	}
	else
	{
		Registrado[playerid] = 0;

	}

	TituloTuto[playerid] = TextDrawCreate(310.000000, 177.000000, "Titulo");
	TextDrawAlignment(TituloTuto[playerid], 2);
	TextDrawBackgroundColor(TituloTuto[playerid], 255);
	TextDrawFont(TituloTuto[playerid], 1);
	TextDrawLetterSize(TituloTuto[playerid], 0.610000, 1.699999);
	TextDrawColor(TituloTuto[playerid], 0x179300FF);
	TextDrawSetOutline(TituloTuto[playerid], 1);
	TextDrawSetProportional(TituloTuto[playerid], 1);

	Linea1Tuto[playerid] = TextDrawCreate(310.000000, 197.000000, "Texto 1");
	TextDrawAlignment(Linea1Tuto[playerid], 2);
	TextDrawBackgroundColor(Linea1Tuto[playerid], 255);
	TextDrawFont(Linea1Tuto[playerid], 1);
	TextDrawLetterSize(Linea1Tuto[playerid], 0.409999, 1.699999);
	TextDrawColor(Linea1Tuto[playerid], 0xFFFFFFFF);
	TextDrawSetOutline(Linea1Tuto[playerid], 1);
	TextDrawSetProportional(Linea1Tuto[playerid], 1);

	Linea2Tuto[playerid] = TextDrawCreate(310.000000, 217.000000, "Texto 2");
	TextDrawAlignment(Linea2Tuto[playerid], 2);
	TextDrawBackgroundColor(Linea2Tuto[playerid], 255);
	TextDrawFont(Linea2Tuto[playerid], 1);
	TextDrawLetterSize(Linea2Tuto[playerid], 0.409999, 1.699999);
	TextDrawColor(Linea2Tuto[playerid], 0xFFFFFFFF);
	TextDrawSetOutline(Linea2Tuto[playerid], 1);
	TextDrawSetProportional(Linea2Tuto[playerid], 1);

	Linea3Tuto[playerid] = TextDrawCreate(310.000000, 237.000000, "Texto 3");
	TextDrawAlignment(Linea3Tuto[playerid], 2);
	TextDrawBackgroundColor(Linea3Tuto[playerid], 255);
	TextDrawFont(Linea3Tuto[playerid], 1);
	TextDrawLetterSize(Linea3Tuto[playerid], 0.409999, 1.699999);
	TextDrawColor(Linea3Tuto[playerid], 0xFFFFFFFF);
	TextDrawSetOutline(Linea3Tuto[playerid], 1);
	TextDrawSetProportional(Linea3Tuto[playerid], 1);
}

Cuentas_OnPlayerRequestSpawn(playerid)
{
	if(!IsPlayerNPC(playerid) && PlayerInfo[playerid][pJugando] == 0)
	{
        return 0;
	}
	return 1;
}

LimpiarVariables(playerid)
{
		//Reseteo de variables: Primero reseteamos todo, luego cargamos...
    //---[GENERALES]---
    PlayerInfo[playerid][pSQLID] = NOEXISTE;
    PlayerInfo[playerid][pEstiloPelea] = 0;
	PlayerInfo[playerid][pLoteria]=-1;
	ResetearVariablesArmas(playerid);
	PlayerInfo[playerid][pMenu]=0;
    PlayerInfo[playerid][pAdminDuty]=0;
    PlayerInfo[playerid][pDuty]=0;
	PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pRespeto]=0;
	SetPlayerScore(playerid,0);
    PlayerInfo[playerid][pMember]=0;
    PlayerInfo[playerid][pRank]=0;
    PlayerInfo[playerid][pJob]=0;
    PlayerInfo[playerid][pBank]=0;
    PlayerInfo[playerid][pPnumber][0]=0;
    PlayerInfo[playerid][pPnumber][1]=0;
	PlayerInfo[playerid][pPTelEstado]=1;
    PlayerInfo[playerid][pHidePms]=0;
    PlayerInfo[playerid][pBigEars]=0;
	PlayerInfo[playerid][pBigAntena]=0;
    PlayerInfo[playerid][pPmEspera]=0;
    PlayerInfo[playerid][pUsandoTelefono]=0;
    PlayerInfo[playerid][pIncomingCall]=NOEXISTE;
    PlayerInfo[playerid][pTimerCall]=0;
    PlayerInfo[playerid][pFacturaTelefono]=0;
    PlayerInfo[playerid][pNotificaciones]=0;
    PlayerInfo[playerid][pAutoescCP]=0;
    PlayerInfo[playerid][pAutoescVeh]=NOEXISTE;
    PlayerInfo[playerid][pAutoescTimer]=0;
    PlayerInfo[playerid][EnClase]=0;
    PlayerInfo[playerid][PreguntaID]=0;
    PlayerInfo[playerid][pFacturaTelefono]=0;
    PlayerInfo[playerid][pFrecuencia]=0;
    PlayerInfo[playerid][pMiFrecuencia]=0;
    PlayerInfo[playerid][pWalkies]=0;
    PlayerInfo[playerid][pHerido]=0;
	//--[INVENTARIO]--
    PlayerInfo[playerid][pPhonebook]=0;
    PlayerInfo[playerid][pDado]=0;
    PlayerInfo[playerid][pEncendedor]=0;
    PlayerInfo[playerid][pCigarrillos]=0;
	PlayerInfo[playerid][pLataFuel]=0;
    PlayerInfo[playerid][SpecID]= INVALID_PLAYER_ID;
    PlayerInfo[playerid][SpecType]= ADMIN_SPEC_TYPE_NONE;
    PlayerInfo[playerid][pTut]=0;
    PlayerInfo[playerid][pHide]=0;
    PlayerInfo[playerid][pDudaid]=NOEXISTE;
    PlayerInfo[playerid][pReporting]=0;
    PlayerInfo[playerid][pMarcado]=0;
    PlayerInfo[playerid][pJailed]=0;
    PlayerInfo[playerid][pJailTime]=0;
    PlayerInfo[playerid][pMultaMoney]=0;
    PlayerInfo[playerid][pMultaID]=NOEXISTE;
    PlayerInfo[playerid][pFrozen]=0;
    PlayerInfo[playerid][pTempFrozen]=0;
	PlayerInfo[playerid][pFrozenTaser]=0;
    PlayerInfo[playerid][pCheckpoint]=0;
    PlayerInfo[playerid][pRefuerzos]=0;
    PlayerInfo[playerid][pAdvertencias]=0;
    PlayerInfo[playerid][pSonido]=0;
    PlayerInfo[playerid][pMoviendoNeg]=0;
    PlayerInfo[playerid][pEditingNeg]=0;
    PlayerInfo[playerid][pMoviendoCasa]=0;
    PlayerInfo[playerid][pEditingCasa]=0;
    PlayerInfo[playerid][pMoviendoParking]=NOEXISTE;
    PlayerInfo[playerid][pLastCar]=NOEXISTE;
    PlayerInfo[playerid][pOfertaCocheID]=NOEXISTE;
    PlayerInfo[playerid][pOfertaCocheKey]=NOEXISTE;
    PlayerInfo[playerid][pOfertaCocheMoney]=0;
	KillTimer(PlayerInfo[playerid][pConsumoTimer]);
    //---[VARIABLES DE LOS TRABAJOS]---
	// -[GLOBALES]-
    PlayerInfo[playerid][pTrabajando]=0;
    PlayerInfo[playerid][pOferta]=0;
    PlayerInfo[playerid][pRutaDeTrabajo]=0;
    PlayerInfo[playerid][pTrabajandoCP]=0;
    PlayerInfo[playerid][pListoCobro]=0;
    PlayerInfo[playerid][pEquipoParaTrabajar]=0;
    PlayerInfo[playerid][pMaterialTrabajo]=0;
    PlayerInfo[playerid][pTrabajoVeh]=NOEXISTE;
    PlayerInfo[playerid][PuntosPositivos]=0;
    PlayerInfo[playerid][PuntosNegativos]=0;
    KillTimer(PlayerInfo[playerid][pTrabajoTimer]);
    // -[DETECTIVE]-
	OfertaContrato[playerid]=0;
	InvestigandoContrato[playerid]=0;
	EsperandoParaBuscar[playerid]=0;
    // -[BASURERO]-
    PlayerInfo[playerid][pBolsaBasura]=0;
    // -[MECANICOS]-
    PlayerInfo[playerid][pEligiendoColores]=0;
    PlayerInfo[playerid][pRepaintOffer]=NOEXISTE;
    PlayerInfo[playerid][pRepaintPrice]=0;
    PlayerInfo[playerid][pRepaintColor]=0;
    PlayerInfo[playerid][pRepaintColor2]=0;
    PlayerInfo[playerid][pRepairOffer]=NOEXISTE;
    PlayerInfo[playerid][pRepairPrice]=0;
    PlayerInfo[playerid][pRefillOffer]=NOEXISTE;
    PlayerInfo[playerid][pRefillPrice]=0;
	PlayerInfo[playerid][pRefillAmount]=0;
    PlayerInfo[playerid][pEstadoMecanico]=0;
	PlayerInfo[playerid][pClienteMecanico]=NOEXISTE;
    // -[PESCA]-
    PlayerInfo[playerid][pPuedePescar]=0;
    PlayerInfo[playerid][pHaTiradoAnzuelo]=0;
    PlayerInfo[playerid][pHaTiradoRedes]=0;
    PlayerInfo[playerid][pPuntosHabilidadGanados]=0;
    PlayerInfo[playerid][pPuntosHabilidadRestantes]=0;
    PlayerInfo[playerid][pNivelPescador]=0;
    PlayerInfo[playerid][pRedRota]=0;
	// -[AMBULANTE]-
	PlayerInfo[playerid][pOfertaHelado]=NOEXISTE;
	PlayerInfo[playerid][pOfertaPerrito]=NOEXISTE;
    // -[PIZZA]-
    PlayerInfo[playerid][pPizzas]=0;
    PlayerInfo[playerid][pHablandoPizza]=0;
	// -[SEGURO]-
	PlayerInfo[playerid][pOfreciendoS]=NOEXISTE;
	PlayerInfo[playerid][pOfreciendoV]=NOEXISTE;
	PlayerInfo[playerid][pOfreciendoC]=0;
	// -[COMIDAS]-
	PlayerInfo[playerid][pMoviendoCom] = NOEXISTE;
	PlayerInfo[playerid][pEditandoCom] = NOEXISTE;
	// -[TUTORIAL]-
	PlayerInfo[playerid][SpawnAngle] = 0.0;
	PlayerInfo[playerid][SpawnState] = true;
	// -[PAGOS]-
	PlayerInfo[playerid][pPagandole] = NOEXISTE;
	PlayerInfo[playerid][pPagandoDin] = 0;
	// -[TAXIS]-
	PlayerInfo[playerid][pEstadoTaxista]=0;
	PlayerInfo[playerid][pClienteTaxista]=NOEXISTE;
	Taxista[playerid][taestado] = 0;
	Taxista[playerid][tarifa] = 0;
	Taxista[playerid][ganancias] = 0;
	Transporte[playerid][trtime] = 0;
	Transporte[playerid][costo] = 0;
	Transporte[playerid][taxista] = 0;
	KillTimer(Transporte[playerid][timer]);
	// -[CHATS]-
	LocalOOC[playerid] = gettime();
	// -[LICARMAS]-
	PlayerInfo[playerid][pGunLic] = 0;
	PlayerInfo[playerid][pGunLicD] = 0;
	PlayerInfo[playerid][pGunLicM] = 0;
	PlayerInfo[playerid][pHablandoArmas]=0;
	// -[PREMIUM]-
	PlayerInfo[playerid][pPremiumTipo] = 0;
	PlayerInfo[playerid][pPremiumTime] = 0;
	PlayerInfo[playerid][pPTelEstado] = 1;
	// -[LOWRIDER]-
	PlayerInfo[playerid][pInContest] = false;
	PlayerInfo[playerid][pCurrentNote] = -1;
	PlayerInfo[playerid][pPointsEarned] = 0;
	PlayerInfo[playerid][pJustJoined] = false;
	// -[TEXT3D]-
	TextToggle[playerid] = 0;
	AudioTextToggle[playerid] = 0;
	// -[TAXIS]-
	Transporte[playerid][trtime] = 0;
	Transporte[playerid][costo] = 0;
	Transporte[playerid][taxista] = NOEXISTE;
	KillTimer(Transporte[playerid][timer]);
	// -[SONIDOS]-
	PlayerInfo[playerid][pEfecto] = NOEXISTE;
	// -[GANGZONES]-
	BuildingGangZone[playerid] = false;
	GetPos[playerid] = false;
	// -[PAINTBALL]-
	HaMuertoJugando[playerid] = 0;
	juega_paintball[playerid] = 0;
	participa_paintball[playerid] = 0;
	equipop[playerid] = 0;
	KillTimer(killtimercuentaatras[playerid]);
	KillTimer(partidapaintterminada[playerid]);


	//
}


forward Cuentas_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
public Cuentas_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1001)
	{
		if(!response) { Kick(playerid); }
		if(IsValid(playerid, "Password", inputtext) && (strlen(inputtext) > 0))
		{
			OnPlayerLogin(playerid);
		}
		else
		{
			ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_PASSWORD, ">>  Contraseña incorrecta!", "\n  Esa no es la contraseña!\n\n  Escribe la contraseña correcta, porfavor:\n", "Log-in", "Cancelar");
		}
	}
	else if(dialogid == 1900)
	{
	    //Registrar
	    if(response == 0) { Kick(playerid); }
	    if(!strlen(inputtext))
	    {

	    	format(string, sizeof(string), "¡Bienvenido %s! Escribe una contraseña para registrarte.", pName(playerid));
			ShowPlayerDialog(playerid, 1900, DIALOG_STYLE_PASSWORD, "Bienvenido!", string, "Registrar", "Cancelar");
			return 1;
		}
		OnPlayerRegister(playerid,inputtext);
	}



      else if(dialogid == Dialogo_IngresarEdad)
      {
      if (response)
      {
      if(strval(inputtext) >= 18 || strval(inputtext) <= 99)
      {

      EdadTemporal[playerid] =  strval(inputtext);
      MensajeFormato(playerid,Amarillo,"Haz ingresado la edad de %d años , recuerda que puedes editarla antes de ingresar datos",EdadTemporal[playerid]);
      SelectTextDraw(playerid, -1);
      }

      }
      }

      else if(dialogid == Dialogo_IngresarSexo)
      {
      if(response) //Hombre
      {

      SetPlayerSkin(playerid,26);
      PlayerInfo[playerid][pSkin] = 26;
	  SexoTemporal[playerid] = 1;
	  SendClientMessage(playerid,Amarillo,"Haz escogido como sexo 'Hombre', puedes volver a editar antes de ingresar los datos");
	  SelectTextDraw(playerid, -1);
      }
      else //Mujer
      {

      SetPlayerSkin(playerid,12);
      PlayerInfo[playerid][pSkin] = 12;
      SexoTemporal[playerid] = 2;
      SendClientMessage(playerid,Amarillo,"Haz escogido como sexo 'Mujer', puedes volver a editar antes de ingresar los datos");
      SelectTextDraw(playerid, -1);
      }
      }

      else if(dialogid == Dialogo_IngresarDatos)
      {
      if(response) //Si
      {
	  PlayerTextDrawHide(playerid, TituloRegistro[playerid]);
      PlayerTextDrawHide(playerid, EdadRegistro[playerid]);
      PlayerTextDrawHide(playerid, SexoRegistro[playerid]);
      PlayerTextDrawHide(playerid, OrigenRegistro[playerid]);
      PlayerTextDrawHide(playerid, IngresarDatosRegistro[playerid]);
      PlayerTextDrawDestroy(playerid, EdadRegistro[playerid]);
      PlayerTextDrawDestroy(playerid, TituloRegistro[playerid]);
      PlayerTextDrawDestroy(playerid, SexoRegistro[playerid]);
      PlayerTextDrawDestroy(playerid, OrigenRegistro[playerid]);
      PlayerTextDrawDestroy(playerid, IngresarDatosRegistro[playerid]);

      PlayerInfo[playerid][pSex] = SexoTemporal[playerid];
      //JugadorInfo[playerid][jOrigen] = OrigenTemporal[playerid];
      PlayerInfo[playerid][pAge] = EdadTemporal[playerid];
      ClearChatbox(playerid,10);
      MensajeFormato(playerid,Amarillo,"Haz confirmado los datos.");
      format(string,sizeof(string),"Nombre del personaje: %s",pName(playerid));
	  SendClientMessage(playerid,Blanco,string);
	  format(string,sizeof(string),"Edad del personaje:   %d",PlayerInfo[playerid][pAge]);
	  SendClientMessage(playerid,Blanco,string);

	  ShowModelSelectionMenu(playerid, skinlist, "Selecciona tu Ropa");
	  if(PlayerInfo[playerid][pSex]==1)
	  {
	  SendClientMessage(playerid,Blanco,"Sexo del personaje:    Hombre");
	  }
	  else if(PlayerInfo[playerid][pSex]==2)
	  {
	  SendClientMessage(playerid,Blanco,"Sexo del personaje:    Mujer");
	  }
	  if(OrigenTemporal[playerid]==1)
	  {
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    Los Santos");
	  }
	  else if(OrigenTemporal[playerid]==2)
	  {
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    Europa");
	  }
	  else if(OrigenTemporal[playerid]==3)
	  {
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    LatinoAmerica");
	  }
	  else if(OrigenTemporal[playerid]==4)
	  {
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    Africa");
	  }
	  else if(OrigenTemporal[playerid]==5)
	  {
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    Afroamericano");
	  }
	  GameTextForPlayer(playerid, "~r~Ingresando datos, en breve comenzara~n~ el tutorial.", 3000, 3);
	  TextDrawHideForPlayer(playerid, Textdraw0);
	  TextDrawHideForPlayer(playerid, Textdraw1);
	  TextDrawHideForPlayer(playerid, Textdraw2);
	  TextDrawHideForPlayer(playerid, Textdraw3);
	  TextDrawHideForPlayer(playerid, Textdraw4);
	  SaveValue(playerid, "Certificacion", 3);
	  TogglePlayerControllable(playerid, 0);
	  SetPlayerVirtualWorld(playerid, playerid);
	  SetTimerEx("ComenzarTutorial", 5000, false, "d", playerid);
      }
      else //No
      {

      SendClientMessage(playerid,Amarillo,"Has rechazado la confirmación.");
      SelectTextDraw(playerid, -1);
      }
      }

    else if(dialogid == Dialogo_IngresarOrigen) {
    if(response)
    {
    switch(listitem) {
	case 0://Nativo LS
	{
	OrigenTemporal[playerid] = 1; //LS
	SendClientMessage(playerid,Amarillo,"Tu personaje protagonizará haber nacido aquí, puedes cambiarlo antes de ingresar datos");
	SelectTextDraw(playerid, -1);
     }
	case 1: //Europa
	{
	OrigenTemporal[playerid] = 2;
	SendClientMessage(playerid,Amarillo,"Tu personaje protagonizará haber nacido en Europa, puedes cambiarlo antes de ingresar datos");
	SelectTextDraw(playerid, -1);
	}
	case 2: //Latino
	{
	OrigenTemporal[playerid] = 3;
	SendClientMessage(playerid,Amarillo,"Tu personaje protagonizará haber nacido en America-Latina, puedes cambiarlo antes de ingresar datos");
	SelectTextDraw(playerid, -1);
	}
	case 3: //Africano
	{
	OrigenTemporal[playerid] = 4;
	SendClientMessage(playerid,Amarillo,"Tu personaje protagonizará haber nacido en Africa, puedes cambiarlo antes de ingresar datos");
	SelectTextDraw(playerid, -1);
	}
	case 4: //Afro-Africano
	{
	 OrigenTemporal[playerid] = 5;
	 SendClientMessage(playerid,Amarillo,"Tu personaje protagonizará haber nacido con descendencia Afroamericana, puedes cambiarlo antes de ingresar datos");
	 SelectTextDraw(playerid, -1);
	}
	}
    }
	}



      else if(dialogid == Dialogo_Bienvenida)
      {
       if (response)
       {

       //Titulo
      TituloRegistro[playerid] = CreatePlayerTextDraw(playerid,190.000000, 81.000000, "Registro - Ciudad Latina Roleplay");
      PlayerTextDrawBackgroundColor(playerid,TituloRegistro[playerid], 255);
      PlayerTextDrawFont(playerid,TituloRegistro[playerid], 1);
      PlayerTextDrawLetterSize(playerid,TituloRegistro[playerid], 0.500000, 2.000000);
      PlayerTextDrawColor(playerid,TituloRegistro[playerid], -1);
      PlayerTextDrawSetOutline(playerid,TituloRegistro[playerid], 1);
      PlayerTextDrawSetProportional(playerid,TituloRegistro[playerid], 1);
      //

      //Boton Seleccionar Edad
      EdadRegistro[playerid] = CreatePlayerTextDraw(playerid,150.000000, 190.000000, "Seleccionar Edad");
      PlayerTextDrawBackgroundColor(playerid,EdadRegistro[playerid], 255);
      PlayerTextDrawFont(playerid,EdadRegistro[playerid], 1);
      PlayerTextDrawLetterSize(playerid,EdadRegistro[playerid], 0.500000, 2.000000);
      PlayerTextDrawColor(playerid,EdadRegistro[playerid], -16776961);
      PlayerTextDrawSetOutline(playerid,EdadRegistro[playerid], 0);
      PlayerTextDrawSetProportional(playerid,EdadRegistro[playerid], 1);
      PlayerTextDrawSetShadow(playerid,EdadRegistro[playerid], 1);

      //

      //Boton de seleccionar Sexo

      SexoRegistro[playerid] = CreatePlayerTextDraw(playerid,371.000000, 189.000000, "Seleccionar Sexo");
      PlayerTextDrawBackgroundColor(playerid,SexoRegistro[playerid], 255);
      PlayerTextDrawFont(playerid,SexoRegistro[playerid], 1);
      PlayerTextDrawLetterSize(playerid,SexoRegistro[playerid], 0.500000, 2.000000);
      PlayerTextDrawColor(playerid,SexoRegistro[playerid], -16776961);
      PlayerTextDrawSetOutline(playerid,SexoRegistro[playerid], 0);
      PlayerTextDrawSetProportional(playerid,SexoRegistro[playerid], 1);
      PlayerTextDrawSetShadow(playerid,SexoRegistro[playerid], 1);


      //

      //Boton de sellecionar Origen
      OrigenRegistro[playerid] = CreatePlayerTextDraw(playerid,241.000000, 259.000000, "Seleccionar Origen");
      PlayerTextDrawBackgroundColor(playerid,OrigenRegistro[playerid], 255);
      PlayerTextDrawFont(playerid,OrigenRegistro[playerid], 1);
      PlayerTextDrawLetterSize(playerid,OrigenRegistro[playerid], 0.500000, 2.000000);
      PlayerTextDrawColor(playerid,OrigenRegistro[playerid], -16776961);
      PlayerTextDrawSetOutline(playerid,OrigenRegistro[playerid], 0);
      PlayerTextDrawSetProportional(playerid,OrigenRegistro[playerid], 1);
      PlayerTextDrawSetShadow(playerid,OrigenRegistro[playerid], 1);

      //

      //Boton de  Ingresar Datos
      IngresarDatosRegistro[playerid] = CreatePlayerTextDraw(playerid,258.000000, 352.000000, "Ingresar Datos");
      PlayerTextDrawBackgroundColor(playerid,IngresarDatosRegistro[playerid], 255);
      PlayerTextDrawFont(playerid,IngresarDatosRegistro[playerid], 1);
      PlayerTextDrawLetterSize(playerid,IngresarDatosRegistro[playerid], 0.500000, 2.000000);
      PlayerTextDrawColor(playerid,IngresarDatosRegistro[playerid], -16776961);
      PlayerTextDrawSetOutline(playerid,IngresarDatosRegistro[playerid], 0);
      PlayerTextDrawSetProportional(playerid,IngresarDatosRegistro[playerid], 1);
      PlayerTextDrawSetShadow(playerid,IngresarDatosRegistro[playerid], 1);

      //
      //Seteamos clickeables
      PlayerTextDrawSetSelectable(playerid,PlayerText:EdadRegistro[playerid],1);
      PlayerTextDrawSetSelectable(playerid,PlayerText:SexoRegistro[playerid],1);
      PlayerTextDrawSetSelectable(playerid,PlayerText:OrigenRegistro[playerid],1);
      PlayerTextDrawSetSelectable(playerid,PlayerText:IngresarDatosRegistro[playerid],1);
      SelectTextDraw(playerid, -1);
      //

      //Mostramos
      PlayerTextDrawShow(playerid, TituloRegistro[playerid]);
      PlayerTextDrawShow(playerid, EdadRegistro[playerid]);
      PlayerTextDrawShow(playerid, SexoRegistro[playerid]);
      PlayerTextDrawShow(playerid, OrigenRegistro[playerid]);
      PlayerTextDrawShow(playerid, IngresarDatosRegistro[playerid]);

      //Variables a 0
      EdadTemporal[playerid] = 0;
      SexoTemporal[playerid] = 0;
      OrigenTemporal[playerid] = 0;
      //




	   }

      }

    if(dialogid == 4160) // TEST - TUTORIAL.
    {

       if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4161, DIALOG_STYLE_LIST, "{00FF00}Pregunta 2: {FFFFFF}¿Qué es MG?:", "Ir zigzageando.\nMeteGol.\nCorrer y saltar.\nConfundir canales IC con OOC.\nNo hacer caso a un admin.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4161)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4162, DIALOG_STYLE_LIST, "{00FF00}Pregunta 3: {FFFFFF}¿Qué es DM?", "Caminar rápido.\nNo rolear.\nMatar a una persona sin razon.\nSaltar y correr.\nConfundir canales IC con OOC.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4162)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4163, DIALOG_STYLE_LIST, "{00FF00}Pregunta 4: {FFFFFF}¿Qué es BH?:", "Saltar y correr al mismo tiempo para llegar rapido.\nMatar a alguien.\nNo rolear como se debe.\nPublicar mal un anuncio.\nHacer lo que no harias en la vida real.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4163)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4164, DIALOG_STYLE_LIST, "{00FF00}Pregunta 5: {FFFFFF}¿Qué es RK?:", "RevengeDeath.\nMatarse a si mismo.\nConfundir canales IC con OOC.\nHacer DM en JAIL.\nMuerte Vengativa - Matar al que te mató.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4164)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4165, DIALOG_STYLE_LIST, "{00FF00}Pregunta 6: {FFFFFF}Si me matan con rol...", "Vuelvo y lo mato.\nLo reporto a un admin.\nMe resigno, he perdido la memoria.\nLo insulto por /pm.\nLe digo que eso no debe hacerse.", "Responder", "Salir"); // Respuesta Correcta
            }
	}
  return 1;
}

if(dialogid == 4165)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4166, DIALOG_STYLE_LIST, "{00FF00}Pregunta 7: {FFFFFF}Si mi auto se averia...", "Le digo a un admin.\nLlamo y espero a un mecánico.\nLo reparo con cheat.\nLo empujo sin rol.\nLo prendo fuego.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4166)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4167, DIALOG_STYLE_LIST, "{00FF00}Pregunta 8: {FFFFFF}Si me apuntan para robarme...", "Le disparo también.\nSalgo corriendo.\nLo golpeo.\nMe lanzo al suelo y hago lo que me pida.\nLo insulto por /pm.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4167)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4167, DIALOG_STYLE_LIST, "{00FF00}Pregunta 9: {FFFFFF}En un tiroteo...", "Saco mi arma y comienzo a disparar.\nMe cubro lanzandome al suelo y llamando al 911.\nComienzo a hacer ZZ.\nLo insulto por /pm.\nMe desconecto.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4168)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            GameTextForPlayer(playerid, "~g~Correcto !", 3000, 3);
            ShowPlayerDialog(playerid, 4167, DIALOG_STYLE_LIST, "{00FF00}Pregunta 10: {FFFFFF}Si veo un antiroler...", "Le digo por /pm a un admin.\nLo insulto por /pm.\nAntiroleo yo también.\nLo reporto mediante /reportar y/o SS y al foro.\nLo mato.", "Responder", "Salir"); // Respuesta Correcta
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}

if(dialogid == 4169)
    {

    if(!response)
       {
       SendClientMessage(playerid, COLOR_RED, "Has decidido cancelar el test! Deberas rehacer el tutorial!"); // Si clickea en cancelar
       Kick(playerid);
       return 1;
       }

       if(response)
       {
            if(listitem == 0)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 1)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 2)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
            if(listitem == 3)
            {
            CleanChat(playerid);
	        SendClientMessage(playerid, -1, "_________________________________________________");
            SendClientMessage(playerid, -1, "{FFFF00}Has contestado correctamente.");
		    SendClientMessage(playerid, -1, "{FFFF00}Cargando datos de tu cuenta...");
 		    SendClientMessage(playerid, -1, "_________________________________________________");
 		    SaveValue(playerid, "Certificacion", 1);
 		    SetTimerEx("FinalizarTutorial", 3000, false, "d", playerid);
       	    }
            if(listitem == 4)
            {
            SendClientMessage(playerid, COLOR_RED, "Has contestado mal! Deberas rehacer el tutorial!"); // Respuesta Incorrecta
            Kick(playerid);
            }
	}
  return 1;
}
	return 1;
}

forward GetValueFromName(playerid, campo[]);
public GetValueFromName(playerid, campo[])
{
	if(IsPlayerNPC(playerid)) return 0;
	new tmp[128];
	new row[60];
	format(tmp, 128, "SELECT %s FROM players WHERE Nombre = '%s' LIMIT 1", campo, pNameEx(playerid));
	mysql_query(tmp);
	mysql_store_result();
	mysql_fetch_row(row);
	new id;
	id = strval(row);
	mysql_free_result();
	return id;
}

forward GetValue(playerid, campo[]);
public GetValue(playerid, campo[])
{
	if(IsPlayerNPC(playerid)) return 0;
	new tmp[128];
	new row[60];
	format(tmp, 128, "SELECT %s FROM players WHERE id = %d LIMIT 1", campo, PlayerInfo[playerid][pSQLID]);
	mysql_query(tmp);
	mysql_store_result();
	mysql_fetch_row(row);
	new id;
	id = strval(row);
	mysql_free_result();
	return id;
}

forward CargarCoordenadas(playerid);
public CargarCoordenadas(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	new tmp[128];
	new row[128];
	format(tmp, 128, "SELECT X, Y, Z, Angulo, Vida, Armor FROM players WHERE id = %d LIMIT 1", PlayerInfo[playerid][pSQLID]);
	mysql_query(tmp);
	mysql_store_result();
	mysql_fetch_row(row);

	split(row, arrCoords, '|');
	PlayerInfo[playerid][pPos_x] = floatstr(arrCoords[0]);
	PlayerInfo[playerid][pPos_y] = floatstr(arrCoords[1]);
	PlayerInfo[playerid][pPos_z] = floatstr(arrCoords[2]);
	PlayerInfo[playerid][pAngulo] = floatstr(arrCoords[3]);
	if(floatcmp(floatstr(arrCoords[4]),0.000) == 1)
	{
		SetPlayerHealth(playerid, floatstr(arrCoords[4]));
	}
	SetPlayerArmour(playerid, floatstr(arrCoords[5]));
	mysql_free_result();
	return 1;
}

forward OnPlayerLogout(playerid);
public OnPlayerLogout(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pJugando] == 0) return 1;
	PlayerInfo[playerid][pJugando] = 0;
	SaveValue(playerid, "Jugando", 0);
	SaveValues(playerid, "Coches");
	SaveValues(playerid, "CochesPrestados");
	SaveValues(playerid,"Inventario");
    if (PlayerInfo[playerid][TiempoEsperaTrabajo] > gettime() )
        SaveValue(playerid, "TiempoEsperaTrabajo", PlayerInfo[playerid][TiempoEsperaTrabajo] - gettime() );
    else SaveValue(playerid, "TiempoEsperaTrabajo", 0 );
    SaveValue(playerid, "Ganancias",PlayerInfo[playerid][pGanancias] );
	SaveValue(playerid, "RutasCompletadas",PlayerInfo[playerid][pRutasCompletadas] );
	SaveValue(playerid, "Respeto",PlayerInfo[playerid][pRespeto]);

	SaveValue(playerid, "Banco",PlayerInfo[playerid][pBank]);
	SaveValue(playerid, "Dinero",SafeGetPlayerMoney(playerid));
	SaveValues(playerid, "Payday");
    SaveValue(playerid, "Pasamontanas", PlayerInfo[playerid][pPasamontanas]);
    SaveValue(playerid, "EstiloPelea", PlayerInfo[playerid][pEstiloPelea]);



	return 1;
}

forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid)
{

	if(IsPlayerNPC(playerid)) return 1;

	//*-----------------------------------------------
	//Carga de variables del jugador, (ya hemos hecho limpieza en onplayerconnect)

	PlayerInfo[playerid][pSQLID] = GetValueFromName(playerid, "id");
	CargarCoordenadas(playerid);
	PlayerInfo[playerid][pRespeto] = GetValue(playerid, "Respeto");
	PlayerInfo[playerid][pAdmin] = GetValue(playerid, "AdminLevel");
	PlayerInfo[playerid][pBank] = GetValue(playerid, "Banco");
	PlayerInfo[playerid][pMember] = GetValue(playerid, "Faccion");
	PlayerInfo[playerid][pRank] = GetValue(playerid, "Rango");
	PlayerInfo[playerid][pJob] = GetValue(playerid, "Trabajo");
	PlayerInfo[playerid][pContrato] = GetValue(playerid, "Contrato");
	PlayerInfo[playerid][pInt] = GetValue(playerid, "Interior");
	PlayerInfo[playerid][pVw] = GetValue(playerid, "VirtualWorld");
	PlayerInfo[playerid][pNegocio] = GetValue(playerid, "PosNeg");
	PlayerInfo[playerid][pPhousekey] = GetValue(playerid, "Casa");
	PlayerInfo[playerid][pPbiskey] = GetValue(playerid, "Negocio");
    PlayerInfo[playerid][pSex] = GetValue(playerid, "sexo");
	PlayerInfo[playerid][pSkin] = GetValue(playerid, "Skin");
	PlayerInfo[playerid][pUniforme] = GetValue(playerid, "Uniforme");
	PlayerInfo[playerid][pDuty] = GetValue(playerid, "EnServicio");
	PlayerInfo[playerid][pHerido] = GetValue(playerid, "Herido");
	PlayerInfo[playerid][pJugando] = 1; SaveValue(playerid, "Jugando", 1);
	PlayerInfo[playerid][pProductos] = GetValue(playerid, "Productos");
	PlayerInfo[playerid][pDocumentacion] = GetValue(playerid, "Documentacion");
	PlayerInfo[playerid][pSeguroMedico] = GetValue(playerid, "SeguroMedico");
//	PlayerInfo[playerid][pPnumber][0] = GetValue(playerid, "Telefono");
//	PlayerInfo[playerid][pPnumber][1] = GetValue(playerid, "Telefono2");
	PlayerInfo[playerid][pFrecuencia] = GetValue(playerid, "Frecuencia");
	PlayerInfo[playerid][pMiFrecuencia] = GetValue(playerid, "MiFrecuencia");
	PlayerInfo[playerid][pWalkies] = GetValue(playerid, "Walkies");
    PlayerInfo[playerid][TiempoEsperaTrabajo] = gettime() + GetValue(playerid, "TiempoEsperaTrabajo");
    PlayerInfo[playerid][pGanancias] = GetValue(playerid, "Ganancias");
    PlayerInfo[playerid][pRutasCompletadas] = GetValue(playerid, "RutasCompletadas");
    PlayerInfo[playerid][pAdvertencias] = GetValue(playerid, "Advertencias");
    PlayerInfo[playerid][pTut] = GetValue(playerid, "Tutorial");
    PlayerInfo[playerid][pSex] = GetValue(playerid, "Sexo");
    PlayerInfo[playerid][pAge] = GetValue(playerid, "Edad");
	PlayerInfo[playerid][pAbstinencia] = GetValue(playerid, "Abstinencia");
	PlayerInfo[playerid][pLoteria] = GetValue(playerid, "Loteria");
	PlayerInfo[playerid][pPremiumTipo] = GetValue(playerid, "Premium_Tipo");
	PlayerInfo[playerid][pPremiumTime] = GetValue(playerid, "Premium_Timestamp");
	PlayerInfo[playerid][PuntosPositivos] = GetValue(playerid, "PuntosPositivos");
	PlayerInfo[playerid][PuntosNegativos] = GetValue(playerid, "PuntosNegativos");
	PlayerInfo[playerid][pGPS] = GetValue(playerid, "GPS");
	PlayerInfo[playerid][pPasamontanas] = GetValue(playerid, "Pasamontanas");
	PlayerInfo[playerid][pEstiloPelea] = GetValue(playerid, "EstiloPelea");
	//


	//
	GetValues(playerid, "Coches");
	GetValues(playerid, "CochesPrestados");
	GetValues(playerid, "Preparada");
	GetValues(playerid, "NoPreparada");
	GetValues(playerid, "Semillas");
	GetValues(playerid, "Parafernalia");
	GetValues(playerid, "Consumos");
	GetValues(playerid, "TmpConsumos");
	GetValues(playerid, "Habilidades");
	GetValues(playerid, "Licencias");
	GetValues(playerid, "Armas");
	GetValues(playerid, "Ammo");
	GetValues(playerid, "Inventario");
	GetValues(playerid, "Encarcelado");
	GetValues(playerid, "Telefonos");
	GetValues(playerid, "LArmas");
	GetValues(playerid, "Muebles");

	new Bloqueado = GetValue(playerid, "Bloqueado");
	if(Bloqueado == 1){ SendClientMessage(playerid,Naranja,"Esta cuenta está bloqueada, pasate por el foro para solucionarlo."); return Kick(playerid); }


	new Certificacion = GetValue(playerid, "Certificacion");
	//if(Certificacion == 0){ SendClientMessage(playerid,Naranja,"Aún no has validado el email de tu cuenta, ni pasada la certificacón."); return Kick(playerid);}
	if(Certificacion == 3)
	{
	SendClientMessage(playerid,Naranja,"Aún no has terminado el proceso de certificación.");
	TogglePlayerControllable(playerid, 0);
	SetPlayerVirtualWorld(playerid, playerid);
	SetTimerEx("ComenzarTutorial", 5000, false, "d", playerid);
	return 1;
	}
	if(Certificacion == 2)
	{
	SendClientMessage(playerid,Naranja,"Has sido reeducado y aún no has pasado de nuevo el proceso de certificación.");
	TogglePlayerControllable(playerid, 0);
	SetPlayerVirtualWorld(playerid, playerid);
	SetTimerEx("ComenzarTutorial", 5000, false, "d", playerid);
	return 1;
	}
	SetPlayerScore(playerid, GetPlayerLevel(playerid));



	if(PlayerInfo[playerid][pPhousekey] == NOEXISTE)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z],                  PlayerInfo[playerid][pAngulo], 0,0,0,0,0,0);
	}

	if(PlayerInfo[playerid][pDuty] == 0)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], PlayerInfo[playerid][pAngulo], 0,0,0,0,0,0);

	}
	else
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pUniforme], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], PlayerInfo[playerid][pAngulo], 0,0,0,0,0,0);
	}
	TogglePlayerControllable(playerid,0);
	SetTimerEx("Descongelar", 4000, 0, "d", playerid);
	if(PlayerInfo[playerid][pHerido] == 1)
	{
		PlayerInfo[playerid][pTmpSpawnx] = PlayerInfo[playerid][pPos_x];
		PlayerInfo[playerid][pTmpSpawny] = PlayerInfo[playerid][pPos_y];
		PlayerInfo[playerid][pTmpSpawnz] = PlayerInfo[playerid][pPos_z];
	}
	SetPlayerInterior(playerid, PlayerInfo[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVw]);


	if(PlayerInfo[playerid][pTut] == 1){ format(string, sizeof(string), "~w~Bienvenido ~n~~y~   %s", pName(playerid)); GameTextForPlayer(playerid, string, 5000, 1);}

	SpawnPlayer(playerid);


	new ip[16], year, month, day, fecha[16];
	GetPlayerIp(playerid, ip, 16);
	getdate(year, month, day);
	format(fecha, 16, "%d/%d/%d", day, month, year);
	format(string, 128, "INSERT INTO logins (time, ip, userid) VALUES ('%s', '%s', %d)",
		fecha,
		ip,
		PlayerInfo[playerid][pSQLID]);
	mysql_query(string);

	if(GetPlayerPremium(playerid) != 0)
	{
		new restante_segundos = PlayerInfo[playerid][pPremiumTime] - gettime();
		new restante_dias = ((restante_segundos /60) /60) /24;
        restante_segundos -= restante_dias*24*60*60;
		new restante_horas = (restante_segundos /60) /60;
        restante_segundos -= restante_horas*60*60;
		new restante_minutos = (restante_segundos /60);
		restante_segundos -= restante_minutos*60;
		format(string, 128, "PREMIUM: %s {FFFFFF} - {77c7ff}TIEMPO RESTANTE:{FFFFFF} %d días %d horas %d minutos %d segundos", Premium[GetPlayerPremium(playerid)], restante_dias, restante_horas, restante_minutos, restante_segundos);
		SendClientMessage(playerid, AzulClaro, string);
		new restante;
		restante = (((PlayerInfo[playerid][pSeguroMedico] - gettime()) /60) /60) /24;
		if(restante <= 0)
		{
			if(PremiumValido(playerid, 2))
			{
				PlayerInfo[playerid][pSeguroMedico] = gettime() + (7 * 24 * 60 * 60);
				SaveValue(playerid, "SeguroMedico", PlayerInfo[playerid][pSeguroMedico]);
				SendClientMessage(playerid, Blanco, " * Tu seguro médico fue renovado por un semana más.");
			}
		}
		new dia, mes, ano;
		getdate(dia, mes, ano);
		if(mes > PlayerInfo[playerid][pGunLicM])
		{
			if(PremiumValido(playerid, 3))
			{
				if(mes != 12)
				{
					PlayerInfo[playerid][pGunLicM] = mes + 1;
					PlayerInfo[playerid][pGunLicD] = dia;
				}
				else
				{
					PlayerInfo[playerid][pGunLicM] = 1;
					PlayerInfo[playerid][pGunLicD] = dia;
				}
				SendClientMessage(playerid, Blanco, " * Tu licencia de armas fue renovada por un mes más.");
				SaveValues(playerid, "LArmas");
			}
		}
		else if(dia >= PlayerInfo[playerid][pGunLicD] && PlayerInfo[playerid][pGunLicM] == mes)
		{
			if(PremiumValido(playerid, 2))
			{
				if(mes != 12)
				{
					PlayerInfo[playerid][pGunLicM] = mes + 1;
					PlayerInfo[playerid][pGunLicD] = dia;
				}
				else
				{
					PlayerInfo[playerid][pGunLicM] = 1;
					PlayerInfo[playerid][pGunLicD] = dia;
				}
				SendClientMessage(playerid, Blanco, " * Tu licencia de armas fue renovada por un mes más.");
				SaveValues(playerid, "LArmas");
			}
		}
	}
	SafeResetPlayerMoney(playerid);
	SafeGivePlayerMoney(playerid, GetValue(playerid, "Dinero"));

	if(PlayerInfo[playerid][pEstiloPelea]==0)
	{
    SetPlayerFightingStyle(playerid, 4);
	}
	if(PlayerInfo[playerid][pEstiloPelea]==5) //Boxing
	{
	SetPlayerFightingStyle(playerid, 5);
	}
	else if(PlayerInfo[playerid][pEstiloPelea]==6) //Kung Fu
	{
	SetPlayerFightingStyle(playerid, 6);
	}
	else if(PlayerInfo[playerid][pEstiloPelea]==7) //Knee Head
	{
	SetPlayerFightingStyle(playerid, 7);
	}
	else if(PlayerInfo[playerid][pEstiloPelea]==15) //Grab Kick
	{
	SetPlayerFightingStyle(playerid, 15);
	}
	else if(PlayerInfo[playerid][pEstiloPelea]==16) //Elbow
	{
	SetPlayerFightingStyle(playerid, 16);
	}


	return 1;
}

forward RefreshPos(playerid);
public RefreshPos(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x],        PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pAngulo]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVw] = GetPlayerVirtualWorld(playerid);
	GetPlayerArmour(playerid, PlayerInfo[playerid][pArmor]);
    SavePos(playerid);
    printf("refresh");
	return 1;
}

Cuentas_OnPlayerSpawn(playerid)
{
	ActualizarArmas(playerid);
	if(PlayerInfo[playerid][pJailed] == 1)
	{
		SetPlayerInterior(playerid, 1);
		SetPlayerPosEx(playerid,2583.8286,-1325.6830,1047.9634);
	}
	if(PlayerInfo[playerid][pJailed] == 2)
	{
		SetPlayerInterior(playerid, 18);
		SetPlayerPosEx(playerid,-219.5259,1409.8380,27.7734);
	}
	if(PlayerInfo[playerid][pJailed] == 3)
	{
		SetPlayerInterior(playerid, 6);
		SetPlayerPosEx(playerid,264.6727,77.6543,1001.0391);
	}
	TextDrawHideForPlayer(playerid, Ciudad);
	TextDrawHideForPlayer(playerid, Prohibida);
	TextDrawHideForPlayer(playerid, Film_1);
	TextDrawHideForPlayer(playerid, Film_2);
	TextDrawHideForPlayer(playerid, Version);
	TextDrawHideForPlayer(playerid, Subtitle);
	TextDrawHideForPlayer(playerid, Title);

	return 1;
}
stock GetPlayerIdFromName(playername[])
{
  for(new i = 0; i <= MAX_PLAYERS; i++)
  {
    if(IsPlayerConnected(i))
    {
      new playername2[MAX_PLAYER_NAME];
      GetPlayerName(i, playername2, sizeof(playername2));
      if(strcmp(playername2, playername, true, strlen(playername)) == 0)
      {
        return i;
      }
    }
  }
  return INVALID_PLAYER_ID;
}
forward SavePos(playerid);
public SavePos(playerid)
{
	new sql[150];
	if(IsPlayerNPC(playerid)) return 0;
	if(PlayerInfo[playerid][pJugando] == 1)
	{
        new Float:PosXNueva,Float:PosYNueva,Float:PosZNueva,Float:PosANueva;
        GetPlayerPos(playerid,PosXNueva,PosYNueva,PosZNueva);
        GetPlayerFacingAngle(playerid,PosANueva);
        printf(" X: %f , Y: %f , Z: %f", PosXNueva,PosYNueva,PosZNueva);
        PlayerInfo[playerid][pPos_x] = PosXNueva;
        PlayerInfo[playerid][pPos_y] = PosYNueva;
        PlayerInfo[playerid][pPos_z] = PosZNueva;
        PlayerInfo[playerid][pAngulo] = PosANueva;
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVw] = GetPlayerVirtualWorld(playerid);
	GetPlayerArmour(playerid, PlayerInfo[playerid][pArmor]);
	format(sql, 150, "UPDATE players SET Interior=%d,VirtualWorld=%d,X=%f,Y=%f,Z=%f,Angulo=%f,Armor=%f WHERE id=%d",
	PlayerInfo[playerid][pInt],
	PlayerInfo[playerid][pVw],
	PlayerInfo[playerid][pPos_x],
	PlayerInfo[playerid][pPos_y],
	PlayerInfo[playerid][pPos_z],
	PlayerInfo[playerid][pAngulo],
	PlayerInfo[playerid][pArmor],
	PlayerInfo[playerid][pSQLID]);
	mysql_query(sql);
        printf("pos guardadas en X:%f, Y: %f z %f",PlayerInfo[playerid][pPos_x],PlayerInfo[playerid][pPos_y],PlayerInfo[playerid][pPos_z]);
	OnPlayerLogout(playerid);
	}
	return 1;
}

forward GetValues(playerid, cadena[]);
public GetValues(playerid, cadena[])
{
	if(IsPlayerNPC(playerid)) return 0;
	new row[128];
	format(string, 128, "SELECT %s FROM players WHERE id = %d", cadena, PlayerInfo[playerid][pSQLID]);
	mysql_query(string);
	mysql_store_result();
	mysql_fetch_row(row);
	split(row, arrCoords, ',');

	if(strcmp(cadena, "Coches", true) == 0)
	{
		for(new i; i < MAX_PROPIOS; i++)
		{
			PlayerInfo[playerid][pPCarKey][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "CochesPrestados", true) == 0)
	{
		for(new i; i < MAX_PRESTADOS; i++)
		{
			PlayerInfo[playerid][pPCochePrestado][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Preparada", true) == 0)
	{
		for(new i; i < 3; i++)
		{
			PlayerInfo[playerid][pDrogaP][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "NoPreparada", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayerInfo[playerid][pDrogaNP][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Semillas", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayerInfo[playerid][pSemillas][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Parafernalia", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayerInfo[playerid][pParafernalia][i] = strval(arrCoords[i]);
		}
	}

	else if(strcmp(cadena, "Consumos", true) == 0)
	{
		for(new i; i < 3; i++)
		{
			PlayerInfo[playerid][pConsumos][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "TmpConsumos", true) == 0)
	{
		for(new i; i < 3; i++)
		{
			PlayerInfo[playerid][pTmpConsumos][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Habilidades", true) == 0)
	{
		PlayerInfo[playerid][pHabilidadMecanico] = strval(arrCoords[0]);
		PlayerInfo[playerid][pHabilidadPescador] = strval(arrCoords[1]);
		PlayerInfo[playerid][pHabilidadLadron] = strval(arrCoords[2]);
	}
	else if(strcmp(cadena, "Licencias", true) == 0)
	{
		PlayerInfo[playerid][pCarLic] = strval(arrCoords[0]);
		PlayerInfo[playerid][pCarLicPoints] = strval(arrCoords[1]);
		PlayerInfo[playerid][pBoatLic] = strval(arrCoords[2]);
		PlayerInfo[playerid][pFlyLic] = strval(arrCoords[3]);
	}
	else if(strcmp(cadena, "Armas", true) == 0)
	{
		for(new i; i < 13; i++)
		{
			AgregarArma(playerid, strval(arrCoords[i]));
		}
	}
	else if(strcmp(cadena, "Ammo", true) == 0)
	{
		for(new i; i < 13; i++)
		{
			AgregarAmmo(playerid, strval(arrCoords[i]), i);
		}
	}
	else if(strcmp(cadena, "Inventario", true) == 0)
	{
		PlayerInfo[playerid][pEncendedor] = strval(arrCoords[0]);
		PlayerInfo[playerid][pCigarrillos] = strval(arrCoords[1]);
		PlayerInfo[playerid][pDado] = strval(arrCoords[2]);
		PlayerInfo[playerid][pCartas] = strval(arrCoords[3]);
        PlayerInfo[playerid][pPalanca] = strval(arrCoords[4]);
        PlayerInfo[playerid][pGanzua] = strval(arrCoords[5]);
        PlayerInfo[playerid][pAlicates] = strval(arrCoords[6]);
		PlayerInfo[playerid][pGafas] = strval(arrCoords[7]);
		PlayerInfo[playerid][pCascos] = strval(arrCoords[8]);
		PlayerInfo[playerid][pMaterialTrabajo] = strval(arrCoords[9]);
		PlayerInfo[playerid][pBandana] = strval(arrCoords[10]);
	}
	else if(strcmp(cadena, "Encarcelado", true) == 0)
	{
		PlayerInfo[playerid][pJailed] = strval(arrCoords[0]);
		PlayerInfo[playerid][pJailTime] = strval(arrCoords[1]);
	}
	else if(strcmp(cadena, "Payday", true) == 0)
	{
		PlayerInfo[playerid][pHora] = strval(arrCoords[0]);
		PlayerInfo[playerid][pMinuto] = strval(arrCoords[1]);
	}
	else if(strcmp(cadena, "LArmas",true)==0)
	{
		PlayerInfo[playerid][pGunLic] = strval(arrCoords[0]);
		PlayerInfo[playerid][pGunLicD] = strval(arrCoords[1]);
		PlayerInfo[playerid][pGunLicM] = strval (arrCoords[2]);
	}
	else if(strcmp(cadena, "Telefonos",true)==0)
	{
		PlayerInfo[playerid][pPnumber][0] = strval(arrCoords[0]);
		PlayerInfo[playerid][pPnumber][1] = strval(arrCoords[1]);
	}
	else if(strcmp(cadena, "Muebles", true) == 0)
	{
		for(new i; i < MAX_MUEBLES_PER_PLAYER; i++)
		{
			PlayerInfo[playerid][pMuebles][i] = strval(arrCoords[i]);
		}
	}
	mysql_free_result();
	return 0;
}

forward SaveValue(playerid, cadena[], valor);
public SaveValue(playerid, cadena[], valor)
{
	if(IsPlayerNPC(playerid)) return 0;
	format(string, 128, "UPDATE players SET %s=%d WHERE id = %d", cadena, valor, PlayerInfo[playerid][pSQLID]);
	mysql_query(string);
	return 0;
}

forward SaveValues(playerid, cadena[]);
public SaveValues(playerid, cadena[])
{
	if(IsPlayerNPC(playerid)) return 0;
	new tmp[128];
	if(strcmp(cadena, "Coches", true) == 0)
	{
		format(tmp, 128, "%d", PlayerInfo[playerid][pPCarKey][0]);
		for(new i = 1; i < MAX_PROPIOS; i++)
		{
			format(string, 128, ",%d", PlayerInfo[playerid][pPCarKey][i]);
			strcat(tmp, string, 128);
		}
	}
	else if(strcmp(cadena, "CochesPrestados", true) == 0)
	{
		format(tmp, 128, "%d", PlayerInfo[playerid][pPCochePrestado][0]);
		for(new i = 1; i < MAX_PRESTADOS; i++)
		{
			format(string, 128, ",%d", PlayerInfo[playerid][pPCochePrestado][i]);
			strcat(tmp, string, 128);
		}
	}
	else if(strcmp(cadena, "Preparada", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d", PlayerInfo[playerid][pDrogaP][0], PlayerInfo[playerid][pDrogaP][1], PlayerInfo[playerid][pDrogaP][2]);
	}
	else if(strcmp(cadena, "NoPreparada", true) == 0)
	{
		format(tmp, 128, "%d,%d", PlayerInfo[playerid][pDrogaNP][0], PlayerInfo[playerid][pDrogaNP][1]);
	}
	else if(strcmp(cadena, "Semillas", true) == 0)
	{
		format(tmp, 128, "%d,%d", PlayerInfo[playerid][pSemillas][0], PlayerInfo[playerid][pSemillas][1]);
	}
	else if(strcmp(cadena, "Parafernalia", true) == 0)
	{
		format(tmp, 128, "%d,%d", PlayerInfo[playerid][pParafernalia][0], PlayerInfo[playerid][pParafernalia][1]);
	}

	else if(strcmp(cadena, "Consumos", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d", PlayerInfo[playerid][pConsumos][0], PlayerInfo[playerid][pConsumos][1], PlayerInfo[playerid][pConsumos][2]);
	}
	else if(strcmp(cadena, "TmpConsumos", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d", PlayerInfo[playerid][pTmpConsumos][0], PlayerInfo[playerid][pTmpConsumos][1], PlayerInfo[playerid][pTmpConsumos][2]);
	}
	else if(strcmp(cadena, "Habilidades", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d",PlayerInfo[playerid][pHabilidadMecanico],  PlayerInfo[playerid][pHabilidadPescador], PlayerInfo[playerid][pHabilidadLadron]);
	}
	else if(strcmp(cadena, "Licencias", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d,%d", PlayerInfo[playerid][pCarLic], PlayerInfo[playerid][pCarLicPoints], PlayerInfo[playerid][pBoatLic], PlayerInfo[playerid][pFlyLic]);
	}
	else if(strcmp(cadena, "Armas", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
			ScriptWeapons[playerid][0],
			ScriptWeapons[playerid][1],
			ScriptWeapons[playerid][2],
			ScriptWeapons[playerid][3],
			ScriptWeapons[playerid][4],
			ScriptWeapons[playerid][5],
			ScriptWeapons[playerid][6],
			ScriptWeapons[playerid][7],
			ScriptWeapons[playerid][8],
			ScriptWeapons[playerid][9],
			ScriptWeapons[playerid][10],
			ScriptWeapons[playerid][11],
			ScriptWeapons[playerid][12]);
	}

	else if(strcmp(cadena, "Ammo", true) == 0)
	{
		format(tmp, 128, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
			ScriptAmmo[playerid][0],
			ScriptAmmo[playerid][1],
			ScriptAmmo[playerid][2],
			ScriptAmmo[playerid][3],
			ScriptAmmo[playerid][4],
			ScriptAmmo[playerid][5],
			ScriptAmmo[playerid][6],
			ScriptAmmo[playerid][7],
			ScriptAmmo[playerid][8],
			ScriptAmmo[playerid][9],
			ScriptAmmo[playerid][10],
			ScriptAmmo[playerid][11],
			ScriptAmmo[playerid][12]);
	}
	else if(strcmp(cadena, "Inventario", true) == 0)
	{
		if(PlayerInfo[playerid][pJob] == 11 || PlayerInfo[playerid][pJob] == 2 || PlayerInfo[playerid][pJob] == 3)
		{
			format(tmp, 128, "%d,%d,%d,%d,%d,%d,%d,%d,%d,0,%d",
				PlayerInfo[playerid][pEncendedor],
				PlayerInfo[playerid][pCigarrillos],
				PlayerInfo[playerid][pDado],
				PlayerInfo[playerid][pCartas],
				PlayerInfo[playerid][pPalanca],
				PlayerInfo[playerid][pGanzua],
				PlayerInfo[playerid][pAlicates],
				PlayerInfo[playerid][pGafas],
				PlayerInfo[playerid][pCascos],
				PlayerInfo[playerid][pBandana]);
		}
		else
		{
			format(tmp, 128, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
				PlayerInfo[playerid][pEncendedor],
				PlayerInfo[playerid][pCigarrillos],
				PlayerInfo[playerid][pDado],
				PlayerInfo[playerid][pCartas],
				PlayerInfo[playerid][pPalanca],
				PlayerInfo[playerid][pGanzua],
				PlayerInfo[playerid][pAlicates],
				PlayerInfo[playerid][pGafas],
				PlayerInfo[playerid][pCascos],
				PlayerInfo[playerid][pMaterialTrabajo],
				PlayerInfo[playerid][pBandana]);
		}
	}
	else if(strcmp(cadena, "Encarcelado", true) == 0)
	{
		format(tmp, 128, "%d,%d",	PlayerInfo[playerid][pJailed], PlayerInfo[playerid][pJailTime]);
	}
	else if(strcmp(cadena, "Payday", true) == 0)
	{
		new hora, minuto, segundo;
		gettime(hora, minuto, segundo);
		format(tmp, 128, "%d,%d",hora, PlayerInfo[playerid][pMinuto]);
	}
	else if(strcmp(cadena, "Telefonos", true) == 0)
	{
		format(tmp, 128, "%d,%d",PlayerInfo[playerid][pPnumber][0],PlayerInfo[playerid][pPnumber][1]);
	}
	else if(strcmp(cadena, "LArmas", true) ==0 )
	{
		format(tmp, 128, "%d,%d,%d",PlayerInfo[playerid][pGunLic], PlayerInfo[playerid][pGunLicD], PlayerInfo[playerid][pGunLicM]);
	}
	else if(strcmp(cadena, "Muebles", true) == 0)
	{
		format(tmp, 128, "%d", PlayerInfo[playerid][pMuebles][0]);
		for(new i = 1; i < MAX_MUEBLES_PER_PLAYER; i++)
		{
			format(string, 128, ",%d", PlayerInfo[playerid][pMuebles][i]);
			strcat(tmp, string, 128);
		}
	}
	new sql[256];
	format(sql, 256, "UPDATE players SET %s = '%s' WHERE id = %d", cadena, tmp, PlayerInfo[playerid][pSQLID]);
	mysql_query(sql);
	return 0;
}

forward MoverCamera(playerid);
public MoverCamera(playerid)
{
    SetPlayerPos(playerid, player_x,player_y,player_z);
    SetPlayerFacingAngle(playerid, player_angle);
    SetPlayerCameraPos(playerid, camera_x,camera_y,camera_z);
    SetPlayerCameraLookAt(playerid, player_x,player_y,player_z);
    if (PlayerInfo[playerid][SpawnState]) PlayerInfo[playerid][SpawnTimer] = SetTimerEx("MoveCamera", moving_speed, true, "i", playerid);
    PlayerInfo[playerid][SpawnState] = false; //preventing the timer to execute again
	SetTimerEx("ColocarPosJugador",7100,0,"d",playerid);
	return 1;
}

forward ColocarPosJugador(playerid);
public ColocarPosJugador(playerid)
{
	TogglePlayerControllable(playerid,1);
	PlayerInfo[playerid][SpawnAngle] = 0.0; //so when you leave and another player comes, the camera will start from start
	PlayerInfo[playerid][SpawnState] = true; //to not execute to much timers
    KillTimer( PlayerInfo[playerid][SpawnTimer] ); //to kill it, since its useless now
    SetCameraBehindPlayer(playerid); //to prevent some bugs
	format(string,sizeof(string),"Bienvenido a Ciudad Latina, %s.", pName(playerid));
	SendClientMessage(playerid,Naranja,string);
	SendClientMessage(playerid,AmarilloClaro,"Recuerda rolear siempre y ayudarte con tu entorno.");
	return 1;
}

forward MoveCamera(playerid);
public MoveCamera(playerid)
{
    //this is called trigonometry. It makes the camera spin
    //you can experiment with this line. Just change the values 2, 10 and 3 to make different effects
	SetPlayerCameraPos(playerid, player_x + 5 * floatsin(-PlayerInfo[playerid][SpawnAngle], degrees), player_y + 8 * floatcos(-PlayerInfo[playerid][SpawnAngle], degrees), player_z + 3);
	SetPlayerCameraLookAt(playerid, player_x, player_y, player_z + 0.5);

    //changing the angle a little
	PlayerInfo[playerid][SpawnAngle] += 1.5;

	if (PlayerInfo[playerid][SpawnAngle] >= 360.0)
    PlayerInfo[playerid][SpawnAngle] = 0.0;
	return 1;
}
OnPlayerRegister(playerid, password[]) // v1.0 by Luk0r
{
	if(IsPlayerConnected(playerid))
	{

		new playername3[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername3, sizeof(playername3));
		new newaccountsqlid = MySQLCreateAccount(playername3, password);
		if (newaccountsqlid != 0)
		{
			PlayerInfo[playerid][pSQLID] = newaccountsqlid;
			PlayerInfo[playerid][pTut] = 0;
			format(string, sizeof(string), "Bienvenido %s. Escribe tu contraseña, por favor.", playername3);
			ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_PASSWORD, "¡Bienvenido!", string, "Login", "Cancelar");
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Ocurrió un error creando tu cuenta. Estás desconectado.");
			Kick(playerid);
			return 0;
		}
	}
	return 0;
}
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == ropalist)
	{
	    if(response)
	    {
	    	SetPlayerSkin(playerid, modelid);
	    	PlayerInfo[playerid][pSkin] = modelid;
	    	SafeGivePlayerMoney(playerid,-20);
	    	TogglePlayerControllable(playerid,1);


	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "Has cancelado la selección.");
    	return 1;
	}
	if(listid == skinlist)
	{
	    if(response)
	    {
	    	SetPlayerSkin(playerid, modelid);
	    	PlayerInfo[playerid][pSkin] = modelid;
	    	SaveValue(playerid, "Skin", PlayerInfo[playerid][pSkin]);
	TextDrawHideForPlayer(playerid, Ciudad);
	TextDrawHideForPlayer(playerid, Prohibida);
	TextDrawHideForPlayer(playerid, Film_1);
	TextDrawHideForPlayer(playerid, Film_2);
	TextDrawHideForPlayer(playerid, Version);
	TextDrawHideForPlayer(playerid, Subtitle);
	TextDrawHideForPlayer(playerid, Title);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "Has cancelado la selección.");
    	return 1;
	}

	return 1;
}

stock CleanChat(playerid)
{
      SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
	  SendClientMessage(playerid, -1, " ");
}

stock MTuto(playerid)
{
    TextDrawShowForPlayer(playerid, TituloTuto[playerid]); TextDrawShowForPlayer(playerid, Linea1Tuto[playerid]);
	TextDrawShowForPlayer(playerid, Linea2Tuto[playerid]); TextDrawShowForPlayer(playerid, Linea3Tuto[playerid]);
	return 0;
}

stock STuto(playerid)
{
    TextDrawHideForPlayer(playerid, TituloTuto[playerid]); TextDrawHideForPlayer(playerid, Linea1Tuto[playerid]);
	TextDrawHideForPlayer(playerid, Linea2Tuto[playerid]); TextDrawHideForPlayer(playerid, Linea3Tuto[playerid]);
	return 0;
}

forward ComenzarTutorial(playerid);
public ComenzarTutorial(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Bienvenido a Los Angeles - Juego de Rol.");
	  TextDrawSetString(Linea1Tuto[playerid],"Por empezar te damos la bienvenida. Queremos dejar en claro que este no es un server de DM");
	  TextDrawSetString(Linea2Tuto[playerid],"sino de RolePlay. Es por eso que si no acatas nuestras reglas o comienzas a hacer DM/FREEROAM");
	  TextDrawSetString(Linea3Tuto[playerid],"te inviamos a que pongas /q. Comenzaremos el tutorial, presta mucha mucha atencion.");
	  MTuto(playerid);
	  TogglePlayerControllable(playerid, 0);
	  SetPlayerVirtualWorld(playerid, playerid);
	  SetTimerEx("Tutorial_1", 10000, false, "d", playerid);
	  return 1;
}

forward Tutorial_1(playerid);
public Tutorial_1(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"RolePlay:");
	  TextDrawSetString(Linea1Tuto[playerid],"Significa Juego de Rol y por ello entendemos que nuestro personaje interpretara la segunda");
	  TextDrawSetString(Linea2Tuto[playerid],"vida virtual dentro del juego. Deberas 'rolear' a tu personaje como si fuera la vida real");
	  TextDrawSetString(Linea3Tuto[playerid],"pero dentro del juego. Tal es el caso que hay diferentes canales para hablar....");
	  SetTimerEx("Tutorial_2", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_2(playerid);
public Tutorial_2(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Canales IC (Dentro del Jugador) y OOC (Fuera del Jugador) - Parte 1:");
	  TextDrawSetString(Linea1Tuto[playerid],"Lo que tu personaje interprete al igual que en la vida real, es el canal IC. Puedes hablar");
	  TextDrawSetString(Linea2Tuto[playerid],"con la tecla 'T' normal del chat. Lo que tu personaje no interprete o sea fuera del mismo");
	  TextDrawSetString(Linea3Tuto[playerid],"y por ende no tenga nada que ver con el 'juego' es el canal OOC....");
	  SetTimerEx("Tutorial_3", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_3(playerid);
public Tutorial_3(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Canales IC (Dentro del Jugador) y OOC (Fuera del Jugador) - Parte 2:");
	  TextDrawSetString(Linea1Tuto[playerid],"Es por eso que si decides poner caritas como por ejemplo 'xD' o ':P', etc, debes ponerlo");
	  TextDrawSetString(Linea2Tuto[playerid],"mediante el canal OOC el cual es /b. Si quieres interpretar la vida real, solo habla por la 'T'");
	  TextDrawSetString(Linea3Tuto[playerid],"del chat comun y listo. Sino respetas esto, es considerado MG y puedes ser sancionado....");
	  SetTimerEx("Tutorial_4", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_4(playerid);
public Tutorial_4(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"DM, BH, DB y ZZ:");
	  TextDrawSetString(Linea1Tuto[playerid],"El DM es matar a una persona sin razon alguna. No puedes hacer esto ya que seras sancionado.");
	  TextDrawSetString(Linea2Tuto[playerid],"El BH es ir saltando y corriendo para llegar a un lugar mucho mas rapido. El DB es disparar");
	  TextDrawSetString(Linea3Tuto[playerid],"desde un vehiculo siendo conductor. El ZZ es ir haciendo ZigZag como un troller....");
	  SetTimerEx("Tutorial_5", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_5(playerid);
public Tutorial_5(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Definicion de PG:");
	  TextDrawSetString(Linea1Tuto[playerid],"El PG es hacer cosas que en la vida real serian imposibles. Tambien es forzar a otro jugador");
	  TextDrawSetString(Linea2Tuto[playerid],"a rolear con el /me, para ello existe el /do y /suerte. Un ejemplo de PG: /me rompe la pared");
	  TextDrawSetString(Linea3Tuto[playerid],"de un puñetazo o /me salta 50 pisos y sobrevive. El PG es considerado antirol, incluso sin /me..");
	  SetTimerEx("Tutorial_6", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_6(playerid);
public Tutorial_6(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Definicion de BD:");
	  TextDrawSetString(Linea1Tuto[playerid],"Es casi igual que el PG solo que con el vehiculo. Tu no puedes ir a 150KM/H en una calle en");
	  TextDrawSetString(Linea2Tuto[playerid],"contra-mano por que en la vida real te chocarias con todos los vehiculos que vienen por ahi.");
	  TextDrawSetString(Linea3Tuto[playerid],"Debes rolear el 'entorno' que se te explicara en el proximo tutorial....");
	  SetTimerEx("Tutorial_7", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_7(playerid);
public Tutorial_7(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Definicion de 'Rol de Entorno':");
	  TextDrawSetString(Linea1Tuto[playerid],"Rolear el 'entorno' significa que debes hacer de cuenta que hay gente a tu lado (por mas de");
	  TextDrawSetString(Linea2Tuto[playerid],"que no esten conectadas) y rolear por tu cuenta de que si las hay. Pongamos un ejemplo:");
	  TextDrawSetString(Linea3Tuto[playerid],"En la vida real, una comisaria esta llena de policias, bueno, en el juego la roleas por /do...");
	  SetTimerEx("Tutorial_8", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_8(playerid);
public Tutorial_8(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"¿Que es RK?:");
	  TextDrawSetString(Linea1Tuto[playerid],"Significa vengar la muerte de tu personaje de manera IC pero por razones OOC, expliquemos:");
	  TextDrawSetString(Linea2Tuto[playerid],"Viene un tio, te carga con su M4 o pistola (te mata) tu naces en el hospital y se supone que");
	  TextDrawSetString(Linea3Tuto[playerid],"debes olvidar TODO lo anterior con ese sujeto. Si regresas, te vengas y lo matas, es RK....");
	  SetTimerEx("Tutorial_9", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_9(playerid);
public Tutorial_9(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"¿Que es CJ y BBH?: (finalizando)");
	  TextDrawSetString(Linea1Tuto[playerid],"El CJ es robar un vehiculo sin rol alguno. Vas caminando y le robas al primero que ves.");
	  TextDrawSetString(Linea2Tuto[playerid],"Obviamente no puedes hacer eso por que en la vida real no lo haces y aparte debes rolear varias");
	  TextDrawSetString(Linea3Tuto[playerid],"cosas antes. El BBH es saltar con la bicicleta como si fueras un troll, esto esta prohibido...");
	  SetTimerEx("Tutorial_10", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_10(playerid);
public Tutorial_10(playerid)
{
	  CleanChat(playerid);
	  TextDrawSetString(TituloTuto[playerid],"Fin del Tutorial:");
	  TextDrawSetString(Linea1Tuto[playerid],"Para finalizar el tutorial, te recordamos que en este server, todo lo explicado anteriormente");
	  TextDrawSetString(Linea2Tuto[playerid],"sino lo llegas a cumplir habra una sancion de carcel por parte de la administracion.");
	  TextDrawSetString(Linea3Tuto[playerid],"A continuacion, te haremos un test de 10 preguntas, si la contestas bien, ya podras jugar! ...");
	  SetTimerEx("Tutorial_11", 15000, false, "d", playerid);
	  return 1;
}

forward Tutorial_11(playerid);
public Tutorial_11(playerid)
{
	  CleanChat(playerid);
	  STuto(playerid);
	  ShowPlayerDialog(playerid, 4160, DIALOG_STYLE_LIST, "{00FF00}Pregunta 1: {FFFFFF}¿Qué es PG?:", "PowerGlowing.\nHacer cosas que no harias en la vida real.\nEstropearse a si mismo.\nCorrer rápido.\nConfundir canales IC con OOC.", "Responder", "Salir");
	  return 1;
}

forward FinalizarTutorial(playerid);
public FinalizarTutorial(playerid)
{
	  SendClientMessage(playerid, -1, "* El tutorial ha finalizado, ya puedes jugar en nuestro servidor.");
	  SendClientMessage(playerid, -1, "* Disfruta tu estadía.");
      SaveValue(playerid, "Skin", PlayerInfo[playerid][pSkin]);
	  SaveValue(playerid, "Edad", PlayerInfo[playerid][pAge]);
      SaveValue(playerid, "Sexo", PlayerInfo[playerid][pSex]);
	  SafeGivePlayerMoney(playerid,6000);
	  TogglePlayerControllable(playerid, 1);
 	  SetPlayerVirtualWorld(playerid, 0);
	  return 1;
}
