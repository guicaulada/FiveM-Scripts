Citizen.CreateThread(function()
	local handsup = false
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("random@mugging3")
		if IsControlPressed(1, 323) then
			if DoesEntityExist(lPed) and not IsPedSittingInAnyVehicle(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if not handsup then
						handsup = true
						TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					end   
				end)
			end
		end

		if IsControlReleased(1, 323) then
			if DoesEntityExist(lPed) and not IsPedSittingInAnyVehicle(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if handsup then
						handsup = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)