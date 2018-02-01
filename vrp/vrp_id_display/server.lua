--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_id_display", "cfg/blips")
vRPidd = {}
IDDclient = Tunnel.getInterface("vrp_id_display","vrp_id_display")
vRPclient = Tunnel.getInterface("vRP","vrp_id_display")
Tunnel.bindInterface("vrp_id_display",vRPidd)
Proxy.addInterface("vrp_id_display",vRPidd)
vRP = Proxy.getInterface("vRP")

AddEventHandler("vRP:playerLeave",function(user_id, source) 
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
	  IDDclient.removeUser(v,{user_id})
	  IDDclient.removeBlip(v,{user_id})
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local users = vRP.getUsers({})
	local job = vRP.getUserGroupByType({user_id,"job"})
	local team = vRPidd.getUserTeamByGroup(user_id,job)
	
	for k,v in pairs(users) do
	  IDDclient.insertUser(source,{k,v})
	  IDDclient.insertUser(v,{user_id,source})
	  	  
	  local ujob = vRP.getUserGroupByType({k,"job"})
	  local uteam = vRPidd.getUserTeamByGroup(k,ujob)
	
	  IDDclient.insertBlip(source,{k,v,ujob,uteam})
	  IDDclient.insertBlip(v,{user_id,source,job,team})
	end
end)

AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
	if gtype == "job" then
	  local player = vRP.getUserSource({user_id})
	  local users = vRP.getUsers({})
	  local job = vRP.getUserGroupByType({user_id,"job"})
	  local team = vRPidd.getUserTeamByGroup(user_id,job)
	
	  for k,v in pairs(users) do
	    local ujob = vRP.getUserGroupByType({k,"job"})
	    local uteam = vRPidd.getUserTeamByGroup(k,ujob)
	
	    IDDclient.insertBlip(player,{k,v,ujob,uteam})
	    IDDclient.insertBlip(v,{user_id,player,job,team})
	  end
	end
end)

AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
	if gtype == "job" then
	  local users = vRP.getUsers({})
	  for k,v in pairs(users) do
	    IDDclient.removeBlip(v,{user_id})
	  end
	end
end)

function vRPidd.getUserTeamByGroup(user_id,group)
  for k,v in pairs(cfg.teams) do
	for l,w in pairs(v) do
	  if group == w then
	    return k
	  end
	end
  end
  return nil
end