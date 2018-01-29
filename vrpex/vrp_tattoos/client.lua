--[[Proxy/Tunnel]]--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)
vRP = Proxy.getInterface("vRP")

custom = {}

function vRPts.setTattoos(data)
    ClearPedDecorations(GetPlayerPed(-1))
	if data then
		custom = data
	end
end

function vRPts.addTattoo(tattoo,store,price)
    ClearPedDecorations(GetPlayerPed(-1))
	if tattoo and store then
	  custom[tattoo] = {store,price}
	end
end

function vRPts.delTattoo(tattoo)
    ClearPedDecorations(GetPlayerPed(-1))
	if tattoo then
	  custom[tattoo] = nil
	end
end

function vRPts.getTattoos()
  return custom
end


function vRPts.cleanPlayer()
  ClearPedDecorations(GetPlayerPed(-1))
  custom = {}
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    while not IsPedModel(GetPlayerPed(-1),"mp_m_freemode_01") and not IsPedModel(GetPlayerPed(-1),"mp_f_freemode_01") do
      Citizen.Wait(1)
    end
    if custom then
      local ped = GetPlayerPed(-1)
      -- parts
      for k,v in pairs(custom) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(v[1]), GetHashKey(k))
      end
    end
  end
end)