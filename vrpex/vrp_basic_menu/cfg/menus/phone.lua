-- TO USE THIS FUNCTION YOU NEED TO HAVE THE ORIGINAL vRP UPDATED TO THE LASTEST VERSION
Citizen.CreateThread(function()



vRP.registerMenuBuilder("phone", function(add) -- phone menu is created on server start, so it has no permissions.
  Citizen.CreateThread(function()
    local choices = {} -- Comment the choices you want to disable by adding -- in front of them.
	
    choices[lang.mpay.button()] = ch_mobilepay -- transfer money through phone
    choices[lang.mcharge.button()] = ch_mobilecharge -- charge money through phone
	
    add(choices)
  end)
end)



end)