local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPmd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_moneydrop")
Tunnel.bindInterface("vrp_moneydrop",vRPmd)

function vRPmd.updateUserMoney(worth)
	local user_id = vRP.getUserId({source})
	vRP.giveMoney({user_id,worth})
end