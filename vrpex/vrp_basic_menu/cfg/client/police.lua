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

frozen = false
unfrozen = false
other = nil
drag = false
playerStillDragged = false


function vRPbm.loadFreeze(notify,god,ghost)
	if not frozen then
	  if notify then
	    vRP.notify(lang.freeze.frozen) -- lang.freeze.frozen()
	  end
	  frozen = true
	  invincible = god
	  invisible = ghost
	  unfrozen = false
	else
	  if notify then
	    vRP.notify(lang.freeze.unfrozen) -- lang.freeze.unfrozen()
	  end
	  unfrozen = true
	  invincible = false
	  invisible = false
	end
end

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

function vRPbm.policeDrag(p1)
    other = p1
    drag = not drag
end

Citizen.CreateThread(function()
    while true do
        if drag and other then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = GetPlayerPed(-1)
            Citizen.InvokeNative(0x6B9BBD38AB0796DF, myped, ped, 4103, 11816, 0.50, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        else
            if playerStillDragged then
                DetachEntity(GetPlayerPed(-1), true, false)
                playerStillDragged = false
            end
        end
        Citizen.Wait(0)
    end
end)

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

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				frozen = false
				invisible = false
				invincible = false
			else
				if invincible then
					SetEntityInvincible(GetPlayerPed(-1),true)
				end
				if invisible then
					SetEntityVisible(GetPlayerPed(-1),false)
				end
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
		end
		Citizen.Wait(0)
	end
end)