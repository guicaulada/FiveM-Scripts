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

-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)
TSclient = Tunnel.getInterface("vrp_tattoos")

-- CFG
local cfg = module("vrp_tattoos", "cfg/tattoos")

-- LANG
lcfg = module("vrp", "cfg/base")
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
Lang:loadLocale(lcfg.lang, module("vrp_tattoos", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

-- build tattooshop menus
function vRPts.openTattooshop(source, shop)
    local user_id = vRP.getUserId(source)
    local menudata = {
      name=lang.tattoos.title(),
      css={top = "75px", header_color="rgba(255,0,0,0.75)"}
    }
  
    -- build tattooshop items
    local kitems = {}
    local old_custom = TSclient.getTattoos(source)
  
    -- item choice
    local tattoshop_choice = function(player,choice)
      local tattoo = cfg.tattoos[shop][choice][1]
      local price = cfg.tattoos[shop][choice][2]
  
      if tattoo then
  	    local applied = false
  	    if tattoo == "CLEAR" then
		  vRPclient.notify(source,lang.tattoos.cleaned())
          TSclient.cleanPlayer(source)
  	    else
		  local custom = TSclient.getTattoos(source)
  		  for k,v in pairs(custom) do
  		    if k == tattoo then
  		      applied = true
  		    end
  		  end
  		  if not applied then
		    vRPclient.notify(source,lang.tattoos.added())
  		    TSclient.addTattoo(source, tattoo, shop, price)
  	      else
		    vRPclient.notify(source,lang.tattoos.removed())
		    TSclient.delTattoo(source,tattoo)
		  end
        end
      end
	end
    
    menudata.onclose = function(player)
      -- compute price
      local custom = TSclient.getTattoos(source)
      local price = 0
      for k,v in pairs(custom) do
        local old = old_custom[k]
        if not old then price = price + v[2] end -- change of tattoo
      end
  
      if vRP.tryPayment(user_id,price) then
  		vRP.setUData(user_id,"vRP:tattoos",json.encode(custom))
        if price > 0 then
          vRPclient.notify(source,lang.money.paid({price}))
        end
      else
        vRPclient.notify(source,lang.money.not_enough())
        -- revert changes
        TSclient.setTattoos(source,old_custom)
      end
    end
  
    -- add item options
    for k,v in pairs(cfg.tattoos[shop]) do
      if k ~= "_config" then -- ignore config property
        menudata[k] = {tattoshop_choice,lang.garage.buy.info({v[2],v[3]})} -- add description
      end
    end
  
    vRP.openMenu(source,menudata)
end

local function build_client_tattooshops(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(cfg.shops) do
      local shop,x,y,z = table.unpack(v)
      local group = cfg.tattoos[shop]

      if group then
        local gcfg = group._config

        local function tattooshop_enter(source)
          local user_id = vRP.getUserId(source)
          if user_id and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
            vRPts.openTattooshop(source,shop)
          end
        end

        local function tattooshop_leave(source)
          vRP.closeMenu(source)
        end
        vRPclient.addBlip(source,x,y,z,gcfg.blipid,gcfg.blipcolor,gcfg.title)
        vRPclient.addMarker(source,x,y,z-1,0.7,0.7,0.5,0,255,125,125,150)

        vRP.setArea(source,"vRP:tattooshop"..k,x,y,z,1,1.5,tattooshop_enter,tattooshop_leave)
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_tattooshops(source)
	local data = vRP.getUData(user_id,"vRP:tattoos")
	if data then
	  local tattoos = json.decode(data)
      TSclient.setTattoos(source,tattoos)
	end
  end
end)