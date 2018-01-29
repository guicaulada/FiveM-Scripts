local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_chairs", "cfg/chairs")
vRPch = {}
Tunnel.bindInterface("vrp_chairs",vRPch)
CHserver = Tunnel.getInterface("vrp_chairs")
vRP = Proxy.getInterface("vRP")

local sitting = false
local lastPos = nil
local currentSitObj = nil
local closest = {}

function headsUp(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if closest then
		  local ped = GetPlayerPed(-1)
		  local distance = closest.distance
		  local object = closest.object
          
		  if not sitting and DoesEntityExist(object) then
		  	headsUp(cfg.enter)
		  	local x,y,z = table.unpack(GetEntityCoords(object))
		  	DrawMarker(0, x, y, z+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
		  	if IsControlJustPressed(0, 38) then
		  		sit(object)
		  	end
		  end
		  if sitting then
		  	headsUp(cfg.leave)
		  	if IsControlJustPressed(0, 23) then
		  		ClearPedTasks(ped)
		  		sitting = false
				local x,y,z = table.unpack(lastPos)
				if GetDistanceBetweenCoords(x, y, z,GetEntityCoords(ped)) < 10 then
					SetEntityCoords(ped, lastPos)
				end
		  		FreezeEntityPosition(ped, false)
		  		FreezeEntityPosition(currentSitObj, false)
		  		CHserver.unoccupyObj(currentSitObj)
		  		currentSitObj = nil
		  	end
		  end
		end
	end
end)

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	local ped = GetPlayerPed(-1)
	local list = {}
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(cfg.chairs) do
	  local obj = GetClosestObjectOfType(x, y, z, cfg.distance, GetHashKey(v.prop), false, true ,true)
	  local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
	  table.insert(list, {object = obj, distance = dist})
	end

	closest = list[1]
	for k,v in pairs(list) do
		if v.distance < closest.distance then
			closest = v
		end
	end
  end
end)

function sit(object)
	local isOccupied = nil
	local ped = GetPlayerPed(-1)
	local occupied = CHserver.getOccupied()
	isOccupied = false
	for k,v in pairs(occupied) do
		if v == object then
			isOccupied = true
		end
	end
	while isOccupied == nil do
		Wait(0)
	end
	if not isOccupied then
		lastPos = GetEntityCoords(ped)
		currentSitObj = object
		CHserver.occupyObj(object)
		FreezeEntityPosition(object, true)
		local objinfo = {}
		for k,v in pairs(cfg.chairs) do
			if tostring(GetHashKey(v.prop)) == tostring(GetEntityModel(object)) then
				objinfo = v
			end
		end
		sitting = true
		local objloc = GetEntityCoords(object)
		if cfg.debug then
		  vRP.notify(objinfo.prop)
		  print(objinfo.prop)
		end
		TaskStartScenarioAtPosition(ped, objinfo.task, objloc.x+objinfo.x, objloc.y+objinfo.y, objloc.z+objinfo.z, GetEntityHeading(object)+objinfo.h, 0, true, true)
	end
end
