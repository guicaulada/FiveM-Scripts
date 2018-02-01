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



-- armor item
vRP.defInventoryItem(lang.bodyarmor.id(),lang.bodyarmor.name(),lang.bodyarmor.desc(),
function(args)
  local choices = {}

  choices[lang.bodyarmor.equip()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, lang.bodyarmor.id(), 1, true) then
		BMclient.setArmour(player,100,true)
        vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,
5.0)

-- lockpicking item
vRP.defInventoryItem(lang.lockpick.id(),lang.lockpick.name(),lang.lockpick.desc(), -- add it for sale to vrp/cfg/markets.lua if you want to use it
function(args)
  local choices = {}

  choices[lang.lockpick.button()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, lang.lockpick.id(), 1, true) then
		BMclient.lockpickVehicle(player,20,true) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
        vRP.closeMenu(player)
      end
    end
  end,lang.lockpick.desc()}

  return choices
end,
0.75)



end)