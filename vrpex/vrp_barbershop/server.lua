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
vRPbs = {}
Tunnel.bindInterface("vrp_barbershop",vRPbs)
Proxy.addInterface("vrp_barbershop",vRPbs)
BSclient = Tunnel.getInterface("vrp_barbershop")

-- CFG
local cfg = module("vrp_barbershop", "cfg/barbershop")
local barbershops = cfg.barbershops

-- LANG
lcfg = module("vrp", "cfg/base")
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
Lang:loadLocale(lcfg.lang, module("vrp_barbershop", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

-- open the skin shop for the specified ped parts
-- name = partid
function vRPbs.openBarbershop(source,parts)
  local user_id = vRP.getUserId(source)
  if user_id then
    -- notify player if wearing a uniform
    local data = vRP.getUserDataTable(user_id)
    if data.cloakroom_idle ~= nil then
      vRPclient.notify(source,lang.common.wearing_uniform())
    end

    -- get old customization to compute the price
    local old_custom = BSclient.getOverlay(source)

    -- start building menu
    local menudata = {
      name=lang.barbershop.title(),
      css={top = "75px", header_color="rgba(0,255,125,0.75)"}
    }

    local drawables = {}
    local textures = {}

    local ontexture = function(player, choice)
      -- change texture
      local texture = textures[choice]
      texture[1] = texture[1]+1
      if texture[1] >= texture[2] then texture[1] = 0 end -- circular selection

      -- apply change
      local custom = BSclient.getOverlay(source)
      custom[""..parts[choice]] = {drawables[choice][1],texture[1]}
      BSclient.setOverlay(source,custom)
    end

    local ondrawable = function(player, choice, mod)
      if mod == 0 then -- tex variation
        ontexture(player,choice)
      else

        -- change drawable
        local drawable = drawables[choice]
        drawable[1] = drawable[1]+mod

        if isprop then
          if drawable[1] >= drawable[2] then drawable[1] = -1 -- circular selection (-1 for prop parts)
          elseif drawable[1] < -1 then drawable[1] = drawable[2]-1 end 
        else
          if drawable[1] >= drawable[2] then drawable[1] = 0 -- circular selection
          elseif drawable[1] < 0 then drawable[1] = drawable[2] end 
        end

        -- apply change
        local custom = BSclient.getOverlay(source)
        custom[""..parts[choice]] = {drawable[1],textures[choice][1]}
        BSclient.setOverlay(source,custom)

        -- update max textures number
        local n = BSclient.getTextures(source,drawable[1])
        textures[choice][2] = n

        if textures[choice][1] >= n then
          textures[choice][1] = 0 -- reset texture number
        end
      end
    end

    for k,v in pairs(parts) do -- for each part, get number of drawables and build menu

      drawables[k] = {0,0} -- {current,max}
      textures[k] = {0,0}  -- {current,max}

      -- init using old customization
      local old_part = old_custom[v]
      if old_part then
        drawables[k][1] = old_part[1]
        textures[k][1] = old_part[2]
      end

      -- get max drawables
      drawables[k][2] = BSclient.getDrawables(source,v)  -- set max

      -- get max textures for this drawable
      textures[k][2] = BSclient.getTextures(source,v) -- set max

      -- add menu choices
      menudata[k] = {ondrawable}
    end

    menudata.onclose = function(player)
      -- compute price
      local custom = BSclient.getOverlay(source)
      local price = 0
      for k,v in pairs(custom) do
        local old = old_custom[k]
		
        if v[1] ~= old[1] then price = price + cfg.drawable_change_price end -- change of drawable
        if v[2] ~= old[2] then price = price + cfg.texture_change_price end -- change of texture
      end

      if vRP.tryPayment(user_id,price) then
        if price > 0 then
          vRPclient.notify(source,lang.money.paid({price}))
		  vRP.setUData(user_id,"vRP:barbershop",json.encode(custom))
        end
      else
        vRPclient.notify(source,lang.money.not_enough())
        -- revert changes
        BSclient.setOverlay(source,old_custom)
      end
    end

    -- open menu
    vRP.openMenu(source,menudata)
  end
end


local function build_client_barbershops(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(barbershops) do
      local parts,x,y,z = table.unpack(v)

      local barbershop_enter = function(source)
        vRPbs.openBarbershop(source,parts)
      end

      local function barbershop_leave(source)
        vRP.closeMenu(source)
      end

      vRPclient.addBlip(source,x,y,z,71,13,lang.barbershop.title())
      vRPclient.addMarker(source,x,y,z-1,0.7,0.7,0.5,0,255,125,125,150)

      vRP.setArea(source,"vRP:barbershop"..k,x,y,z,1,5,barbershop_enter,barbershop_leave)
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_barbershops(source)
    local custom = {}
    local value = vRP.getUData(user_id,"vRP:barbershop")
    if value ~= nil then
	  custom = json.decode(value)
      BSclient.setOverlay(source,custom)
	end
  end
end)

-- ADMIN BUTTON
player_customs = {}
ch_display_custom = {function(player, choice)
  local custom = BSclient.getOverlay(player)
  if player_customs[player] then -- hide
    player_customs[player] = nil
    vRPclient.removeDiv(player,"barbershop")
  else -- show
    local content = "cfg.default = { \n"
    for k,v in pairs(custom) do
      content = content.."[\""..k.."\"] = {"..v[1]..","..v[2].."},".."\n" 
    end
	content = content.."}"
    player_customs[player] = true
	local ok = vRP.prompt(player,"Head Overlay(Press CTRL+A and CTRL+C to copy):",content)
  end
end, lang.barbershop.desc()}

Citizen.CreateThread(function()
  vRP.registerMenuBuilder("admin", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
  	
      if vRP.hasPermission(user_id,lang.barbershop.perm()) then
        choices[lang.barbershop.button()] = ch_display_custom
      end
  	
      add(choices)
    end
  end)
end)