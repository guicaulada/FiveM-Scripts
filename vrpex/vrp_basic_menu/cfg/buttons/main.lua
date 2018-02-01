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


--toggle service
choice_service = {function(player,choice)
    local user_id = vRP.getUserId(player)
    local service = lang.service.group()
    if user_id ~= nil then
      if vRP.hasGroup(user_id,service) then
	    vRP.removeUserGroup(user_id,service)
	    if vRP.hasMission(player) then
		  vRP.stopMission(player)
	    end
        vRPclient.notify(player,lang.service.off())
	  else
	    vRP.addUserGroup(user_id,service)
        vRPclient.notify(player,lang.service.on())
	  end
    end
end, lang.service.desc()}

--loot corpse
choice_loot = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local nplayer = vRPclient.getNearestPlayer(player,10)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        local in_coma = vRPclient.isInComa(nplayer)
          if in_coma then
			local revive_seq = {
			  {"amb@medic@standing@kneel@enter","enter",1},
			  {"amb@medic@standing@kneel@idle_a","idle_a",1},
			  {"amb@medic@standing@kneel@exit","exit",1}
			}
  			vRPclient.playAnim(player,false,revive_seq,false) -- anim
            SetTimeout(15000, function()
              local ndata = vRP.getUserDataTable(nuser_id)
              if ndata ~= nil then
			    if ndata.inventory ~= nil then -- gives inventory items
				  vRP.clearInventory(nuser_id)
                  for k,v in pairs(ndata.inventory) do 
			        vRP.giveInventoryItem(user_id,k,v.amount,true)
	              end
				end
			  end
			  local nmoney = vRP.getMoney(nuser_id)
			  if vRP.tryPayment(nuser_id,nmoney) then
			    vRP.giveMoney(user_id,nmoney)
			  end
            end)
			vRPclient.stopAnim(player,false)
          else
            vRPclient.notify(player,lang.emergency.menu.revive.not_in_coma())
          end
      else
        vRPclient.notify(player,lang.common.no_player_near())
      end
    end
end,lang.loot.desc()}

-- hack player
ch_hack = {function(player,choice)
  -- get nearest player
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local nplayer = vRPclient.getNearestPlayer(player,25)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
		  local nbank = vRP.getBankMoney(nuser_id)
          local amount = math.floor(nbank*0.01)
		  local nvalue = nbank - amount
		  if math.random(1,100) == 1 then
			vRP.setBankMoney(nuser_id,nvalue)
            vRPclient.notify(nplayer,lang.hacker.hacked({amount}))
		    vRP.giveInventoryItem(user_id,"dirty_money",amount,true)
		  else
            vRPclient.notify(nplayer,lang.hacker.failed.good())
            vRPclient.notify(player,lang.hacker.failed.bad())
		  end
        else
          vRPclient.notify(player,lang.common.no_player_near())
        end
      else
        vRPclient.notify(player,lang.common.no_player_near())
      end
    end
end,lang.hacker.desc()}

-- mug player
ch_mug = {function(player,choice)
    -- get nearest player
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local nplayer = vRPclient.getNearestPlayer(player,10)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
		  local nmoney = vRP.getMoney(nuser_id)
          local amount = nmoney
		  if math.random(1,3) == 1 then
            if vRP.tryPayment(nuser_id,amount) then
              vRPclient.notify(nplayer,lang.mugger.mugged({amount}))
		      vRP.giveInventoryItem(user_id,"dirty_money",amount,true)
            else
              vRPclient.notify(player,lang.money.not_enough())
            end
		  else
            vRPclient.notify(nplayer,lang.mugger.failed.good())
            vRPclient.notify(player,lang.mugger.failed.bad())
		  end
        else
          vRPclient.notify(player,lang.common.no_player_near())
        end
      else
        vRPclient.notify(player,lang.common.no_player_near())
      end
    end
end, lang.mugger.desc()}

-- lockpick vehicle
ch_lockpickveh = {function(player,choice) 
	BMclient.lockpickVehicle(player,20,true) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
end,lang.lockpick.desc()}