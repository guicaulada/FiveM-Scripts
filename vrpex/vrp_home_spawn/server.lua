local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- unfreeze on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if not first_spawn then
		local address = vRP.getUserAddress(user_id)
	    if address then 
		  SetTimeout(5000,function()
		    vRP.accessHome(user_id, address.home, address.number)
		  end)
	    end
	end
end)
