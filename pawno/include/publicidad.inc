#include <globalvars>
#include <funciones>




forward IngresarAnuncio(playerid,textoad[],tiempo);
forward MostrarAnuncios(playerid);
forward EliminarAnuncio(id);

public EliminarAnuncio(id)
{
AnunciosInfo[id][aID] = NOEXISTE;
format(AnunciosInfo[id][aProp], 24, "%s", "Nadie");
format(AnunciosInfo[id][aTexto], 256, "%s", "Nada");
AnunciosInfo[id][aTiempo] = NOEXISTE;
AnunciosInfo[id][aMostrar] = NOEXISTE;
AnunciosInfo[id][aCreado] = NOEXISTE;
return 1;
}





public MostrarAnuncios(playerid)
{
for(new i=0; i<MAX_ANUNCIOS; i++)
{
if(AnunciosInfo[i][aCreado] != NOEXISTE)
{
format(string,128,"Anuncio: %s Contacto : %s", AnunciosInfo[i][aTexto], AnunciosInfo[i][aProp]);
SendClientMessage(playerid,Amarillo,string);
break;

}

}
return 1;
}

public IngresarAnuncio(playerid,textoad[],tiempo)
{

if(anunciostotal==MAX_ANUNCIOS) return SendClientMessage(playerid,Rojo,"No se pueden ingresar mas anucios");
for(new i=0;i<MAX_ANUNCIOS;i++)
{
if(AnunciosInfo[i][aCreado]!=NOEXISTE)
{
AnunciosInfo[i][aID] = i;
format(AnunciosInfo[i][aProp], 24, "%s", pName(playerid));
format(AnunciosInfo[i][aTexto], 256, "%s", textoad);
AnunciosInfo[i][aTiempo] = tiempo;
AnunciosInfo[i][aMostrar] = 1;
AnunciosInfo[i][aCreado] = 1;
format(string,128,"Has enviado un anuncio id: %d con el mensaje %s",AnunciosInfo[i][aID],AnunciosInfo[i][aTexto]);
SendClientMessage(playerid,Amarillo,string);
anunciostotal++;

}
}

//Fin Bucle
return 1;
}


