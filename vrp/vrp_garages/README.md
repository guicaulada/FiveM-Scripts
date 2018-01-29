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
