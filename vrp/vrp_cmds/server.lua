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

local cfg = module("vrp_cmds", "cfg/commands")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPcmd = {}
vRP = Proxy.getInterface("vRP")
vRPidd = Proxy.getInterface("vrp_id_display")
vRPclient = Tunnel.getInterface("vRP","vrp_cmds")
CMDclient = Tunnel.getInterface("vrp_cmds","vrp_cmds")
IDDclient = Tunnel.getInterface("vrp_id_display","vrp_cmds")
Tunnel.bindInterface("vrp_cmds",vRPcmd)

AddEventHandler("chatMessage", function(p, color, msg)
    if msg:sub(1, 1) == "/" then
        text = splitString(msg, " ")
        cmd = text[1]
		args = text[2]
		for k,v in ipairs(text) do
          if k > 2 then
		    args = args.." "..v
          end
		end
		for k,v in pairs(cfg.commands) do
          if cmd == k then
		    v.action(p,color,args)
        	CancelEvent()
          end
		end
    end
end)

-- add tp areas areas on player first spawn
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    vRP.getSData({"vRP:cmd:teleports",function(teleports)
      local tps = json.decode(teleports)
	  if tps == nil then
		tps = {}
	  end
      for k,v in pairs(tps) do
		if v.active then
			vRPcmd.setTpIn(source,k,v.pos_in.x,v.pos_in.y,v.pos_in.z,v.pos_in.h,v.pos_out.x,v.pos_out.y,v.pos_out.z,v.pos_out.h)
			vRPcmd.setTpOut(source,k,v.pos_in.x,v.pos_in.y,v.pos_in.z,v.pos_in.h,v.pos_out.x,v.pos_out.y,v.pos_out.z,v.pos_out.h)
		end
      end
    end})
  end
end)

function vRPcmd.setTpIn(user,name,pos_in_x,pos_in_y,pos_in_z,pos_in_h,pos_out_x,pos_out_y,pos_out_z,pos_out_h)
	vRP.setArea({user,"vRP:cmd:tp:in:"..name,pos_in_x,pos_in_y,pos_in_z,1,1.5,function(player, area)
		CMDclient.teleport(player,{pos_out_x,pos_out_y,pos_out_z,pos_out_h})
		vRPclient.removeNamedMarker(player,{"vRP:cmd:tp:out:"..name})
		vRP.removeArea({player,"vRP:cmd:tp:out:"..name})
		SetTimeout(5000,function() 
		  vRPcmd.setTpOut(player,name,pos_in_x,pos_in_y,pos_in_z,pos_in_h,pos_out_x,pos_out_y,pos_out_z,pos_out_h)
		end)
	end,nil})
	vRPclient.setNamedMarker(user,{"vRP:cmd:tp:in:"..name, pos_in_x,pos_in_y,pos_in_z-1,0.7,0.7,0.5,255,226,0,125,150})
end

function vRPcmd.setTpOut(user,name,pos_in_x,pos_in_y,pos_in_z,pos_in_h,pos_out_x,pos_out_y,pos_out_z,pos_out_h)
	vRP.setArea({user,"vRP:cmd:tp:out:"..name,pos_out_x,pos_out_y,pos_out_z,1,1.5,function(player, area)
		CMDclient.teleport(player,{pos_in_x,pos_in_y,pos_in_z,pos_in_h})
		vRPclient.removeNamedMarker(player,{"vRP:cmd:tp:in:"..name})
		vRP.removeArea({player,"vRP:cmd:tp:in:"..name})
		SetTimeout(5000,function() 
		  vRPcmd.setTpIn(player,name,pos_in_x,pos_in_y,pos_in_z,pos_in_h,pos_out_x,pos_out_y,pos_out_z,pos_out_h)
		end)
	end,nil})
	vRPclient.setNamedMarker(user,{"vRP:cmd:tp:out:"..name, pos_out_x,pos_out_y,pos_out_z-1,0.7,0.7,0.5,255,226,0,125,150})
end