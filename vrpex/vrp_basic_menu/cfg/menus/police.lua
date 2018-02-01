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



vRP.registerMenuBuilder("police", function(add, data)
  Citizen.CreateThread(function()
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
	  
	  if vRP.hasPermission(user_id,lang.jail.perm()) then
        choices[lang.jail.button()] = ch_jail -- Send a nearby handcuffed player to jail with prompt for choice and user_list
      end
	  
	  if vRP.hasPermission(user_id,lang.unjail.perm()) then
        choices[lang.unjail.button()] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
      end
	  
	  if vRP.hasPermission(user_id,lang.fine.perm()) then
        choices[lang.fine.button()] = ch_fine -- Fines closeby player
      end
	  
	  if vRP.hasPermission(user_id,lang.cuff.perm()) then
        choices[lang.cuff.button()] = ch_handcuff -- Toggle cuffs AND CLOSE MENU for nearby player
      end
	  
	  if vRP.hasPermission(user_id,lang.spikes.perm()) then
        choices[lang.spikes.button()] = ch_spikes -- Toggle spikes
      end
	  
      if vRP.hasPermission(user_id,lang.drag.perm()) then
        choices[lang.drag.button()] = ch_drag -- Drags closest handcuffed player
      end
	  
	  if vRP.hasPermission(user_id,lang.freeze.perm()) then
        choices[lang.freeze.button()] = ch_freeze -- Toggle freeze
      end
	  
      add(choices)
    end
  end)
end)



end)