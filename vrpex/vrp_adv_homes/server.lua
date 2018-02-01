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
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPh = {}
Tunnel.bindInterface("vrp_adv_homes",vRPh)
Proxy.addInterface("vrp_adv_homes",vRPh)
Hclient = Tunnel.getInterface("vrp_adv_homes")

-- sql
MySQL.createCommand("vRP/fix_home_index",[[
  ALTER TABLE `vrp_user_homes`
	CHANGE COLUMN `home` `home` VARCHAR(255) NOT NULL AFTER `user_id`,
	DROP INDEX `home`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`user_id`, `home`);
]])
MySQL.createCommand("vRP/new_rm_address","DELETE FROM vrp_user_homes WHERE user_id = @user_id AND home = @home")

-- CFG
local cfg = module("vrp_adv_homes","cfg/homes")

-- LANG
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(cfg.lang, module("vrp", "cfg/lang/"..cfg.lang) or {})
lang = Lang.lang[cfg.lang]

-- api
local components = {}

-- return user address (home and number) or nil
function vRPh.getUserAddresses(user_id)
  local rows = MySQL.query("vRP/get_address", {user_id = user_id})
  return rows
end

-- set user address
function vRPh.setUserAddress(user_id,home,number)
  MySQL.execute("vRP/set_address", {user_id = user_id, home = home, number = number})
end

-- remove user address
function vRPh.removeUserAddress(user_id, home)
  MySQL.execute("vRP/new_rm_address", {user_id = user_id, home = home})
end

-- return user_id or nil
function vRPh.getUserByAddress(home,number)
  local rows = MySQL.query("vRP/get_home_owner", {home = home, number = number})
  if #rows > 0 then
    return tonumber(rows[1].user_id)
  end
  return false
end

-- init
Citizen.CreateThread(function()
  local data = vRP.getSData("homes:init")
  local init = json.decode(data)
  if not init then
    MySQL.execute("vRP/fix_home_index")			          
	vRP.setSData("homes:init", json.encode(true))
  end
end)

-- find a free address number to buy
-- return number or nil if no numbers availables
function vRPh.findFreeNumber(home,max)
  local i = 1
  while i <= max do
    if not vRPh.getUserByAddress(home,i) then
      return i
    end
    i = i+1
  end
end

-- define home component
-- name: unique component id
-- oncreate(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
-- ondestroy(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
function vRPh.defHomeComponent(name, oncreate, ondestroy)
  components[name] = {oncreate,ondestroy}
end

-- SLOTS

-- used (or not) slots
local uslots = {}
for k,v in pairs(cfg.slot_types) do
  uslots[k] = {}
  for l,w in pairs(v) do
    uslots[k][l] = {used=false}
  end
end

-- return slot id or nil if no slot available
local function allocateSlot(stype)
  local slots = cfg.slot_types[stype]
  if slots then
    local _uslots = uslots[stype]
    -- search the first unused slot
    for k,v in pairs(slots) do
      if _uslots[k] and not _uslots[k].used then
        _uslots[k].used = true -- set as used
        return k  -- return slot id
      end
    end
  end

  return nil
end

-- free a slot
local function freeSlot(stype, id)
  local slots = cfg.slot_types[stype]
  if slots then
    uslots[stype][id] = {used = false} -- reset as unused
  end
end

-- get in use address slot (not very optimized yet)
-- return slot_type, slot_id or nil,nil
local function getAddressSlot(home_name,number)
  for k,v in pairs(uslots) do
    for l,w in pairs(v) do
      if w.home_name == home_name and tostring(w.home_number) == tostring(number) then
        return k,l
      end
    end
  end

  return nil,nil
end

-- builds

local function is_empty(table)
  for k,v in pairs(table) do
    return false
  end

  return true
end

-- leave slot
local function leave_slot(user_id,player,stype,sid) -- called when a player leave a slot
  print(user_id.." leave slot "..stype.." "..sid)
  local slot = uslots[stype][sid]
  local home = cfg.homes[slot.home_name]

  -- record if inside a home slot
  local data = vRP.getUData(user_id, "homes:inside")
  local inside = json.decode(data)
  if inside and inside.home_stype then
    vRP.setUData(user_id, "homes:inside", json.encode({home_stype = nil, home_sid = nil}))
  end

  -- teleport to home entry point (outside)
  vRPclient.teleport(player, table.unpack(home.entry_point)) -- already an array of params (x,y,z)

  -- uncount player
  slot.players[user_id] = nil

  -- destroy loaded components and special entry component
  for k,v in pairs(cfg.slot_types[stype][sid]) do
    local name,x,y,z = table.unpack(v)

    if name == "entry" then
      -- remove marker/area
      local nid = "vRP:home:slot"..stype..sid
      vRPclient.removeNamedMarker(player,nid)
      vRP.removeArea(player,nid)
    else
      local component = components[v[1]]
      if component then
        -- ondestroy(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
        component[2](slot.owner_id, stype, sid, k, v._config or {}, x, y, z, player)
      end
    end
  end

  if is_empty(slot.players) then -- free the slot
    print("free slot "..stype.." "..sid)
    freeSlot(stype,sid)
  end
end

-- enter slot
local function enter_slot(user_id,player,stype,sid) -- called when a player enter a slot
  print(user_id.." enter slot "..stype.." "..sid)
  local slot = uslots[stype][sid]
  local home = cfg.homes[slot.home_name]

  -- record if inside a home slot
  local data = vRP.getUData(user_id, "homes:inside")
  local inside = json.decode(data)
  if not inside or not inside.home_stype then
    vRP.setUData(user_id, "homes:inside", json.encode({home_stype = stype, home_sid = sid}))
  end

  -- count
  slot.players[user_id] = player

  -- build the slot entry menu
  local menu = {name=slot.home_name,css={top="75px",header_color="rgba(0,255,125,0.75)"}}
  menu[lang.home.slot.leave.title()] = {function(player,choice) -- add leave choice
    leave_slot(user_id,player,stype,sid)
  end}

  local owner = (vRPh.getUserByAddress(slot.home_name, slot.home_number) == user_id)
  -- check if owner
  if owner then
    menu[lang.home.slot.ejectall.title()] = {function(player,choice) -- add eject all choice
      -- copy players before calling leave for each (iteration while removing)
      local copy = {}
      for k,v in pairs(slot.players) do
        copy[k] = v
      end

      for k,v in pairs(copy) do
        leave_slot(k,v,stype,sid)
      end
    end,lang.home.slot.ejectall.description()}
  end

  -- build the slot entry menu marker/area

  local function entry_enter(player,area)
    vRP.openMenu(player,menu)
  end

  local function entry_leave(player,area)
    vRP.closeMenu(player)
  end

  -- build components and special entry component
  for k,v in pairs(cfg.slot_types[stype][sid]) do
    local name,x,y,z = table.unpack(v)

    if name == "entry" then
      -- teleport to the slot entry point
      vRPclient.teleport(player, x,y,z) -- already an array of params (x,y,z)

      local nid = "vRP:home:slot"..stype..sid
      vRPclient.setNamedMarker(player,nid,x,y,z-1,0.7,0.7,0.5,0,255,125,125,150)
      vRP.setArea(player,nid,x,y,z,1,1.5,entry_enter,entry_leave)
    else -- load regular component
      local component = components[v[1]]
      if component then
        -- oncreate(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
        component[1](slot.owner_id, stype, sid, k, v._config or {}, x, y, z, player)
      end
    end
  end
end

-- access a home by address
-- return true on success
function vRPh.accessHome(user_id, home, number)
  local _home = cfg.homes[home]
  local stype,slotid = getAddressSlot(home,number) -- get current address slot
  local player = vRP.getUserSource(user_id)

  local owner_id = vRPh.getUserByAddress(home,number)
  if _home ~= nil and player ~= nil then
    if stype == nil then -- allocate a new slot
      stype = _home.slot
      slotid = allocateSlot(_home.slot)

      if slotid ~= nil then -- allocated, set slot home infos
        local slot = uslots[stype][slotid]
        slot.home_name = home
        slot.home_number = number
        slot.owner_id = owner_id
        slot.players = {} -- map user_id => player
      end
    end

    if slotid ~= nil then -- slot available
      enter_slot(user_id,player,stype,slotid)
      return true
    end
  end
end

-- build the home entry menu
local function build_entry_menu(user_id, home_name)
  local home = cfg.homes[home_name]
  local menu = {name=home_name,css={top="75px",header_color="rgba(0,255,125,0.75)"}}

  -- intercom, used to enter in a home
  menu[lang.home.intercom.title()] = {function(player,choice)
    local number = vRP.prompt(player, lang.home.intercom.prompt(), "")
      number = parseInt(number)
      local huser_id = vRPh.getUserByAddress(home_name,number)
        if huser_id then
          if huser_id == user_id then -- identify owner (direct home access)
            if not vRPh.accessHome(user_id, home_name, number) then
                vRPclient.notify(player,lang.home.intercom.not_available())
              end
          else -- try to access home by asking owner
            local hplayer = vRP.getUserSource(huser_id)
            if hplayer ~= nil then
              local who = vRP.prompt(player,lang.home.intercom.prompt_who(),"")
                vRPclient.notify(player,lang.home.intercom.asked())
                -- request owner to open the door
                if vRP.request(hplayer, lang.home.intercom.request({who}), 30) then
                    vRPh.accessHome(user_id, home_name, number)
                  else
                    vRPclient.notify(player,lang.home.intercom.refused())
                  end
            else
              vRPclient.notify(player,lang.home.intercom.refused())
            end
          end
        else
          vRPclient.notify(player,lang.common.not_found())
        end
  end,lang.home.intercom.description()}

  menu[lang.home.buy.title()] = {function(player,choice)
    local addresses = vRPh.getUserAddresses(user_id)
	local owner = false
	for k,address in pairs(addresses) do
      if address and address.home == home_name then -- check if already have a home
	    owner = true
	  end
	end
	if not owner then
      local number = vRPh.findFreeNumber(home_name, home.max)
      if number then
        if vRP.tryPayment(user_id, home.buy_price) then
          -- bought, set address
          vRPh.setUserAddress(user_id, home_name, number)

          vRPclient.notify(player,lang.home.buy.bought())
        else
          vRPclient.notify(player,lang.money.not_enough())
        end
      else
        vRPclient.notify(player,lang.home.buy.full())
      end
    else
      vRPclient.notify(player,lang.home.buy.have_home())
    end
  end, lang.home.buy.description({home.buy_price})}

  menu[lang.home.sell.title()] = {function(player,choice)
    local addresses = vRPh.getUserAddresses(user_id)
	local owner = false
	for k,address in pairs(addresses) do
      if address and address.home == home_name then -- check if already have a home
	    owner = true
	  end
	end
	if owner then
      -- sold, give sell price, remove address
      vRP.giveMoney(user_id, home.sell_price)
      vRPh.removeUserAddress(user_id, home_name)
      vRPclient.notify(player,lang.home.sell.sold())
    else
      vRPclient.notify(player,lang.home.sell.no_home())
    end
  end, lang.home.sell.description({home.sell_price})}

  return menu
end

-- build homes entry points
local function build_client_homes(source)
  local user_id = vRP.getUserId(source)
  if user_id then
    for k,v in pairs(cfg.homes) do
      local x,y,z = table.unpack(v.entry_point)

      local function entry_enter(player,area)
        local user_id = vRP.getUserId(player)
        if user_id and vRP.hasPermissions(user_id,v.permissions or {}) then
          vRP.openMenu(source,build_entry_menu(user_id, k))
        end
      end

      local function entry_leave(player,area)
        vRP.closeMenu(player)
      end

      vRPclient.addBlip(source,x,y,z,v.blipid,v.blipcolor,k)
      vRPclient.addMarker(source,x,y,z-1,0.7,0.7,0.5,0,255,125,125,150)

      vRP.setArea(source,"vRP:home"..k,x,y,z,1,1.5,entry_enter,entry_leave)
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then -- first spawn, build homes
    build_client_homes(source)
  end -- death, leave home if inside one
  -- leave slot if inside one
  local data = vRP.getUData(user_id, "homes:inside")
  local inside = json.decode(data)
  if inside and inside.home_stype then
    leave_slot(user_id, source, inside.home_stype, inside.home_sid)
  end
end)


