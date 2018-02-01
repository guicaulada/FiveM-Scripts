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


Citizen.CreateThread(function()



vRP.registerMenuBuilder("main", function(add, data)
  Citizen.CreateThread(function()
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
	  
      if vRP.hasPermission(user_id,lang.player.perm()) then
        choices[lang.player.button()] = ch_player_menu -- opens player submenu
      end
	  
      if vRP.hasPermission(user_id,lang.service.perm()) then
        choices[lang.service.button()] = choice_service -- toggle the receiving of missions
      end
	  
      if vRP.hasPermission(user_id,lang.loot.perm()) then
        choices[lang.loot.button()] = choice_loot -- take the items of nearest player in coma
      end
	  
      if vRP.hasPermission(user_id,lang.mugger.perm()) then
        choices[lang.mugger.button()] = ch_mug -- steal nearest player wallet
      end
	  
      if vRP.hasPermission(user_id,lang.hacker.perm()) then
        choices[lang.hacker.button()] = ch_hack --  1 in 100 chance of stealing 1% of nearest player bank
      end
	  
      if vRP.hasPermission(user_id,lang.lockpick.perm()) then
        choices[lang.lockpick.button()] = ch_lockpickveh -- opens a locked vehicle
      end	
	  
      add(choices)
    end
  end)
end)



end)