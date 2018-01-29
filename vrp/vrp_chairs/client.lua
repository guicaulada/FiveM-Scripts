CHserver = Tunnel.getInterface("vrp_chairs","vrp_chairs")

local sitting = false
local lastPos = nil
local currentSitObj = nil

function headsUp(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	local objects = {}
	for k,v in pairs(cfg.chairs) do
		table.insert(objects, v.prop)
	end
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)
		local list = {}
		for k,v in pairs(objects) do
			local obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 3.0, GetHashKey(v), false, true ,true)
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
			table.insert(list, {object = obj, distance = dist})
		end

		local closest = list[1]
		for k,v in pairs(list) do
			if v.distance < closest.distance then
				closest = v
			end
		end

		local distance = closest.distance
		local object = closest.object

		if distance < cfg.distance and not sitting and DoesEntityExist(object) then
			headsUp('You are close to an object on which you can sit! Press ~INPUT_CONTEXT~ to sit!')
			DrawMarker(0, GetEntityCoords(object).x, GetEntityCoords(object).y, GetEntityCoords(object).z+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			if IsControlJustPressed(0, 38) then
				sit(object)
			end
		end
		if sitting then
			headsUp('Press ~INPUT_ENTER~ to get up.')
			if IsControlJustPressed(0, 23) then
				ClearPedTasks(ped)
				sitting = false
				local x,y,z = table.unpack(lastPos)
				if GetDistanceBetweenCoords(x, y, z,GetEntityCoords(ped)) < 10 then
					SetEntityCoords(ped, lastPos)
				end
				FreezeEntityPosition(ped, false)
				FreezeEntityPosition(currentSitObj, false)
				CHserver.unoccupyObj({currentSitObj})
				currentSitObj = nil
			end
		end
	end
end)



function sit(object)
	local isOccupied = nil
	local ped = GetPlayerPed(-1)
	CHserver.getOccupied({}, function(occupied)
		isOccupied = false
		for k,v in pairs(occupied) do
			if v == object then
				isOccupied = true
			end
		end
	end)
	while isOccupied == nil do
		Wait(0)
	end
	if not isOccupied then
		lastPos = GetEntityCoords(ped)
		currentSitObj = object
		CHserver.occupyObj({object})
		FreezeEntityPosition(object, true)
		local objinfo = {}
		for k,v in pairs(cfg.chairs) do
			if tostring(GetHashKey(v.prop)) == tostring(GetEntityModel(object)) then
				objinfo = v
			end
		end
		local objloc = GetEntityCoords(object)
		SetEntityCoords(ped, objloc.x, objloc.y, objloc.z+objinfo.verticalOffset)
		SetEntityHeading(ped, GetEntityHeading(object)+objinfo.angularOffset)
		FreezeEntityPosition(ped, true)
		sitting = true
		TaskStartScenarioAtPosition(ped, objinfo.scenario, objloc.x, objloc.y, objloc.z-objinfo.verticalOffset, GetEntityHeading(object)+180.0, 0, true, true)
	end
end
