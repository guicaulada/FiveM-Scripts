vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
TSserver = Tunnel.getInterface("vrp_tattoos","vrp_tattoos")

function vRPts.cleanPlayer()
	ClearPedDecorations(GetPlayerPed(-1))
end

function vRPts.drawTattoo(tattoo,tattooshop)
  ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(tattooshop), GetHashKey(tattoo))
end