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

local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- unfreeze on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if not first_spawn then
		local address = vRP.getUserAddress(user_id)
	    if address then 
		  SetTimeout(5000,function()
		    vRP.accessHome(user_id, address.home, address.number)
		  end)
	    end
	end
end)
