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
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
Tunnel.bindInterface("vrp_scoreboard",vRPsb)
users = {}

function vRPsb.insertUser(user_id,user_source,user_firstname,user_name,user_job)
	users[user_id] = {
		player = user_source,
		firstname = user_firstname,
		name = user_name,
		job = user_job
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
        Citizen.Wait(0)

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
                    Citizen.Wait(0)
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