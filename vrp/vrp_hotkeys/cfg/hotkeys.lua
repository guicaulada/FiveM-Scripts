-- TUNNEL AND PROXY
cfg = {}
vRPhk = {}
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
vRPserver = Tunnel.getInterface("vRP","vrp_hotkeys")
HKserver = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
vRP = Proxy.getInterface("vRP")

-- GLOBAL VARIABLES
handsup = false
crouched = false
pointing = false
engine = true
called = 0

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {
  [170] = {
    -- F3 toggle Cuff nearest player
    group = 1, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then -- Comment to allow use in vehicle
	    HKserver.toggleHandcuff()
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [73] = {
    -- X toggle HandsUp
    group = 1, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then -- Comment to allow use in vehicle
	    handsup = not handsup
	    SetEnableHandcuffs(GetPlayerPed(-1), handsup)
	    if handsup then
	      vRP.playAnim({true,{{"random@mugging3", "handsup_standing_base", 1}},true})
	    else
	      vRP.stopAnim({true})
		  SetPedStealthMovement(GetPlayerPed(-1),false,"") 
	    end
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [29] = {
    -- B toggle Point
    group = 0, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then  -- Comment to allow use in vehicle
		RequestAnimDict("anim@mp_point")
		while not HasAnimDictLoaded("anim@mp_point") do
          Wait(0)
		end
        pointing = not pointing 
		if pointing then 
		  SetPedCurrentWeaponVisible(GetPlayerPed(-1), 0, 1, 1, 1)
		  SetPedConfigFlag(GetPlayerPed(-1), 36, 1)
		  Citizen.InvokeNative(0x2D537BA194896636, GetPlayerPed(-1), "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
		  RemoveAnimDict("anim@mp_point")
        else
		  Citizen.InvokeNative(0xD01015C7316AE176, GetPlayerPed(-1), "Stop")
		  if not IsPedInjured(GetPlayerPed(-1)) then
		    ClearPedSecondaryTask(GetPlayerPed(-1))
		  end
		  if not IsPedInAnyVehicle(GetPlayerPed(-1), 1) then
		    SetPedCurrentWeaponVisible(GetPlayerPed(-1), 1, 1, 1, 1)
		  end
		  SetPedConfigFlag(GetPlayerPed(-1), 36, 0)
		  ClearPedSecondaryTask(PlayerPedId())
        end 
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [36] = {
    -- CTRL toggle Crouch
    group = 0, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then  -- Comment to allow use in vehicle
        RequestAnimSet("move_ped_crouched")
		while not HasAnimSetLoaded("move_ped_crouched") do 
          Citizen.Wait(0)
        end 
        crouched = not crouched 
		if crouched then 
          ResetPedMovementClipset(GetPlayerPed(-1), 0)
        else
          SetPedMovementClipset(GetPlayerPed(-1), "move_ped_crouched", 0.25)
        end 
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [46] = {
    -- E call/skip emergency
    group = 0, 
	pressed = function() 
	  if vRP.isInComa({}) then
	    if called == 0 then 
	      HKserver.canSkipComa({"coma.skipper","coma.caller"},function(skipper,caller) -- permission to skip when no Doc is online, or just call them when they are. Change them on client.lua too if you do
		    if skipper or caller then
		      HKserver.docsOnline({},function(docs)
		        if docs == 0 and skipper then
				  vRP.killComa({})
			    else
				  called = 30
				  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				  HKserver.helpComa({x,y,z})
				  Citizen.Wait(1000)
			    end
			  end)
            end
		  end)
		else
		  vRP.notify({"~r~You already called the ambulance."})
		end
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [213] = {
    -- HOME toggle User List
    group = 0, 
	pressed = function() 
	  HKserver.openUserList({})
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [311] = {
    -- K toggle Vehicle Engine
    group = 1, 
	pressed = function() 
      if not IsPauseMenuActive() and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		engine = not engine
		SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), engine, false, false)
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [71] = {
    -- W starts Vehicle Engine
    group = 1, 
	pressed = function() 
      if not IsPauseMenuActive() and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		engine = true
		SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), engine, false, false)
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [182] = {
    -- L toggle Vehicle Lock
    group = 1, 
	pressed = function() 
	  player = GetPlayerPed(-1)
	  vehicle = GetVehiclePedIsIn(player, false)
	  isPlayerInside = IsPedInAnyVehicle(player, true)
	  lastVehicle = GetPlayersLastVehicle()
	  px, py, pz = table.unpack(GetEntityCoords(player, true))
	  coordA = GetEntityCoords(player, true)

	  for i = 1, 32 do
		coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, (6.281)/i, 0.0)
		local rayHandle = CastRayPointToPoint(coordA.x, coordA.y, coordA.z, coordB.x, coordB.y, coordB.z, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, rayVehicle = GetRaycastResult(rayHandle)
		targetVehicle = rayVehicle
		if targetVehicle ~= nil and targetVehicle ~= 0 then
		  vx, vy, vz = table.unpack(GetEntityCoords(targetVehicle, false))
		  if GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false) then
			distance = GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false)
			break
		  end
		end
	  end

	  if distance ~= nil and distance <= 5 and targetVehicle ~= 0 or vehicle ~= 0 then
		if vehicle ~= 0 then
		  plate = GetVehicleNumberPlateText(vehicle)
		else
		  vehicle = targetVehicle
		  plate = GetVehicleNumberPlateText(vehicle)
		end
	    HKserver.canUserLockVehicle({plate, vehicle, isPlayerInside})
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
}