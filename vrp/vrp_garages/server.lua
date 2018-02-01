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

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_garages")
vRPgc = Tunnel.getInterface("vRP_garages","vRP_garages")

--SQL--
MySQL.createCommand("vRP/ply_get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")


-- PLY_GARAGES
RegisterServerEvent('ply_garages:CheckForAptGarages')
AddEventHandler('ply_garages:CheckForAptGarages', function()
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRP.getUserAddress({user_id, function(address)
      if address then
		if address.home == "Rich Housing" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -751.5107421875,365.883117675781,86.9666687011719,267.344543457031)
		elseif address.home == "Basic Housing 1" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -635.4501953125,57.4368324279785,43.8587303161621,88.8649536132813)
		elseif address.home == "Basic Housing 2" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -1448.18701171875,-514.856567382813,30.6881823348999,29.5690689086914)
		elseif address.home == "Ranch Main" then
			TriggerClientEvent("ply_garages:addAptGarage", player, 1408.32495117188,1117.44665527344,113.737692260742,87.2900848388672)
		elseif address.home == "Regular House 1" then
			TriggerClientEvent("ply_garages:addAptGarage", player, 843.398803710938,-191.063568115234,71.6714935302734,339.229705810547)
		elseif address.home == "Regular House 2" then
			TriggerClientEvent("ply_garages:addAptGarage", player, 174.276748657227,483.056274414063,141.339096069336,357.040771484375)
		elseif address.home == "Regular House 3" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.590148925781,184.175857543945,71.0921401977539,131.889053344727)
		elseif address.home == "Regular House 4" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -1858.14965820313,328.570861816406,87.6500091552734,8.03947734832764)
		elseif address.home == "Regular House 5" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -25.002462387085,-1436.29431152344,29.6531391143799,89.9820022583008)
		elseif address.home == "Rich Housing 2" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -81.860595703125,-809.427734375,35.4030570983887,350.814697265625)
		elseif address.home == "Regular House 6" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -2587,1930.97326660156,166.304656982422,93.3231887817383)
		end
      end
	end})
end)

RegisterServerEvent('ply_garages:CheckForSpawnVeh')
AddEventHandler('ply_garages:CheckForSpawnVeh', function(vehicle)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/ls_customs", {user_id = user_id, vehicle = vehicle}, function(result, affected)
	  vRP.closeMenu({player})
      vRPgc.spawnGarageVehicle(player,{result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation})
	end)
end)

RegisterServerEvent('ply_garages:CheckForSpawnBasicVeh')
AddEventHandler('ply_garages:CheckForSpawnBasicVeh', function(user_id,vehicle)
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/ls_customs", {user_id = user_id, vehicle = vehicle}, function(result, affected)
	  vRP.closeMenu({player})
      vRPgc.spawnGarageVehicle(player,{result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation})
	end)
end)

RegisterServerEvent('ply_garages:CheckForVeh')
AddEventHandler('ply_garages:CheckForVeh', function(plate,vehicle,vtype)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/lsc_get_vehicle", {user_id = user_id, vehicle = vehicle, plate = plate}, function(rows, affected)
    if #rows > 0 then -- has vehicle
      vRPgc.despawnGarageVehicle(player,{vtype,5})
	else
	  vRPclient.notify(player,{"~r~No owned vehicle closeby"})
	end
  end)
end)

RegisterServerEvent('ply_garages:CheckGarageForVeh')
AddEventHandler("ply_garages:CheckGarageForVeh", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    MySQL.query("vRP/ply_get_vehicles", {user_id = user_id}, function(pvehicles, affected)
      local vehicles = {}
      for k,v in ipairs(pvehicles) do
		if v.veh_type == "car" or v.veh_type == "bike" then
		  table.insert(vehicles, {["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle})
		end
      end
      TriggerClientEvent("ply_garages:getVehicles", player, vehicles) 
	end)
end)