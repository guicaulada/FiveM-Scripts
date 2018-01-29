# vrp_barbershop

Support me and my scripts on Patreon:  
[![Support me and my scripts on Patreon](http://i.imgur.com/dyePK6Q.png)](https://www.patreon.com/Sighmir)  
*******************************************************************************************************************************
/!\ BARBERSHOP RESETS PLAYER HAIR AND FACE ON FIRST USE /!\\

/!\ PLEASE RESELECT YOUR FACE BEFORE CHANGING ANY OTHER FACIAL FEATURE /!\\  

Comment out the hair part on your cfg/skinshops.lua, like so:
```
  --["Face"] = 0,
  --["Hair"] = 2,
```
The barbershop replace those options.
***
Add:
```
TriggerEvent("vRP:cloakroom:update", player)

```
to vRP/module/cloakroom.lua after line 39 and 76 for **cloakroom compatibility**.  
Under data.cloakroom_idle = nil and vRPclient.setCustomization(player,{idle_copy}).

to vRP/module/home_components.lua after line 80 for **wardrobe compatibility**.  
Under vRPclient.setCustomization(player,{custom}).

Thank you [@Aleweadan](https://github.com/Aleweadan) for this and other solutions you provided!

## License

    FiveM Scripts
    Copyright (C) 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
