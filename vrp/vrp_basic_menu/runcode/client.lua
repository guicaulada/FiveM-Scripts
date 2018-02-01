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