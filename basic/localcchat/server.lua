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

AddEventHandler("vRP:playerSpawn",function(user_id,source,name,last_login)
	local player = source
	local r = math.random(10,250)
	local g = math.random(10,250) 
	local b = math.random(10,250)
	TriggerClientEvent("setPlayerColor", player, r, g, b)
end)

AddEventHandler("chatMessage", function(source, name, message)
    if message:sub(1, 1) == "/" then
        fullcmd = stringSplit(message, " ")
        cmd = fullcmd[1]
		local msg = fullcmd[2]
		for k,v in ipairs(fullcmd) do
			if k > 2 then
				msg = msg .. " " .. fullcmd[k]
			end
		end

        if cmd == "/me" then
			TriggerClientEvent("sendProximityMessageMe", -1, source, name, tostring(msg))
        	CancelEvent()
        end
		
        if cmd == "/do" then
			TriggerClientEvent("sendProximityMessageDo", -1, source, name, tostring(msg))
        	CancelEvent()
        end
		
        if cmd == "/g" then
			TriggerClientEvent("sendGlobalMessage", -1, source, name, tostring(msg))
        	CancelEvent()
        end
		
        if cmd == "/ooc" then
			TriggerClientEvent("sendOOCMessage", -1, source, name, tostring(msg))
        	CancelEvent()
        end
	else
		TriggerClientEvent("sendProximityMessage", -1, source, name, message)
        CancelEvent()
	end
end)

function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end