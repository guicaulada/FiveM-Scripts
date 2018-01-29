
vRPcw = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

Tunnel.bindInterface("vrp_carwash",vRPcw)
Proxy.addInterface("vrp_carwash",vRPcw)
vRP = Proxy.getInterface("vRP")

function vRPcw.cleanVehicle()
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false), 0.0)
	SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
end

function vRPcw.getDirtLevel()
	return GetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false))
end

function vRPcw.isInAnyVehicle()
  local veh = GetVehiclePedIsIn(GetPlayerPed(-1))  -- pega o veiculo
  if veh then  -- se tiver em veiculo
    local driver = GetPedInVehicleSeat(veh, -1) -- pega o motorista do vieculo
    if driver == GetPlayerPed(-1) then  -- se o motorista for o meu ped
      return true
    end
  end
  return false
end