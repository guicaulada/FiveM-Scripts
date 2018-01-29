-- godmode task
gods = {}
function task_god()
  SetTimeout(10000, task_god)

  for k,v in pairs(gods) do
    vRP.setHunger(v, 0)
    vRP.setThirst(v, 0)

    local player = vRP.getUserSource(v)
    if player ~= nil then
      vRPclient.setHealth(player, 200)
    end
  end
end

Citizen.CreateThread(function()
  task_god()
end)

function vRPbm.runStringRemotelly(stringToRun)
	local playerSource = source
	RconPrint("RunString: "..tostring(stringToRun))
	RconPrint("RunString Source: "..tostring(playerSource))
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
			TriggerClientEvent("chatMessage", playerSource, "[SS-RunCode]", {187, 0, 0}, "SRun Error: "..tostring(errorMessage))
			return false
		end
		-- Try and execute the function
		local results = {pcall(stringFunction)}
		if(not results[1]) then
			-- Error, return it to the player
			TriggerClientEvent("chatMessage", playerSource, "[SS-RunCode]", {187, 0, 0}, "SRun Error: "..tostring(results[2]))
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
			TriggerClientEvent("chatMessage", playerSource, "[SS-RunCode]", {187, 0, 0}, "SRun Command Result: "..tostring(resultsString))
			return true
		end
	end
end