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


vRPcw = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

Tunnel.bindInterface("vrp_carwash",vRPcw)
Proxy.addInterface("vrp_carwash",vRPcw)
vRP = Proxy.getInterface("vRP")

function vRPcw.cleanVehicle()
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false), 0.0)
	SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
end

function vRPcw.getDirtLevel()
	return GetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false))
end

function vRPcw.isInAnyVehicle()
  local veh = GetVehiclePedIsIn(GetPlayerPed(-1))  -- pega o veiculo
  if veh then  -- se tiver em veiculo
    local driver = GetPedInVehicleSeat(veh, -1) -- pega o motorista do vieculo
    if driver == GetPlayerPed(-1) then  -- se o motorista for o meu ped
      return true
    end
  end
  return false
end