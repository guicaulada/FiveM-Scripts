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

-- a basic gunshop implementation
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPas = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
ASclient = Tunnel.getInterface("vrp_armorshop")
Tunnel.bindInterface("vrp_armorshop",vRPas)

local cfg = module("vrp_armorshop", "cfg/gunshops")
local lcfg = module("vrp", "cfg/base")

-- load global and local languages
local Luang = module("vrp", "lib/Luang")
local Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
--Lang:loadLocale(lcfg.lang, module("vrp_armorshop", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

local gunshops = cfg.gunshops
local gunshop_types = cfg.gunshop_types

local gunshop_menus = {}

function vRPas.updateArmor(armor)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
	vRP.setUData(user_id,"vRP:bodyarmor",json.encode(armor))
  end
end

-- build gunshop menus
Citizen.CreateThread(function()
  for gtype,weapons in pairs(gunshop_types) do
    local gunshop_menu = {
      name=lang.gunshop.title({gtype}),
      css={top = "75px", header_color="rgba(255,0,0,0.75)"}
    }

    -- build gunshop items
    local kitems = {}

    -- item choice
    local gunshop_choice = function(player,choice)
      local weapon = kitems[choice][1]
      local price = kitems[choice][2]
      local price_ammo = kitems[choice][3]

      if weapon then
        local user_id = vRP.getUserId(player)
	    if weapon == "ARMOR" then-- get player weapons to not rebuy the body
          -- payment
          if user_id and vRP.tryFullPayment(user_id,price) then
            ASclient.setArmour(player,100,true)
            vRPclient.notify(player,lang.money.paid({price}))
          else
            vRPclient.notify(player,lang.money.not_enough())
          end
	    else
          -- get player weapons to not rebuy the body
          local weapons = vRPclient.getWeapons(player)
          -- prompt amount
          local amount = vRP.prompt(player,lang.gunshop.prompt_ammo({choice}),"")
            local amount = parseInt(amount)
            if amount >= 0 then
              local total = math.ceil(parseFloat(price_ammo)*parseFloat(amount))
            
              if weapons[string.upper(weapon)] == nil then -- add body price if not already owned
                total = total+price
              end

              -- payment
              if user_id and vRP.tryFullPayment(user_id,total) then
                vRPclient.giveWeapons(player,{
                  [weapon] = {ammo=amount}
                })

                vRPclient.notify(player,lang.money.paid({total}))
              else
                vRPclient.notify(player,lang.money.not_enough())
              end
            else
              vRPclient.notify(player,lang.common.invalid_value())
            end
	    end
      end
    end

    -- add item options
    for k,v in pairs(weapons) do
      if k ~= "_config" then -- ignore config property
        kitems[v[1]] = {k,math.max(v[2],0),math.max(v[3],0)} -- idname/price/price_ammo
        gunshop_menu[v[1]] = {gunshop_choice,lang.gunshop.info({v[2],v[3],v[4]})} -- add description
      end
    end

    gunshop_menus[gtype] = gunshop_menu
  end
end)

function build_client_gunshops(source)
  local user_id = vRP.getUserId(source)
  if user_id then
    for k,v in pairs(gunshops) do
      local gtype,x,y,z = table.unpack(v)
      local group = gunshop_types[gtype]
      local menu = gunshop_menus[gtype]

      if group and menu then
        local gcfg = group._config

        local function gunshop_enter()
          local user_id = vRP.getUserId(source)
          if user_id and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
            vRP.openMenu(source,menu) 
          end
        end

        local function gunshop_leave()
          vRP.closeMenu(source)
        end

        vRPclient.addBlip(source,x,y,z,gcfg.blipid,gcfg.blipcolor,lang.gunshop.title({gtype}))
        vRPclient.addMarker(source,x,y,z-1,0.7,0.7,0.5,0,255,125,125,150)

        vRP.setArea(source,"vRP:gunshop"..k,x,y,z,1,1.5,gunshop_enter,gunshop_leave)
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    Citizen.CreateThread(function()
      build_client_gunshops(source)
	  local value = vRP.getUData(user_id,"vRP:bodyarmor")
	  local armor = json.decode(value)
      if armor then
        ASclient.setArmour(source,tonumber(armor),true)
      end
	end)
  end
end)
