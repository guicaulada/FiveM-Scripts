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


function vRPbm.getArmour()
    return GetPedArmour(GetPlayerPed(-1))
end

function vRPbm.setArmour(armour,vest)
    local player = GetPlayerPed(-1)
    if vest then
	  if(GetEntityModel(player) == GetHashKey("mp_m_freemode_01")) then
	    SetPedComponentVariation(player, 9, 4, 1, 2)  --Bulletproof Vest
	  else 
	    if(GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
	      SetPedComponentVariation(player, 9, 6, 1, 2)
	    end
	  end
    end
    local n = math.floor(armour)
    SetPedArmour(player,n)
end

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(30000)

    if IsPlayerPlaying(PlayerId()) and state_ready then
	  if vRPbm.getArmour() == 0 then
	    if(GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01")) or (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) then
	      SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
		end
	  end
    end
  end
end)