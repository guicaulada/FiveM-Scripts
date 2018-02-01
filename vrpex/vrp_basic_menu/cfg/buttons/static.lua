--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

--police weapons // comment out the weapons if you dont want to give weapons.
police_weapons = {}
police_weapons[lang.police_weapons.first] = {function(player,choice)
    vRPclient.giveWeapons(player,{
	  ["WEAPON_COMBATPISTOL"] = {ammo=200},
	  ["WEAPON_PUMPSHOTGUN"] = {ammo=200},
	  ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_STUNGUN"] = {ammo=200}
	}, true)
	BMclient.setArmour(player,100,true)
end}

--medkit storage
emergency_medkit = {}
emergency_medkit[lang.emergency_medkit.first] = {function(player,choice)
	local user_id = vRP.getUserId(player) 
	vRP.giveInventoryItem(user_id,"medkit",25,true)
	vRP.giveInventoryItem(user_id,"pills",25,true)
end}

--heal me
emergency_heal = {}
emergency_heal[lang.emergency_heal.first] = {function(player,choice)
	local user_id = vRP.getUserId(player) 
	vRPclient.setHealth(player,1000)
end}