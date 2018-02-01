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

vRPncj = {}
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_nocarjack", "cfg/nocarjack")

Tunnel.bindInterface("vrp_nocarjack",vRPncj)
Proxy.addInterface("vrp_nocarjack",vRPncj)
NCJserver = Tunnel.getInterface("vrp_nocarjack")
vRPserver = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(function()
    while true do
		-- gets if player is entering vehicle
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			-- gets vehicle player is trying to enter and its lock status
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)
	    
			-- Get the conductor door angle, open if value > 0.0
            local doorAngle = GetVehicleDoorAngleRatio(veh, 0)
			
			-- normalizes chance
			if cfg.chance > 100 then
			  cfg.chance = 100
			elseif cfg.chance < 0 then
			  cfg.chance = 0
			end
			
			-- check if got lucky
			local lucky = (math.random(100) < cfg.chance)
			
			-- Set lucky if conductor door is open
			if doorAngle > 0.0 then
				lucky = true
			end
				
			-- check if vehicle is in blacklist
			local backlisted = false
			for k,v in pairs(cfg.blacklist) do
			  if IsVehicleModel(veh, GetHashKey(v)) then
			    blacklisted = true
			  end
			end

			-- gets ped that is driving the vehicle
            local pedd = GetPedInVehicleSeat(veh, -1)
			local plate = GetVehicleNumberPlateText(veh)
			-- lock doors if not lucky or blacklisted
            if (lock == 7 or pedd) then
				if not lucky or blacklisted then
					NCJserver.setVehicleDoorsForEveryone(veh, 2, plate)
				else
					NCJserver.setVehicleDoorsForEveryone(veh, 1, plate)
				end
            end
        end
        Citizen.Wait(1)	    							
    end
end)

function vRPncj.setVehicleDoors(veh, doors)
  SetVehicleDoorsLocked(veh, doors)
end
