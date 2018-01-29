vRPd = {}
Tunnel.bindInterface("vrp_drugs",vRPd)
Proxy.addInterface("vrp_drugs",vRPd)
Dserver = Tunnel.getInterface("vrp_drugs","vrp_drugs")
vRPserver = Tunnel.getInterface("vRP","vrp_drugs")
vRP = Proxy.getInterface("vRP")

-- SCREEN

-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function vRPd.playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)

    Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
      Citizen.Wait(math.floor((duration+1)*1000))
      StopScreenEffect(name)
    end)
  end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function vRPd.stopScreenEffect(name)
  StopScreenEffect(name)
end

-- MOVEMENT CLIPSET
function vRPd.playMovement(clipset,blur,drunk,fade,clear)
  --request anim
  RequestAnimSet(clipset)
  while not HasAnimSetLoaded(clipset) do
    Citizen.Wait(0)
  end
  -- fade out
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
  end
  -- clear tasks
  if clear then
    ClearPedTasksImmediately(GetPlayerPed(-1))
  end
  -- set timecycle
  SetTimecycleModifier("spectator5")
  -- set blur
  if blur then 
    SetPedMotionBlur(GetPlayerPed(-1), true) 
  end
  -- set movement
  SetPedMovementClipset(GetPlayerPed(-1), clipset, true)
  -- set drunk
  if drunk then
    SetPedIsDrunk(GetPlayerPed(-1), true)
  end
  -- fade in
  if fade then
    DoScreenFadeIn(1000)
  end
  
end

function vRPd.resetMovement(fade)
  -- fade
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
  end
  -- reset all
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(GetPlayerPed(-1), 0)
  SetPedIsDrunk(GetPlayerPed(-1), false)
  SetPedMotionBlur(GetPlayerPed(-1), false)
end
