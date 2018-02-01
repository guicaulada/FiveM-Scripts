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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_moneydrop", "cfg/moneydrop")

MDserver = Tunnel.getInterface("vrp_moneydrop")

pedindex = {}
objval = {}

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for k,v in pairs(objval) do
			if DoesEntityExist(k) then
				if cfg.autoloot and IsControlPressed(0,cfg.autoloot_key) then -- E
					Citizen.CreateThread(function() RampTowardsPlayer(k) end)
					Wait(50)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
		PopulatePedIndex()
        ResetIndexOnDeath()
            
        for k,v in pairs(pedindex) do
            if DoesEntityExist(k) then
				veh = GetVehiclePedIsIn(k, false)
				if not IsPedInVehicle(k, veh, true) then
					if IsEntityDead(k) then
						SpawnMoneyWithRandomValue(k,cfg.basedrop.low,cfg.basedrop.high)
						pedindex[k] = nil
						if cfg.highlight.active then
							HighlightObject(k)
						end
					end
				end
            end
        end
            
        for k,v in pairs(objval) do
            if DoesEntityExist(k) then
                dist = DistanceBetweenCoords(PlayerPedId(-1), k)
                if (dist.x < 0.4) and (dist.y < 0.4) and (dist.z < 1) then
                    MDserver.updateUserMoney(v.worth)
                    DeleteObject(k)
					PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                    objval[k] = nil
                end
				if cfg.highlight.active then
					HighlightObject(k)
				end
            end
        end
    end
end)

function HighlightObject(object)
    x, y, z = table.unpack(GetEntityCoords(object, true))
    SetDrawOrigin(x, y, z, 0)
    RequestStreamedTextureDict("helicopterhud", false)
    DrawSprite("helicopterhud", "hud_corner", -0.01, -0.01, 0.006, 0.006, 0.0, cfg.highlight.r, cfg.highlight.g, cfg.highlight.b, cfg.highlight.a)
    DrawSprite("helicopterhud", "hud_corner", 0.01, -0.01, 0.006, 0.006, 90.0, cfg.highlight.r, cfg.highlight.g, cfg.highlight.b, cfg.highlight.a)
    DrawSprite("helicopterhud", "hud_corner", -0.01, 0.01, 0.006, 0.006, 270.0, cfg.highlight.r, cfg.highlight.g, cfg.highlight.b, cfg.highlight.a)
    DrawSprite("helicopterhud", "hud_corner", 0.01, 0.01, 0.006, 0.006, 180.0, cfg.highlight.r, cfg.highlight.g, cfg.highlight.b, cfg.highlight.a)
    ClearDrawOrigin()
end

function DistanceBetweenCoords(ent1, ent2)
    local x1,y1,z1 = table.unpack(GetEntityCoords(ent1, true))
    local x2,y2,z2 = table.unpack(GetEntityCoords(ent2, true))
    local deltax = x1 - x2
    local deltay = y1 - y2
    local deltaz = y1 - y2
    
    dist = math.sqrt((deltax * deltax) + (deltay * deltay) + (deltaz * deltaz))
    xout = math.abs(deltax)
    yout = math.abs(deltay)
    zout = math.abs(deltaz)
    result = {distance = dist, x = xout, y = yout, z = zout}
    
    return result
end
    
function ResetIndexOnDeath()
    if IsEntityDead(GetPlayerPed(-1)) then
        for k,v in pairs(objval) do
            objval[k] = nil
        end
    end
end

function PopulatePedIndex()
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat
		local player = false
        for i = 0, 32 do
            if (ped == GetPlayerPed(i)) then
                player = true
            end
        end
        if not IsEntityDead(ped) and not player then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)
end

function SpawnMoneyWithRandomValue(ped, lowlimit, upperlimit)
    value = math.random(lowlimit, upperlimit)
    money, quantity = MoneyVariance(value)
    
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	z = z + 1.3

    i = 0
    while i < quantity do
        

        x2 = math.random() + math.random(-2,2)
        y2 = math.random() + math.random(-2,2)
	    z2 = math.random() + math.random(6,9)
		
        i = i + 1
        
        tempobject = CreateObject(GetCashHash((RoundNumber((money / quantity), 0))), x, y, z, true, false, true)
		SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(tempobject, true)
		SetEntityDynamic(tempobject, true)
        ApplyForceToEntity(tempobject, 1, x2, y2, z2, 0.0, 3.0, 0.0, 0, 0, 1, 1, 0, 1)
        objval[tempobject] = { worth = (RoundNumber((money / quantity), 0)) }
    end
end

function RampTowardsPlayer(entity)
	local t = 0.0
	
	while t < 1.0 do
		Wait(25)
		t = t + 0.01
		vec3 = VectorLerp(GetEntityCoords(entity, true), GetEntityCoords(PlayerPedId(), true), t)
		vehicle = GetRandomVehicleInSphere(vec3,2.0,0,0)

		if DoesEntityExist(entity) and (vehicle < 2) then -- The reason we choose two is because sometimes it returns 1 and I don't know why. I assume it also returns 2 sometimes just incase.
			SetEntityCoords(entity, vec3)			
		elseif not DoesEntityExist(entity) then
			t = 1.0
		end
	end
end

function VectorLerp(vec1, vec2, t)
	vecOut = vec1 - (t * (vec1 - vec2))
	return vecOut
end

function GetCashHash(money)
    local propA = cfg.dropA.prop
    local propB = cfg.dropB.prop
    local propC = cfg.dropC.prop
    local propD = cfg.dropD.prop
    local propE = cfg.dropE.prop
    local propF = cfg.dropF.prop 
    local model = 0
    
    if (money >= cfg.dropA.min_value) then
        model = propA
    end
    if (money >= cfg.dropB.min_value) then
        model = propB
    end
    if (money >= cfg.dropC.min_value) then
        model = propC
    end    
    if (money >= cfg.dropD.min_value) then
        model = propD
    end    
    if (money >= cfg.dropE.min_value) then
        model = propE
    end    
    if (money >= cfg.dropF.min_value) then
        model = propF
    end
   
    return GetHashKey(model)
end

function MoneyVariance(value)
    local RNG = math.random()
    local basevalue = value
    local multiplier = cfg.basedrop.multiplier
    local quantity = math.random(cfg.basedrop.min,cfg.basedrop.max)
    
    
    if (RNG <= cfg.dropA.RNG) then
        multiplier = cfg.dropA.multiplier
        quantity = math.random(cfg.dropA.min,cfg.dropA.max)
    end
    if (RNG <= cfg.dropB.RNG) then
        multiplier = cfg.dropB.multiplier
        quantity = math.random(cfg.dropB.min,cfg.dropB.max)
    end
    if (RNG >= cfg.dropC.RNG) then
        multiplier = cfg.dropC.multiplier
        quantity = math.random(cfg.dropC.min,cfg.dropC.max)
    end
    if (RNG >= cfg.dropD.RNG) then
        multiplier = cfg.dropD.multiplier
        quantity = math.random(cfg.dropD.min,cfg.dropD.max)
    end
    if (RNG >= cfg.dropE.RNG) then
        multiplier = cfg.dropE.multiplier
        quantity = math.random(cfg.dropE.min,cfg.dropE.max)
    end
    if (RNG >= cfg.dropF.RNG) then
        multiplier = cfg.dropF.multiplier
        quantity = math.random(cfg.dropF.min,cfg.dropF.max)
    end
    if(RNG >= cfg.jackpot.RNG) then
        multiplier = cfg.jackpot.multiplier
        quantity = math.random(cfg.jackpot.min,cfg.jackpot.max)
    end
    
    finalvalue = basevalue * multiplier
    return finalvalue, quantity
end


angleint = 0
function CapsuleCheckForNearbyPed(inputped)
    x, y, z = table.unpack(GetEntityCoords(inputped, true))
    flag = 12
    radius = 60
    Wait(7)
    for i = angleint, 72 do     
        angleint = angleint + 1
        AdjustAngleInt()
        
        local angle = math.rad(i * 5)

        local startX = (60.0 * math.cos(angle)) + x;
        local startY = (60.0 * math.sin(angle)) + y;
                    
        local endX = x - (startX - x)
        local endY = y - (startY - y)
        
        ray = StartShapeTestCapsule(startX,startY,z,endX,endY,z,radius,flag,inputped,7)
        _, _, _, _, result = GetShapeTestResult(ray)

        return result
    end
end

function AdjustAngleInt()    
    if angleint > 72 then
        angleint = 1
    end
end

function DetectNpcByAiming()
    local aiming = false
    local entity
    
    if IsPlayerFreeAiming(PlayerId()) then
        aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if (aiming) then
            if IsEntityAPed(entity) then
                return entity
            end
        end
    end
end

function GetTableLength(temptable)
    local count = 0
    for _ in pairs(temptable) do
        count = count+1
    end
    
    return count
end

function RoundNumber(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
        local mult = 10^numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    
    return math.floor(num + 0.5)
end
