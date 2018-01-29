local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
SBclient = Tunnel.getInterface("vrp_scoreboard")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

AddEventHandler("vRP:playerLeave",function(user_id, source) 
	local users = vRP.getUsers()
	for k,v in pairs(users) do
	  SBclient.removeUser(v,user_id)
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local users = vRP.getUsers()
	local my_identity = vRP.getUserIdentity(user_id)
	for k,v in pairs(users) do
	  local his_identity = vRP.getUserIdentity(k)
	  SBclient.insertUser(source,k, v, his_identity.firstname, his_identity.name,vRP.getUserGroupByType(k,"job"))
	  SBclient.insertUser(v,user_id, source, my_identity.firstname, my_identity.name,vRP.getUserGroupByType(user_id,"job"))
	end
end)

AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype) 
  if gtype == "job" then
	local users = vRP.getUsers()
	for k,v in pairs(users) do
	  SBclient.updateUser(v,user_id,group)
	end
  end
end)