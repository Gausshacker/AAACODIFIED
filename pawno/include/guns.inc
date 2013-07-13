#include <a_samp>
#include <globalvars>
#include <colores>
#include <funciones>

//------------------------------------------------------------------------------------------------------

Guns_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
		new weapon = GetPlayerWeapon(playerid);
		new target = NOEXISTE;
		if(BalasDeGoma[playerid] == 1 || Taser[playerid] == 1) return 1;
		switch(weapon)
		{
			case 8:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 800)
						{
							GM_SetPlayerHealth(target, 0);
						}
					}
				}
				return 1;
			}
			case 34:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 800)
						{
							GM_SetPlayerHealth(target, 0);
							GameTextForPlayer(playerid, "~r~HeadShot!", 3000, 5);
						}
					}
				}
				else if(IsPlayerAimingBodyPart(playerid, 2) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 2);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 800)
						{
							new Float:Vida, dano, Float:Armor;
							GetPlayerArmour(target, Armor);
							if(Armor > 0)
							{
								dano = random (5) + 5;
								SetPlayerArmour(target, Armor - dano);
							}
							else
							{
								GetPlayerHealth(target, Vida);
								dano = random (25) + 50;
								GM_SetPlayerHealth(target, Vida - dano);
							}
						}
					}
				}
				return 1;
			}
			case 22, 24:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 30)
						{
							GM_SetPlayerHealth(target, 0);
							GameTextForPlayer(playerid, "~r~HeadShot!", 3000, 5);
						}
					}
				}
				else if(IsPlayerAimingBodyPart(playerid, 2) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 2);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 30)
						{
							new Float:Vida, dano, Float:Armor;
							GetPlayerArmour(target, Armor);
							if(Armor > 0)
							{
								dano = random (5) + 5;
								SetPlayerArmour(target, Armor - dano);
							}
							else
							{
								GetPlayerHealth(target, Vida);
								dano = random (15) + 10;
								GM_SetPlayerHealth(target, Vida - dano);
							}
						}
					}
				}
				return 1;
			}
			case 28, 29:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 20)
						{
							GM_SetPlayerHealth(target, 0);
							GameTextForPlayer(playerid, "~r~HeadShot!", 3000, 5);
						}
					}
				}
				else if(IsPlayerAimingBodyPart(playerid, 2) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 2);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 30)
						{
							new Float:Vida, dano, Float:Armor;
							GetPlayerArmour(target, Armor);
							if(Armor > 0)
							{
								dano = random (5) + 5;
								SetPlayerArmour(target, Armor - dano);
							}
							else
							{
								GetPlayerHealth(target, Vida);
								dano = random (10) + 30;
								GM_SetPlayerHealth(target, Vida - dano);
							}
						}
					}
				}
				return 1;
			}
			case 31, 30:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 50)
						{
							GM_SetPlayerHealth(target, 0);
							GameTextForPlayer(playerid, "~r~HeadShot!", 3000, 5);
						}
					}
				}
				else if(IsPlayerAimingBodyPart(playerid, 2) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 2);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 30)
						{
							new Float:Vida, dano, Float:Armor;
							GetPlayerArmour(target, Armor);
							if(Armor > 0)
							{
								dano = random (5) + 5;
								SetPlayerArmour(target, Armor - dano);
							}
							else
							{
								GetPlayerHealth(target, Vida);
								dano = random (5) + 15;
								GM_SetPlayerHealth(target, Vida - dano);
							}
						}
					}
				}
				return 1;
			}
			case 25, 26, 27:
			{
				if(IsPlayerAimingBodyPart(playerid, 1) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 1);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 15)
						{
							GM_SetPlayerHealth(target, 0);
							GameTextForPlayer(playerid, "~r~HeadShot!", 3000, 5);
						}
					}
				}
				else if(IsPlayerAimingBodyPart(playerid, 2) != INVALID_PLAYER_ID)
				{
					target = IsPlayerAimingBodyPart(playerid, 2);
					if(PlayerInfo[target][pHerido] == 0 && IsPlayerLookingAtPlayer(playerid, target))
					{
						if(GetDistanceBetweenPlayers(playerid, target) < 30)
						{
							new Float:Vida, dano, Float:Armor;
							GetPlayerArmour(target, Armor);
							if(Armor > 0)
							{
								dano = random (5) + 5;
								SetPlayerArmour(target, Armor - dano);
							}
							else
							{
								GetPlayerHealth(target, Vida);
								dano = random (10) + 30;
								GM_SetPlayerHealth(target, Vida - dano);
							}
						}
					}
				}
				return 1;				
			}
		}
	}
	return 0;
}