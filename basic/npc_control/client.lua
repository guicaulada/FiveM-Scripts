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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
		
        for ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
				for i,model in pairs(cfg.peds) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						veh = GetVehiclePedIsIn(ped, false)
						SetEntityAsNoLongerNeeded(ped)
						SetEntityCoords(ped,10000,10000,10000,1,0,0,1)
						if veh ~= nil then
							SetEntityAsNoLongerNeeded(veh)
							SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
						end
					end
				end
				for i,model in pairs(cfg.noguns) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						RemoveAllPedWeapons(ped, true)
					end
				end
				for i,model in pairs(cfg.nodrops) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						SetPedDropsWeaponsWhenDead(ped,false) 
					end
				end
			end
		end
		--[[ WORK IN PROGESS // DOES NOT WORK
        for veh in EnumerateVehicles() do
            if DoesEntityExist(veh) then
				for i,model in pairs(cfg.vehs) do
					if (GetEntityModel(veh) == GetHashKey(model)) then
						SetEntityAsNoLongerNeeded(veh)
						SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
					end
				end
			end
		end
		]]
    end
end)

Citizen.CreateThread(function()
    while true 
        do
         -- These natives has to be called every frame.
        SetPedDensityMultiplierThisFrame(cfg.density.peds)
        SetScenarioPedDensityMultiplierThisFrame(cfg.density.peds, cfg.density.peds)
        SetVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        SetRandomVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        SetParkedVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        Citizen.Wait(0)
    end
end)
