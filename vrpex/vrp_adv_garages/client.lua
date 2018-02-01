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
vRPg = {}
Tunnel.bindInterface("vrp_adv_garages",vRPg)
Proxy.addInterface("vrp_adv_garages",vRPg)
Gserver = Tunnel.getInterface("vrp_adv_garages")

local cfg = module("vrp_adv_garages", "cfg/garages")
local lang = module("vrp_adv_garages", "cfg/lang/"..cfg.lang)

local showroom = nil
local vehicles = {}
local mods = {}
local toggles = {}
local colors = {}
local wheel = 0

function vRPg.repairVehicle(mod)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  SetVehicleFixed(veh)
  SetVehicleDirtLevel(veh, 0.0)
  SetVehicleUndriveable(veh, false)
end

function vRPg.notifyTimed(msg,timed)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(msg)
  local n = DrawNotification(true, false)
  Citizen.Wait(timed)
  RemoveNotification(n)
end

function vRPg.protectVehicle(protect)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if veh then
    FreezeEntityPosition(veh, protect)
    if protect then SetVehicleDoorsLocked(veh,4) else SetVehicleDoorsLocked(veh,0) end
    SetPlayerInvincible(PlayerId(),protect)
    SetEntityInvincible(veh,protect)
    SetEntityInvincible(ped,protect)
    SetEntityCollision(veh,not protect,not protect)
  end
end

function vRPg.toggleNeon(neon)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if not toggles[neon] then toggles[neon] = false end
  toggles[neon] = not toggles[neon]
  SetVehicleNeonLightEnabled(veh,neon, toggles[neon])
end

function vRPg.setNeonColour(r,g,b)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  SetVehicleNeonLightsColour(veh,r,g,b)
end

function vRPg.setSmokeColour(r,g,b)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  SetVehicleTyreSmokeColor(veh,r,g,b)
end

function vRPg.scrollVehiclePrimaryColour(pmod)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if not colors[1] then colors[1] = 0 end
  colors[1] = colors[1]+pmod
  if colors[1] > 160 then colors[1] = 0 end
  if colors[1] < 0 then colors[1] = 160 end
  SetVehicleModKit(veh,0)
  ClearVehicleCustomPrimaryColour(veh)
  SetVehicleColours(veh, colors[1], colors[2])
end

function vRPg.scrollVehicleSecondaryColour(smod)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if not colors[2] then colors[2] = 0 end
  colors[2] = colors[2]+smod
  if colors[2] > 160 then colors[2] = 0 end
  if colors[2] < 0 then colors[2] = 160 end
  SetVehicleModKit(veh,0)
  ClearVehicleCustomSecondaryColour(veh)
  SetVehicleColours(veh, colors[1], colors[2])
end

function vRPg.setCustomPrimaryColour(r, g, b)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  SetVehicleCustomPrimaryColour(veh,r,g,b)
end

function vRPg.setCustomSecondaryColour(r, g, b)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  SetVehicleCustomSecondaryColour(veh,r,g,b)
end

function vRPg.scrollVehiclePearlescentColour(emod)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if not colors[3] then colors[3] = 0 end
  SetVehicleModKit(veh,0)
  colors[3] = colors[3]+emod
  if colors[3] > 160 then colors[3] = 0 end
  if colors[3] < 0 then colors[3] = 160 end
  SetVehicleExtraColours(veh, colors[3], colors[4])
end

function vRPg.scrollVehicleWheelColour(wmod)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if not colors[4] then colors[4] = 0 end
  SetVehicleModKit(veh,0)
  colors[4] = colors[4]+wmod
  if colors[4] > 160 then colors[4] = 0 end
  if colors[4] < 0 then colors[4] = 160 end
  SetVehicleExtraColours(veh, colors[3], colors[4])
end
  
function vRPg.scrollVehicleMods(mod,add)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  local num = GetNumVehicleMods(veh,mod)
  
  -- num for plate and windows
  if mod == 35 or mod == 26 then 
    num = GetNumberOfVehicleNumberPlates() 
  elseif mod == 46 then
    num = 6 
  end
  
  -- get modification
  SetVehicleModKit(veh,0)
  if not mods[mod] then mods[mod] = 0 end
  mods[mod] = mods[mod]+add
  
  -- check for toggles
  if mod > 17 and mod < 23 then
    -- check if exists
    if toggles[mod] == nil then toggles[mod] = false end
    toggles[mod] = not toggles[mod]
    ToggleVehicleMod(veh, mod, toggles[mod])
	if toggles[mod] then vRPg.notifyTimed(lang.garage.shop.client.toggle.applied,1500) else vRPg.notifyTimed(lang.garage.shop.client.toggle.removed,1500) end
	
  -- wheel type change	
  elseif (mod == 23 or mod == 24) and add == 0 then
    wheel = wheel+1
	-- normalization check for wheel
	if wheel > 7 then wheel = 0 end 
	SetVehicleWheelType(veh, wheel)
    SetVehicleMod(veh,mod,mods[mod],false)
	
  -- no modifications case	
  elseif num == 0 then vRPg.notifyTimed(lang.garage.shop.client.nomods,1500)
  
  -- normalization checks for mods[mod]
  elseif mods[mod] > num then
    mods[mod] = num
    vRPg.notifyTimed(lang.garage.shop.client.maximum,1500) 
  elseif mods[mod] < 0 then
    mods[mod] = 0
    vRPg.notifyTimed(lang.garage.shop.client.minimum,1500) 
	
  -- changing plate index
  elseif mod == 35 or mod == 26 then
    SetVehicleNumberPlateTextIndex(veh, mods[mod])
	
  -- window tint change
  elseif mod == 46 then
    SetVehicleWindowTint(veh,mods[mod])
	
  -- default mod change
  else
    SetVehicleMod(veh,mod,mods[mod],false)
	
	-- if armor > level 3 then tires cant burst
    if mod == 16 and mods[mod] > 3 then
      SetVehicleTyresCanBurst(veh, true)
    elseif mod == 16 then
      SetVehicleTyresCanBurst(veh, false)
    end
  end
end

function vRPg.getVehicleMods(vtype)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  local vehicle = vehicles[vtype]
  local vname = false
  if vehicle then vname = vehicle[2] end
  if veh then
    local custom = {}
	if DoesEntityExist(veh) then
	  local colours = table.pack(GetVehicleColours(veh))
	  local extra_colors = table.pack(GetVehicleExtraColours(veh))
      
	  custom.plate = {}
	  custom.plate.text = GetVehicleNumberPlateText(veh) -- Licence ID
	  custom.plate.index = GetVehicleNumberPlateTextIndex(veh) --
	  
	  custom.colour = {}
	  custom.colour.primary = colours[1] -- 1rst colour
	  custom.colour.secondary = colours[2] -- 2nd colour
	  custom.colour.pearlescent = extra_colors[1] -- colour type
	  custom.colour.wheel = extra_colors[2] -- wheel colour
	  
	  colors[1] = custom.colour.primary
	  colors[2] = custom.colour.secondary
	  colors[3] = custom.colour.pearlescent
	  colors[4] = custom.colour.wheel
	  
	  custom.colour.neon = table.pack(GetVehicleNeonLightsColour(veh))
	  custom.colour.smoke = table.pack(GetVehicleTyreSmokeColor(veh))
	  
	  custom.colour.custom = {}
	  custom.colour.custom.primary = table.pack(GetVehicleCustomPrimaryColour(veh))
	  custom.colour.custom.secondary = table.pack(GetVehicleCustomSecondaryColour(veh))
	  
	  custom.mods = {}
	  for i=0,49 do
	    custom.mods[i] = GetVehicleMod(veh, i)
	  end
	  
	  custom.mods[46] = GetVehicleWindowTint(veh) -- Tinted Windows
	  custom.mods[18] = IsToggleModOn(veh,18)
	  custom.mods[20] = IsToggleModOn(veh,20)
	  custom.mods[22] = IsToggleModOn(veh,22)
	  
	  mods = custom.mods
	  
	  toggles[18] = custom.mods[18]
	  toggles[20] = custom.mods[20]
	  toggles[22] = custom.mods[22]
	  
	  custom.neon = {}
	  custom.neon.left = IsVehicleNeonLightEnabled(veh,0)
	  custom.neon.right = IsVehicleNeonLightEnabled(veh,1)
	  custom.neon.front = IsVehicleNeonLightEnabled(veh,2)
	  custom.neon.back = IsVehicleNeonLightEnabled(veh,3)
	  
	  custom.bulletproof = GetVehicleTyresCanBurst(veh)
	  custom.variation = GetVehicleModVariation(veh,23) 
	  custom.wheel = GetVehicleWheelType(veh) -- Wheel Type
	  wheel = custom.wheel
	  return vname, custom
	end
  end
  return false, false
end

function vRPg.setVehicleMods(custom)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if custom and veh then
    SetVehicleModKit(veh,0)
    if custom.colour then
      SetVehicleColours(veh, tonumber(custom.colour.primary), tonumber(custom.colour.secondary))
      SetVehicleExtraColours(veh, tonumber(custom.colour.pearlescent), tonumber(custom.colour.wheel))
  	  if custom.colour.neon then
        SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
  	  end
  	  if custom.colour.smoke then
        SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
  	  end
  	  if custom.colour.custom then
  	    if custom.colour.custom.primary then
  	      SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
  	    end
  	    if custom.colour.custom.secondary then
  	      SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
  	    end
  	  end
	end
    
    if custom.plate then
      SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
    end
	
    SetVehicleWindowTint(veh,tonumber(custom.mods[46]))
    SetVehicleTyresCanBurst(veh, tonumber(custom.bulletproof))
    SetVehicleWheelType(veh, tonumber(custom.wheel))
	
    ToggleVehicleMod(veh, 18, tonumber(custom.mods[18]))
    ToggleVehicleMod(veh, 20, tonumber(custom.mods[20]))
    ToggleVehicleMod(veh, 22, tonumber(custom.mods[22]))
    
    if custom.neon then
      SetVehicleNeonLightEnabled(veh,0, tonumber(custom.neon.left))
      SetVehicleNeonLightEnabled(veh,1, tonumber(custom.neon.right))
      SetVehicleNeonLightEnabled(veh,2, tonumber(custom.neon.front))
      SetVehicleNeonLightEnabled(veh,3, tonumber(custom.neon.back))
    end
	
    for i,mod in pairs(custom.mods) do 
	  if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
        SetVehicleMod(veh, tonumber(i), tonumber(mod))
	  end
    end
	
  end
end

function vRPg.spawnGarageVehicle(vtype,name,pos) -- vtype is the vehicle type (one vehicle per type allowed at the same time)
  local vehicle = vehicles[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
    vehicles[vtype] = nil
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition()
      if pos then
        x,y,z = table.unpack(pos)
      end

	  if vRPg.clearAreaOfVehicles(3) then
        local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false)
        SetVehicleOnGroundProperly(nveh)
        SetEntityInvincible(nveh,false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
        SetVehicleNumberPlateText(nveh, vRP.getRegistrationNumber())
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        
        vehicles[vtype] = {vtype,name,nveh} -- set current vehicule
        
        SetModelAsNoLongerNeeded(mhash)
	    if IsEntityAVehicle(nveh) then
	      Gserver.resetCooldown()
	    end
	    return true
	  end
    end
  end
  return false
end

function vRPg.clearAreaOfVehicles(radius)
  local closeby = vRP.getNearestVehicle(radius)
  if IsEntityAVehicle(closeby) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(closeby,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, closeby, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(closeby))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(closeby))
	return vRPg.clearAreaOfVehicles(radius)
  end
  return true
end

function vRPg.spawnShowroomVehicle(name,pos)
  if showroom then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(showroom,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, showroom, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(showroom))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(showroom))
    showroom = nil
  end
  
  if showroom == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)
    
    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end
    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition()
      if pos then
        x,y,z = table.unpack(pos)
      end
	  
	  if vRPg.clearAreaOfVehicles(3) then
        local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false)
        SetVehicleOnGroundProperly(nveh)
        SetEntityInvincible(nveh,false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
        SetVehicleNumberPlateText(nveh, vRP.getRegistrationNumber())
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
         
        showroom = nveh -- set current vehicule
        
        SetModelAsNoLongerNeeded(mhash)
	    if IsEntityAVehicle(nveh) then
	      Gserver.resetCooldown()
	    end
	    return true
	  end
    end
  end
  return false
end

function vRPg.despawnGarageVehicle(vtype,max_range)
  local vehicle = vehicles[vtype]
  if vehicle then
    local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
    local px,py,pz = vRP.getPosition()

    if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- check distance with the vehicule
      -- remove vehicle
      SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
      Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
      vehicles[vtype] = nil
	  return true
    else
	  return false
    end
  end
end

function vRPg.despawnShowroomVehicle()
  if showroom then
    -- remove vehicle
    SetVehicleHasBeenOwnedByPlayer(showroom,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, showroom, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(showroom))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(showroom))
	showroom = nil
  end
end

-- return ok,vtype,name
function vRPg.getNearestOwnedVehicle(radius)
  local px,py,pz = vRP.getPosition()
  for k,v in pairs(vehicles) do
    local x,y,z = table.unpack(GetEntityCoords(v[3],true))
    local dist = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
    if dist <= radius+0.0001 then return true,v[1],v[2] end
  end

  return false,"",""
end

function vRPg.isOwnedVehicleOut(vname)
  for vtype,vehicle in pairs(vehicles) do
    if vehicle[2] == vname then 
	  return vtype, vehicle 
	end
  end
  return false, false
end

-- vehicle commands
function vRPg.vc_openDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorOpen(vehicle[3],door_index,0,false)
  end
end

function vRPg.vc_closeDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorShut(vehicle[3],door_index)
  end
end

function vRPg.vc_detachTrailer(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    DetachVehicleFromTrailer(vehicle[3])
  end
end

function vRPg.vc_detachTowTruck(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetEntityAttachedToTowTruck(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromTowTruck(vehicle[3],ent)
    end
  end
end

function vRPg.vc_detachCargobob(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetVehicleAttachedToCargobob(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromCargobob(vehicle[3],ent)
    end
  end
end

function vRPg.vc_toggleEngine(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle[3]) -- GetIsVehicleEngineRunning
    SetVehicleEngineOn(vehicle[3],not running,true,true)
    if running then
      SetVehicleUndriveable(vehicle[3],true)
    else
      SetVehicleUndriveable(vehicle[3],false)
    end
  end
end

function vRPg.vc_toggleLock(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local veh = vehicle[3]
    local locked = GetVehicleDoorLockStatus(veh) >= 2
    if locked then -- unlock
      SetVehicleDoorsLockedForAllPlayers(veh, false)
      SetVehicleDoorsLocked(veh,1)
      SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
      vRP.notify(lang.garage.personal.client.unlocked)
    else -- lock
      SetVehicleDoorsLocked(veh,2)
      SetVehicleDoorsLockedForAllPlayers(veh, true)
      vRP.notify(lang.garage.personal.client.locked)
    end
  end
end