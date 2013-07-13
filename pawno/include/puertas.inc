#include <a_samp>
#include <globalvars>
#include <funciones>
#include <colores>

//new PDe;// palo exterior, garaje policía (rota)
new lspdgate; // puerta garaje policía
//new barrera;
new jgate; //Jin Azugay's gate
new ggate;//Gay Palmer's gate
new ggate_state = 0;//Cerrada por defecto

new depositogate1;
new depositogate2;
new depositoestado = 0;
//new tgate; // Taxistas' gate
new puertacomi1,puertacomi2,puertacomi3,puertacomi4,puertacomi5,puertacomi6,puertacomi7;

new puertacomi8,puertacomi9,puertacomi10,puertacomi11,puertacomi12,puertacomi13;


new puertasheriff1,puertasheriff2;


//Nueva comisaria Franco
new puertafranco1; //Carcel 1
new puertafranco2; //Carcel 1
new puertafranco3; //Carcel 1

new puertafranco4; //Entrada a las cárceles

new puertafranco5; //Entrada a los confesionarios
//

new puertafranco6; //Entrada IZq
new puertafranco7; //Entrada dere


new puertacarcel1; //Recepcion Cerrada
new puertacarcel2; //Puerta de la seccion de la derecha interrogatorios

//CEldas
new celda1;   //celda 1 izq derecha
new celda2; // celda 2
new celda3,celda4,celda5,celda6;
//

new duchas1;

Puertas_OnGameModeInit()
{
	lspdgate = CreateDynamicObject(10558, 1588.6029, -1638.3813, 14.4201, 0.0000, 0.0000, 269.6265); //LSPDt 1
	
	depositogate1 = CreateDynamicObject(985, -493.40, -562.91, 26.16,   0.00, 0.00, 180.00);//Cerrada
	depositogate2 = CreateDynamicObject(986, -485.44, -562.89, 26.16,   0.00, 0.00, 180.00);//Cerrada
	//PDe = CreateDynamicObject(968, 1544.670532, -1630.744873, 13.182366, 1.7189, 90.2408, 89.3814); //LSPD 2
	puertacomi1 = CreateDynamicObject(1569, 228.24, 150.46, 1001.95,   0.00, 0.00, 90.00);
	puertacomi2 = CreateDynamicObject(1569, 228.25, 160.48, 1002.03,   0.00, 0.00, 90.00);
	puertacomi3 = CreateDynamicObject(1569, 230.73, 169.82, 1002.02,   0.00, 0.00, 0.00);//Cerrada
	puertacomi4 = CreateDynamicObject(1569, 246.44, 193.65, 1007.17,   0.00, 0.00, 0.00); //Cerrada
	puertacomi5 = CreateDynamicObject(1569, 265.06, 190.47, 1007.17,   0.00, 0.00, 90.00);//Cerrada
	puertacomi6 = CreateDynamicObject(1569, 274.84, 189.39, 1006.17,   0.00, 0.00, 0.00);//Cerrada
	puertacomi7 = CreateDynamicObject(1569, 295.90, 189.36, 1006.17,   0.00, 0.00, 0.00);//Cerrada
	puertacomi8 = CreateDynamicObject(19303, 198.94, 160.32, 1003.26,   0.00, 0.00, 180.00);//Cerrada
	puertacomi9 = CreateDynamicObject(19303, 194.70, 160.40, 1003.26,   0.00, 0.00, 180.00);//Cerrada
	puertacomi10 = CreateDynamicObject(19303, 190.45, 160.42, 1003.26,   0.00, 0.00, 180.00);//Cerrada
	puertacomi11 = CreateDynamicObject(19303, 197.19, 176.97, 1003.26,   0.00, 0.00, 0.00);//Cerrada
	puertacomi12 = CreateDynamicObject(19303, 192.95, 177.02, 1003.26,   0.00, 0.00, 0.00);//Cerrada
	puertacomi13 = CreateDynamicObject(19303, 188.70, 177.04, 1003.26,   0.00, 0.00, 0.00);//Cerrada
	
	
	//puertasheriff1 = CreateDynamicObject(977,250.62304688,62.25606537,1003.46875000,0.00000000,0.00000000,102.00000000);
	//puertasheriff2 = CreateDynamicObject(977,247.46295166,72.61702728,1003.96923828,0.00000000,0.00000000,190.25001526);
	jgate = CreateDynamicObject(10558,1643.30000000,-1715.00000000,16.00000000,0.00000000,0.00000000,0.00000000);
	ggate = CreateDynamicObject(975,1469.51904297,-1494.60839844,14.22451973,0.00000000,0.00000000,87.80010986);
	//tgate = CreateDynamicObject(975, 2534.1584472656, -1515.5895996094, 24.67022895813, 0, 0, 0);
	
	puertafranco1 = CreateDynamicObject(19303, 266.30, 78.46, 1001.30,   0.00, 0.00, -90.00);
	puertafranco2 = CreateDynamicObject(19303, 266.25, 82.96, 1001.30,   0.00, 0.00, -90.00);
	puertafranco3 = CreateDynamicObject(19303, 266.27, 87.46, 1001.30,   0.00, 0.00, -90.00);
	puertafranco4 = CreateDynamicObject(19302, 258.95, 91.00, 1002.69,   0.00, 0.00, 270.35);
	puertafranco5 = CreateDynamicObject(19303, 258.37, 88.02, 1002.67,   0.00, 0.00, 180.00);
	puertafranco6 = CreateDynamicObject(1569, 244.92, 72.47, 1002.64,   0.00, 0.00, 0.00);
	puertafranco7 = CreateDynamicObject(1569, 247.89, 72.47, 1002.64,   0.00, 0.00, -180.00);
	
 //Carcel
	puertacarcel1 = CreateDynamicObject(19303, 2576.97, -1369.21, 1048.16,   0.00, 0.00, 0.00);
	puertacarcel2 = CreateDynamicObject(1569, 2577.59, -1364.18, 1046.88,   0.00, 0.00, 0.00);
	celda1 = CreateDynamicObject(19302, 2589.83, -1327.63, 1044.03,   0.00, 0.00, 0.00);
	celda2 = CreateDynamicObject(19302, 2593.85, -1327.64, 1044.03,   0.00, 0.00, 0.00);
	celda3 = CreateDynamicObject(19302, 2597.79, -1327.66, 1044.03,   0.00, 0.00, 0.00);
	celda4 = CreateDynamicObject(19302, 2601.71, -1327.68, 1044.03,   0.00, 0.00, 0.00);
	celda5 = CreateDynamicObject(19302, 2605.74, -1327.66, 1044.03,   0.00, 0.00, 0.00);
	celda6 = CreateDynamicObject(19302, 2609.73, -1327.70, 1044.03,   0.00, 0.00, 0.00);
	duchas1 = CreateDynamicObject(19302, 2622.20, -1345.99, 1044.10,   0.00, 0.00, 90.00);
	return 1;
}

Puertas_OnPlayerCommandText(playerid,cmdtext[])
{
	new cmd[128];
	new idx;
	cmd = strtokex(cmdtext, idx);
	if(strcmp(cmd, "/ap", true) == 0)
	{
        if(PlayerToPoint(25.0,playerid,1588.5617, -1638.0871, 5.7200))
		{
			if(PlayerInfo[playerid][pMember] == 1)
			{
				MoveDynamicObject(lspdgate, 1588.6631, -1638.3735, 18.4032, 1);
				format(string,sizeof(string), "* %s usa su control remoto para abrir la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"La puerta se cerrará automáticamente en 10 segundos");
				SetTimerEx("CloseGate",10000,0,"p",lspdgate);
			}
		}
		/*else if(PlayerToPoint(25.0,playerid,1544.683593,-1630.765991,12.952643))
		{
			if(PlayerInfo[playerid][pMember] == 1)
			{
				SetDynamicObjectRot(PDe,0.0000, 0.0000, 89.3814); //LSPD2 :)
				format(string,sizeof(string), "* %s le avisa al oficial en la cabina que levante la barrera.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"La barrera se cerrará automáticamente en 5 segundos");
				SetTimerEx("CloseGate",8000,0,"p",barrera);
			}
		}*/
		else if(PlayerToPoint(50.0,playerid,1643, -1715, 16.299999237061))
		{
			if(PlayerInfo[playerid][pMember] == 91)
			{
				MoveDynamicObject(jgate,1643.30000000,-1707.00000000,16.00000000, 1);
				format(string,sizeof(string), "* %s usa su control remoto para abrir la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"La barrera se cerrará automáticamente en 10 segundos");
				SetTimerEx("CloseGate",10000,0,"p",jgate);
			}
		}
		else if(PlayerToPoint(25.0,playerid,-492.0030,-571.1730,23.4867))
		{
			if(PlayerInfo[playerid][pMember] == 1 && depositoestado == 0)
			{
				MoveDynamicObject(depositogate1,-500.40, -562.91, 26.16, 1);
				MoveDynamicObject(depositogate2, -478.44, -562.89, 26.16, 1);
				depositoestado = 1;
				format(string,sizeof(string), "* %s usa su control remoto para abrir la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"Para cerrar la barrera usa /ap.");
			}
			else if(PlayerInfo[playerid][pMember] == 1 && depositoestado == 1)
			{
				CloseGate(depositogate1);
				CloseGate(depositogate2);
				depositoestado = 0;
				format(string,sizeof(string), "* %s usa su control remoto para cerrar la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
			}
		}
		/*else if(PlayerToPoint(25.0,playerid,2525.828125, -1515.7279052734, 24.670562744141))
		{
			if(PlayerInfo[playerid][pMember] == 3)
			{
				MoveDynamicObject(tgate,2525.828125, -1515.7279052734, 24.670562744141, 1);
				format(string,sizeof(string), "* %s usa su control remoto para abrir la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"La barrera se cerrará automáticamente en 5 segundos");
				SetTimerEx("CloseGate",8000,0,"p",tgate);
			}
		}*/
		else if(PlayerToPoint(25.0,playerid,1469.51904297,-1486.60839844,14.22451973))
		{
			if(PlayerInfo[playerid][pMember] == 92 && ggate_state == 0)
			{
				MoveDynamicObject(ggate,1469.51904297,-1486.60839844,14.22451973, 1);
				ggate_state = 1;
				format(string,sizeof(string), "* %s usa su control remoto para abrir la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
				SendClientMessage(playerid,Azul,"Para cerrar la barrera usa /ap.");
			}
			else if(PlayerInfo[playerid][pMember] == 92 && ggate_state == 1)
			{
				CloseGate(ggate);
				ggate_state = 0;
				format(string,sizeof(string), "* %s usa su control remoto para cerrar la puerta.",pName(playerid));
				ProxDetector(20.0, playerid, string, Morado,Morado,Morado,Morado,Morado);
			}
		}
		return 1;
	}
	return 0;
}

Puertas_OnPlayerKeyStateChange(playerid, newkeys)
{
	new keyso, updown, leftright;
	GetPlayerKeys(playerid, keyso, updown, leftright);
	if((newkeys & KEY_SECONDARY_ATTACK))
	{
		if(PlayerToPoint(4.0,playerid,228.24, 150.46, 1001.95) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi1,228.24, 149.07, 1001.95,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi1);
			return 1;
		}
		if(PlayerToPoint(4.0,playerid,228.25, 160.48, 1002.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi2,228.26, 159.06, 1002.03,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi2);
			return 1;
		}
		if(PlayerToPoint(4.0,playerid,230.73, 169.82, 1002.02) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi3,229.31, 169.82, 1002.02,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi3);
			return 1;
		}
		if(PlayerToPoint(4.0,playerid,246.44, 193.65, 1007.17) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi4,244.99, 193.65, 1007.17,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi4);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,265.06, 190.47, 1007.17) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi5,265.07, 189.04, 1007.17,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi5);
			return 1;
		}	
		if(PlayerToPoint(1.5,playerid,274.84, 189.39, 1006.17) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi6,273.40, 189.39, 1006.17,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi6);
			return 1;
		}			
		if(PlayerToPoint(1.5,playerid,295.90, 189.36, 1006.17) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi7,294.46, 189.36, 1006.17,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi7);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,198.94, 160.32, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi8,197.34, 160.32, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi8);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,194.70, 160.40, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi9,193.11, 160.40, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi9);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,190.45, 160.42, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi10,189.00, 160.42, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi10);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,197.19, 176.97, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi11,198.83, 176.97, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi11);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,192.95, 177.02, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi12,194.55, 177.02, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi12);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,188.70, 177.04, 1003.26) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacomi13,190.30, 177.04, 1003.26,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacomi13);
			return 1;
		}
		if(PlayerToPoint(1.5,playerid,250.62304688,62.25606537,1003.46875000) && PlayerInfo[playerid][pMember] == 6)
		{
			MoveDynamicObject(puertasheriff1,250.63641357,60.44984436,1003.46875000,4);
			SetTimerEx("CloseGate",4000,0,"p",puertasheriff1);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,247.46295166,72.61702728,1003.96923828) && PlayerInfo[playerid][pMember] == 6)
		{
			MoveDynamicObject(puertasheriff2,249.28527832,72.52067566,1003.96923828,4);
			SetTimerEx("CloseGate",4000,0,"p",puertasheriff2);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,266.30, 78.46, 1001.30) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco1,266.30, 76.96, 1001.30,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco1);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,266.25, 82.96, 1001.30) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco2,266.25, 81.46, 1001.30,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco2);
			return 1;
		}
		
		if(PlayerToPoint(2.0,playerid,266.27, 87.46, 1001.30) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco3,266.27, 85.96, 1001.30,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco3);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,258.95, 91.00, 1002.69) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco4,258.95, 92.50, 1002.69,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco4);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,258.37, 88.02, 1002.67) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco5,256.87, 88.02, 1002.67,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco5);
			return 1;
		}
			if(PlayerToPoint(2.0,playerid,2576.97, -1369.21, 1048.16) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacarcel1,2576.99, -1369.21, 1048.16,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacarcel1);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2577.59, -1364.18, 1046.88) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertacarcel2, 2577.59, -1365.69, 1046.88,4);
			SetTimerEx("CloseGate",4000,0,"p",puertacarcel2);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2589.83, -1327.63, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda1,2588.41, -1327.63, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda1);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2593.85, -1327.64, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda2,2592.32, -1327.64, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda2);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2597.79, -1327.66, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda3,2596.34, -1327.66, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda3);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2601.71, -1327.68, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda4,2600.18, -1327.68, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda4);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2605.74, -1327.66, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda5,2604.21, -1327.66, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda5);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2609.73, -1327.70, 1044.03) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(celda6,2608.11, -1327.70, 1044.03,4);
			SetTimerEx("CloseGate",4000,0,"p",celda6);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,2622.20, -1345.99, 1044.10) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(duchas1,2622.20, -1344.46, 1044.10,4);
			SetTimerEx("CloseGate",4000,0,"p",duchas1);
			return 1;
		}
		if(PlayerToPoint(2.0,playerid,246.3652,71.2773,1003.6406) && PlayerInfo[playerid][pMember] == 1)
		{
			MoveDynamicObject(puertafranco6,244.06, 72.47, 1002.64,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco6);
			MoveDynamicObject(puertafranco7,248.71, 72.47, 1002.64,4);
			SetTimerEx("CloseGate",4000,0,"p",puertafranco7);
			return 1;
		}
		
	}
	return 0;
}

forward CloseGate(gate);
public CloseGate(gate)
{
	//if(gate == barrera)  {SetDynamicObjectRot(PDe,1.7189, 90.2408, 89.3814);}
	if(gate == lspdgate)   {MoveDynamicObject(lspdgate, 1588.6029, -1638.3813, 14.4201, 1);}
	if(gate == puertacomi1) {MoveDynamicObject(puertacomi1,228.24, 150.46, 1001.95,4);}
	if(gate == puertacomi2) {MoveDynamicObject(puertacomi2, 228.25, 160.48, 1002.03,4);}
	if(gate == puertacomi3) {MoveDynamicObject(puertacomi3,230.73, 169.82, 1002.02,4);}
	if(gate == puertacomi4) {MoveDynamicObject(puertacomi4,246.44, 193.65, 1007.17,4);}
	if(gate == puertacomi5) {MoveDynamicObject(puertacomi5,265.06, 190.47, 1007.17,4);}
	if(gate == puertacomi6) {MoveDynamicObject(puertacomi6,274.84, 189.39, 1006.17,4);}
	if(gate == puertacomi7) {MoveDynamicObject(puertacomi7,295.90, 189.36, 1006.17,4);}
	if(gate == puertacomi8) {MoveDynamicObject(puertacomi8,198.94, 160.32, 1003.26,4);}
	if(gate == puertacomi9) {MoveDynamicObject(puertacomi9,194.70, 160.40, 1003.26,4);}
	if(gate == puertacomi10) {MoveDynamicObject(puertacomi10,190.45, 160.42, 1003.26,4);}
	if(gate == puertacomi11) {MoveDynamicObject(puertacomi11,197.19, 176.97, 1003.26,4);}
	if(gate == puertacomi12) {MoveDynamicObject(puertacomi12,192.95, 177.02, 1003.26,4);}
	if(gate == puertacomi13) {MoveDynamicObject(puertacomi13,188.70, 177.04, 1003.26,4);}
	if(gate == puertasheriff1) {MoveDynamicObject(puertasheriff1,250.62304688,62.25606537,1003.46875000,4);}
	if(gate == puertasheriff2) {MoveDynamicObject(puertasheriff2,247.46295166,72.61702728,1003.96923828,4);}
	if(gate == jgate) {MoveDynamicObject(jgate,1643.30000000,-1715.00000000,16.00000000,1);}
	if(gate == ggate) {MoveDynamicObject(ggate,1469.51904297,-1494.60839844,14.22451973,1);}
	if(gate == puertafranco1) {MoveDynamicObject(puertafranco1,266.30, 78.46, 1001.30,1);}
	if(gate == puertafranco2) {MoveDynamicObject(puertafranco2,266.25, 82.96, 1001.30,1);}
	if(gate == puertafranco3) {MoveDynamicObject(puertafranco3,266.27, 87.46, 1001.30,1);}
	if(gate == puertafranco4) {MoveDynamicObject(puertafranco4,258.95, 91.00, 1002.69,1);}
	if(gate == puertafranco5) {MoveDynamicObject(puertafranco5,258.37, 88.02, 1002.67,1);}
	if(gate == puertafranco6) {MoveDynamicObject(puertafranco6,244.92, 72.47, 1002.64,1);}
	if(gate == puertafranco7) {MoveDynamicObject(puertafranco7,247.89, 72.47, 1002.64,1);}
	if(gate == puertacarcel1) {MoveDynamicObject(puertacarcel1,2576.97, -1369.21, 1048.16,1);}
	if(gate == puertacarcel2) {MoveDynamicObject(puertacarcel2,2577.59, -1365.69, 1046.88,1);}
	if(gate == celda1) {MoveDynamicObject(celda1,2589.83, -1327.63, 1044.03,1);}
	if(gate == celda2) {MoveDynamicObject(celda2,2593.85, -1327.64, 1044.03,1);}
	if(gate == celda3) {MoveDynamicObject(celda3,2597.79, -1327.66, 1044.03,1);}
	if(gate == celda4) {MoveDynamicObject(celda4,2601.71, -1327.68, 1044.03,1);}
	if(gate == celda5) {MoveDynamicObject(celda5,2605.74, -1327.66, 1044.03,1);}
	if(gate == celda6) {MoveDynamicObject(celda6,2609.73, -1327.70, 1044.03,1);}
	if(gate == duchas1) {MoveDynamicObject(duchas1,2622.20, -1345.99, 1044.10,1);}
	if(gate == depositogate1) {MoveDynamicObject(depositogate1, -493.40, -562.91, 26.16,1);}
	if(gate == depositogate2) {MoveDynamicObject(depositogate2,-485.44, -562.89, 26.16,1);}
	//if(gate == tgate) {MoveDynamicObject(tgate,2534.1584472656, -1515.5895996094, 24.67022895813,1);}
	return 1;
}
