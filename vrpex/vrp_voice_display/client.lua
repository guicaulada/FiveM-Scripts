local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_voice_display", "cfg/display")
vRP = Proxy.getInterface("vRP")

local voice = 1

Citizen.CreateThread(function()
  while true do
     Citizen.Wait(0)
     if IsControlJustPressed(1, cfg.key) then 
      voice = voice + 1
      if voice > #cfg.volume then voice = 1 end
      vRP.setDiv("voice_text",cfg.volume[voice].css,cfg.volume[voice].text)
      vRP.setDiv("voice_icon",cfg.volume[voice].css,cfg.volume[voice].text)
      NetworkSetTalkerProximity(cfg.volume[voice].distance)
     end
  end
end)

AddEventHandler('playerSpawned', function(spawn)
  vRP.setDiv("voice_text",cfg.volume[voice].css,cfg.volume[voice].text)
  vRP.setDiv("voice_icon",cfg.volume[voice].css,cfg.volume[voice].text)
  NetworkSetTalkerProximity(cfg.volume[voice].distance)
end)