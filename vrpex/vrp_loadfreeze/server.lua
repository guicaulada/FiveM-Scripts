
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPlf = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
LFclient = Tunnel.getInterface("vrp_loadfreeze")
Tunnel.bindInterface("vrp_loadfreeze",vRPlf)


-- unfreeze on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	LFclient.loadFreeze(source)
end)