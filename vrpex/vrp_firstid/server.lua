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

MySQL = module("vrp_mysql", "MySQL")
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPl = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Lclient = Tunnel.getInterface("vrp_firstid")
Tunnel.bindInterface("vrp_firstid",vRPl)
Proxy.addInterface("vrp_firstid",vRPl)

function vRPl.setIdentity(data)
	if data then
	  local user_id = vRP.getUserId(source)
      local registration = vRP.generateRegistrationNumber()
      local phone = vRP.generatePhoneNumber()
	  local firstname = data.last
	  local name = data.first
	  local age = data.age
	  vRP.setUData(user_id,"vRP:firstid",json.encode(os.date("%x")))
      MySQL.execute("vRP/update_user_identity", {
        user_id = user_id,
        firstname = firstname,
        name = name,
        age = age,
        registration = registration,
        phone = phone
      })
	  vRPclient.setRegistrationNumber(source,registration)
	end
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
  if first_spawn then
	local user_id = vRP.getUserId(source)
	local data = vRP.getUData(user_id,"vRP:firstid")
	if not data then
      Lclient.openForm(source)
	else
	  local ldate = json.decode(data)
	  if not ldate then
        Lclient.openForm(source)
	  end
	end
  end
end)