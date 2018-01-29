
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPlf = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_loadfreeze",vRPlf)
Proxy.addInterface("vrp_loadfreeze",vRPlf)

timeout = 0
frozen = false
function vRPlf.loadFreeze()
  timeout = 30
  while not IsPedModel(GetPlayerPed(-1),"mp_m_freemode_01") and not IsPedModel(GetPlayerPed(-1),"mp_f_freemode_01") and timeout > 0 do
    SetEntityInvincible(GetPlayerPed(-1),true)
    SetEntityVisible(GetPlayerPed(-1),false)
    FreezeEntityPosition(GetPlayerPed(-1),true)
	frozen = true
    Citizen.Wait(1)
  end
  SetEntityInvincible(GetPlayerPed(-1),false)
  SetEntityVisible(GetPlayerPed(-1),true)
  FreezeEntityPosition(GetPlayerPed(-1),false)
  frozen = false
end

Citizen.CreateThread(function()
  while true do
    if timeout > 0 then
      timeout = timeout - 1
    end
    Citizen.Wait(1000)
  end
end)

function vRPlf.isFrozen()
  return frozen
end