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


unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource(tonumber(target_id))
  local users = vRP.getUsers()
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  vRPclient.notify(target, lang.jail.timer({timer}))
      vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(timer))
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger(tonumber(target_id), 0)
		vRP.setThirst(tonumber(target_id), 0)
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,false,true,true)
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,false,false,false)
	  end)
	  vRPclient.teleport(target,425.7607421875,-978.73425292969,30.709615707397) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,false)
      vRPclient.notify(target,lang.jail.free())
	  vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(-1))
    end
  end
end

-- (server) called when a logged player spawn to check for vRP:jail in user_data
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
  local target = vRP.getUserSource(user_id)
  SetTimeout(35000,function()
    local custom = {}
    local value = vRP.getUData(user_id,"vRP:jail:time")
	  if value ~= nil then
	    custom = json.decode(value)
	    if custom ~= nil then
		  if tonumber(custom) > 0 then
			BMclient.loadFreeze(target,false,true,true)
			SetTimeout(15000,function()
			  BMclient.loadFreeze(target,false,false,false)
			end)
            vRPclient.setHandcuffed(target,true)
            vRPclient.teleport(target,1641.5477294922,2570.4819335938,45.564788818359) -- teleport inside jail
            vRPclient.notify(target,lang.jail.resent())
			vRP.setHunger(tonumber(user_id),0)
			vRP.setThirst(tonumber(user_id),0)
			local target_id = lang.jail.rejailer()
			vRPbm.logInfoToFile(lang.jail.file(),lang.jail.log({user_id,target_id,custom}))
		    jail_clock(tonumber(user_id),tonumber(custom))
		  end
	    end
	  end
  end)
end)