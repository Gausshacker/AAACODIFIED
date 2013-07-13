#include <a_samp>
#include <globalvars>
#include <colores>
#include <funciones>
#include <detective>
#include <taxis>
#include <mSelection>
#include <j_inventory_v2>
#pragma tabsize 0
//---[INTRO]---
//where the player will spawn
#define player_x (1480.6287)
#define player_y (-1742.1365)
#define player_z (13.5469)
#define player_angle (354.9398)
//note: for a better effect, let the camera be a few meters away from the player
#define camera_x (1473.8756)
#define camera_y (-1750.1123)
#define camera_z (15.4453)
#define moving_speed 50 //ATTENTION; THESE ARE MILISECONDS
//------------

new skinlist = mS_INVALID_LISTID;

new PlayerText:TituloRegistro[MAX_PLAYERS];
new PlayerText:EdadRegistro[MAX_PLAYERS];
new PlayerText:SexoRegistro[MAX_PLAYERS];
new PlayerText:OrigenRegistro[MAX_PLAYERS];
new PlayerText:IngresarDatosRegistro[MAX_PLAYERS];

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
    
	if(!IsPlayerNPC(playerid))
	{
		if(Registrado[playerid] == 0)
		 {
		 format(string, sizeof(string), "¡Bienvenido %s! Escribe una contraseña para registrarte.", pName(playerid));
		ShowPlayerDialog(playerid, 1900, DIALOG_STYLE_PASSWORD, "Bienvenido!", string, "Registrar", "Cancelar");
		 //SendClientMessage(playerid,Amarillo,"Debes registrarte en www.losangeles-rp.com/pcu para ingresar al servidor.");
		 //KickWithMessage(playerid,"");
		  return 1;
		   }
		format(string,sizeof(string),"\n  ¡Bienvenido de nuevo %s!\n\nIngrese la contraseña de su personaje abajo.\n",pName(playerid));
		ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_PASSWORD, "Inicio de sesión - American RolePlay", string, "Log-in", "Cancelar");
		return 0;
	}
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
		//SendClientMessage(playerid, Amarillo, "Debes registrarte en losangeles-rp.com/pcu para poder ingresar al servidor.");
		//KickWithMessage(playerid,"");
		
	}
}

Cuentas_OnPlayerRequestSpawn(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
        	return 0;
	}
	return 1;
}

LimpiarVariables(playerid)
{
		//Reseteo de variables: Primero reseteamos todo, luego cargamos...
    //---[GENERALES]---
	EstaEn[playerid] = -1;
    PlayerInfo[playerid][pTrafico] = 0;
	JugadorChoque[playerid] = 0;
	BolDerechaID[playerid] = 0;
        BolDerechaTipo[playerid] = 0;
        BolDerechaCantidad[playerid] = 0;
        for(new i = 1;i < 13;i++)
    {
        BolsilloID[playerid][i] = 0;
        BolsilloTipo[playerid][i] = 0;
        BolsilloCantidad[playerid][i] = 0;
    }
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
    PlayerInfo[playerid][pLastCar2]=NOEXISTE;
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
	/*BuildingGangZone[playerid] = false;
	GetPos[playerid] = false;*/
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
		if(strfind( inputtext, "=", true ) != -1 ) return SendClientMessage(playerid, -1, "No se admiten pruebas de ese tipo.Si crees que fue un error, habla con la administración."), Ban(playerid), true;
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
	    if(response == 0) {  Kick(playerid); }
	    if(strfind( inputtext, "=", true ) != -1 ) return SendClientMessage(playerid, -1, "No se admiten pruebas de ese tipo.Si crees que fue un error, habla con la administración."), Ban(playerid), true;
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
      MensajeFormato(playerid,Amarillo,"Has ingresado la edad de %d años , recuerda que puedes editarla antes de ingresar datos",EdadTemporal[playerid]);
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
	  SendClientMessage(playerid,Amarillo,"Has escogido como sexo 'Hombre', puedes volver a editar antes de ingresar los datos");
	  SelectTextDraw(playerid, -1);
      }
      else //Mujer
      {

      SetPlayerSkin(playerid,12);
      PlayerInfo[playerid][pSkin] = 12;
      SexoTemporal[playerid] = 2;
      SendClientMessage(playerid,Amarillo,"Has escogido como sexo 'Mujer', puedes volver a editar antes de ingresar los datos");
      SelectTextDraw(playerid, -1);
      }
      }

      else if(dialogid == Dialogo_IngresarDatos)
      {
      if(response) //Si
      {
      if(SexoTemporal[playerid]==0)
      {
      Mensaje(playerid,Rojo,"Te falta escoger el sexo de tu personaje.");
      }
	  if(EdadTemporal[playerid]==0)
	  {
	  Mensaje(playerid,Rojo,"Te falta escoger la edad de tu personaje");
	  }
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
      MensajeFormato(playerid,Amarillo,"Has confirmado los datos.");
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
	  SendClientMessage(playerid,Blanco,"Origen del personaje:    Los Angeles");
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
	  //GameTextForPlayer(playerid, "~r~Ingresando datos, en breve comenzara~n~ el tutorial.", 3000, 3);
	  TextDrawHideForPlayer(playerid, Textdraw0);
	  TextDrawHideForPlayer(playerid, Textdraw1);
	  TextDrawHideForPlayer(playerid, Textdraw2);
	  TextDrawHideForPlayer(playerid, Textdraw3);
	  TextDrawHideForPlayer(playerid, Textdraw4);
	  SaveValue(playerid, "Certificacion", 3);
	  TogglePlayerControllable(playerid, 0);
	  SetPlayerVirtualWorld(playerid, 0);
	  SafeGivePlayerMoney(playerid,2000);
	  PlayerInfo[playerid][pBank] = 18000;
	  //SetTimerEx("ComenzarTutorial", 5000, false, "d", playerid);
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
      TituloRegistro[playerid] = CreatePlayerTextDraw(playerid,190.000000, 81.000000, "Registro - American Roleplay");
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
      else {
      SendClientMessage(playerid, AMARILLO, "Muchas gracias por visitar American Roleplay, ¡nos vemos pronto!");
      SendClientMessage(playerid, ROJO, "Has cancelado el registro.");
      SetTimerEx("KickRetra", 2000, false, "i", playerid);
      }
      
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
	print("TIRAENLOGOUT");
	if(IsPlayerNPC(playerid)) return 1;
	print("ASDF");
	PlayerInfo[playerid][pJugando] = 0;
print("ASDF");
	SaveValue(playerid, "Jugando", 0);
print("ASDF");
	SaveValues(playerid, "Coches");
print("ASDF");
	SaveValues(playerid, "CochesPrestados");
print("ASDF");
	SaveValues(playerid,"Inventario");
	if (PlayerInfo[playerid][TiempoEsperaTrabajo] > gettime() )
	SaveValue(playerid, "TiempoEsperaTrabajo", PlayerInfo[playerid][TiempoEsperaTrabajo] - gettime() );
 	else SaveValue(playerid, "TiempoEsperaTrabajo", 0);
 	SaveValue(playerid, "Ganancias",PlayerInfo[playerid][pGanancias] );
	SaveValue(playerid, "RutasCompletadas",PlayerInfo[playerid][pRutasCompletadas] );
	SaveValue(playerid, "Respeto",PlayerInfo[playerid][pRespeto]);
	SaveValue(playerid, "Banco",PlayerInfo[playerid][pBank]);
	SaveValue(playerid, "Dinero",SafeGetPlayerMoney(playerid));
	SaveValues(playerid, "Payday");
    	SaveValue(playerid, "Pasamontanas", PlayerInfo[playerid][pPasamontanas]);
    	SaveValue(playerid, "EstiloPelea", PlayerInfo[playerid][pEstiloPelea]);
    for(new i = 1;i < 13;i++)
	{
	    new sql[16];
	    format(sql, sizeof(sql), "Bol%dID", i);
	    SaveValue(playerid, sql, BolsilloID[playerid][i]);
	    format(sql, sizeof(sql), "Bol%dTipo", i);
	    SaveValue(playerid, sql, BolsilloTipo[playerid][i]);
	    format(sql, sizeof(sql), "Bol%dCantidad", i);
	    SaveValue(playerid, sql, BolsilloCantidad[playerid][i]);
	}
	SaveValue(playerid, "CinturonID", CinturonID[playerid]);
	SaveValue(playerid, "CinturonCantidad", CinturonCantidad[playerid]);
	SaveValue(playerid, "CinturonTipo", CinturonTipo[playerid]);
	
	SaveValue(playerid, "EspaldaID", EspaldaID[playerid]);
	SaveValue(playerid, "EspaldaCantidad", EspaldaCantidad[playerid]);
	SaveValue(playerid, "EspaldaTipo", EspaldaTipo[playerid]);
	
	extranoid[playerid] = 0;
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
	PlayerInfo[playerid][pEsLider] = GetValue(playerid, "EsLider");
	PlayerInfo[playerid][pJob] = GetValue(playerid, "Trabajo");
	PlayerInfo[playerid][pContrato] = GetValue(playerid, "Contrato");
	PlayerInfo[playerid][pInt] = GetValue(playerid, "Interior");
	PlayerInfo[playerid][pHq] = GetValue(playerid, "HQ");
	PlayerInfo[playerid][pVw] = GetValue(playerid, "VirtualWorld");
	PlayerInfo[playerid][pNegocio] = GetValue(playerid, "PosNeg");
	PlayerInfo[playerid][pPhousekey] = GetValue(playerid, "Casa");
	PlayerInfo[playerid][pPbiskey] = GetValue(playerid, "Negocio");
    PlayerInfo[playerid][pSex] = GetValue(playerid, "sexo");
	PlayerInfo[playerid][pSkin] = GetValue(playerid, "Skin");
	PlayerInfo[playerid][pUniforme] = GetValue(playerid, "Uniforme");
	PlayerInfo[playerid][pDuty] = GetValue(playerid, "EnServicio");
	PlayerInfo[playerid][pHerido] = GetValue(playerid, "Herido");
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
	PlayerInfo[playerid][pTrafico] = GetValue(playerid, "Trafico");
	for(new i = 1;i < 13;i++)
	{
	    new sql[16];
	    format(sql, sizeof(sql), "Bol%dID", i);
		BolsilloID[playerid][i] = GetValueFromName(playerid, sql);
	    format(sql, sizeof(sql), "Bol%dTipo", i);
		BolsilloTipo[playerid][i] = GetValueFromName(playerid, sql);
	    format(sql, sizeof(sql), "Bol%dCantidad", i);
		BolsilloCantidad[playerid][i] = GetValueFromName(playerid, sql);
	}
	CinturonID[playerid] = GetValue(playerid, "CinturonID");
	CinturonCantidad[playerid] = GetValue(playerid, "CinturonCantidad");
	CinturonTipo[playerid] = GetValue(playerid, "CinturonTipo");

	EspaldaID[playerid] = GetValue(playerid, "EspaldaID");
	EspaldaCantidad[playerid] = GetValue(playerid, "EspaldaCantidad");
	EspaldaTipo[playerid] = GetValue(playerid, "EspaldaTipo");


	/*BolsilloID[playerid][1] = GetValue(playerid, "Bol1ID");
	BolsilloID[playerid][2] = GetValue(playerid, "Bol2ID");
	BolsilloID[playerid][3] = GetValue(playerid, "Bol3ID");
	BolsilloID[playerid][4] = GetValue(playerid, "Bol4ID");
	BolsilloID[playerid][5] = GetValue(playerid, "Bol5ID");
	BolsilloID[playerid][6] = GetValue(playerid, "Bol6ID");
	BolsilloID[playerid][7] = GetValue(playerid, "Bol7ID");
	BolsilloID[playerid][8] = GetValue(playerid, "Bol8ID");
	BolsilloID[playerid][9] = GetValue(playerid, "Bol9ID");
	BolsilloID[playerid][10] = GetValue(playerid, "Bol10ID");
	BolsilloID[playerid][11] = GetValue(playerid, "Bol11ID");
	BolsilloID[playerid][12] = GetValue(playerid, "Bol12ID");
	
	
    BolsilloTipo[playerid][1] = GetValue(playerid,"Bol1Tipo");
    BolsilloTipo[playerid][2] = GetValue(playerid,"Bol2Tipo");
    BolsilloTipo[playerid][3] = GetValue(playerid,"Bol3Tipo");
    BolsilloTipo[playerid][4] = GetValue(playerid,"Bol4Tipo");
    BolsilloTipo[playerid][5] = GetValue(playerid,"Bol5Tipo");
    BolsilloTipo[playerid][6] = GetValue(playerid,"Bol6Tipo");
    BolsilloTipo[playerid][7] = GetValue(playerid,"Bol7Tipo");
    BolsilloTipo[playerid][8] = GetValue(playerid,"Bol8Tipo");
    BolsilloTipo[playerid][9] = GetValue(playerid,"Bol9Tipo");
    BolsilloTipo[playerid][10] = GetValue(playerid,"Bol10Tipo");
    BolsilloTipo[playerid][11] = GetValue(playerid,"Bol11Tipo");
    BolsilloTipo[playerid][12] = GetValue(playerid,"Bol12Tipo");
    
    
    BolsilloCantidad[playerid][1] = GetValue(playerid,"Bol1Cantidad");
    BolsilloCantidad[playerid][2] = GetValue(playerid,"Bol2Cantidad");
    BolsilloCantidad[playerid][3] = GetValue(playerid,"Bol3Cantidad");
    BolsilloCantidad[playerid][4] = GetValue(playerid,"Bol4Cantidad");
    BolsilloCantidad[playerid][5] = GetValue(playerid,"Bol5Cantidad");
    BolsilloCantidad[playerid][6] = GetValue(playerid,"Bol6Cantidad");
    BolsilloCantidad[playerid][7] = GetValue(playerid,"Bol7Cantidad");
    BolsilloCantidad[playerid][8] = GetValue(playerid,"Bol8Cantidad");
    BolsilloCantidad[playerid][9] = GetValue(playerid,"Bol9Cantidad");
    BolsilloCantidad[playerid][10] = GetValue(playerid,"Bol10Cantidad");
    BolsilloCantidad[playerid][11] = GetValue(playerid,"Bol11Cantidad");
    BolsilloCantidad[playerid][12] = GetValue(playerid,"Bol12Cantidad");
    
    
    DarObjeto(playerid, BolsilloID[playerid][1], BolsilloTipo[playerid][1], BolsilloCantidad[playerid][1]);
    DarObjeto(playerid, BolsilloID[playerid][2], BolsilloTipo[playerid][2], BolsilloCantidad[playerid][2]);
    DarObjeto(playerid, BolsilloID[playerid][3], BolsilloTipo[playerid][3], BolsilloCantidad[playerid][3]);
    DarObjeto(playerid, BolsilloID[playerid][4], BolsilloTipo[playerid][4], BolsilloCantidad[playerid][4]);
    DarObjeto(playerid, BolsilloID[playerid][5], BolsilloTipo[playerid][5], BolsilloCantidad[playerid][5]);
    DarObjeto(playerid, BolsilloID[playerid][6], BolsilloTipo[playerid][6], BolsilloCantidad[playerid][6]);
    DarObjeto(playerid, BolsilloID[playerid][7], BolsilloTipo[playerid][7], BolsilloCantidad[playerid][7]);
    DarObjeto(playerid, BolsilloID[playerid][8], BolsilloTipo[playerid][8], BolsilloCantidad[playerid][8]);
    DarObjeto(playerid, BolsilloID[playerid][9], BolsilloTipo[playerid][9], BolsilloCantidad[playerid][9]);
    DarObjeto(playerid, BolsilloID[playerid][10], BolsilloTipo[playerid][10], BolsilloCantidad[playerid][10]);
    DarObjeto(playerid, BolsilloID[playerid][11], BolsilloTipo[playerid][11], BolsilloCantidad[playerid][11]);
    DarObjeto(playerid, BolsilloID[playerid][12], BolsilloTipo[playerid][12], BolsilloCantidad[playerid][12]);*/
	
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
	GetValues(playerid, "Inventario");
	GetValues(playerid, "Encarcelado");
	GetValues(playerid, "Telefonos");
	GetValues(playerid, "LArmas");
	GetValues(playerid, "Muebles");
	//GetValues(playerid, "Bolsillos");

	new Bloqueado = GetValue(playerid, "Bloqueado");
	if(Bloqueado == 1){ SendClientMessage(playerid,Naranja,"Esta cuenta está bloqueada, pasate por el foro para solucionarlo."); return Kick(playerid); }
	
	
	//new Certificacion = GetValue(playerid, "Certificacion");
	//if(Certificacion == 0){ SendClientMessage(playerid,Naranja,"Tu cuenta no está certificada, espera por la aprobación."); return KickWithMessage(playerid,"");}
	//if(Certificacion == 3){ SendClientMessage(playerid,Naranja,"Aún no has terminado el proceso de certificación."); return Kick(playerid);}
	//if(Certificacion == 2){ SendClientMessage(playerid,Naranja,"Has sido reeducado y aún no has pasado de nuevo el proceso de certificación."); return Kick(playerid);}
	
	SetPlayerScore(playerid, GetPlayerLevel(playerid));
	PlayerInfo[playerid][pJugando] = 1; SaveValue(playerid, "Jugando", 1);
	
	if(PlayerInfo[playerid][pPos_x] == 0.0 && PlayerInfo[playerid][pPos_y] == 0.0 && PlayerInfo[playerid][pPos_z] == 0.0)
	{
	PlayerInfo[playerid][pPos_x] = 1128.8754;
	PlayerInfo[playerid][pPos_y] = -1490.4360;
	PlayerInfo[playerid][pPos_z] = 22.7690;
	}
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
	
	
	extranoid[playerid] = playerid*24;
	 if(playerid == 0) extranoid[playerid] = 50;
    	SaveValue(playerid, "Conectado", 1);

	if(EsArma(BolsilloID[playerid][11]))
	{
	ResetPlayerWeapons(playerid);
	SafeGivePlayerWeapon(playerid, BolsilloID[playerid][11], BolsilloCantidad[playerid][11]);
	}
	ActualizarObjetos(playerid);
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
	return 1;
}

Cuentas_OnPlayerSpawn(playerid)
{

	/*if(PlayerInfo[playerid][pJailed] == 1)
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,198.0853,158.8262,1003.0234);
	}
	if(PlayerInfo[playerid][pJailed] == 3)
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPosEx(playerid,197.9805,178.2182,1003.0234);
	}
	if(PlayerInfo[playerid][pJailed] == 5)
	{
		SetPlayerInterior(playerid, 2);
		SetPlayerPosEx(playerid,2583.8286,-1325.6830,1047.9634);
                //SetPlayerWorldBounds(playerid, -217.4910, -221.5403, 1408.2410, 1412.1958);
	}*/
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
//	if(IsValidNPC(playerid)) return 0;
	if(PlayerInfo[playerid][pJugando] == 1) 
	{
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
		OnPlayerLogout(playerid);
	}
	return 0;
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
	format(string,sizeof(string),"Bienvenido a Los Angeles, %s.", pName(playerid));
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
			TogglePlayerControllable(playerid,1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "Has cancelado la selección.");
    	return 1;
	}
	
	return 1;
}
