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

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPdmv = {}
vRP = Proxy.getInterface("vRP")
DMVserver = Tunnel.getInterface("vrp_dmvschool")
Tunnel.bindInterface("vrp_dmvschool",vRPdmv)
Proxy.addInterface("vrp_dmvschool",vRPdmv)
cfg = module("vrp_dmvschool", "cfg/dmv")
lang = module("vrp_dmvschool", "cfg/lang/"..cfg.lang)

DTutOpen = false
license = false

tlock = true
plock = true

onTtest = false
onPtest = false

Error = 0
onTestEvent = 0
DamageControl = 0
CruiseControl = 0
SpeedArea = 1

start_pos = {}

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function LocalPed()
	return GetPlayerPed(-1)
end

function GetCar() 
	return GetVehiclePedIsIn(GetPlayerPed(-1),false) 
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function EndDTest()
    if Error > cfg.practical.max_errors then
		drawNotification(string.gsub(lang.client.failed,"{1}", Error))
		onPtest = false
		EndTestTasks()
	else
		DMVserver.setLicense()
		onPtest = false
		TestDone = true
		tlock = false
		plock = false
		drawNotification(string.gsub(lang.client.passed,"{1}", Error))	
		EndTestTasks()
	end
end

function EndTestTasks()
	onTestBlipp = nil
	onTestEvent = 0
	DamageControl = 0
	Error = 0
	TaskLeaveVehicle(GetPlayerPed(-1), veh, 0)
	Wait(1000)
	CarTargetForLock = GetPlayersLastVehicle(GetPlayerPed(-1))
	lockStatus = GetVehicleDoorLockStatus(CarTargetForLock)
	SetVehicleDoorsLocked(CarTargetForLock, 2)
	SetVehicleDoorsLockedForPlayer(CarTargetForLock, PlayerId(), false)
	SetEntityAsMissionEntity(CarTargetForLock, true, true)
	Wait(2000)
	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( CarTargetForLock ) )
end


function SpawnTestCar()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('blista')

    RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	colors = table.pack(GetVehicleColours(veh))
	extra_colors = table.pack(GetVehicleExtraColours(veh))
	plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, cfg.practical.spawn[1],cfg.practical.spawn[2],cfg.practical.spawn[3], true, false)
	SetVehicleColours(spawned_car,4,5)
	SetVehicleExtraColours(spawned_car,extra_colors[1],extra_colors[2])
	SetEntityHeading(spawned_car, 317.64)
	SetVehicleOnGroundProperly(spawned_car)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	CruiseControl = 0
	DTutOpen = false
	SetEntityVisible(myPed, true)
	SetVehicleDoorsLocked(GetCar(), 4)
	FreezeEntityPosition(myPed, false)
end

function DIntro()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
	for k,v in ipairs(cfg.intro) do
	  SetEntityCoords(myPed,v.pos[1],v.pos[2],v.pos[3],true, false, false,true)
	  TriggerEvent("pNotify:SendNotification",{
           text = v.msg,
           type = "alert",
           timeout = (15000),
           layout = "center",
           queue = "global"
       })				
	  Citizen.Wait(16500)
	end
	SetEntityCoords(myPed,start_pos.x, start_pos.y, start_pos.z,true, false, false,true)
	SetEntityVisible(myPed, true)
	FreezeEntityPosition(myPed, false)
	DTutOpen = false
end

function DTut()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
	SetEntityCoords(myPed,start_pos.x, start_pos.y, start_pos.z,true, false, false,true)
	SetEntityHeading(myPed, 314.39)
	for k,v in ipairs(cfg.practical.intro) do
	  TriggerEvent("pNotify:SendNotification",{
           text = v,
           type = "alert",
           timeout = (15000),
           layout = "center",
           queue = "global"
       })
	  Citizen.Wait(16500)
	end
	SpawnTestCar()
	DTutOpen = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local ped = GetPlayerPed(-1)
		if HasEntityCollidedWithAnything(veh) and DamageControl == 1 then
		TriggerEvent("pNotify:SendNotification",{
            text = lang.client.pnotify.damaged,
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })			
			Citizen.Wait(1000)
			Error = Error + 1	
		elseif(IsControlJustReleased(1, 23)) and DamageControl == 1 then
			drawNotification(lang.client.control.cant_leave)
    	end
		
		for step,event in ipairs(cfg.practical.steps) do
		  if onTestEvent == step then
		    if onTestEvent ~= #cfg.practical.steps then
		      local nstep = cfg.practical.steps[step+1]
			  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), event.pos[1], event.pos[2], event.pos[3], true) > 4.0001 then
			  	DrawMarker(1,event.pos[1], event.pos[2], event.pos[3],0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
			  else
			  	if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
			  		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
			  	end
			  	onTestBlipp = AddBlipForCoord(nstep.pos[1],nstep.pos[2],nstep.pos[3])
			  	N_0x80ead8e2e1d5d52e(onTestBlipp)
			  	SetBlipRoute(onTestBlipp, 1)
			  	if event.stop then
			  	  DrawMissionText2(event.stop, 5000)
			  	  PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			  	  FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			  	  Citizen.Wait(4000)
			  	  FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			  	end
			  	if event.area then
			  	  SpeedArea = event.area
			  	  PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			  	  drawNotification(string.gsub(string.gsub(string.gsub(string.gsub(lang.client.pnotify.area,"{1}",cfg.speed.area[SpeedArea].name),"{2}",cfg.speed.area[SpeedArea].limit),"{3}",Error),"{4}",cfg.practical.max_errors))
			  	end
			  	if event.msg then
			  	  DrawMissionText2(event.msg, 5000)
			  	end
			  	onTestEvent = step+1
			  end
		    else
			  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),event.pos[1], event.pos[2], event.pos[3], true) > 4.0001 then
			  	DrawMarker(1,event.pos[1], event.pos[2], event.pos[3],0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
			  else
			  	if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
			  		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
			  	end
			  	EndDTest()
			  end
			end
		  end
		end		
	end
end)

----Theory Test NUI Operator
-- ***************** Open Gui and Focus NUI
function openGui()
  onTtest = true
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if onTtest then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  cb('ok')
  DrawMissionText2(lang.client.proceed, 2000)	
  tlock = true
  plock = false
  onTtest = false
end)

RegisterNUICallback('kick', function(data, cb)
  closeGui()
  for k,v in pairs(data) do
    print(v)
  end
  cb('ok')
  DrawMissionText2(lang.client.try_again, 2000)	
  onTtest = false
  tlock = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and not TestDone and not onPtest and cfg.dmv.warn then
		DrawMissionText2(lang.client.no_license, 2000)			
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		CarSpeed = GetEntitySpeed(GetCar()) *  cfg.speed.mult
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and CarSpeed >= cfg.speed.area[SpeedArea].limit and onPtest then
		TriggerEvent("pNotify:SendNotification",{
            text = string.gsub(lang.client.pnotify.speeding,"{1}", cfg.speed.area[SpeedArea].limit),
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1	
			Citizen.Wait(10000)
		end
	end
end)


local speedLimit = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )   
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleModel = GetEntityModel(vehicle)
        local speed = GetEntitySpeed(vehicle)
        local inVehicle = IsPedSittingInAnyVehicle(ped)
        if ( ped and inVehicle and DamageControl == 1 ) then
            if IsControlJustPressed(1, cfg.speed.control.toggle) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if CruiseControl == 0 then
                        speedLimit = speed
                        SetEntityMaxSpeed(vehicle, speedLimit)
						drawNotification(string.gsub(lang.client.control.enabled,"{1}", math.floor(speedLimit*cfg.speed.mult)))
						Citizen.Wait(1000)
				        DisplayHelpText(lang.client.control.help)
						PlaySound(-1, "COLLECTED", "HUD_AWARDS", 0, 0, 1)
                        CruiseControl = 1
                    else
                        SetEntityMaxSpeed(vehicle, GetVehicleMaxSpeed(vehicleModel))
						drawNotification(lang.client.control.disabled)			
                        CruiseControl = 0
                    end
                else
				    drawNotification(lang.client.control.not_driving)						
                end
			end
            if IsControlJustPressed(1, cfg.speed.control.up) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit + 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					DisplayHelpText(string.gsub(lang.client.control.speed,"{1}", math.floor(speedLimit*cfg.speed.mult)))
                end
			end
            if IsControlJustPressed(1, cfg.speed.control.down) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit - 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
					DisplayHelpText(string.gsub(lang.client.control.speed,"{1}", math.floor(speedLimit*cfg.speed.mult)))
                end
            end
        end
    end
end)

----Theory Test NUI Operator

-- ***************** Open Gui and Focus NUI
function openGui()
  onTtest = true
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if onTtest then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    if DTutOpen then
      local ply = GetPlayerPed(-1)
      local active = true
	  SetEntityVisible(ply, false)
	  FreezeEntityPosition(ply, true)
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  for k,v in pairs(data) do
    print(v)
  end
  cb('ok')
  DrawMissionText2(lang.client.proceed, 2000)	
  tlock = true
  plock = false
  onTtest = false
end)

RegisterNUICallback('kick', function(data, cb)
    closeGui()
    for k,v in pairs(data) do
      print(v)
    end
    cb('ok')
    DrawMissionText2(lang.client.try_again, 2000)	
    onTtest = false
end)

---------------------------------- DMV PED ----------------------------------

Citizen.CreateThread(function()

  RequestModel(GetHashKey("a_m_y_business_01"))
  while not HasModelLoaded(GetHashKey("a_m_y_business_01")) do
    Wait(1)
  end

  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end

 	    -- Spawn the DMV Ped
  for _, item in pairs(cfg.dmv.peds) do
    dmvmainped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.h, false, true)
    SetEntityHeading(dmvmainped, item.h)
    FreezeEntityPosition(dmvmainped, true)
	SetEntityInvincible(dmvmainped, true)
	SetBlockingOfNonTemporaryEvents(dmvmainped, true)
    TaskPlayAnim(dmvmainped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

local talktodmvped = true
--DMV Ped interaction
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in pairs(cfg.dmv.peds) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0)then
				DisplayHelpText(lang.client.interact)
				if(IsControlJustReleased(1, 38))then
						if talktodmvped then
						    Notify(lang.client.welcome)
						    Citizen.Wait(500)
							DMVMenu()
							Menu.hidden = false
							talktodmvped = false
						else
							talktodmvped = true
						end
				end
				Menu.renderGUI(cfg.dmv.menu)
			end
		end
	end
end)

------------
------------ DRAW MENUS
------------
function DMVMenu()
	ClearMenu()
	Menu.addButton(lang.client.menu.obtain,"VehLicenseMenu",nil)
    Menu.addButton(lang.client.menu.mclose,"CloseMenu",nil) 
end

function VehLicenseMenu()
    ClearMenu()
	Menu.addButton(lang.client.menu.intro,"startIntro",nil)
	Menu.addButton(lang.client.menu.theory,"payTheory",nil)
	Menu.addButton(lang.client.menu.practical,"payPractical",nil)
    Menu.addButton(lang.client.menu.mreturn,"DMVMenu",nil) 
end

function CloseMenu()
		Menu.hidden = true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

----------------
----------------blip
----------------



Citizen.CreateThread(function()
  for k,v in pairs(cfg.dmv.peds) do
	local blip = AddBlipForCoord(v.x,v.y,v.z)
	SetBlipSprite(blip,cfg.dmv.blip.id)
	SetBlipColour(blip,cfg.dmv.blip.colour)
	SetBlipScale(blip,cfg.dmv.blip.size)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(cfg.dmv.blip.title)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
  end
end)