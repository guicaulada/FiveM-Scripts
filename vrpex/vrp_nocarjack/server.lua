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

-- a basic gunshop implementation
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPncj = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
NCJclient = Tunnel.getInterface("vrp_nocarjack")
Tunnel.bindInterface("vrp_nocarjack",vRPncj)

local vehicles = {}
function vRPncj.setVehicleDoorsForEveryone(veh, doors, plate)
  if not vehicles[plate] then
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	  local user_plate = "P " .. identity.registration
	  if user_plate ~= plate then
	    local users = vRP.getUsers()
	    for k,v in pairs(users) do
          NCJclient.setVehicleDoors(v,veh, doors)
	    end
	  end
	vehicles[plate] = true
  end
end