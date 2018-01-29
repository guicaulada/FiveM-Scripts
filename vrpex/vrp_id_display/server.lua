local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_id_display", "cfg/display")
vRPidd = {}
IDDclient = Tunnel.getInterface("vrp_id_display")
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_id_display",vRPidd)
Proxy.addInterface("vrp_id_display",vRPidd)
vRP = Proxy.getInterface("vRP")

AddEventHandler("vRP:playerLeave",function(user_id, source) 
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
	  IDDclient.removeUser(v,user_id)
	  IDDclient.removeBlip(v,user_id)
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local users = vRP.getUsers({})
	local job = vRP.getUserGroupByType(user_id,"job")
	local teams = vRPidd.getUserTeamsByGroup(user_id,job)
	
	for k,v in pairs(users) do
	  IDDclient.insertUser(source,k,v)
	  IDDclient.insertUser(v,user_id,source)
	  	  
	  local ujob = vRP.getUserGroupByType(k,"job")
	  local uteams = vRPidd.getUserTeamsByGroup(k,ujob)
	
	  IDDclient.insertBlip(source,k,v,ujob,uteams)
	  IDDclient.insertBlip(v,user_id,source,job,teams)
	end
end)

AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
	if gtype == "job" then
	  local player = vRP.getUserSource(user_id)
	  local users = vRP.getUsers()
	  local job = vRP.getUserGroupByType(user_id,"job")
	  local teams = vRPidd.getUserTeamsByGroup(user_id,job)
	
	  for k,v in pairs(users) do
	    local ujob = vRP.getUserGroupByType(k,"job")
	    local uteams = vRPidd.getUserTeamsByGroup(k,ujob)
	
	    IDDclient.insertBlip(player,k,v,ujob,uteams)
	    IDDclient.insertBlip(v,user_id,player,job,teams)
	  end
	end
end)

AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
	if gtype == "job" then
	  local users = vRP.getUsers({})
	  for k,v in pairs(users) do
	    IDDclient.removeBlip(v,user_id)
	  end
	end
end)

function vRPidd.getUserTeamsByGroup(user_id,group)
  local teams = {}
  for k,v in pairs(cfg.teams) do
	for l,w in pairs(v) do
	  if group == w then
	    table.insert(teams, k)
	  end
	end
  end
  return teams
end