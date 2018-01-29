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
