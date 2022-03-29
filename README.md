# ![Icon](/graphics/I_PHCM.png) gzPhotographer 

**gzPhotographer** is a small bespoke mod which adds a photography camera into any [gzDoom](https://zdoom.org/downloads) load order. It has been designed with maximum compatibility with other mods, placing the camera in your inventory under slot 0, and providing a universal printscreen button replacement which takes clean, unobstructed photos.

**To enable photo-taking, you will need to turn on `Options > Miscellaneous > Enable making screenshots by script`.**

## Features

### Sorry Cyberimp DSC-P72
The photography camera is a "weapon" which allows taking clean photographs by "firing", and clean selfies by "alt-firing".

![Sony Cybershot DSC-P72, renamed to a Sorry Cyberimp](/sprites/PHCMA0.png)

It has clean animations and graphics based on a *Sony Cybershot DSC-P72*. It does not aim to replicate this camera in functionality, it is just a cute model that i thought made a good visual reference. Due to the aim of being maximally compatible with other mods, the camera is presented "floating" as opposed to showing specific hands.

#### Selfie Mode
![A selfie taken in the opening of Doom 2](/screenshots/selfie.png)

Alt-firing produces a selfie, by placing the camera in front of you and shooting backwards. Note that this means you will not be photographing what is in front of you, but instead what is behind you. Moving will return the perspective to normal.

### Flash and Fill Flash

| Fill Modes | |
| --- | --- |
| ![Natural lighting](/screenshots/natural.png) | ![Fill-flash lighting](/screenshots/fill.png)            |
| ![Flash lighting](/screenshots/flash.png)     | ![Full flash with lighting](/screenshots/flash_fill.png) |

The photography camera features both a flash and fill-flash for photographing dark rooms and close-up objects. They can be seperately toggled in the options menu. The full flash is toggleable with a keybinding (default configuration `F` for "Flash").

### Universal clean screenshots
A series of console commands are preconfigured (taken from [the zdoom wiki](https://zdoom.org/wiki/Screenshot#Creating_clean_screenshots)) that enable taking clean screenshots in any load order. Unlike the camera itself, these screenshots have been configured to replace the default in-engine `PrintScreen` with the new clean shots. The hotkey can be changed in the options menu.

### Shot composition overlays
The camera supports multple composition overlays, which can be toggled to cycle through them (default configuration `G` for "Grid"). These exist as seperate crosshairs, and thus can have their scaling tweaked from the options menu. The camera crosshair is selected seperately from your main crosshairs.

Note that the camera overlay will follow the same colouring as your crosshair.

#### Overlays
- None (default)
- Thirds
- Golden Ratio
- Root 2 Armature
- Diamond

### Photo information overlay
When taking a picture, you may have the mod print map and megawad information onto the photograph. This feature is toggleable in the settings, and provides an override to megawad detection. Note that megawad detection is performed upon starting play, not entering the main menu.

## Compatibility Notes
- Fill flash may not work correctly with mods which modify the default firing modes of weapons in the engine. (ex: [Castlevania: Simon's Destiny](https://batandy.itch.io/simonsdestiny))
- The camera will not be accessible or functional with mods which entirely disable weapons. (ex: [GZ P.T.](https://batandy.itch.io/gz-pt)) In these cases, the universal hotkey should still function.
