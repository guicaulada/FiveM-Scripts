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

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_holdup")

local stores = cfg.holdups

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_holdup:toofar')
AddEventHandler('es_holdup:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery was cancelled at: ^2" .. stores[robb].nameofstore)
	end
end)

RegisterServerEvent('es_holdup:playerdied')
AddEventHandler('es_holdup:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_holdup:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery was cancelled at: ^2" .. stores[robb].nameofstore)
	end
end)

RegisterServerEvent('es_holdup:rob')
AddEventHandler('es_holdup:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByPermission({cfg.permission})
  if vRP.hasPermission({user_id,cfg.permission}) then
    vRPclient.notify(player,{"~r~Cops can't rob stores."})
  else
    if #cops >= cfg.cops then
	  if stores[robb] then
		  local store = stores[robb]

		  if (os.time() - store.lastrobbed) <  cfg.seconds+cfg.cooldown and store.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'ROBBERY', {255, 0, 0}, "This has already been robbed recently. Please wait another: ^2" .. (cfg.seconds+cfg.cooldown - (os.time() - store.lastrobbed)) .. "^0 seconds.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery in progress at ^2" .. store.nameofstore)
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "You started a robbery at: ^2" .. store.nameofstore .. "^0, do not get too far away from this point!")
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "Hold the fort for ^12 ^0minutes and the money is yours!")
		  TriggerClientEvent('es_holdup:currentlyrobbing', player, robb)
		  stores[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(cfg.seconds*1000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem({user_id,"dirty_money",store.reward,true})
					  TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery is over at: ^2" .. store.nameofstore .. "^0!")
					  TriggerClientEvent('es_holdup:robberycomplete', savedSource, store.reward)
				  end
			  end
		  end)		
	  end
    else
      vRPclient.notify(player,{"~r~Not enough cops online."})
    end
  end
end)