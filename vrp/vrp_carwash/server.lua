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

--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_carwash")

RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function(dirt)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if parseFloat(dirt) > parseFloat(1.0) then
	  if vRP.tryPayment({user_id,25}) then
		TriggerClientEvent('carwash:success', player)
	  else
		TriggerClientEvent('carwash:notenough', player)
	  end	
	else
	  TriggerClientEvent('carwash:alreadyclean', player)
	end
end)
