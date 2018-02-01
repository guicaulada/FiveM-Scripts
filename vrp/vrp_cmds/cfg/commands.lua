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

cfg = {}
-- THIS FILE IS ON SERVER SIDE ( Just reminding you ;) )
--[[ Create Your commands inside the list cfg.commands like so: 
  ["/cmd"] = {
    action = function(p,color,msg)
	  -- function of what the command does
	end
  },
]]
-- p is player, color is {r, g, b} of the message and msg is the message of course.
cfg.commands = {
  ["/pos"] = {
    -- /pos to log postion to file with user name and msg
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId({p})
	  if vRP.hasPermission({user_id,"admin.cmd_pos"}) then
	    CMDclient.getPlayerPosH(p,{},function(x,y,z,h)
	      file = io.open("cmdPos.txt", "a")
		  if file then
		    file:write(GetPlayerName(p).." at ".."{" .. x .. "," .. y .. "," .. z .. "," .. h .. "} wrote: "..(msg or "").."\n")
		  end
		  file:close()
		  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Location sent to file!")
	    end)
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  ["/t"] = {
    -- /t to send message to team from vrp_id_display
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId({p})
	  if vRP.hasPermission({user_id,"player.cmd_team"}) then
	    if msg ~= nil and msg ~= "" then
	      local player = vRP.getUserSource({user_id})
	      local users = vRP.getUsers({})
	      local job = vRP.getUserGroupByType({user_id,"job"})
	      local team = vRPidd.getUserTeamByGroup({user_id,job})
		  
		  if team ~= nil then
	        for k,v in pairs(users) do
	          local ujob = vRP.getUserGroupByType({k,"job"})
	          local uteam = vRPidd.getUserTeamByGroup({k,ujob})
		      if uteam == team then
		        IDDclient.getGroupColour(player,{job}, function(r,g,b)
		          TriggerClientEvent('chatMessage', v, "["..team.."] "..job.." | "..GetPlayerName(p), {r, g, b}, msg)
			    end)
		      end
			end
		  else
			TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't belong to a team!")
	      end
		end
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  ["/tp"] = {
    -- /tp to create linked areas that teleport to each other like doors
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId({p})
	  if vRP.hasPermission({user_id,"admin.cmd_tp"}) then
	    if msg ~= nil then
	      local args = splitString(msg, " ")
	      local exists = false
	      local complete = false
	      if args[1] == "in" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				tps = {}
			  end
			  for k,v in pairs(tps) do
				if k == args[2] then
					exists = true
				end
			  end
			  CMDclient.getPlayerPosH(p,{},function(px,py,pz,ph)
				if exists then
					tps[args[2]].pos_in = {x = px,y = py,z = pz,h = ph-180}
					TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You moved the teleport in for "..args[2].." to this location!")
				else
					tps[args[2]] = {
					  pos_in = {x = px,y = py,z = pz,h = ph-180},
					  pos_out = nil,
					  active = false
					}
					TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You created the teleport in for "..args[2].." in this location!")
				end
				vRP.setSData({"vRP:cmd:teleports",json.encode(tps)})
			  end)
		    end})
	      elseif args[1] == "out" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				tps = {}
			  end
			  for k,v in pairs(tps) do
				if k == args[2] then
					exists = true
				end
			  end
			  CMDclient.getPlayerPosH(p,{},function(px,py,pz,ph)
				if exists then
					tps[args[2]].pos_out = {x = px,y = py,z = pz,h = ph-180}
					TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You moved the teleport out for "..args[2].." to this location!")
				else
					tps[args[2]] = {
					  pos_in = nil,
					  pos_out = {x = px,y = py,z = pz,h = ph-180},
					  active = false
					}
					TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You created the teleport out for "..args[2].." in this location!")
				end
				vRP.setSData({"vRP:cmd:teleports",json.encode(tps)})
			  end)
		    end})
	      elseif args[1] == "off" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				tps = {}
			  end
			  for k,v in pairs(tps) do
				if k == args[2] then
					exists = true
					if v.pos_in and v.pos_out then
						complete = true
					end
				end
			  end
			  if exists and complete then
				tps[args[2]].active = false
				vRP.setSData({"vRP:cmd:teleports",json.encode(tps)})
				vRP.removeArea({-1,"vRP:cmd:tp:in:"..args[2]})
				vRPclient.removeNamedMarker(-1,{"vRP:cmd:tp:in:"..args[2]})
				vRP.removeArea({-1,"vRP:cmd:tp:out:"..args[2]})
				vRPclient.removeNamedMarker(-1,{"vRP:cmd:tp:out:"..args[2]})
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You deactivated the teleport for "..args[2].."!")
			  elseif exists then
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not complete yet!")
			  else
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not created yet!")
			  end
			end})
	      elseif args[1] == "on" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				tps = {}
			  end
			  for k,v in pairs(tps) do
				if k == args[2] then
					exists = true
					if v.pos_in and v.pos_out then
						complete = true
					end
				end
			  end
			  if exists  and complete then
				tps[args[2]].active = true
				vRP.setSData({"vRP:cmd:teleports",json.encode(tps)})
				local users = vRP.getUsers({})
				for k,v in pairs(users) do
				  vRPcmd.setTpIn(v,args[2],tps[args[2]].pos_in.x,tps[args[2]].pos_in.y,tps[args[2]].pos_in.z,tps[args[2]].pos_in.h,tps[args[2]].pos_out.x,tps[args[2]].pos_out.y,tps[args[2]].pos_out.z,tps[args[2]].pos_out.h)
				  vRPcmd.setTpOut(v,args[2],tps[args[2]].pos_in.x,tps[args[2]].pos_in.y,tps[args[2]].pos_in.z,tps[args[2]].pos_in.h,tps[args[2]].pos_out.x,tps[args[2]].pos_out.y,tps[args[2]].pos_out.z,tps[args[2]].pos_out.h)
				end

				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You activated the teleport for "..args[2].."!")
			  elseif exists then
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not complete yet!")
			  else
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not created yet!")
			  end
			end})
	      elseif args[1] == "del" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				tps = {}
			  end
			  for k,v in pairs(tps) do
				if k == args[2] then
					exists = true
					if v.pos_in and v.pos_out then
						complete = true
					end
				end
			  end
			  if exists then
				tps[args[2]] = nil
				vRP.setSData({"vRP:cmd:teleports",json.encode(tps)})
				vRP.removeArea({-1,"vRP:cmd:tp:in:"..args[2]})
				vRPclient.removeNamedMarker(-1,{"vRP:cmd:tp:in:"..args[2]})
				vRP.removeArea({-1,"vRP:cmd:tp:out:"..args[2]})
				vRPclient.removeNamedMarker(-1,{"vRP:cmd:tp:out:"..args[2]})
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You deleted the teleport for "..args[2].."!")
			  else
				TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not created yet!")
			  end
			end})
	      elseif args[1] == "show" then
	        vRP.getSData({"vRP:cmd:teleports",function(teleports)
			  local tps = json.decode(teleports)
			  if tps == nil then
				  tps = {}
			  end
			  local tps_str = ""
			  if args[2] == nil then
			    for k,v in pairs(tps) do
				  if v ~= nil then
			        tps_str = tps_str .. " " .. k
				  end
			    end
			    TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Existing TPs:" .. tps_str)
			    TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Usage: /tp show <tpName>")
			  else
			    for k,v in pairs(tps) do
			      if k == args[2] then
				    if v ~= nil then
				      TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Showing: " .. k)
					  if v.pos_in ~= nil then
				        TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "In: {" .. v.pos_in.x ..","..v.pos_in.y..","..v.pos_in.z..","..v.pos_in.h.."}")
					  end
					  if v.pos_out ~= nil then
				        TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Out: {" .. v.pos_out.x ..","..v.pos_out.y..","..v.pos_out.z..","..v.pos_out.h.."}")
					  end
					  if v.active then
				        TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "State: on")
					  else
				        TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "State: off")
					  end
					end
				  end
			    end
			    TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Use \"/tp show\" to show all existing TPs.")
			  end
		    end})
	      else
		    TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Usage: /tp <in/out/on/off/del/show> <tpName>")
	      end
	    else
		  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Usage: /tp <in/out/on/off/del/show> <tpName>")
	    end
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  --HERE GOES YOUR COMMANDS
  
}

return cfg