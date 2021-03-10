# Titanium CAD: FiveM-Plugin

This resource allows for in-game integration using the API provided by Titanium CAD.

## Installation

1. Download this resource and add the `TitaniumCAD` folder to your server.

2. Create a server on [TitaniumCAD](https://titaniumcad.com/settings) and copy the server's secret.

3. Modify the `config.lua` and fill the secret.

4. Add the resource to your `server.cfg`.

> If you want to change the resource name, you will have to modify `/ui/index.html` and `/ui/main.js`, and change `https://TitaniumCAD/hide` to `https://NewName/hide` otherwise the resource will break.

## Integration Features

- **In-Game Tablet**
  - Access all available features of Titanium CAD website.
  - Intended for use as MDT for online officers.

- **Location Updates**
  - Automatically updates unit locations on the CAD/MDT.

- **911 Calls**
  - Built-in `/911` command.
  - Sends call to Dispatch and online officers.

## Disclaimer

This resource only works with the use of [TitaniumCAD](https://titaniumcad.com). Without a valid server secret, the resource will not work by default. However, this resource may be modified in whatever ways possible to allow integration with other CAD systems. It should also be noted that the TitaniumCAD system is completely separate from this resource, which means the addition of this in-game resource is completely optional!

All usages of this software are **not** FiveM-exclusive. These API events can be used to update the CAD with information from any game. The games that these API endpoints could be used for include, but are not limited to, Garry's Mod, Roblox, Unturned, Minecraft, etc.

**The system is currently in beta. Some bugs are expected.**
