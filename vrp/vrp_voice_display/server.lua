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
local cfg = module("vrp_voice_display", "cfg/display")
vRPvd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_voice_display")
VDclient = Tunnel.getInterface("vrp_voice_display","vrp_voice_display")
Tunnel.bindInterface("vrp_voice_display",vRPvd)

function vRPvd.setVoiceDisplay(player,volume)
	if not player then player = source end
	vRPclient.setDiv(player,{"voice_text",cfg[volume].css,cfg[volume].text})
    vRPclient.setDiv(player,{"voice_icon",cfg[volume].css,cfg[volume].text})
	VDclient.setTalkerProxity(player,{cfg[volume].distance})
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	vRPvd.setVoiceDisplay(source,1)
end)