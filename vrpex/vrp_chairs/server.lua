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