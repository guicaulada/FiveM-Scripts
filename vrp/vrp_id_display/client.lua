vRPidd = {}
Tunnel.bindInterface("vrp_id_display",vRPidd)
users = {}
blips = {}
myteam = nil

function vRPidd.insertUser(user_id,source)
	users[user_id] = GetPlayerFromServerId(source)
end

function vRPidd.removeUser(user_id)
	users[user_id] = nil
end

function vRPidd.insertBlip(user_id,source,group,btype)
	blips[user_id] = {player = GetPlayerFromServerId(source), job = group, team = btype}
	if GetPlayerPed( blips[user_id].player ) == GetPlayerPed( -1 ) then
	  myteam = btype
	end
end

function vRPidd.removeBlip(user_id)
	local ped = GetPlayerPed(blips[user_id].player)
	local blip = GetBlipFromEntity(ped)
	RemoveBlip(blip)
	blips[user_id] = {player = nil, job = nil, team = nil}
	if ped == GetPlayerPed( -1 ) then
	  myteam = nil
	end
end

function vRPidd.getGroupColour(group)
	return cfg.blips[group].id.r, cfg.blips[group].id.g, cfg.blips[group].id.b
end

function DrawText3D(x,y,z, text, r,g,b) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function UpdateBlip(player, blip, sprite, colour, alpha)
	local blipSprite = GetBlipSprite( blip )
	HideNumberOnBlip( blip )
	if blipSprite ~= sprite then
	  SetBlipSprite( blip, sprite )
	  Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
	end
	SetBlipNameToPlayerName( blip, player )
	SetBlipScale( blip,  0.85 )
	SetBlipColour( blip, colour )
	SetBlipAlpha( blip, alpha )
end

Citizen.CreateThread(function()
    while true do
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end
        for k,v in pairs(users) do
		  if v ~= nil then
			if  ((GetPlayerPed( v ) ~= GetPlayerPed( -1 )) or cfg.showself) then -- disable your own
				x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
				x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( v ), true ) )
				distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

				if ((distance < cfg.distance)) then
					if NetworkIsPlayerTalking( v ) then
						DrawText3D(x2, y2, z2+1, k, cfg.talker.r, cfg.talker.g, cfg.talker.b) -- talker color
					elseif blips[k].team ~= nil and (blips[k].team == myteam or cfg.showteam) and not cfg.hideteam then
						DrawText3D(x2, y2, z2+1, k, cfg.blips[blips[k].job].id.r, cfg.blips[blips[k].job].id.g, cfg.blips[blips[k].job].id.b)
					else
						DrawText3D(x2, y2, z2+1, k, cfg.default.r, cfg.default.g, cfg.default.b)
					end
				end  
			end
		  end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(blips) do
		  if v.player ~= nil then
			local ped = GetPlayerPed( v.player )
		    if ((ped ~= GetPlayerPed( -1 )) or cfg.showself) then
			  local blip = GetBlipFromEntity(ped)
			  x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
			  x2, y2, z2 = table.unpack( GetEntityCoords( ped, true ) )
			  distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
			  if v.job ~= nil then
			    if cfg.blips[v.job] ~= nil then
			      if distance < cfg.blips[v.job].distance and v.team == myteam then
				    local alpha = 255 - (255*(distance/cfg.blips[v.job].distance))
			        if not DoesBlipExist( blip ) then
				      blip = AddBlipForEntity( ped )
				      UpdateBlip(v.player, blip, cfg.blips[v.job].sprite, cfg.blips[v.job].colour, alpha)
			        else
				      UpdateBlip(v.player, blip, cfg.blips[v.job].sprite, cfg.blips[v.job].colour, alpha)
			        end
			      else
			        if DoesBlipExist( blip ) then
			          RemoveBlip(blip)
				    end
		          end
				end
			  end
		    end
		  end
		end
      Citizen.Wait(0)
    end
end)