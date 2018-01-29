# vrp_garages
fx-server only, requires my vrp_lscustoms

Support me and my scripts on Patreon:  
[![Support me and my scripts on Patreon](http://i.imgur.com/dyePK6Q.png)](https://www.patreon.com/Sighmir)  
***********************************************************************************************************************************
Add:
```
AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
	vehicles[vtype] = vehicle
end)
```
to the top of your vrp/client/basic_garage.lua, under the local vehicles variable, for vehicle button compatibility.
************************************************************************************************************************************
Replace:
```
            vRPclient.spawnGarageVehicle(player,{veh_type,vname})
```
With:
```
            TriggerEvent('ply_garages:CheckForSpawnBasicVeh', user_id, vname)
```
on line 67 of your vrp/modules/basic_garage.lua, under the vRP.closeMenu(player) function, for basic garage compatibility.
