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

--[[BASE]]--
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_dmvschool")

--[[LANG]]--
local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

--[[SQL]]--
MySQL.createCommand("vRP/dmv_column", "ALTER TABLE vrp_users ADD IF NOT EXISTS DmvTest varchar(50) NOT NULL default 'Required'")
MySQL.createCommand("vRP/dmv_success", "UPDATE vrp_users SET DmvTest='Passed' WHERE id = @id")
MySQL.createCommand("vRP/dmv_search", "SELECT * FROM vrp_users WHERE id = @id AND DmvTest = 'Passed'")

-- init
MySQL.query("vRP/dmv_column")

--[[DMV Test]]--

RegisterServerEvent("dmv:success")
AddEventHandler("dmv:success", function()
	local user_id = vRP.getUserId({source})
	MySQL.query("vRP/dmv_success", {id = user_id})
end)

RegisterServerEvent("dmv:ttcharge")
AddEventHandler("dmv:ttcharge", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryPayment({user_id,200}) then
        TriggerClientEvent('dmv:startttest',player)
	else
		vRPclient.notify(player,{"~r~Not enough money."})
	end
end)

RegisterServerEvent("dmv:ptcharge")
AddEventHandler("dmv:ptcharge", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryPayment({user_id,500}) then
        TriggerClientEvent('dmv:startptest',player)
	else
		vRPclient.notify(player,{"~r~Not enough money."})
	end
end)

--[[ ***** SPAWN CHECK ***** ]]
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
  if user_id then
	MySQL.query("vRP/dmv_search", {id = user_id}, function(rows, affected)
      if #rows > 0 then
          TriggerClientEvent('dmv:CheckLicStatus',source)
      end
    end)
  end
end)

--[[POLICE MENU]]--
local choice_asklc = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking license..."})
      vRP.request({nplayer,"Do you want to show your license ?",15,function(nplayer,ok)
        if ok then
          MySQL.query("vRP/dmv_search", {id = nuser_id}, function(rows, affected)
            if #rows > 0 then
			  vRPclient.notify(player,{"User license: ~g~OK"})
			else
			  vRPclient.notify(player,{"User license: ~r~REQUIRED"})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Check license from the nearest player."}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    -- build police menu
    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Check license"] = choice_asklc
    end
	
    add(choices)
  end
end})