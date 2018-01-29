
vRPcmd = {}
Tunnel.bindInterface("vrp_cmds",vRPcmd)
vRPserver = Tunnel.getInterface("vRP","vrp_cmds")
CMDserver = Tunnel.getInterface("vrp_cmds","vrp_cmds")
vRP = Proxy.getInterface("vRP")

function vRPcmd.getPlayerPosH()
	x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local h = GetEntityHeading(GetPlayerPed(-1))
	return x , y , z , h
end

function vRPcmd.teleport(x,y,z,h)
	vRP.unjail({}) -- force unjail before a teleportation
    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001, 1,0,0,1)
	SetEntityHeading(GetPlayerPed(-1), h+0.0001)
    vRPserver.updatePos({x+0.0001, y+0.0001, z+0.0001})
end