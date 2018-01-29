
Citizen.CreateThread(function()



vRP.registerMenuBuilder("police", function(add, data)
  Citizen.CreateThread(function()
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
	  
	  if vRP.hasPermission(user_id,lang.jail.perm()) then
        choices[lang.jail.button()] = ch_jail -- Send a nearby handcuffed player to jail with prompt for choice and user_list
      end
	  
	  if vRP.hasPermission(user_id,lang.unjail.perm()) then
        choices[lang.unjail.button()] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
      end
	  
	  if vRP.hasPermission(user_id,lang.fine.perm()) then
        choices[lang.fine.button()] = ch_fine -- Fines closeby player
      end
	  
	  if vRP.hasPermission(user_id,lang.cuff.perm()) then
        choices[lang.cuff.button()] = ch_handcuff -- Toggle cuffs AND CLOSE MENU for nearby player
      end
	  
	  if vRP.hasPermission(user_id,lang.spikes.perm()) then
        choices[lang.spikes.button()] = ch_spikes -- Toggle spikes
      end
	  
      if vRP.hasPermission(user_id,lang.drag.perm()) then
        choices[lang.drag.button()] = ch_drag -- Drags closest handcuffed player
      end
	  
	  if vRP.hasPermission(user_id,lang.freeze.perm()) then
        choices[lang.freeze.button()] = ch_freeze -- Toggle freeze
      end
	  
      add(choices)
    end
  end)
end)



end)