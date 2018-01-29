-- MAIN THREAD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs(cfg.hotkeys) do
		  if IsControlJustPressed(v.group, k) or IsDisabledControlJustPressed(v.group, k) then
		    v.pressed()
		  end

		  if IsControlJustReleased(v.group, k) or IsDisabledControlJustReleased(v.group, k) then
		    v.released()
		  end
		end
	end
end)

-- OTHER THREADS
-- THIS IS FOR CROUCH
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    if DoesEntityExist(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1)) then 
      DisableControlAction(0,36,true) -- INPUT_DUCK   
    end 
  end
end)

-- THIS IS FOR HANDSUP
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if handsup then
      SetPedStealthMovement(GetPlayerPed(-1),true,"")
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,71,true) -- veh forward
      DisableControlAction(0,72,true) -- veh backwards
      DisableControlAction(0,63,true) -- veh turn left
      DisableControlAction(0,64,true) -- veh turn right
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      --DisableControlAction(0,75,true) -- disable exit vehicle
      --DisableControlAction(27,75,true) -- disable exit vehicle
    end
  end
end)

-- THIS IS FOR POINTING
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if pointing then
      local camPitch = GetGameplayCamRelativePitch()
      if camPitch < -70.0 then
          camPitch = -70.0
      elseif camPitch > 42.0 then
          camPitch = 42.0
      end
      camPitch = (camPitch + 70.0) / 112.0

      local camHeading = GetGameplayCamRelativeHeading()
      local cosCamHeading = Cos(camHeading)
      local sinCamHeading = Sin(camHeading)
      if camHeading < -180.0 then
          camHeading = -180.0
      elseif camHeading > 180.0 then
          camHeading = 180.0
      end
      camHeading = (camHeading + 180.0) / 360.0

      local blocked = 0
      local nn = 0

      local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
      local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, GetPlayerPed(-1), 7);
      nn,blocked,coords,coords = GetRaycastResult(ray)

      Citizen.InvokeNative(0xD5BB4025AE449A4E, GetPlayerPed(-1), "Pitch", camPitch)
      Citizen.InvokeNative(0xD5BB4025AE449A4E, GetPlayerPed(-1), "Heading", camHeading * -1.0 + 1.0)
      Citizen.InvokeNative(0xB0A6CFD2C69C1088, GetPlayerPed(-1), "isBlocked", blocked)
      Citizen.InvokeNative(0xB0A6CFD2C69C1088, GetPlayerPed(-1), "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    end
  end
end)

-- THIS IS FOR ENGINE-CONTROL
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
    if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
      local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
	  engine = IsVehicleEngineOn(veh)
	end
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) and not engine then
	  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	  local damage = GetVehicleBodyHealth(vehicle)
	  SetVehicleEngineOn(vehicle, engine, false, false)
	  if damage <= 0 then
		SetVehicleUndriveable(vehicle, true)
		vRP.notify({"~r~Vehicle is too damaged."})
	  end
	end
  end
end)

-- THIS IS FOR NO DOC COMA
Citizen.CreateThread(function() -- coma thread
  while true do
    Citizen.Wait(1000)
    if vRP.isInComa({}) then
	  if called == 0  then
	    HKserver.canSkipComa({"coma.skipper","coma.caller"},function(skipper, caller) -- change them on cfg too if you do
	      if skipper or caller then
		    HKserver.docsOnline({},function(docs)
		      if docs == 0 and skipper then
			    vRP.notify({"~r~There's nobody to revive you.\n~b~Press ~g~E~b~ to respawn."})
			  elseif docs > 0 and caller then
			    vRP.notify({"~g~There are doctors online.\n~b~Press ~g~E~b~ to call an ambulance."})
			  end
		    end)
          end
	    end)
	  else
	    called = called - 1
	  end
	else
	  called = 0
	end
  end
end)


-- OTHER FUNCTIONS
function vRPhk.lockVehicle(lockStatus, vehicle)
	if lockStatus == 1 or lockStatus == 0 then -- locked or unlocked

		if IsVehicleEngineOn(vehicle) and not isPlayerInside then
			SetVehicleUndriveable(vehicle, true)
		end

		SetVehicleDoorsLocked(vehicle, 2) 
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
		HKserver.lockSystemUpdate({2, plate})

		-- ## Notifications
		    local eCoords = GetEntityCoords(vehicle)
			HKserver.playSoundWithinDistanceOfCoordsForEveryone({eCoords.x, eCoords.y, eCoords.z, 10, "lock", 1.0})   		
			Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle, true, true) -- set as mission entity
			vRP.notifyPicture({"CHAR_LIFEINVADER", 3, "LockSystem", "vRP Hotkeys", "Vehicle locked."})
		-- ## Notifications

	elseif lockStatus == 2 then -- if it is locked

		if not IsVehicleEngineOn(vehicle) then
			Citizen.CreateThread(function()
				while true do
					Wait(0)
					if isPlayerInside then
						SetVehicleUndriveable(vehicle, false)
						break
					end
				end
			end)
		end

		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
		HKserver.lockSystemUpdate({1, plate})

		-- ## Notifications
		    local eCoords = GetEntityCoords(vehicle)
			HKserver.playSoundWithinDistanceOfCoordsForEveryone({eCoords.x, eCoords.y, eCoords.z, 10, "unlock", 1.0})
			vRP.notifyPicture({"CHAR_LIFEINVADER", 3, "LockSystem", "vRP Hotkeys", "Vehicle unlocked."})
		-- ## Notifications

	end
end

function vRPhk.playSoundWithinDistanceOfCoords(x, y, z, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, x, y, z)
	local Sreduc = 1.0 - (distIs/maxDistance)
	local reducedVolume = Sreduc*soundVolume
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = reducedVolume
        })
    end
end