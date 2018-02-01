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

spikes = {}
ch_spikes = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local closeby = BMclient.isCloseToSpikes(player)
	if closeby and (spikes[player] or vRP.hasPermission(user_id,lang.spikes.admin())) then
	  BMclient.removeSpikes(player)
	  spikes[player] = false
	elseif closeby and not spikes[player] and not vRP.hasPermission(user_id,lang.spikes.admin()) then
	  vRPclient.notify(player,lang.spikes.nocarry())
	elseif not closeby and spikes[player] and not vRP.hasPermission(user_id,lang.spikes.admin()) then
	  vRPclient.notify(player,lang.spikes.nodeploy())
	elseif not closeby and (not spikes[player] or vRP.hasPermission(user_id,lang.spikes.admin())) then
	  BMclient.setSpikesOnGround(player)
	  spikes[player] = true
	end
end, lang.spikes.desc()}

-- drag player
ch_drag = {function(player,choice)
  -- get nearest player
  local nplayer = vRPclient.getNearestPlayer(player,5)
  if nplayer then
    local handcuffed = vRPclient.isHandcuffed(nplayer)
    if handcuffed then
    	BMclient.policeDrag(nplayer, player)
    else
    	vRPclient.notify(player,lang.police.not_handcuffed())
    end
  else
    vRPclient.notify(player,lang.common.no_player_near())
  end
end, lang.drag.desc()}

-- dynamic jail
ch_jail = {function(player,choice) 
    local nplayers = vRPclient.getNearestPlayers(player,15) 
	local user_list = ""
    for k,v in pairs(nplayers) do
	  user_list = user_list .. lang.userlist.format({vRP.getUserId(k),GetPlayerName(k)})
    end 
	if user_list ~= "" then
	  local target_id = vRP.prompt(player,lang.userlist.nearby({user_list}),"") 
	    if target_id ~= nil and target_id ~= "" then 
	      local jail_time = vRP.prompt(player,lang.jail.prompt(),"")
			if jail_time ~= nil and jail_time ~= "" then 
	          local target = vRP.getUserSource(tonumber(target_id))
			  if target ~= nil then
		        if tonumber(jail_time) > 30 then
  			      jail_time = 30
		        end
		        if tonumber(jail_time) < 1 then
		          jail_time = 1
		        end
		  
                local handcuffed = vRPclient.isHandcuffed(target)  
                  if handcuffed then 
					BMclient.loadFreeze(target,false,true,true)
					SetTimeout(15000,function()
					  BMclient.loadFreeze(target,false,false,false)
					end)
				    vRPclient.teleport(target,1641.5477294922,2570.4819335938,45.564788818359) -- teleport to inside jail
				    vRPclient.notify(target,lang.jail.sent.bad())
				    vRPclient.notify(player,lang.jail.sent.good())
				    vRP.setHunger(tonumber(target_id),0)
				    vRP.setThirst(tonumber(target_id),0)
				    jail_clock(tonumber(target_id),tonumber(jail_time))
					local user_id = vRP.getUserId(player)
					vRPbm.logInfoToFile(lang.jail.file(),lang.jail.log({user_id,target_id,jail_time}))
			      else
				    vRPclient.notify(player,lang.police.not_handcuffed())
			      end
			  else
				vRPclient.notify(player,lang.common.invalid_value())
			  end
			else
			  vRPclient.notify(player,lang.common.invalid_value())
			end
        else
          vRPclient.notify(player,lang.common.invalid_value())
        end 
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end 
end,lang.jail.desc()}

-- dynamic unjail
ch_unjail = {function(player,choice) 
	local target_id = vRP.prompt(player,lang.unjail.prompt(),"") 
	  if target_id ~= nil and target_id ~= "" then 
		local value = vRP.getUData(tonumber(target_id),"vRP:jail:time")
		  if value ~= nil then
		    custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId(player)
			  if tonumber(custom) > 0 or vRP.hasPermission(user_id,lang.unjail.admin()) then
	            local target = vRP.getUserSource(tonumber(target_id))
				if target ~= nil then
	              unjailed[target] = tonumber(target_id)
				  vRPclient.notify(player,lang.unjail.released())
				  vRPclient.notify(target,lang.unjail.lowered())
				  vRPbm.logInfoToFile(lang.unjail.file(),lang.unjail.log({user_id,target_id,custom}))
				else
				  vRPclient.notify(player,lang.common.invalid_value())
				end
			  else
				vRPclient.notify(player,lang.common.invalid_value())
			  end
			end
		  end
      else
        vRPclient.notify(player,lang.common.invalid_value())
      end 
end,lang.unjail.desc()}

-- dynamic fine
ch_fine = {function(player,choice) 
    local nplayers = vRPclient.getNearestPlayers(player,15) 
	local user_list = ""
    for k,v in pairs(nplayers) do
	  user_list = user_list .. lang.userlist.format({vRP.getUserId(k),GetPlayerName(k)})
    end 
	if user_list ~= "" then
	  local target_id = vRP.prompt(player,lang.userlist.nearby({user_list}),"") 
	    if target_id ~= nil and target_id ~= "" then 
	      local fine = vRP.prompt(player,lang.fine.prompt.amount(),"")
			if fine ~= nil and fine ~= "" then 
	          local reason = vRP.prompt(player,lang.fine.prompt.reason(),"")
			    if reason ~= nil and reason ~= "" then 
	              local target = vRP.getUserSource(tonumber(target_id))
				  if target ~= nil then
		            if tonumber(fine) > 1000 then
  			          fine = 1000
		            end
		            if tonumber(fine) < 100 then
		              fine = 100
		            end
			  
		            if vRP.tryFullPayment(tonumber(target_id), tonumber(fine)) then
                      vRP.insertPoliceRecord(tonumber(target_id), lang.police.menu.fine.record({reason,fine}))
                      vRPclient.notify(player,lang.police.menu.fine.fined({reason,fine}))
                      vRPclient.notify(target,lang.police.menu.fine.notify_fined({reason,fine}))
					  local user_id = vRP.getUserId(player)
					  vRPbm.logInfoToFile(lang.fine.file(),lang.fine.log({user_id,target_id,custom,reason}))
                      vRP.closeMenu(player)
                    else
                      vRPclient.notify(player,lang.money.not_enough())
                    end
				  else
					vRPclient.notify(player,lang.common.invalid_value())
				  end
				else
				  vRPclient.notify(player,lang.common.invalid_value())
				end
			else
			  vRPclient.notify(player,lang.common.invalid_value())
			end
        else
          vRPclient.notify(player,lang.common.invalid_value())
        end 
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end 
end,lang.fine.desc()}

-- improved handcuff
ch_handcuff = {function(player,choice)
    local nplayer = vRPclient.getNearestPlayer(player,10)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.toggleHandcuff(nplayer)
	  local user_id = vRP.getUserId(player)
	  vRPbm.logInfoToFile(lang.cuff.file(),lang.cuff.log({user_id,nuser_id}))
      vRP.closeMenu(nplayer)
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end
end,lang.police.menu.handcuff.description()}

-- dynamic freeze
ch_freeze = {function(player,choice) 
	local user_id = vRP.getUserId(player)
	if vRP.hasPermission(user_id,lang.freeze.admin()) then
	  local target_id = vRP.prompt(player,lang.freeze.prompt(),"") 
	    if target_id ~= nil and target_id ~= "" then 
	      local target = vRP.getUserSource(tonumber(target_id))
		  if target ~= nil then
		    vRPclient.notify(player,lang.freeze.notify())
		    BMclient.loadFreeze(target,true,true,true)
		  else
			vRPclient.notify(player,lang.common.invalid_value())
		  end
        else
		  vRPclient.notify(player,lang.common.invalid_value())
        end 
	else
	  local nplayer = vRPclient.getNearestPlayer(player,10)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
		  vRPclient.notify(player,lang.freeze.notify())
		  BMclient.loadFreeze(nplayer,true,false,false)
        else
          vRPclient.notify(player,lang.common.no_player_near())
        end
	end
end,lang.freeze.desc()}