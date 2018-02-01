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

-- TO USE THIS FUNCTION YOU NEED TO HAVE THE ORIGINAL vRP UPDATED TO THE LASTEST VERSION
Citizen.CreateThread(function()



vRP.registerMenuBuilder("phone", function(add) -- phone menu is created on server start, so it has no permissions.
  Citizen.CreateThread(function()
    local choices = {} -- Comment the choices you want to disable by adding -- in front of them.
	
    choices[lang.mpay.button()] = ch_mobilepay -- transfer money through phone
    choices[lang.mcharge.button()] = ch_mobilecharge -- charge money through phone
	
    add(choices)
  end)
end)



end)