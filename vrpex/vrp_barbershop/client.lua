--[[Proxy/Tunnel]]--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPbs = {}
Tunnel.bindInterface("vrp_barbershop",vRPbs)
Proxy.addInterface("vrp_barbershop",vRPbs)
BSserver = Tunnel.getInterface("vrp_barbershop")
vRP = Proxy.getInterface("vRP")

local cfg = module("vrp_barbershop", "cfg/barbershop")
custom = cfg.default

function vRPbs.setOverlay(data)
	if data then
		custom = data
	end
end

function vRPbs.getOverlay()
  return custom
end

function vRPbs.getDrawables(part)
  if part == 12 then
    return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),2))
  elseif part == -1 then
    return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),0))
  elseif part == -2 then
    return 64
  else
    return tonumber(GetNumHeadOverlayValues(part))
  end
end

function vRPbs.getTextures(part)
  if part == -1 then
    return tonumber(GetNumHairColors())
  else
    return 64
  end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    while not IsPedModel(GetPlayerPed(-1),"mp_m_freemode_01") and not IsPedModel(GetPlayerPed(-1),"mp_f_freemode_01") do
      Citizen.Wait(1)
    end
    if custom then
      local ped = GetPlayerPed(-1)
      if custom["-1"] then
        SetPedHeadBlendData(ped,custom["-1"][1],custom["-1"][1],custom["-1"][1],custom["-1"][2],custom["-1"][2],custom["-1"][2],1.0,0.0,0.0,false)
      else
        SetPedHeadBlendData(ped,0,0,0,0,0,0,1.0,0.0,0.0,false)
      end
      -- parts
      for k,v in pairs(custom) do
        if tonumber(k) == -1 then
        elseif tonumber(k) == -2 then
          SetPedEyeColor(ped,v[2])
        elseif tonumber(k) == 12 then 
          SetPedComponentVariation(ped, 2, v[1], 0, 0) 
  	      SetPedHairColor(ped, v[2], v[2])
		elseif tonumber(k) == 1 or tonumber(k) == 2 or tonumber(k) == 10 then
          SetPedHeadOverlayColor(ped, tonumber(k), 1, v[2], v[2])
          SetPedHeadOverlay(ped, tonumber(k), v[1], 1.0)
		elseif tonumber(k) == 5 or tonumber(k) == 8 then
          SetPedHeadOverlayColor(ped, tonumber(k), 2, v[2], v[2])
          SetPedHeadOverlay(ped, tonumber(k), v[1], 1.0)
        else
          SetPedHeadOverlayColor(ped, tonumber(k), 0, v[2], v[2])
          SetPedHeadOverlay(ped, tonumber(k), v[1], 1.0)
        end
      end
    end
  end
end)