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

-- this module make paycheck and bill to pay for users who have group permission

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local cfg = module("vrp_paycheck", "cfg/paycheck")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

function paycheck_giver()
  for k,v in pairs(cfg.paycheck) do
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
	  local paycheck = v
      local player = vRP.getUserSource(user_id)
	  if cfg.bank then
		vRP.giveBankMoney(user_id,paycheck)
	  else
		vRP.giveMoney(user_id,paycheck)
	  end	
	  vRPclient.notifyPicture(player,cfg.paycheck_picture, 9, cfg.paycheck_title_picture, false, cfg.message_paycheck..paycheck..cfg.post)
	end	
  end
  SetTimeout(1000*60*cfg.minutes_paycheck, function()
	paycheck_giver()
  end)
end

Citizen.CreateThread(function()
  paycheck_giver()
end)

function paycheck_taker()
  for k,v in pairs(cfg.bill) do
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
	  local bill = v
      local player = vRP.getUserSource(user_id)
	  local money = vRP.getBankMoney(user_id)
	  if cfg.bank then
		vRP.setBankMoney(user_id,money-bill)
	  else
		vRP.tryPayment(user_id,bill)
	  end	
	  vRPclient.notifyPicture(player,cfg.bill_picture, 9, cfg.bill_title_picture, false, cfg.message_bill..bill..cfg.post)
	end	
  end
  SetTimeout(1000*60*cfg.minutes_bill, function()
	paycheck_taker()
  end)
end

Citizen.CreateThread(function()
  paycheck_taker()
end)