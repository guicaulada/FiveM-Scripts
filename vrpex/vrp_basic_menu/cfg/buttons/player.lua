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


-- fix barbershop green hair for now
ch_fixhair = {function(player,choice)
    local custom = {}
    local user_id = vRP.getUserId(player)
    local value = vRP.getUData(user_id,"vRP:head:overlay")
	if value ~= nil then
	  custom = json.decode(value)
      BSclient.setOverlay(player,custom,true)
	end
end, lang.fixhaircut.desc()}

-- store armor
choice_store_armor = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local armour = BMclient.getArmour(player)
      if armour > 95 then
        vRP.giveInventoryItem(user_id, lang.bodyarmor.id(), 1, true)
        -- clear armor
	    BMclient.setArmour(player,0,false)
	  else
	    vRPclient.notify(player, lang.bodyarmor.damaged())
      end
  end
end, lang.bodyarmor.store.desc()}

--store money
choice_store_money = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local amount = vRP.getMoney(user_id)
    if vRP.tryPayment(user_id, amount) then -- unpack the money
      vRP.giveInventoryItem(user_id, "money", amount, true)
    end
  end
end, lang.money.store.desc()}

-- player check
choice_player_check = {function(player,choice)
    local nplayer = vRPclient.getNearestPlayer(player,5)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.notify(nplayer,lang.police.menu.check.checked())
      local weapons = vRPclient.getWeapons(nplayer)
        -- prepare display data (money, items, weapons)
        local money = vRP.getMoney(nuser_id)
        local items = ""
        local data = vRP.getUserDataTable(nuser_id)
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item_name = vRP.getItemName(k)
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info}))
        -- request to hide div
        local ok = vRP.request(player, lang.police.menu.check.request_hide(), 1000)
        vRPclient.removeDiv(player,"police_check")
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end
end, lang.inspect.desc()}

-- player store weapons
choice_store_weapons = {function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local weapons = vRPclient.getWeapons(player)
      for k,v in pairs(weapons) do
        -- convert weapons to parametric weapon items
        vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
        if v.ammo > 0 then
          vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
        end
      end

      -- clear all weapons
      vRPclient.giveWeapons(player,{},true)
    end
end, lang.weapons.store.desc()}

player_lists = {}
ch_userlist = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if player_lists[player] then -- hide
      player_lists[player] = nil
      vRPclient.removeDiv(player,"user_list")
    else -- show
      local content = "<span class=\"id\">"..lang.userlist.id().."</span><span class=\"pseudo\">"..lang.userlist.nickname().."</span><span class=\"name\">"..lang.userlist.rpname().."</span><span class=\"job\">"..lang.userlist.job().."</span>"
      local count = 0
	  local users = vRP.getUsers()
      for k,v in pairs(users) do
        count = count+1
        local source = vRP.getUserSource(k)
        local identity = vRP.getUserIdentity(k)
		  if source ~= nil then
            content = content.."<br /><span class=\"id\">"..k.."</span><span class=\"pseudo\">"..vRP.getPlayerName(source).."</span>"
            if identity then
              content = content.."<span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span><span class=\"job\">"..vRP.getUserGroupByType(k,"job").."</span>"
            end
          end
		  
          -- check end
          count = count-1
          if count == 0 then
            player_lists[player] = true
            local css = [[
              .div_user_list{ 
                margin: auto; 
				text-align: left;
                padding: 8px; 
                width: 650px; 
                margin-top: 100px; 
                background: rgba(50,50,50,0.0); 
                color: white; 
                font-weight: bold; 
                font-size: 1.1em;
              } 
              .div_user_list span{ 
				display: inline-block;
				text-align: center;
              } 
              .div_user_list .id{ 
                color: rgb(255, 255, 255);
                width: 45px; 
              }
              .div_user_list .pseudo{ 
                color: rgb(66, 244, 107);
                width: 145px; 
              }
              .div_user_list .name{ 
                color: rgb(92, 170, 249);
                width: 295px; 
              }
			  .div_user_list .job{ 
                color: rgb(247, 193, 93);
                width: 145px; 
			  }
            ]]
            vRPclient.setDiv(player,"user_list", css, content)
          end
      end
    end
  end
end, lang.userlist.desc()}