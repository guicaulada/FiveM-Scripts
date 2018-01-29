local playerColor = {0,0,0}

RegisterNetEvent('setPlayerColor')
AddEventHandler('setPlayerColor', function(r, g, b)
	playerColor = {r,g,b}
end)

RegisterNetEvent('sendGlobalMessage')
AddEventHandler('sendGlobalMessage', function(id, name, message)
	TriggerEvent('chatMessage', "[G]"..name, {255, 0, 0}, message)
end)

RegisterNetEvent('sendOOCMessage')
AddEventHandler('sendOOCMessage', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "[OOC]"..name, {128, 128, 128}, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "[OOC]"..name, {128, 128, 128}, message)
	end
end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', name, playerColor, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', name, playerColor, message)
	end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6" .. name .."  ".."  " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6" .. name .."  ".."  " .. message)
	end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^4*" .. name .."  ".."  " .. message .. "*")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^4*" .. name .."  ".."  " .. message .. "*")
	end
end)