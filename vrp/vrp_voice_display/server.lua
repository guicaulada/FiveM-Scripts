local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_voice_display", "cfg/display")
vRPvd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_voice_display")
VDclient = Tunnel.getInterface("vrp_voice_display","vrp_voice_display")
Tunnel.bindInterface("vrp_voice_display",vRPvd)

function vRPvd.setVoiceDisplay(player,volume)
	if not player then player = source end
	vRPclient.setDiv(player,{"voice_text",cfg[volume].css,cfg[volume].text})
    vRPclient.setDiv(player,{"voice_icon",cfg[volume].css,cfg[volume].text})
	VDclient.setTalkerProxity(player,{cfg[volume].distance})
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	vRPvd.setVoiceDisplay(source,1)
end)