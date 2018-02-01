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

vRP = Proxy.getInterface("vRP","vrp_esx_menu")
vRPclient = Tunnel.getInterface("vRP","vrp_esx_menu")

local cfg = module("vrp_esx_menu", "cfg/design")
local lcfg = module("vrp", "cfg/gui")

-- events
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    -- load additional css using the div api
	SetTimeout(30000,function()
	  vRPclient.setDivCss(source,{"additional_css",".div_additional_css{ display: none; }\n\n"..lcfg.css.."\n\n"..cfg.menu,""})
	end)
  end
end)
