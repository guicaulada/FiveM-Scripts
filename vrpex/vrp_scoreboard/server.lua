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