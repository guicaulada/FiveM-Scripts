--infinite stamina
Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
    RestorePlayerStamina(PlayerId(), 1.0)
  end
end)