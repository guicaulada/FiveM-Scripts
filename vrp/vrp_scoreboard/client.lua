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

local listOn = false
vRPsb = {}
Tunnel.bindInterface("vrp_scoreboard",vRPsb)
users = {}

function vRPsb.insertUser(user_id,user_source,user_firstname,user_name,user_job)
	users[user_id] = { -- tonumber and tostrings are inlogical in this case
		player = tonumber(user_source), -- but apparently it fixes holes that shouldnt even be on the list in case this was the problem
		firstname = tostring(user_firstname), -- maybe my logic is flawed, but whats the point of converting values to what they are already ?
		name = tostring(user_name), -- this doesn't change anything, but for some, it seems to fix the holes that logically shouldn't even be there
		job = tostring(user_job) -- Better be safe than sorry. Everything should have a logical explanation... maybe not in FiveM. =)
	}
end

function vRPsb.removeUser(user_id)
	users[user_id] = nil
end

function vRPsb.updateUser(user_id,user_job)
	users[user_id].job = user_job
end

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 27)--[[ INPUT_PHONE ]] then
            if not listOn then
                local players = ""
                for k, v in pairs(users) do
				  if NetworkIsPlayerActive(GetPlayerFromServerId(v.player)) then 
                    r, g, b = GetPlayerRgbColour(GetPlayerFromServerId(v.player))
                    players = players..'<tr style=\"color: rgb(' .. r .. ', ' .. g .. ', ' .. b .. ')\"><td>' .. k .. '</td><td>' .. GetPlayerName(GetPlayerFromServerId(v.player)) .. '</td><td>' .. v.firstname .. " " .. v.name .. '</td><td>' .. (v.job or "") .. '</td></tr>'
				  end
                end
                
                SendNUIMessage({ text = players })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 27) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)