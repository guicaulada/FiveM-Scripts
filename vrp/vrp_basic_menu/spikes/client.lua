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

function vRPbm.setSpikesOnGround()
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	h = GetEntityHeading(ped)
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
	spike = GetHashKey("P_ld_stinger_s")

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
    end

    local object = CreateObject(spike, ox, oy, oz, true, true, false)
    PlaceObjectOnGroundProperly(object)
	SetEntityHeading(object, h+90)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
      if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
         SetVehicleTyreBurst(veh, 0, true, 1000.0)
         SetVehicleTyreBurst(veh, 1, true, 1000.0)
         SetVehicleTyreBurst(veh, 2, true, 1000.0)
         SetVehicleTyreBurst(veh, 3, true, 1000.0)
         SetVehicleTyreBurst(veh, 4, true, 1000.0)
         SetVehicleTyreBurst(veh, 5, true, 1000.0)
         SetVehicleTyreBurst(veh, 6, true, 1000.0)
         SetVehicleTyreBurst(veh, 7, true, 1000.0)
         vRPbm.removeSpikes()
       end
     end
   end
end)

function vRPbm.isCloseToSpikes()
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey("P_ld_stinger_s"), true) then
	  return true
	else 
	  return false
	end
end

function vRPbm.removeSpikes()
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey("P_ld_stinger_s"), true) then
        spike = GetClosestObjectOfType(ox, oy, oz, 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
        SetEntityAsMissionEntity(spike, true, true)
        DeleteObject(spike)
	end
end