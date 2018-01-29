local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
SBclient = Tunnel.getInterface("vrp_scoreboard","vrp_scoreboard")
vRPclient = Tunnel.getInterface("vRP","vrp_scoreboard")
vRP = Proxy.getInterface("vRP")

AddEventHandler("vRP:playerLeave",function(user_id, source) 
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
		SBclient.removeUser(v,{user_id})
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
	  vRP.getUserIdentity({k, function(identity)
		SBclient.insertUser(source,{k, v, identity.firstname, identity.name,vRP.getUserGroupByType({k,"job"})})
	  end})
	  vRP.getUserIdentity({user_id, function(identity)
	    SBclient.insertUser(v,{user_id, source, identity.firstname, identity.name,vRP.getUserGroupByType({user_id,"job"})})
	  end})
	end
end)

AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype) 
  if gtype == "job" then
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
		SBclient.updateUser(v,{user_id,group})
	end
  end
end)