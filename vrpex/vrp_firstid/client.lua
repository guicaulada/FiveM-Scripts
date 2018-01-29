Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPl = {}
vRP = Proxy.getInterface("vRP")
Lserver = Tunnel.getInterface("vrp_firstid")
Tunnel.bindInterface("vrp_firstid",vRPl)
Proxy.addInterface("vrp_firstid",vRPl)
frozen = false
unfrozen = false

-- Open Form and Focus NUI
function vRPl.openForm()
  onHTML = true
  frozen = true
  SetNuiFocus(true)
  SendNUIMessage({openForm = true})
end
-- Close Form and Unfocus NUI
function vRPl.closeForm()
  onHTML = false
  unfrozen = true
  SetNuiFocus(false)
  SendNUIMessage({closeForm = true})
end

-- Receive callback from JavaScrip
RegisterNUICallback('submit', function(data, cb)
  vRPl.closeForm()
  -- Treat callback data information on server side
  Lserver.setIdentity(data)
  cb('ok')
end)

-- Disable controls while Form open
Citizen.CreateThread(function()
  while true do
    if onHTML then
      DisableControlAction(0, 1, true) -- Disable looking horizontally
      DisableControlAction(0, 2, true) -- Disable looking vertically
      DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
      DisableControlAction(0, 142, true) -- Disable aiming
      DisableControlAction(0, 106, true) -- Disable in-game mouse controls
      if IsDisabledControlJustReleased(0, 142) then -- Detect trying attack
        SendNUIMessage({type = "click"}) -- Send attack as click
      end
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				frozen = false
				unfrozen = false
				SetEntityInvincible(GetPlayerPed(-1),false) -- Set entity vinvcible
				SetEntityVisible(GetPlayerPed(-1),true) -- Set entity visible
				FreezeEntityPosition(GetPlayerPed(-1),false) -- Unreeze entity position
			else
				SetEntityInvincible(GetPlayerPed(-1),true) -- Set entity invinvcible
				SetEntityVisible(GetPlayerPed(-1),false) -- Set entity invisible
				FreezeEntityPosition(GetPlayerPed(-1),false) -- Freeze entity position
			end
		end
		Citizen.Wait(0)
	end
end)