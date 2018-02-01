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

--[[Proxy/Tunnel]]--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)
vRP = Proxy.getInterface("vRP")

custom = {}

function vRPts.setTattoos(data)
    ClearPedDecorations(GetPlayerPed(-1))
	if data then
		custom = data
	end
end

function vRPts.addTattoo(tattoo,store,price)
    ClearPedDecorations(GetPlayerPed(-1))
	if tattoo and store then
	  custom[tattoo] = {store,price}
	end
end

function vRPts.delTattoo(tattoo)
    ClearPedDecorations(GetPlayerPed(-1))
	if tattoo then
	  custom[tattoo] = nil
	end
end

function vRPts.getTattoos()
  return custom
end


function vRPts.cleanPlayer()
  ClearPedDecorations(GetPlayerPed(-1))
  custom = {}
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    while not IsPedModel(GetPlayerPed(-1),"mp_m_freemode_01") and not IsPedModel(GetPlayerPed(-1),"mp_f_freemode_01") do
      Citizen.Wait(1)
    end
    if custom then
      local ped = GetPlayerPed(-1)
      -- parts
      for k,v in pairs(custom) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(v[1]), GetHashKey(k))
      end
    end
  end
end)