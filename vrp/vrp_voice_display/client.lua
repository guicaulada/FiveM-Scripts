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

vRPvd = {}
Tunnel.bindInterface("vrp_voice_display",vRPvd)
vRPserver = Tunnel.getInterface("vRP","vrp_voice_display")
VDserver = Tunnel.getInterface("vrp_voice_display","vrp_voice_display")
vRP = Proxy.getInterface("vRP")

local key = 10 -- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls
local voice = 1 -- Current distance to voice (1 to 3) (Do not touch)

function vRPvd.setTalkerProxity(distance)
	NetworkSetTalkerProximity(distance) -- set range
end

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(0)
 		if IsControlJustPressed(1, key) then 
 			voice = voice + 1
			if voice > 3 then voice = 1 end
			VDserver.setVoiceDisplay({false,voice})
 		end
 	end
end)