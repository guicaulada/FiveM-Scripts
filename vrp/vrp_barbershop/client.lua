--[[Proxy/Tunnel]]--

vRPbsT = {}
Tunnel.bindInterface("vRP_barbershop",vRPbsT)
Proxy.addInterface("vRP_barbershop",vRPbsT)
vRPbsS = Tunnel.getInterface("vRP_barbershop","vRP_barbershop")
vRP = Proxy.getInterface("vRP")

function vRPbsT.setOverlay(custom,spawn)
  if custom then
    local ped = GetPlayerPed(-1)
    if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) or (GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then -- check for mp model
	  if spawn then
	    SetPedHeadBlendData(ped,custom["-1"][1],custom["-1"][1],custom["-1"][1],custom["-1"][1],custom["-1"][2],custom["-1"][3],1.0,0.0,0.0,false)
	  end
      -- parts
      for k,v in pairs(custom) do
	    if tonumber(k) == 12 then 
	      SetPedComponentVariation(ped, 2, v[1], 0, 1) 
		  SetPedHairColor(ped, v[3], v[3])
	    elseif tonumber(k) == -1 then 
		  SetPedHeadBlendData(ped,v[1],v[1],v[1],v[1],v[2],v[3],1.0,0.0,0.0,false)
	    else
	      SetPedHeadOverlay(ped, tonumber(k), v[1], 1.0)
	      SetPedHeadOverlayColor(ped, tonumber(k), v[2], v[3], v[3])
	    end
	  end
      vRPbsS.updateOverlay({custom})
	else
	  vRP.notify({"~r~You can only modify the MP model."}) -- message from check
    end
  end
end
-- SetPedHeadBlendData(GetPlayerPed(-1),12,12,12,12,0,2,1.0,0.0,0.0,false) -- Face {12,0,2}

function vRPbsT.getDrawables(part)
  if part == 12 then
    return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),2))
  elseif part == -1 then
    return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),0))
  else
    return tonumber(GetNumHeadOverlayValues(part))
  end
end

function vRPbsT.getTextures()
    return tonumber(GetNumHairColors())
end