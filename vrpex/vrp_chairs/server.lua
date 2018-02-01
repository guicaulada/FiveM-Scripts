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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPch = {}
Tunnel.bindInterface("vrp_chairs",vRPch)
local occupied = {}

function vRPch.occupyObj(object)
	table.insert(occupied, object)
end

function vRPch.unoccupyObj(object)
	for k,v in pairs(occupied) do
		if v == object then
			table.remove(occupied, k)
		end
	end
end


function vRPch.getOccupied()
	return occupied
end