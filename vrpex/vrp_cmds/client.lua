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
vRPcmd = {}
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_cmds",vRPcmd)

mask = nil

function vRPcmd.getPlayerPosH()
	x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local h = GetEntityHeading(GetPlayerPed(-1))
	return x , y , z , h
end

function vRPcmd.teleport(x,y,z,h)
	vRP.unjail() -- force unjail before a teleportation
    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001, 1,0,0,1)
	SetEntityHeading(GetPlayerPed(-1), h+0.0001)
    vRPserver.updatePos(x+0.0001, y+0.0001, z+0.0001)
end

function vRPcmd.togglePlayerMask()
	local custom = vRP.getCustomization()
	if custom[1][1] == 0 then
	  custom[1] = mask
	else
	  mask = custom[1]
	  custom[1] = {0,0}
	end
	vRP.setCustomization(custom)
end