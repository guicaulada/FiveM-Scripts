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

ch_player_menu = {function(player,choice)
  Citizen.CreateThread(function()
	local user_id = vRP.getUserId(player)
	local menu = {}
	menu.name = lang.player.button()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
	
    if vRP.hasPermission(user_id,lang.money.store.perm()) then
      menu[lang.money.store.button()] = choice_store_money -- transforms money in wallet to money in inventory to be stored in houses and cars
    end
	
    if vRP.hasPermission(user_id,lang.fixhaircut.perm()) then
      menu[lang.fixhaircut.button()] = ch_fixhair -- just a work around for barbershop green hair bug while I am busy
    end
	
    if vRP.hasPermission(user_id,lang.userlist.perm()) then
      menu[lang.userlist.button()] = ch_userlist -- a user list for players with vRP ids, player name and identity names only.
    end
	
    if vRP.hasPermission(user_id,lang.weapons.store.perm()) then
      menu[lang.weapons.store.button()] = choice_store_weapons -- store player weapons, like police store weapons from vrp
    end
	
    if vRP.hasPermission(user_id,lang.bodyarmor.store.perm()) then
      menu[lang.bodyarmor.store.button()] = choice_store_armor -- store player armor
    end
	
    if vRP.hasPermission(user_id,lang.inspect.perm()) then
      menu[lang.inspect.button()] = choice_player_check -- checks nearest player inventory, like police check from vrp
    end
	
	vRP.openMenu(player, menu)
  end)
end, lang.player.desc()}