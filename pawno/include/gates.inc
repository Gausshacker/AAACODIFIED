#include <a_samp>
#include <colores>
#include <globalvars>
#include <funciones>

new TotalGates;



Gates_OnGameModeInit()
{
	CargarGates();

	return 1;
}


LoadNegocio()
{
	new sql[80], row[512], gatescount, galiminado;
	format(sql, sizeof(sql), "SELECT COUNT(*) FROM gates");
	mysql_query(sql);
	mysql_store_result();
	mysql_fetch_row(row);
	gatescount = strval(row);

	for (new idx=1; idx<=gatescount; idx++)
	{
		format(sql, sizeof(sql), "SELECT * FROM gates WHERE id=%d LIMIT 1", idx);
	    mysql_query(sql);
	    mysql_store_result();
     	mysql_fetch_row(row);
		split(row, arrCoords, '|');
		galiminado = strval(arrCoords[16]);
		if(galiminado == 0)
		{
			NegocioInfo[idx][nId] = strval(arrCoords[0]);
			format(NegocioInfo[idx][nName], 128, "%s", arrCoords[1]);
			NegocioInfo[idx][nType] = strval(arrCoords[2]);
			NegocioInfo[idx][nEPos_x] = floatstr(arrCoords[3]);
			NegocioInfo[idx][nEPos_y] = floatstr(arrCoords[4]);
			NegocioInfo[idx][nEPos_z] = floatstr(arrCoords[5]);
			NegocioInfo[idx][nSPos_x] = floatstr(arrCoords[6]);
			NegocioInfo[idx][nSPos_y] = floatstr(arrCoords[7]);
			NegocioInfo[idx][nSPos_z] = floatstr(arrCoords[8]);
			NegocioInfo[idx][nProd] = strval(arrCoords[9]);
			NegocioInfo[idx][nCajaFuerte] = strval(arrCoords[10]);
			NegocioInfo[idx][nLocked] = strval(arrCoords[11]);
			format(NegocioInfo[idx][nOwner], 128, "%s", arrCoords[12]);
			NegocioInfo[idx][nOwned] = strval(arrCoords[13]);
			NegocioInfo[idx][nInterior] = strval(arrCoords[14]);
			NegocioInfo[idx][nCosto] = strval(arrCoords[15]);

			TotalGates++;
		}
	}

	printf("Gates: %d (MAX: %d)",TotalGates,MAX_GATES);
	mysql_free_result();
	return 1;
}
