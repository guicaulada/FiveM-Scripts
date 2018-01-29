function vRPbm.lockpickVehicle(wait,any)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
		if DoesEntityExist(vehicleHandle) then
		  if GetVehicleDoorsLockedForPlayer(vehicleHandle,PlayerId()) or any then
			local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)
			if(IsEntityAnObject(prevObj)) then
				SetEntityAsMissionEntity(prevObj)
				DeleteObject(prevObj)
			end
			StartVehicleAlarm(vehicleHandle)
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
			Citizen.Wait(wait*1000)
			SetVehicleDoorsLocked(vehicleHandle, 1)
			for i = 1,64 do 
				SetVehicleDoorsLockedForPlayer(vehicleHandle, GetPlayerFromServerId(i), false)
			end 
			ClearPedTasksImmediately(GetPlayerPed(-1))
			
			vRP.notify(lang.lockpick.success) -- lang.lockpick.success()
			
			-- ties to the hotkey lock system
			local plate = GetVehicleNumberPlateText(vehicleHandle)
			HKserver.lockSystemUpdate(1, plate)
			HKserver.playSoundWithinDistanceOfEntityForEveryone(vehicleHandle, 10, "unlock", 1.0)
		  else
			vRP.notify(lang.lockpick.unlocked) -- lang.lockpick.unlocked()
		  end
		else
			vRP.notify(lang.lockpick.toofar) -- lang.lockpick.toofar()
		end
end

