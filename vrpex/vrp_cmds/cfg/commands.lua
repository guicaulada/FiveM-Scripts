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
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"admin.cmd_pos") then
	    local x,y,z,h = CMDclient.getPlayerPosH(p)
	    file = io.open("cmdPos.txt", "a")
		if file then
		  file:write(GetPlayerName(p).." at ".."{" .. x .. "," .. y .. "," .. z .. "," .. h .. "} wrote: "..(msg or "").."\n")
		end
		file:close()
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Location sent to file!")
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  ["/t"] = {
    -- /t to send message to team from vrp_id_display
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"player.cmd_team") then
	    if msg ~= nil and msg ~= "" then
	      local player = vRP.getUserSource(user_id)
	      local users = vRP.getUsers()
	      local job = vRP.getUserGroupByType(user_id,"job")
	      local teams = vRPidd.getUserTeamsByGroup(user_id,job)
	      local args = splitString(msg, " ")
		  local specific = args[1]
		  local new_msg = ""
		  for n,m in pairs(args) do
		    if n > 1 then
			  new_msg = new_msg .. " " .. m
			end
		  end
		  local send = {}
		  local sent = ""
		  local special = false
		  
		  if teams then
		    for x,y in pairs(teams) do
			  if specific == y then
			    special = true
			  end
			end
		    local r, g, b = IDDclient.getGroupColour(player,job)
			local tcount = 0
	        for i,t in pairs(teams) do
			  tcount = tcount + 1
			  if tcount == #teams then
			    sent = sent .. t
			  else
			    sent = sent .. t .. " | "
			  end
	          for k,v in pairs(users) do
	            local ujob = vRP.getUserGroupByType(k,"job")
	            local uteams = vRPidd.getUserTeamsByGroup(k,ujob)
			    for l,u in pairs(uteams) do
				  if not special and not send[k] then
		            if u == t then
					    send[k] = v
					end
				  else
					if specific == t then
					    send[k] = v
					end
			      end
				end
			  end
			end
			if special then 
			  msg = new_msg
			  sent = specific
			end
			for k,v in pairs(send) do
		      TriggerClientEvent('chatMessage', v, "["..sent.."] "..job.." | "..GetPlayerName(p), {r, g, b}, msg)
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
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"admin.cmd_tp") then
	    if msg ~= nil then
	      local args = splitString(msg, " ")
	      local exists = false
	      local complete = false
	      if args[1] == "in" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
			local tps = json.decode(teleports)
			if tps == nil then
			  tps = {}
			end
			for k,v in pairs(tps) do
			  if k == args[2] then
				exists = true
			  end
			end
			local px,py,pz,ph = CMDclient.getPlayerPosH(p)
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
			vRP.setSData("vRP:cmd:teleports",json.encode(tps))
	      elseif args[1] == "out" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
			local tps = json.decode(teleports)
			if tps == nil then
			  tps = {}
			end
			for k,v in pairs(tps) do
			  if k == args[2] then
				exists = true
			  end
			end
			local px,py,pz,ph = CMDclient.getPlayerPosH(p)
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
			vRP.setSData("vRP:cmd:teleports",json.encode(tps))
	      elseif args[1] == "off" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
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
			  vRP.setSData("vRP:cmd:teleports",json.encode(tps))
			  vRP.removeArea(-1,"vRP:cmd:tp:in:"..args[2])
			  vRPclient.removeNamedMarker(-1,"vRP:cmd:tp:in:"..args[2])
			  vRP.removeArea(-1,"vRP:cmd:tp:out:"..args[2])
			  vRPclient.removeNamedMarker(-1,"vRP:cmd:tp:out:"..args[2])
			  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You deactivated the teleport for "..args[2].."!")
			elseif exists then
			  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not complete yet!")
			else
			  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not created yet!")
			end
	      elseif args[1] == "on" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
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
			  vRP.setSData("vRP:cmd:teleports",json.encode(tps))
			  local users = vRP.getUsers()
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
	      elseif args[1] == "del" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
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
			  vRP.setSData("vRP:cmd:teleports",json.encode(tps))
			  vRP.removeArea(-1,"vRP:cmd:tp:in:"..args[2])
			  vRPclient.removeNamedMarker(-1,"vRP:cmd:tp:in:"..args[2])
			  vRP.removeArea(-1,"vRP:cmd:tp:out:"..args[2])
			  vRPclient.removeNamedMarker(-1,"vRP:cmd:tp:out:"..args[2])
			  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You deleted the teleport for "..args[2].."!")
			else
			  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "The teleport for "..args[2].." is not created yet!")
			end
	      elseif args[1] == "show" then
	        local teleports = vRP.getSData("vRP:cmd:teleports")
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
  ["/mask"] = {
    -- /mask toggles mask on and off
	action = function(p,color,msg)
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"player.cmd_mask") then
	    CMDclient.togglePlayerMask(p)
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  ["/plate"] = {
    -- /plate checks vehicle owner
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"police.cmd_plate") then
		if msg then
		    local user_id = vRP.getUserByRegistration(msg)
            if user_id then
              local identity = vRP.getUserIdentity(user_id)
              if identity then
				TriggerClientEvent('chatMessage', p, "LSPD", {80, 80, 255}, identity.name.." "..identity.firstname..", "..identity.age)
			  else
		        TriggerClientEvent('chatMessage', p, "LSPD", {80, 80, 255}, "Owner not found, vehicle stolen or invalid plate!")
              end
            else
		      TriggerClientEvent('chatMessage', p, "LSPD", {80, 80, 255}, "Owner not found, vehicle stolen or invalid plate!")
            end
		else
		  TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Usage: /plate <plate>")
		end
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  ["/homes"] = {
    -- /homes show user homes from adv_homes
	action = function(p,color,msg) 
	  local user_id = vRP.getUserId(p)
	  if vRP.hasPermission(user_id,"player.cmd_homes") then
	      local adresses = vRPh.getUserAddresses(user_id)
		  local homeless = true
	      for k,address in pairs(adresses) do
		    homeless = false
		    TriggerClientEvent('chatMessage', p, "HOME "..k, {255, 0, 0}, address.home..", "..address.number)
		  end
		  if homeless then
		    TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have any homes!")
		  end
	  else
		TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
	  end
	end
  },
  --HERE GOES YOUR COMMANDS
  
}

return cfg