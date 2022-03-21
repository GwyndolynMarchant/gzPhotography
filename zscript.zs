version "4.7.1"

class PhotoCamera : Weapon
{
	Default {
		Weapon.SelectionOrder 0;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 0;
		Inventory.Icon "PHOTOICON";
		Obituary "Journalism is scary.";
		+WEAPON.WIMPY_WEAPON;
		Tag "Photography Camera";
	}

	States {
		Ready:
			PHCM A 1 A_WeaponReady;
			Loop;
		Deselect:
			PHCM A 1 A_Lower;
			Loop;
		Select:
			PHCM A 1 A_Raise;
			Loop;
		Fire:
			PHCM B 2;
			---- B 0 {
				if (CVar.GetCVar("camera_flash_fill").GetBool())
					A_GunFlash("FlashFill");
				// A_SetCrosshair(50); need to figure out null crosshair
				if (CVar.GetCVar("camera_flash").GetBool()) {
					int b = CVar.GetCVar("camera_flash_bright").GetInt();
					A_Light(b);
				}
				if (CVar.GetCVar("camera_info").GetBool()) {
					CallACS("photography_camera_display");
				}
			}
			TNT1 A 10 {
				level.MakeScreenShot();
			}
			PHCM C 1 {
				A_Light0();
				A_StartSound("photo");
				A_SetCrosshair(0);
			}
			PHCM DEFGHI 1;
			Goto Ready;
		AltFire:
			TNT1 A 0 {
				A_SpawnItemEx("AimingCamera", -25, 5, 48, 0, 0, 0, 180, SXF_ISTARGET);
				SetCamera(target, true);
			}
			TNT1 B 15 {
				if (CVar.GetCVar("camera_info").GetBool()) {
					CallACS("photography_camera_display");
				}
				level.MakeScreenShot();
			}
			TNT1 C 8 {
				A_StartSound("photo");
				A_SetCrosshair(0);
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