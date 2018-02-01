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

local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_voice_display", "cfg/display")
vRP = Proxy.getInterface("vRP")

local voice = 1

Citizen.CreateThread(function()
  while true do
     Citizen.Wait(0)
     if IsControlJustPressed(1, cfg.key) then 
      voice = voice + 1
      if voice > #cfg.volume then voice = 1 end
      vRP.setDiv("voice_text",cfg.volume[voice].css,cfg.volume[voice].text)
      vRP.setDiv("voice_icon",cfg.volume[voice].css,cfg.volume[voice].text)
      NetworkSetTalkerProximity(cfg.volume[voice].distance)
     end
  end
end)

AddEventHandler('playerSpawned', function(spawn)
  vRP.setDiv("voice_text",cfg.volume[voice].css,cfg.volume[voice].text)
  vRP.setDiv("voice_icon",cfg.volume[voice].css,cfg.volume[voice].text)
  NetworkSetTalkerProximity(cfg.volume[voice].distance)
end)