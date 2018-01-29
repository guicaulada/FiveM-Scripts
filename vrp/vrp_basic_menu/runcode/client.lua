--[[
	Example Commands
	/crun SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(GetPlayerPed(-1)), 255, 70, 0)
	/crun SetVehicleFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	/crun GetEntityCoords(GetPlayerPed(-1))
]]

local function RunStringLocally_Handler(stringToRun)
	if(stringToRun) then
		local resultsString = ""
		-- Try and see if it works with a return added to the string
		local stringFunction, errorMessage = load("return "..stringToRun)
		if(errorMessage) then
			-- If it failed, try to execute it as-is
			stringFunction, errorMessage = load(stringToRun)
		end
		if(errorMessage) then
			-- Shit tier code entered, return the error to the player
			TriggerEvent("chatMessage", "[SS-RunCode]", {187, 0, 0}, "CRun Error: "..tostring(errorMessage))
			return false
		end
		-- Try and execute the function
		local results = {pcall(stringFunction)}
		if(not results[1]) then
			-- Error, return it to the player
			TriggerEvent("chatMessage", "[SS-RunCode]", {187, 0, 0}, "CRun Error: "..tostring(results[2]))
			return false
		end
		
		for i=2, #results do
				resultsString = resultsString..", "
			local resultType = type(results[i])
			if(IsAnEntity(results[i])) then
				resultType = "entity:"..tostring(GetEntityType(results[i]))
			end
			resultsString = resultsString..tostring(results[i]).." ["..resultType.."]"
		end
		if(#results > 1) then
			TriggerEvent("chatMessage", "[SS-RunCode]", {187, 0, 0}, "CRun Command Result: "..tostring(resultsString))
			return true
		end
	end
end
RegisterNetEvent("RunCode:RunStringLocally")
AddEventHandler("RunCode:RunStringLocally", RunStringLocally_Handler)