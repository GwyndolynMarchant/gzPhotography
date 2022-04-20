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
			}
			TNT1 A 1 {
				double offset = CVar.GetCVar("camera_osd_offset").GetFloat();
				invoker.offsets = Screen.SetOffset(-offset, -offset);
			}
			TNT1 A 30 {
				level.MakeScreenShot();
			}
			TNT1 A 1 {
				A_Light0();
				A_StartSound("photo");
				A_SetCrosshair(0);
				Screen.SetOffset(invoker.offsets.x, invoker.offsets.y);
			}
			PHCM CDEFGHI 1;
			Goto Ready;
		AltFire:
			TNT1 A 0 {
				A_SpawnItemEx("AimingCamera", -25, 5, 48, 0, 0, 0, 180, SXF_ISTARGET);
				SetCamera(target, true);
				double offset = CVar.GetCVar("camera_osd_offset").GetFloat();
				invoker.offsets = Screen.SetOffset(-offset, -offset);
			}
			TNT1 B 35 {
				level.MakeScreenShot();
			}
			TNT1 C 8 {
				A_StartSound("photo");
				A_SetCrosshair(0);
				Screen.SetOffset(invoker.offsets.x, invoker.offsets.y);
			}
			Goto Ready;
		FlashFill:
			TNT1 A 15;
			Stop;
		Spawn:
			PHCM A -1;
			Stop;
	}
}