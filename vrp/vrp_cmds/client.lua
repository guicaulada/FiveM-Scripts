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


vRPcmd = {}
Tunnel.bindInterface("vrp_cmds",vRPcmd)
vRPserver = Tunnel.getInterface("vRP","vrp_cmds")
CMDserver = Tunnel.getInterface("vrp_cmds","vrp_cmds")
vRP = Proxy.getInterface("vRP")

function vRPcmd.getPlayerPosH()
	x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local h = GetEntityHeading(GetPlayerPed(-1))
	return x , y , z , h
end

function vRPcmd.teleport(x,y,z,h)
	vRP.unjail({}) -- force unjail before a teleportation
    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001, 1,0,0,1)
	SetEntityHeading(GetPlayerPed(-1), h+0.0001)
    vRPserver.updatePos({x+0.0001, y+0.0001, z+0.0001})
end