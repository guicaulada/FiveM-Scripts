
Citizen.CreateThread(function()



vRP.registerMenuBuilder("admin", function(add, data)
  Citizen.CreateThread(function()
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
	  
	  if vRP.hasPermission(user_id,lang.deleteveh.perm()) then
        choices[lang.deleteveh.button()] = ch_deleteveh -- Delete nearest vehicle
	  end
	  
	  if vRP.hasPermission(user_id,lang.spawnveh.perm()) then
        choices[lang.spawnveh.button()] = ch_spawnveh -- Spawn a vehicle model
	  end
	  
	  if vRP.hasPermission(user_id,lang.godmode.perm()) then
        choices[lang.godmode.button()] = ch_godmode -- Toggles admin godmode (Disable the default admin.god permission to use this!) 
	  end
	  
      if vRP.hasPermission(user_id,lang.blips.perm()) then
        choices[lang.blips.button()] = ch_blips -- turn on map blips and sprites
      end
	  
      if vRP.hasPermission(user_id,lang.sprites.perm()) then
        choices[lang.sprites.button()] = ch_sprites -- turn on only name sprites
      end
	  
      if vRP.hasPermission(user_id,lang.crun.perm()) then
        choices[lang.crun.button()] = ch_crun -- run any client command, any GTA V client native http://www.dev-c.com/nativedb/
      end
	  
      if vRP.hasPermission(user_id,lang.srun.perm()) then
        choices[lang.srun.button()] = ch_srun -- run any server command, any GTA V server native http://www.dev-c.com/nativedb/
      end
    
	  if vRP.hasPermission(user_id,lang.tptowaypoint.perm()) then
        choices[lang.tptowaypoint.button()] = choice_tptowaypoint -- teleport user to map blip
	  end
	  
	  if vRP.hasPermission(user_id,lang.unjail.perm()) then
        choices[lang.unjail.button()] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
      end
	  
	  if vRP.hasPermission(user_id,lang.spikes.perm()) then
        choices[lang.spikes.button()] = ch_spikes -- Toggle spikes
      end
	  
	  if vRP.hasPermission(user_id,lang.freeze.perm()) then
        choices[lang.freeze.button()] = ch_freeze -- Toggle freeze
      end
	  
      add(choices)
    end
  end)
end)



end)