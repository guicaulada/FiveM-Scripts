Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
				if not HasStreamedTextureDictLoaded("speedometer") then
					RequestStreamedTextureDict("speedometer", true) -- unload it
					while not HasStreamedTextureDictLoaded("speedometer") do
						Wait(0)
					end
				else
					-- everything is ok
					local degree = 0
					local step = 2.05833
					if GetEntitySpeed(vehicle) > 0 then degree=(GetEntitySpeed(vehicle)*2.236936)*step end
					DrawSprite("speedometer", "speedom_003", 0.898,0.752,0.16,0.245, 0.0, 255, 255, 255, 255)
					if degree > 247 then degree=247 end
					DrawSprite("speedometer", "needle_003", 0.898,0.755,0.116,0.15,43.00001+degree, 255, 255, 255, 200)
					if IsControlPressed(1, 216) then DrawSprite("speedometer", "brakeson_001", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 255)
					else DrawSprite("speedometer", "brakeson_002", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 255) end
				end
			end
		end
	end
end)


-- explanations.
--[[
what does 'local step' means?
I detect the minimum needle angle (is 43.0 and maximum - is 290.0).
Difference between min and max angles is 247.0. Then i divide this difference by zero, no wait, divide this
by 120 (how much gradation units we have on our speedometer) and i got local step. It is 2.05833 as you can see.
Then i found on nativeDB how to detect entity speed in MPH.
Thanks for reading this barbarian-english comments.
]]