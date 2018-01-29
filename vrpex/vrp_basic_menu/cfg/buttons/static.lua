--police weapons // comment out the weapons if you dont want to give weapons.
police_weapons = {}
police_weapons[lang.police_weapons.first] = {function(player,choice)
    vRPclient.giveWeapons(player,{
	  ["WEAPON_COMBATPISTOL"] = {ammo=200},
	  ["WEAPON_PUMPSHOTGUN"] = {ammo=200},
	  ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_STUNGUN"] = {ammo=200}
	}, true)
	BMclient.setArmour(player,100,true)
end}

--medkit storage
emergency_medkit = {}
emergency_medkit[lang.emergency_medkit.first] = {function(player,choice)
	local user_id = vRP.getUserId(player) 
	vRP.giveInventoryItem(user_id,"medkit",25,true)
	vRP.giveInventoryItem(user_id,"pills",25,true)
end}

--heal me
emergency_heal = {}
emergency_heal[lang.emergency_heal.first] = {function(player,choice)
	local user_id = vRP.getUserId(player) 
	vRPclient.setHealth(player,1000)
end}