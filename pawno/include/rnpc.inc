/**
 *	RNPC - Recordfile NPCs
 *  Version 0.2
 *	made by Mauzen, parts based on Joe Staffs code
 */
#define RNPC_DEBUG

#pragma tabsize 0

#define PLAYER_RECORDING_TYPE_NONE		0
#define PLAYER_RECORDING_TYPE_DRIVER	1
#define PLAYER_RECORDING_TYPE_ONFOOT	2

// @since 0.1
native BuildRecording(npcid, Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed);
// @since 0.1.1
native BuildVehicleRecording(npcid, Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed);
native BuildTestRecording(npcid, Float:x, Float:y, Float:z);

// @since 0.2
native RNPC_CreateBuild(npcid, type, slot=0);
native RNPC_FinishBuild(clear=1);
native RNPC_AddMovement(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed=0.006);
native RNPC_ConcatMovement(Float:x, Float:y, Float:z, Float:speed=0.006);
native RNPC_AddPause(time);

native RNPC_SetUpdateRate(rate);

native RNPC_SetLRKeys(lr);
native RNPC_SetUDKeys(ud);
native RNPC_SetKeys(keys);
native RNPC_SetQuat1(Float:w);
native RNPC_SetQuat2(Float:x);
native RNPC_SetQuat3(Float:y);
native RNPC_SetQuat4(Float:z);
native RNPC_SetHealth(hp);
native RNPC_SetArmour(arm);
native RNPC_SetSpecialAction(sp);
native RNPC_SetWeaponID(weaponid);
native RNPC_SetAnimID(anim);
native RNPC_SetAnimParams(params);
native RNPC_SetAngleQuats(Float:a, Float:h, Float:b);

// Fake communication functions
#define RNPC_StopPlayback(%1)			SendClientMessage(%1, -1, "RNPC:102")
#define RNPC_SetAutorepeat(%1,%2)		new rtxt[10]; format(rtxt, 10, "RNPC:%d", 110 + %2); SendClientMessage(%1, -1, rtxt)

forward OnRNPCPlaybackFinished(npcid);

/**
 *	Connects a new RNPC, returning his ID.
 *	@since 	V0.1
 */
stock ConnectRNPC(name[])
{
	new slot = -1;
	for (new i = 0; i < MAX_PLAYERS; i++) {
		if (!IsPlayerConnected(i) && !IsPlayerNPC(i)) {
			slot = i;
			break;
		}
	}
	
	ConnectNPC(name, "RNPC");
	return slot;
}

/**
 *	Moves a RNPC to the given position.
 *	@since 	V0.1
 */
stock MoveRNPC(npcid, Float:x, Float:y, Float:z, Float:speed)
{
	if (!IsPlayerNPC(npcid)) return false;
	
	new Float:nx, Float:ny, Float:nz;
	if (IsPlayerInAnyVehicle(npcid)) {
		GetVehiclePos(GetPlayerVehicleID(npcid), nx, ny, nz);
		BuildVehicleRecording(npcid, nx, ny, nz, x, y, z, speed);
	} else {
		GetPlayerPos(npcid, nx, ny, nz);
		RNPC_CreateBuild(npcid, PLAYER_RECORDING_TYPE_ONFOOT);
		RNPC_AddMovement(nx, ny, nz, x, y, z, speed);
		RNPC_FinishBuild();
	}
	
	SendClientMessage(npcid, -1, "RNPC:101:0");
	
	return true;
}

/**
 *
 *	@since	V0.1.1
 */
stock RNPC_StartPlayback(npcid, rec[])
{
	if (!IsPlayerNPC(npcid)) return false;
	
	new form[40];
	format(form, 40, "RNPC:109:%s", rec);
	SendClientMessage(npcid, -1, form);
}

/**
 *
 *	@since V0.2
 */
stock RNPC_StartBuildPlayback(npcid, slot=0)
{
	new cmd[16];
	format(cmd, 16, "RNPC:101:%d", slot);
	SendClientMessage(npcid, -1, cmd);
        SetPlayerSkin(npcid, 167);
        new Text3D:TextoBot = Create3DTextLabel("{FFFF00}[BOT] {FFFFFF}Jack [K9]",0xFF0000FF,30.0,40.0,50.0,40.0,0);
        Attach3DTextLabelToPlayer(TextoBot, npcid, 0.0, 0.0, 0.5);
        SetPlayerPos(npcid, 869.4095,-1256.8677,-4.7228);
	SetPlayerColor(npcid, 0xFFFFFF00);
}

/**
 *	Serverside interface for RNPC communication
 */

public OnPlayerCommandText(playerid, cmdtext[]) {
	if (!IsPlayerNPC(playerid)) return CallLocalFunction("RNPC_OnPlayerCommandText", "is", playerid, cmdtext);
	#if defined RNPC_DEBUG
		printf("RNPC %d: [CMD] %s", playerid, cmdtext);
	#endif
	
	if (!strcmp("RNPC:002", cmdtext)) {
		CallLocalFunction("OnRNPCPlaybackFinished", "i", playerid);
	}
	
	CallLocalFunction("RNPC_OnPlayerCommandText", "is", playerid, cmdtext);
	return true;
}
#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText RNPC_OnPlayerCommandText
forward RNPC_OnPlayerCommandText(playerid, cmdtext[]);