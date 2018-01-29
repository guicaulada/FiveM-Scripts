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