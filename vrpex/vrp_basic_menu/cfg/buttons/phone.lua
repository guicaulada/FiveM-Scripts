-- mobilepay
ch_mobilepay = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
	menu[lang.mpay.type.button()] = {
	  -- payment function
	  function(player,choice) 
	    local phone = vRP.prompt(player,lang.mpay.type.prompt,"")
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.payPhoneNumber(user_id,phone)
		  else
			vRPclient.notify(player,lang.common.invalid_value())
		  end
	  end,lang.mpay.type.desc()}
	local directory = vRP.getPhoneDirectory(user_id)
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.payPhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu(player, menu)
end,lang.mpay.desc()}

-- mobilecharge
ch_mobilecharge = {function(player,choice) 
	local user_id = vRP.getUserId(player)
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
	menu[lang.mcharge.type.button()] = {
	  -- payment function
	  function(player,choice) 
	    local phone = vRP.prompt(player,lang.mcharge.type.prompt(),"")
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.chargePhoneNumber(user_id,phone)
		  else
			vRPclient.notify(player,lang.common.invalid_value())
		  end
	  end,lang.mcharge.type.desc()}
	local directory = vRP.getPhoneDirectory(user_id)
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.chargePhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu(player, menu)
end,lang.mcharge.desc()}