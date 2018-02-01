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

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPcw = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
CWclient = Tunnel.getInterface("vrp_carwash")
Tunnel.bindInterface("vrp_carwash",vRPcw)
Proxy.addInterface("vrp_carwash",vRPcw)
local cfg = module("vrp_carwash", "cfg/carwash")
local lcfg = module("vrp", "cfg/base")
-- load global and local languages
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

function vRPcw.cleanVehicle(source)
	local user_id = vRP.getUserId(source)
	local in_vehicle = CWclient.isInAnyVehicle(source)
	if in_vehicle then
	  local dirt = CWclient.getDirtLevel(source)
	  if parseFloat(dirt) > parseFloat(1.0) then
	    local total = parseInt(parseFloat(dirt)*cfg.price)
	    if vRP.tryPayment(user_id,math.floor(total)) then
	  	CWclient.cleanVehicle(source)
	  	vRPclient.notify(source, lang.money.paid({total}))
	    else
	  	vRPclient.notify(source, lang.money.not_enough())
	    end	
	  else
	    vRPclient.notify(source, cfg.lang.cleaned)
	  end
	else
	  vRPclient.notify(source, cfg.lang.no_veh)
	end
end

local function build_client_carwash(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(cfg.carwash) do
      local x,y,z = table.unpack(v)

      local carwash_enter = function(source)
        vRPcw.cleanVehicle(source)
      end

      local function carwash_leave(source)
        vRPclient.notify(source,cfg.lang.goodbye)
      end

      vRPclient.addBlip(source,x,y,z,cfg.blip.id,cfg.blip.color,cfg.lang.title)
      vRPclient.addMarker(source,x,y,z-1,3,3,0.7,125,125,255,255,150)

      vRP.setArea(source,"vRP:carwash"..k,x,y,z,3,1.5,carwash_enter,carwash_leave)
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_carwash(source)
  end
end)