
-- teleport waypoint
choice_tptowaypoint = {function(player,choice)
	BMclient.tpToWaypoint(player)
end, lang.tptowaypoint.desc()}

-- toggle blips
ch_blips = {function(player,choice)
	BMclient.showBlips(player)
end, lang.blips.desc()}

-- toggle sprites
ch_sprites = {function(player,choice)
	BMclient.showSprites(player)
end, lang.sprites.desc()}

-- delete vehicle
ch_deleteveh = {function(player,choice)
	BMclient.deleteVehicleInFrontOrInside(player,5.0)
end, lang.deleteveh.desc()}

-- client function
ch_crun = {function(player,choice)
    local stringToRun = vRP.prompt(player,lang.crun.prompt(),"") 
      stringToRun = stringToRun or ""
	  BMclient.runStringLocally(player, stringToRun)
end, lang.crun.desc()}

-- server function
ch_srun = {function(player,choice)
    local stringToRun = vRP.prompt(player,lang.srun.prompt(),"") 
      stringToRun = stringToRun or ""
	  vRPbm.runStringRemotelly(stringToRun)
end, lang.srun.desc()}

-- godmode
ch_godmode = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if gods[player] then
	    gods[player] = nil
	    vRPclient.notify(player,lang.godmode.off())
	  else
	    gods[player] = user_id
	    vRPclient.notify(player,lang.godmode.on())
	  end
    end
end, lang.godmode.desc()}

-- spawn vehicle
ch_spawnveh = {function(player,choice) 
	local model = vRP.prompt(player,lang.spawnveh.prompt(),"")
	  if model ~= nil and model ~= "" then 
	    BMclient.spawnVehicle(player,model)
	  else
		vRPclient.notify(player,lang.common.invalid_value())
	  end
end,lang.spawnveh.desc()}