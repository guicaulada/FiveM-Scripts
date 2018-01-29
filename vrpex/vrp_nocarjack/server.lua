-- a basic gunshop implementation
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPncj = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
NCJclient = Tunnel.getInterface("vrp_nocarjack")
Tunnel.bindInterface("vrp_nocarjack",vRPncj)

local vehicles = {}
function vRPncj.setVehicleDoorsForEveryone(veh, doors, plate)
  if not vehicles[plate] then
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	  local user_plate = "P " .. identity.registration
	  if user_plate ~= plate then
	    local users = vRP.getUsers()
	    for k,v in pairs(users) do
          NCJclient.setVehicleDoors(v,veh, doors)
	    end
	  end
	vehicles[plate] = true
  end
end