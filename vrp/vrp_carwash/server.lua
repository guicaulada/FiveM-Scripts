--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_carwash")

RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function(dirt)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if parseFloat(dirt) > parseFloat(1.0) then
	  if vRP.tryPayment({user_id,25}) then
		TriggerClientEvent('carwash:success', player)
	  else
		TriggerClientEvent('carwash:notenough', player)
	  end	
	else
	  TriggerClientEvent('carwash:alreadyclean', player)
	end
end)
