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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_showroom")
Gclient = Tunnel.getInterface("vRP_garages","vRP_showroom")

-- vehicle db / garage and lscustoms compatibility
MySQL.createCommand("vRP/showroom_columns", [[
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS veh_type varchar(255) NOT NULL DEFAULT 'default' ;
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS vehicle_plate varchar(255) NOT NULL;
]])
MySQL.query("vRP/showroom_columns")

MySQL.createCommand("vRP/add_custom_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)")

-- SHOWROOM
RegisterServerEvent('veh_SR:CheckMoneyForVeh')
AddEventHandler('veh_SR:CheckMoneyForVeh', function(vehicle, price ,veh_type)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
	if #pvehicle > 0 then
		vRPclient.notify(player,{"~r~Vehicle already owned."})
	else
		if vRP.tryFullPayment({user_id,price}) then
			vRP.getUserIdentity({user_id, function(identity)
              MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
			end})
			
			TriggerClientEvent('veh_SR:CloseMenu', player, vehicle, veh_type)
			vRPclient.notify(player,{"Paid ~r~"..price.."$."})
		else
			vRPclient.notify(player,{"~r~Not enough money."})
		end
	end
  end)
end)
