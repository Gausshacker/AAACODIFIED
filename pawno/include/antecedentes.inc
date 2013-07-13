#include <a_samp>
#include <globalvars>
#include <colores>

new AntecedenteE[MAX_PLAYERS];
enum aDatos
{
	aNombre[24],
	aDescripcion[128],
	aDia,
	aMes,
	aAno,
}
new Antecedentes[MAX_PLAYERS][aDatos];

new MaxRegistros2;

new Escribiendo[MAX_PLAYERS];
 //Numero de telefono que usa (para llamar o sms)



LoadAntecedentes()
{
	new sql[80], row[512], count;
	format(sql, sizeof(sql), "SELECT COUNT(*) FROM antecedentes");
	mysql_query(sql);
	mysql_store_result();
	mysql_fetch_row(row);
	count = strval(row);
	
	for (new idx=1; idx<=count; idx++)
	{
		format(sql, sizeof(sql), "SELECT * FROM antecedentes WHERE id=%d LIMIT 1", idx);
	    mysql_query(sql);
	    mysql_store_result();
     	mysql_fetch_row(row);
		split(row, arrCoords, '|');
	
		Antecedente[idx][aId] = strval(arrCoords[0]);
		format(Antecedente[idx][aNombre], 24, "%s", arrCoords[1]);
		format(Antecedente[idx][aDescripcion], 128, "%s", arrCoords[2]);
		Antecedente[idx][aDia] = strval(arrCoords[3]);
		Antecedente[idx][aMes] = strval(arrCoords[4]);
		Antecedente[idx][aAno] = strval(arrCoords[5]);
	}
	
	MaxRegistros2 = count;
	return 1;
}

stock GuardarAntecedente(idx)
{
	format(string, 128, "UPDATE antecedentes SET Nombre='%s', Descripcion='%s', Dia=%d, Mes=%d ,Ano=%d WHERE id=%d",
		Antecedente[idx][aNombre],
		Antecedente[idx][aDescripcion],
		Antecedente[idx][aDia],
		Antecedente[idx][aMes],
		Antecedente[idx][aAno],
		Antecedente[idx][aId]);
	mysql_query(string);
	return 1;
}



Antecedente(playerid, operacion, letras[], id[])
{
	new count;
	switch(operacion)
	{
		case 1:
		{ 	// Agregar antecedente
			SendClientMessage(playerid, Amarillo, "Nuevo contacto de agenda.");
			SendClientMessage(playerid, AmarilloClaro, "Ingresa un nombre para este contacto.");
			AgendaE[playerid] = 1;
		}
		case 3:
		{
			//Ver Anteceednte
			SendClientMessage(playerid, Amarillo, "Agenda del móvil");
			if(strlen(letras))
			{
				format(string, 128, "Personas que contienen %s:", letras);
				SendClientMessage(playerid, AmarilloClaro, string);
				
				for(new i= 1; i <= MaxRegistros; i++)
				{
					if(Antecedente[i][aId] == NOEXISTE) { continue; }
					if(Antecedente[i][aId] == PlayerInfo[playerid][pSQLID])
					{
						if(strfind(Registro[i][rNombre], letras, true, 0) != -1)
						{
							format(string, 128, "- %s - %d", Registro[i][rNombre], Registro[i][rNumero]);
							SendClientMessage(playerid, AmarilloClaro, string);
						}
					}
				}
			}
			else
			{
				format(string, 128, "Algunos contactos (Usa /agenda ver [Letra(s)] para buscar un contacto exacto):");
				SendClientMessage(playerid, AmarilloClaro, string);
				
				new p = 0;
				for(new i= 1; i <= MaxRegistros; i++)
				{
					if(Registro[i][rId] == NOEXISTE) continue;
					if(Registro[i][rProp] == PlayerInfo[playerid][pSQLID])
					{
						if(p == 20) break;
						format(string, 128, "- %s - %d", Registro[i][rNombre], Registro[i][rNumero]);
						SendClientMessage(playerid, AmarilloClaro, string);
						p++;
					}
				}
			}
		}
		case 4:
		{
			if(strlen(id) <= 3 && strlen(id) > 0)
			{
				new player;
				player = strval(id);
				if(IsPlayerConnected(player))
				{
					for(new i = 1; i <= MaxRegistros; i++)
					{
						if(Registro[i][rId] == NOEXISTE) continue;
						
						if(Registro[i][rNumero] == PlayerInfo[player][pPnumber][0])
						{
							if(Registro[i][rProp] == PlayerInfo[playerid][pSQLID])
							{
								return PlayerInfo[player][pPnumber][0];
							}
						}
						if(Registro[i][rNumero] == PlayerInfo[player][pPnumber][1])
						{
							if(Registro[i][rProp] == PlayerInfo[playerid][pSQLID])
							{
								return PlayerInfo[player][pPnumber][1];
							}
						}
					}
				}
			}

			else if(strlen(letras))
			{
				for(new i; i < MaxRegistros; i++)
				{
					if(Registro[i][rId] == NOEXISTE) continue;
					
					if(Registro[i][rProp] == PlayerInfo[playerid][pSQLID])
					{
						if(strcmp(Registro[i][rNombre], letras, true) == 0)
						{
							count = Registro[i][rNumero];
						}
					}
				}
				if(count > 0) return count;
				else
				{
					new player;
					player = ReturnUser(letras);
					format(string, 128, "%d", player);
					return Agenda(playerid, 4, "", string);
				}
			}
		}
		
	}
	return 1;
}


	
	if(strcmp(cmd, "/agenda", true) == 0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /agenda [Ver|Nuevo|Borrar|Solicitar]");
		}
		else if(strcmp(tmp, "Ver", true) == 0)
		{
			tmp = strtokex(cmdtext, idx);
			Agenda(playerid, 3, tmp, "");
		}
		else if(strcmp(tmp, "Borrar", true) == 0)
		{
			Agenda(playerid, 2, "", "");
		}
		else if(strcmp(tmp, "Nuevo", true) == 0)
		{
			Agenda(playerid, 1, "", "");
		}
		/*else if(strcmp(tmp, "Solicitar", true) == 0)
		{

			Agenda(playerid, 5, "", "");
		}*/
		return 1;
	}

	

Tlf_OnPlayerText(playerid, text[])
{
	if(PlayerInfo[playerid][pUsandoTelefono] == 2 || PlayerInfo[playerid][pUsandoTelefono] == 3 || PlayerInfo[playerid][pUsandoTelefono] == 914 || PlayerInfo[playerid][pUsandoTelefono] == 915)
	{
		format(string, 128, "(Teléfono): %s", text);
		SendClientMessage(PlayerInfo[playerid][pIncomingCall], Amarillo, string);
		ProxDetector(5.0, playerid, string, Gris, Gris, Gris, Gris, Gris);
		return 1;
	}
	else if(PlayerInfo[playerid][pUsandoTelefono] == 4)
	{
		format(string, 128, "Mensaje de Voz: %s, Tlf: %d", text, PlayerInfo[playerid][pPnumber][ActiveNumber[playerid]]);
		SendClientMessage(PlayerInfo[playerid][pIncomingCall], Amarillo, string);
		format(string, 128, "Mensaje de Voz: %s, Tlf: %d", text, PlayerInfo[playerid][pIncomingCall]);
		SendClientMessage(playerid, Gris, string);
		ColgarTelefono(playerid);
		return 1;
	}
	else if(AgendaE[playerid] == 1)
	{
		format(AgendaMemoria[playerid][aNombre], 24, "%s", text);
		SendClientMessage(playerid, Amarillo, "Ahora ingresa el número de este contacto.");
		AgendaE[playerid] = 2;
		return 1;
	}
	   else if(PlayerInfo[playerid][SolicitarNumero] == 1)
	    {
	    
		
		if(IsNumeric(text))
		{
		 new id;
		id = strval(text);
	
		if(!IsPlayerConnected(id)) { SendClientMessage(playerid,Rojo,"El jugador no esta conectado"); PlayerInfo[playerid][SolicitarNumero] = 0; return 1; }
		//if(PlayerInfo[playerid][pPnumber][0]==0) return SendClientMessage(playerid,Rojo,"El jugador no tiene telefono");
		//if(PlayerInfo[playerid][pPnumber][1]==0) return SendClientMessage(playerid,Rojo,"El jugador no tiene telefono");
		format(string,128,"Le has solicitado el número a %s , espera..",pName(id));
		SendClientMessage(playerid,Amarillo,string);
		format(string,128,"El jugador %s te esta solicitando el numero escribe /aceptar numero..",pName(playerid));
		SendClientMessage(id,Amarillo,string);
		PlayerInfo[id][EstanSolicitando] = 1;
		PlayerInfo[playerid][IDSolicitud1] = id;
		PlayerInfo[id][IDSolicitud2] = playerid;
		}
		return 1;
	}
	else if(AgendaE[playerid] == 2)
	{
		new count;
		AgendaMemoria[playerid][aNumero] = strval(text);
		format(string, 128, "Contacto: %s con número: %d - Creado.", AgendaMemoria[playerid][aNombre], AgendaMemoria[playerid][aNumero]);
		SendClientMessage(playerid, AmarilloClaro, string);
		format(string, 128, "INSERT INTO agenda (nombre, numero, propietario) VALUES ('%s',%d,%d)", AgendaMemoria[playerid][aNombre], AgendaMemoria[playerid][aNumero], PlayerInfo[playerid][pSQLID]);
		mysql_query(string);
		count = MaxRegistros +1;
		
		Registro[count][rId] = count;
		format(Registro[count][rNombre], 24, "%s", AgendaMemoria[playerid][aNombre]);
		Registro[count][rNumero] = AgendaMemoria[playerid][aNumero];
		Registro[count][rProp] = PlayerInfo[playerid][pSQLID];
		
		MaxRegistros++;
		
		AgendaE[playerid] = 0;
		return 1;
	}
	else if(AgendaE[playerid] == 10)
	{	
		new id = 0;
		for(new i = 1; i <= MaxRegistros; i++)
		{
			if(Registro[i][rId] == NOEXISTE) continue;
			
			if(Registro[i][rProp] == PlayerInfo[playerid][pSQLID])
			{
				if(Registro[i][rNumero] == strval(text))
				{
					id = i;
				}
				else if(strcmp(Registro[i][rNombre], text, true) == 0)
				{
					id = i;
				}
			}
		}
		
		if(id == 0)
		{
			SendClientMessage(playerid, Naranja, "* Ningun contacto concuerda con tu busqueda.");
			AgendaE[playerid] = 0;
			return 1;
		}
		
		if(IsNumeric(text))
		{
			format(string, 128, "¿Seguro que quieres eliminar a '%d' de tu agenda? Escribe 'Si' o 'No'.", strval(text));
		}
		else
		{
			format(string, 128, "¿Seguro que quieres eliminar a '%s' de tu agenda? Escribe 'Si' o 'No'.", text);
		}
		SendClientMessage(playerid, Amarillo, string);
		AgendaMemoria[playerid][aNumero] = id;
		AgendaE[playerid] = 11;
		return 1;
	}
	else if(AgendaE[playerid] == 11)
	{
		if(strcmp(text, "Si", true) == 0)
		{
			format(string, 128,"DELETE FROM agenda WHERE id = %d", Registro[AgendaMemoria[playerid][aNumero]][rId]);
			mysql_query(string);
			SendClientMessage(playerid, Verde, "Eliminado de la agenda.");
			AgendaE[playerid] = 0;
			Registro[AgendaMemoria[playerid][aNumero]][rId] = NOEXISTE;
			return 1;
		}
		else if(strcmp(text, "No", true) == 0)
		{
			SendClientMessage(playerid, Rojo, "Operación abortada.");
			AgendaE[playerid] = 0;
			return 1;
		}
	}
	else if(Escribiendo[playerid] > NOEXISTE)
	{
		new frec = Escribiendo[playerid];
		if(strcmp(Frecuencia[frec][fPassword], text, true) == 0)
		{
			PlayerInfo[playerid][pFrecuencia] = Frecuencia[frec][fId];
			SendClientMessage(playerid, Verde, "* Password aceptada. Frecuencia sintonizada correctamente.");
			Escribiendo[playerid] = NOEXISTE;
			SaveValue(playerid, "Frecuencia", PlayerInfo[playerid][pFrecuencia]);
			return 1;
		}
		else 
		{
			SendClientMessage(playerid, Rojo, "* Password incorrecta. Operación abortada.");
			Escribiendo[playerid] = NOEXISTE;
			return 1;
		}
	}

	return 0;
}


