version "4.7.1"

class PhotoShim : EventHandler
{
	string FilterGameIwad (void) {
		// Standalone IWADs
		if (CVar.FindCVar("GAME_BLASPHEMER")) return "Blasphemer";
		if (CVar.FindCVar("GAME_URBAN")) return "Action Doom 2: Urban Brawl";
		if (CVar.FindCVar("GAME_HARMONY")) return "Harmony";
		if (CVar.FindCVar("GAME_DEL")) return "Delaweare";
		if (CVar.FindCVar("GAME_ROTWB")) return "Rise Of The Wool Ball";

		// Heretic
		if (CVar.FindCVar("GAME_HERETIC")) {
			if (CVar.FindCVar("GAME_HERETIC_SHADOW")) return "Heretic: Shadow of the Serpent Riders";
			return "Heretic";
		}

		// Hexen
		if (CVar.FindCVar("GAME_HEXEN_KING")) return "Hexen: Deathkings of the Dark Citadel";
		if (CVar.FindCVar("GAME_HEXEN")) return "Hexen: Beyond Heretic";

		// Strife
		if (CVar.FindCVar("GAME_STRIFE_VETERAN")) return "Strife: Veteran Edition";
		if (CVar.FindCVar("GAME_STRIFE")) return "Strife: Quest for the Sigil";

		// Chex
		if (CVar.FindCVar("GAME_CHEX3")) return "Chex® Quest 3";
		if (CVar.FindCVar("GAME_CHEX")) return "Chex® Quest";

		// Hacx
		if (CVar.FindCVar("GAME_HACX2")) return "Hacx 2.0";
		if (CVar.FindCVar("GAME_HACX")) return "Hacx: Twitch'n Kill";

		// Square
		if (CVar.FindCVar("GAME_SQUARE")) return "The Adventures of Square (Square-ware)";
		if (CVar.FindCVar("GAME_SQUARE2")) return "The Adventures of Square";

		// Doom Complete
		if (CVar.FindCVar("GAME_DOOM_COMPLETE")) return "DOOM: Complete: WadSmoosh";

		// Freedoom Variant
		if (CVar.FindCVar("GAME_FREEDOOM")) {
			if (CVar.FindCVar("GAME_FREEDOOM_DM")) return "FreeDM";
			if (CVar.FindCVar("GAME_FREEDOOM_PHASE2")) return "Freedoom: Phase 2";
			if (CVar.FindCVar("GAME_FREEDOOM_PHASE1")) return "Freedoom: Phase 1";
			if (CVar.FindCVar("GAME_FREEDOOM_DEMO")) return "Freedoom: Demo Version";
			return "Freedoom";
		}

		// Doom Variant
		if (CVar.FindCVar("GAME_DOOM")) {
			if (CVar.FindCVar("GAME_DOOM_BFG")) return "Doom: BFG Edition";
			if (CVar.FindCVar("GAME_DOOM_UNITY")) return "Doom: Unity Edition";
			if (CVar.FindCVar("GAME_DOOM_ULT")) {
				if (CVar.FindCVar("GAME_DOOM_XB")) return "Doom: XBox Edition";
				return "The Ultimate Doom";
			}
			if (CVar.FindCVar("GAME_DOOM_REG")) return "Doom Registered";
			return "Doom";
		}

		// Doom 2 Variant
		if (CVar.FindCVar("GAME_DOOM2_TNT")) {
			if (CVar.FindCVar("GAME_DOOM2_TNT_UNITY")) return "Final Doom: TNT - Evilution: Unity Edition";
			return "Final Doom: TNT - Evilution";
		}
		if (CVar.FindCVar("GAME_DOOM2_PLUT")) {
			if (CVar.FindCVar("GAME_DOOM2_PLUT_UNITY")) return "Final Doom: Plutonia Experiment: Unity Edition";
			return "Final Doom: Plutonia Experiment";
		}
		if (CVar.FindCVar("GAME_DOOM2_UNITY")) return "Doom 2: Unity Edition";
		if (CVar.FindCVar("GAME_DOOM2_BFG")) return "Doom 2: BFG Edition";
		if (CVar.FindCVar("GAME_DOOM2")) {
			if (CVar.FindCVar("GAME_DOOM2_FR")) return "Doom 2: L'Enfer sur Terre";
			if (CVar.FindCVar("GAME_DOOM2_XB")) return "Doom 2: XBox Edition";
			return "Doom 2: Hell on Earth";
		}

		return "";
	}

	override void WorldLoaded (WorldEvent e) {
		CVar game_name = CVar.FindCVar("game_name");
		if (game_name.GetString() != "") return;

		// Quickly check IWAD type against filterable titles
		game_name.SetString(FilterGameIwad());

		// Check to see if there is an IWADINFO lump which could have a different game name
		int lump = -1;
		while (-1 != (lump = Wads.FindLump("IWADINFO", lump + 1)))
		{
			string content = Wads.ReadLump(lump);
			array<string> lines;
			content.split(lines,"\n");
			if (lines.size() > 0) continue;

			for (int i = 0; i < lines.size(); i++) {
				array<string> p;
				lines[i].split(p,"=");
				if (p.size() == 0) continue;

				p[0].StripRight();
				if (p[0] ~== "NAME") game_name.SetString(p[1]);
			}
		}

		// Check for a GAMEINFO lump for whether further modifications should change the game name
		while (-1 != (lump = Wads.FindLump("GAMEINFO", lump + 1)))
		{
			string content = Wads.ReadLump(lump);
			array<string> lines;
			content.split(lines,"\n");
			for (int i = 0; i < lines.size(); i++) {
				array<string> p;
				lines[i].split(p,"=");
				p[0].StripRight();
				if (p[0] ~== "STARTUPTITLE") {
					p[1].Replace('"', "");
					game_name.SetString(p[1]);
				}
			}
		}
	}

	override void RenderOverlay (RenderEvent e) {
		if (!CVar.GetCVar("camera_info").GetBool()) return;

		double offset = CVar.GetCVar("screenoffset").GetFloat();
		int f_color = CVar.GetCVar("camera_osd_color").GetInt();

		Screen.DrawText("OSDlg",
						f_color,
						offset + (Screen.GetWidth() * 0.05),
						offset + (Screen.GetHeight() * 0.95) - (CleanYfac * 50),
						level.LevelName,
						DTA_CleanNoMove, true);
		
		string gamename = CVar.GetCVar("game_name").GetString();
		
		Screen.DrawText("OSDsm",
						f_color,
						offset + (Screen.GetWidth() * 0.05),
						offset + (Screen.GetHeight() * 0.95) - (CleanYfac * 20),
						gamename,
						DTA_CleanNoMove, true);	
	}
}

class PhotoCamera : Weapon
{
	Vector2 offsets;

	Default {
		Inventory.Amount 0;
   		Inventory.MaxAmount 1;
   		Inventory.Icon "I_PHCM";
   		+INVENTORY.UNDROPPABLE;

		Weapon.SelectionOrder 6966669;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 0;
		+WEAPON.WIMPY_WEAPON;
		+WEAPON.NOAUTOSWITCHTO;
		+WEAPON.NOAUTOAIM;

		Obituary "Journalism is scary.";
		Tag "Photography Camera";
	}

	States {
		Ready:
			PHCM A 1 {
				A_WeaponReady();
				A_SetCrosshair(CVar.GetCVar("camera_overlay").GetInt());
			}
			Loop;
		Deselect:
			PHCM A 1 {
				A_Lower();
				A_SetCrosshair(0);
			}
			Loop;
		Select:
			PHCM A 1 A_Raise;
			Loop;
		Fire:
			PHCM B 2 {
				if (CVar.GetCVar("camera_flash_fill").GetBool())
					A_GunFlash("FlashFill");
				A_SetCrosshair(69); // custom null crosshair
				if (CVar.GetCVar("camera_flash").GetBool()) {
					int b = CVar.GetCVar("camera_flash_bright").GetInt();
					A_Light(b);
				}
				double offset = CVar.GetCVar("screenoffset").GetFloat();
				invoker.offsets = Screen.SetOffset(-offset, -offset);
			}
			TNT1 A 12 {
				level.MakeScreenShot();
			}
			PHCM C 1 {
				A_Light0();
				A_StartSound("photo");
				A_SetCrosshair(0);
				Screen.SetOffset(invoker.offsets.x, invoker.offsets.y);
			}
			PHCM DEFGHI 1;
			Goto Ready;
		AltFire:
			TNT1 A 0 {
				A_SpawnItemEx("AimingCamera", -25, 5, 48, 0, 0, 0, 180, SXF_ISTARGET);
				SetCamera(target, true);
				double offset = CVar.GetCVar("screenoffset").GetFloat();
				invoker.offsets = Screen.SetOffset(-offset, -offset);
			}
			TNT1 B 15 {
				level.MakeScreenShot();
			}
			TNT1 C 8 {
				A_StartSound("photo");
				A_SetCrosshair(0);
				Screen.SetOffset(invoker.offsets.x, invoker.offsets.y);
			}
			Goto Ready;
		FlashFill:
			TNT1 A 3;
			Stop;
		Spawn:
			PHCM A -1;
			Stop;
	}
}