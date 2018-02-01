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

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
cfg = module("vrp_robbery", "cfg/robbery")
vRProb = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_robbery",vRProb)
Proxy.addInterface("vrp_robbery",vRProb)
ROBclient = Tunnel.getInterface("vrp_robbery")

-- LANG
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(cfg.lang, module("vrp", "cfg/lang/"..cfg.lang) or {})
Lang:loadLocale(cfg.lang, module("vrp_robbery", "cfg/lang/"..cfg.lang) or {})
lang = Lang.lang[cfg.lang]

robbers = {}
lastrobbed = {}

function vRProb.cancelRobbery(robb)
	if(robbers[source])then
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, lang.title.news(), {255, 0, 0}, lang.robbery.canceled({cfg.robbery[robb].name}))
	end
end

function vRProb.startRobbery(robb)
  local canceled = false
  local player = source
  local user_id = vRP.getUserId(player)
  local cops = vRP.getUsersByPermission(cfg.cops)
  local robbery = cfg.robbery[robb]
  if vRP.hasPermission(user_id,cfg.cops) then
  	ROBclient.robberyComplete(player)
    vRPclient.notify(player,lang.cops.cant_rob())
  else
    if robbery then
	  if #cops >= robbery.cops then
		if lastrobbed[robb] then
		  local past = os.time() - lastrobbed[robb]
		  local wait = robbery.rob + robbery.wait
		  if past <  wait then
			ROBclient.robberyComplete(player)
		    TriggerClientEvent('chatMessage', player, lang.title.robbery(), {255, 0, 0}, lang.robbery.wait({wait - past}))
			canceled = true
		  end
		end
		if not canceled then
		  TriggerClientEvent('chatMessage', -1, lang.title.news(), {255, 0, 0}, lang.robbery.progress({robbery.name}))
		  TriggerClientEvent('chatMessage', player, lang.title.system(), {255, 0, 0}, lang.robbery.started({robbery.name}))
		  TriggerClientEvent('chatMessage', player, lang.title.system(), {255, 0, 0}, lang.robbery.hold({math.ceil(robbery.rob/60)}))
		  lastrobbed[robb] = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(robbery.rob*1000, function()
			if(robbers[savedSource])then
			  if(user_id)then
				local reward = math.random(robbery.min,robbery.max)
				vRP.giveInventoryItem(user_id,"dirty_money",reward,true)
				TriggerClientEvent('chatMessage', -1, lang.title.news(), {255, 0, 0}, lang.robbery.over({robbery.name}))
				TriggerClientEvent('chatMessage', savedSource, lang.title.system(), {255, 0, 0}, lang.robbery.done({reward}))
				ROBclient.robberyComplete(savedSource)
			  end
			end
		  end)
		end
      else
		ROBclient.robberyComplete(player)
        vRPclient.notify(player,lang.cops.not_enough({robbery.cops}))
      end
    end
  end
end