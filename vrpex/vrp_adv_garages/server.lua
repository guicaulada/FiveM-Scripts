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

-- vRP TUNNEL/PROXY
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPg = {}
Tunnel.bindInterface("vrp_adv_garages",vRPg)
Proxy.addInterface("vrp_adv_garages",vRPg)
Gclient = Tunnel.getInterface("vrp_adv_garages")

-- MYSQL
MySQL.createCommand("vRP/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @tuser_id WHERE user_id = @user_id AND vehicle = @vehicle")

-- CFG
local cfg = module("vrp_adv_garages", "cfg/garages")
local cfg_inventory = module("vrp","cfg/inventory")

-- LANG
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(cfg.lang, module("vrp", "cfg/lang/"..cfg.lang) or {})
Lang:loadLocale(cfg.lang, module("vrp_adv_garages", "cfg/lang/"..cfg.lang) or {})
lang = Lang.lang[cfg.lang]

local adv_garages = cfg.adv_garages
local items = cfg.items
local cooldown = {}
  
Citizen.CreateThread(function()
  for k,v in pairs(items) do
    vRP.defInventoryItem(k,v[1],v[2],v[3],v[4])
  end
end)

function vRPg.resetCooldown()
  cooldown[source] = false
end
-- build garages menus
function vRPg.openGarage(source, gid, pos)
  local user_id = vRP.getUserId(source)
  local vehicles = adv_garages[gid]
  local veh_type = vehicles._config.vtype
  local gtypes = vehicles._config.gtype
  local gpay = vehicles._config.gpay
  local mods = vehicles._shop
  local menu = {
    name=lang.garage.title({gid}),
    css={top = "75px", header_color="rgba(255,125,0,0.75)"}
  }
  
  for _,gtype in pairs(gtypes) do
	if gtype == "showroom" then
      menu[lang.garage.showroom.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
        if user_id then
          -- build nested menu
          local kitems = {}
		  local bought = false
          local submenu = {name=lang.garage.title({lang.garage.buy.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
          submenu.onclose = function()
            vRP.openMenu(source,menu)
			if not bought then
			  Gclient.despawnShowroomVehicle(source) 
			end
			Gclient.protectVehicle(source,false)
          end
      
          local choose = function(player, choice, mod)
            local vname = kitems[choice]
            if vname then
              -- buy vehicle
              local vehicle = vehicles[vname]
			  if vehicle then
			    if mod == 0 then
    		      local ok = vRP.request(source, lang.garage.buy.request(), 10)
    		      if ok then
				    local price = vehicle[2]
				    local item = vehicle[4]
				    local payment = false
				    if item then
                      payment = vRP.tryGetInventoryItem(user_id,item,price,true)
				    elseif gpay == "bank" then
                      payment = vRP.tryFullPayment(user_id,price)
				    elseif gpay == "wallet" then
                      payment = vRP.tryPayment(user_id,price)
				    end
				    if payment then
					  local name, custom = Gclient.getVehicleMods(source, veh_type)
			          -- print("custom:u"..user_id.."veh_"..vname.." = " .. json.encode(custom)) -- uncomment to see data structure upon save
			          vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode(custom))
					  MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vname})
				      Gclient.despawnShowroomVehicle(source) 
					  if Gclient.spawnGarageVehicle(source,veh_type,vname,pos) then
					  	Gclient.setVehicleMods(source,custom)
					  else
					  	vRPclient.notify(source,lang.garage.personal.out())
					  end
					  bought = true
			          if not item and price > 0 then
                        vRPclient.notify(source,lang.money.paid({price}))
			          end
                      vRP.closeMenu(source)
                    else
				      if not item then
                        vRPclient.notify(source,lang.money.not_enough())
					  end
                    end
				  else
				    vRPclient.notify(source,lang.common.request_refused())
				  end
			    elseif not cooldown[source] then
				  cooldown[source] = true
                  if Gclient.spawnShowroomVehicle(source,vname, pos) then
				    Gclient.protectVehicle(source,true)
				  end
			    end
			  end
            end
          end
          
          -- get player owned vehicles (indexed by vehicle type name in lower case)
          local _pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
          local pvehicles = {}
          for k,v in pairs(_pvehicles) do
            pvehicles[string.lower(v.vehicle)] = true
          end
      
          -- for each existing vehicle in the garage group
          for k,v in pairs(vehicles) do
            if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then -- not already owned
              local price = math.max(v[2],0)
			  if v[4] then
                submenu[v[1]] = {choose,lang.garage.buy.item({vRP.getItemName(v[4]),price,v[3]})}
			  else
                submenu[v[1]] = {choose,lang.garage.buy.info({price,v[3]})}
			  end
              kitems[v[1]] = k
            end
          end
      
          vRP.openMenu(source,submenu)
        end
      end,lang.garage.showroom.description()}
	elseif gtype == "personal" then 
      menu[lang.garage.owned.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
        if user_id then
          -- init tmpdata for rents
          local tmpdata = vRP.getUserTmpTable(user_id)
          if not tmpdata.rent_vehicles then
            tmpdata.rent_vehicles = {}
          end
      
      
          -- build nested menu
          local kitems = {}
          local submenu = {name=lang.garage.title({lang.garage.owned.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
          submenu.onclose = function()
            vRP.openMenu(source,menu)
          end
          
          -- get player owned vehicles
          local pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
          -- add rents to whitelist
          for k,v in pairs(tmpdata.rent_vehicles) do
            if v then -- check true, prevent future neolua issues
              table.insert(pvehicles,{vehicle = k})
            end
          end
      
          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              -- spawn vehicle
              vRP.closeMenu(source)
			  local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
			  local custom = json.decode(data)
			  if not cooldown[source] then
				cooldown[source] = true
                if Gclient.spawnGarageVehicle(source,veh_type,vname,pos) then
			      Gclient.setVehicleMods(source,custom)
			    else
			      vRPclient.notify(source,lang.garage.personal.out())
			    end
			  end
            end
          end
		  
          for k,v in pairs(pvehicles) do
		    local vehicle
		    for x,garage in pairs(adv_garages) do
			  if garage._config.vtype == veh_type then
                vehicle = garage[v.vehicle]
			  end
			  if vehicle then break end
			end
			
            if vehicle then
              submenu[vehicle[1]] = {choose,vehicle[3]}
              kitems[vehicle[1]] = v.vehicle
            end
          end
      
          vRP.openMenu(source,submenu)
        end
      end,lang.garage.owned.description()}
	  
      menu[lang.garage.store.title()] = {function(player,choice)
        if Gclient.despawnGarageVehicle(source,veh_type,15) then
		  vRPclient.notify(source,lang.garage.personal.stored())
		else
		  vRPclient.notify(source,lang.garage.personal.toofar())
		end
      end, lang.garage.store.description()}
	elseif gtype == "store" then
      menu[lang.garage.buy.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
        if user_id then
          -- build nested menu
          local kitems = {}
          local submenu = {name=lang.garage.title({lang.garage.buy.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
          submenu.onclose = function()
            vRP.openMenu(source,menu)
          end
      
          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              -- buy vehicle
              local vehicle = vehicles[vname]
              if vehicle then
    		    local ok = vRP.request(source, lang.garage.buy.request(), 10)
    		    if ok then
			      local price = vehicle[2]
				  local item = vehicle[4]
				  local payment = false
				  if item then
                    payment = vRP.tryGetInventoryItem(user_id,item,price,true)
				  elseif gpay == "bank" then
                    payment = vRP.tryFullPayment(user_id,price)
				  elseif gpay == "wallet" then
                    payment = vRP.tryPayment(user_id,price)
				  end
				  if payment then
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vname})
                    -- spawn vehicle
                    if not Gclient.spawnGarageVehicle(source,veh_type,vname,pos) then
			          vRPclient.notify(source,lang.garage.personal.out())
			        end
				    
			        if not item and price > 0 then
                      vRPclient.notify(source,lang.money.paid({price}))
			        end
                    vRP.closeMenu(source)
                  else
				    if not item then
                      vRPclient.notify(source,lang.money.not_enough())
				    end
                  end
				else
				  vRPclient.notify(source,lang.common.request_refused())
				end
			  end
            end
          end
          
          -- get player owned vehicles (indexed by vehicle type name in lower case)
          local _pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
          local pvehicles = {}
          for k,v in pairs(_pvehicles) do
            pvehicles[string.lower(v.vehicle)] = true
          end
      
          -- for each existing vehicle in the garage group
          for k,v in pairs(vehicles) do
            if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then -- not already owned
              local price = math.max(v[2],0)
			  if v[4] then
                submenu[v[1]] = {choose,lang.garage.buy.item({vRP.getItemName(v[4]),price,v[3]})}
			  else
                submenu[v[1]] = {choose,lang.garage.buy.info({price,v[3]})}
			  end
              kitems[v[1]] = k
            end
          end
      
          vRP.openMenu(source,submenu)
        end
      end,lang.garage.buy.description()}
      
      menu[lang.garage.sell.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
        if user_id then
      
          -- build nested menu
          local kitems = {}
          local submenu = {name=lang.garage.title({lang.garage.sell.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
          submenu.onclose = function()
            vRP.openMenu(source,menu)
          end
      
          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              -- sell vehicle
              local vehicle = vehicles[vname]
              if vehicle then      
                local rows = MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname})
                if #rows > 0 then -- has vehicle
				  local price = math.ceil(vehicle[2]*cfg.sell_factor)
				  local item = vehicle[4]
				  if item then
					vRP.giveInventoryItem(user_id,item,price,true)
				  elseif gpay == "bank" then
                    vRP.giveBankMoney(user_id,price)
				  elseif gpay == "wallet" then
                    vRP.giveMoney(user_id,price)
				  end
                  MySQL.execute("vRP/remove_vehicle", {user_id = user_id, vehicle = vname})
                  vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode())
				  
			      if not item and price > 0 then
                    vRPclient.notify(source,lang.money.received({price}))
			      end
				  
				  local vtype, vehicle = Gclient.isOwnedVehicleOut(source, vname)
				  if vtype and vehicle then
					if Gclient.despawnGarageVehicle(source,vtype,100000) then
					  vRPclient.notify(source,lang.garage.personal.sold())
					end
				  end
      
                  vRP.closeMenu(source)
                else
                  vRPclient.notify(source,lang.common.not_found())
                end
              end
            end
          end
          
          -- get player owned vehicles (indexed by vehicle type name in lower case)
          local _pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
          local pvehicles = {}
          for k,v in pairs(_pvehicles) do
            pvehicles[string.lower(v.vehicle)] = true
          end
      
          -- for each existing vehicle in the garage group
          for k,v in pairs(pvehicles) do
            local vehicle = vehicles[k]
            if vehicle then -- not already owned
              local price = math.ceil(vehicle[2]*cfg.sell_factor)
			  if vehicle[4] then
                submenu[vehicle[1]] = {choose,lang.garage.buy.item({vRP.getItemName(vehicle[4]),price,vehicle[3]})}
			  else
                submenu[vehicle[1]] = {choose,lang.garage.buy.info({price,vehicle[3]})}
			  end
              kitems[vehicle[1]] = k
            end
          end
      
          vRP.openMenu(source,submenu)
        end
      end,lang.garage.sell.description()}
    elseif gtype == "rental" then
      menu[lang.garage.rent.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
        if user_id then
          -- init tmpdata for rents
          local tmpdata = vRP.getUserTmpTable(user_id)
          if tmpdata.rent_vehicles == nil then
            tmpdata.rent_vehicles = {}
          end
      
          -- build nested menu
          local kitems = {}
          local submenu = {name=lang.garage.title({lang.garage.rent.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
          submenu.onclose = function()
            vRP.openMenu(source,menu)
          end
      
          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              -- rent vehicle
              local vehicle = vehicles[vname]
              if vehicle then
                local price = math.ceil(vehicle[2]*cfg.rent_factor)
				local item = vehicle[4]
				local payment = false
				if item then
                  payment = vRP.tryGetInventoryItem(user_id,item,price,true)
				elseif gpay == "bank" then
                  payment = vRP.tryFullPayment(user_id,price)
				elseif gpay == "wallet" then
                  payment = vRP.tryPayment(user_id,price)
				end
				if payment then
                  -- add vehicle to rent tmp data
                  tmpdata.rent_vehicles[vname] = true
                  -- spawn vehicle
                  if not Gclient.spawnGarageVehicle(source,veh_type,vname,pos) then
			        vRPclient.notify(source,lang.garage.personal.out())
			      end
				  
			      if not item and price > 0 then
                    vRPclient.notify(source,lang.money.paid({price}))
			      end
      
                  vRPclient.notify(source,lang.money.paid({price}))
                  vRP.closeMenu(source)
                else
				  if not item then
                    vRPclient.notify(source,lang.money.not_enough())
				  end
                end
              end
            end
          end
          
          -- get player owned vehicles (indexed by vehicle type name in lower case)
          local _pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
          local pvehicles = {}
          for k,v in pairs(_pvehicles) do
            pvehicles[string.lower(v.vehicle)] = true
          end
      
          -- add rents to blacklist
          for k,v in pairs(tmpdata.rent_vehicles) do
            pvehicles[string.lower(k)] = true
          end
      
          -- for each existing vehicle in the garage group
          for k,v in pairs(vehicles) do
            if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then -- not already owned
              local price = math.ceil(v[2]*cfg.rent_factor)
			  if v[4] then
                submenu[v[1]] = {choose,lang.garage.buy.item({vRP.getItemName(v[4]),price,v[3]})}
			  else
                submenu[v[1]] = {choose,lang.garage.buy.info({price,v[3]})}
			  end
              kitems[v[1]] = k
            end
          end
      
          vRP.openMenu(source,submenu)
        end
      end,lang.garage.rent.description()}
      menu[lang.garage.store.title()] = {function(player,choice)
        if Gclient.despawnGarageVehicle(source,veh_type,15) then
		  vRPclient.notify(source,lang.garage.personal.stored())
		else
		  vRPclient.notify(source,lang.garage.personal.toofar())
		end
      end, lang.garage.store.description()}
	elseif gtype == "shop" then
      menu[lang.garage.shop.title()] = {function(player,choice)
        local user_id = vRP.getUserId(source)
		local tosub = false
        if user_id then
          -- build nested menu
          local submenu = {name=lang.garage.title({lang.garage.shop.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
		  
		  -- payment and saving
          submenu.onclose = function()
		    if not tosub then
              vRP.openMenu(source,menu)
		      Gclient.protectVehicle(source,false)
			end
          end
		  
          local ch_color = function(player, choice)
			local old_vname, old_custom = Gclient.getVehicleMods(source, veh_type)
            local subsubmenu = {name=lang.garage.title({lang.garage.shop.colour.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
            subsubmenu.onclose = function()
			  tosub = false
			  local vname, custom = Gclient.getVehicleMods(source, veh_type)
			  local price = 0
			  if custom then
			    for k,v in pairs(custom.colour.custom.primary) do
			      local old = old_custom.colour.custom.primary[k]
			      if mod then
			        if old ~= v then price = price + cfg.price.colour end -- modification
			      end
			    end
			    for k,v in pairs(custom.colour.custom.secondary) do
			      local old = old_custom.colour.custom.secondary[k]
			      if mod then
			        if old ~= v then price = price + cfg.price.colour end -- modification
			      end
			    end
			    if custom.colour.primary ~= old_custom.colour.primary then price = price + cfg.price.colour end -- modification
			    if custom.colour.secondary ~= old_custom.colour.secondary then price = price + cfg.price.colour end -- modification
				local payment = false
				if gpay == "bank" then
                  payment = vRP.tryFullPayment(user_id,price)
				elseif gpay == "wallet" then
                  payment = vRP.tryPayment(user_id,price)
				end
				if payment then
			      if vname then
			        -- print("custom:u"..user_id.."veh_"..vname.." = " .. json.encode(custom)) -- uncomment to see data structure upon save
			        vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode(custom))
			        if price > 0 then
                      vRPclient.notify(source,lang.money.paid({price}))
			        end
		          end
				else
				  Gclient.setVehicleMods(source,old_custom)
                  vRPclient.notify(source,lang.money.not_enough())
				end
			  end
              vRP.openMenu(source,submenu)
            end
            
            local ch_pcolor = function(player, choice, mod)
			  Gclient.scrollVehiclePrimaryColour(source,mod)
            end
            local ch_scolor = function(player, choice, mod)
			  Gclient.scrollVehicleSecondaryColour(source,mod)
            end
            local ch_cpcolor = function(player, choice)
			  local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
			  rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
			  local r,g,b = table.unpack(splitString(rgb, " "))
			  Gclient.setCustomPrimaryColour(source,tonumber(r),tonumber(g),tonumber(b))
            end
            local ch_cscolor = function(player, choice)
			  local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
			  rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
			  local r,g,b = table.unpack(splitString(rgb, " "))
			  Gclient.setCustomSecondaryColour(source,tonumber(r),tonumber(g),tonumber(b))
            end
			
            subsubmenu[lang.garage.shop.colour.primary()] = {ch_pcolor,""}
            subsubmenu[lang.garage.shop.colour.secondary()] = {ch_scolor,""}
            subsubmenu[lang.garage.shop.colour.custom.primary()] = {ch_cpcolor,""}
            subsubmenu[lang.garage.shop.colour.custom.secondary()] = {ch_cscolor,""}
			
			tosub = true
            vRP.openMenu(source,subsubmenu)
          end
          submenu[lang.garage.shop.colour.title()] = {ch_color,lang.garage.shop.colour.info({})}
		  
          local ch_extracolor = function(player, choice)
			local old_vname, old_custom = Gclient.getVehicleMods(source, veh_type)
            local subsubmenu = {name=lang.garage.title({lang.garage.shop.colour.extra.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
            subsubmenu.onclose = function()
			  tosub = false
			  local vname, custom = Gclient.getVehicleMods(source, veh_type)
			  local price = 0
			  if custom then
			    for k,v in pairs(custom.colour.smoke) do
			      local old = old_custom.colour.smoke[k]
			      if mod then
			        if old ~= v then price = price + cfg.price.extra end -- modification
			      end
			    end
			    if custom.colour.pearlescent ~= old_custom.colour.pearlescent then price = price + cfg.price.extra end -- modification
			    if custom.colour.wheel ~= old_custom.colour.wheel then price = price + cfg.price.extra end -- modification
				local payment = false
				if gpay == "bank" then
                  payment = vRP.tryFullPayment(user_id,price)
				elseif gpay == "wallet" then
                  payment = vRP.tryPayment(user_id,price)
				end
				if payment then
			      if vname then
			        -- print("custom:u"..user_id.."veh_"..vname.." = " .. json.encode(custom)) -- uncomment to see data structure upon save
			        vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode(custom))
		          end
			      if price > 0 then
                    vRPclient.notify(source,lang.money.paid({price}))
			      end
				else
				  Gclient.setVehicleMods(source,old_custom)
                  vRPclient.notify(source,lang.money.not_enough())
				end
			  end
              vRP.openMenu(source,submenu)
            end
            
            local ch_pcolor = function(player, choice, mod)
			  Gclient.scrollVehiclePearlescentColour(source,mod)
            end
            local ch_wcolor = function(player, choice, mod)
			  Gclient.scrollVehicleWheelColour(source,mod)
            end
            local ch_scolor = function(player, choice)
			  local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
			  rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
			  local r,g,b = table.unpack(splitString(rgb, " "))
			  Gclient.setSmokeColour(source,tonumber(r),tonumber(g),tonumber(b))
            end
			
            subsubmenu[lang.garage.shop.colour.extra.pearlescent()] = {ch_pcolor,""}
            subsubmenu[lang.garage.shop.colour.extra.wheel()] = {ch_wcolor,""}
            subsubmenu[lang.garage.shop.colour.extra.smoke()] = {ch_scolor,""}
			
			tosub = true
            vRP.openMenu(source,subsubmenu)
          end
          submenu[lang.garage.shop.colour.extra.title()] = {ch_extracolor,lang.garage.shop.colour.extra.info({})}
		  
          local ch_neon = function(player, choice)
			local old_vname, old_custom = Gclient.getVehicleMods(source, veh_type)
            local subsubmenu = {name=lang.garage.title({lang.garage.shop.neon.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
            subsubmenu.onclose = function()
			  tosub = false
			  local vname, custom = Gclient.getVehicleMods(source, veh_type)
			  local price = 0
			  if custom then
			    for k,v in pairs(custom.neon) do
			      local old = old_custom.neon[k]
			      if mod then
			        if old ~= v then price = price + cfg.price.neon end -- modification
			      end
			    end
			    for k,v in pairs(custom.colour.neon) do
			      local old = old_custom.colour.neon[k]
			      if mod then
			        if old ~= v then price = price + cfg.price.neon end -- modification
			      end
			    end
				local payment = false
				if gpay == "bank" then
                  payment = vRP.tryFullPayment(user_id,price)
				elseif gpay == "wallet" then
                  payment = vRP.tryPayment(user_id,price)
				end
				if payment then
			      if vname then
			        -- print("custom:u"..user_id.."veh_"..vname.." = " .. json.encode(custom)) -- uncomment to see data structure upon save
			        vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode(custom))
		          end
			      if price > 0 then
                    vRPclient.notify(source,lang.money.paid({price}))
			      end
				else
				  Gclient.setVehicleMods(source,old_custom)
                  vRPclient.notify(source,lang.money.not_enough())
				end
			  end
              vRP.openMenu(source,submenu)
            end
            
            local ch_nleft = function(player, choice)
			  Gclient.toggleNeon(source,0)
            end
            local ch_nright = function(player, choice)
			  Gclient.toggleNeon(source,1)
            end
            local ch_nfront = function(player, choice)
			  Gclient.toggleNeon(source,2)
            end
            local ch_nback = function(player, choice)
			  Gclient.toggleNeon(source,3)
            end
            local ch_ncolor = function(player, choice)
			  local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
			  rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
			  local r,g,b = table.unpack(splitString(rgb, " "))
			  Gclient.setNeonColour(source,tonumber(r),tonumber(g),tonumber(b))
            end
			
            subsubmenu[lang.garage.shop.neon.back()] = {ch_nback,""}
            subsubmenu[lang.garage.shop.neon.front()] = {ch_nfront,""}
            subsubmenu[lang.garage.shop.neon.left()] = {ch_nleft,""}
            subsubmenu[lang.garage.shop.neon.right()] = {ch_nright,""}
            subsubmenu[lang.garage.shop.neon.colour()] = {ch_ncolor,""}
		    
			tosub = true
            vRP.openMenu(source,subsubmenu)
          end
          submenu[lang.garage.shop.neon.title()] = {ch_neon,lang.garage.shop.neon.info({})}
		  
          local ch_mods = function(player, choice)
            local kitems = {}
			local old_vname, old_custom = Gclient.getVehicleMods(source, veh_type)
            local subsubmenu = {name=lang.garage.title({lang.garage.shop.mods.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
            subsubmenu.onclose = function()
			  tosub = false
			  local vname, custom = Gclient.getVehicleMods(source, veh_type)
			  local price = 0
			  local items = {}
			  if custom then
			    for k,v in pairs(custom.mods) do
			      local old = old_custom.mods[k]
			      local mod = mods[k]
			      if mod then
				    if old ~= v then
				      if mod[4] then
					    items[k] = {mod[4],mod[2]} -- item prices
					  else price = price + mod[2] end -- modification
					end
			      end
			    end
				local payment = false
				local payitems = false
				if not next(items) then
				  payitems = true
				else
				  for n,i in pairs(items) do
                    payitems = vRP.tryGetInventoryItem(user_id,i[1],i[2],true)
				    if not payitems then break end
				  end
				end
				if payitems then
				  if gpay == "bank" then
                    payment = vRP.tryFullPayment(user_id,price)
				  elseif gpay == "wallet" then
                    payment = vRP.tryPayment(user_id,price)
				  end
				  if payment then
			        if vname then
			          -- print("custom:u"..user_id.."veh_"..vname.." = " .. json.encode(custom)) -- uncomment to see data structure upon save
			          vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode(custom))
			          if price > 0 then
                        vRPclient.notify(source,lang.money.paid({price}))
			          end
		            end
				  else
				    Gclient.setVehicleMods(source,old_custom)
                    vRPclient.notify(source,lang.money.not_enough())
				  end
				end
			  end
              vRP.openMenu(source,submenu)
            end
            
            local ch_mod = function(player, choice, mod)
		      Gclient.scrollVehicleMods(source,kitems[choice],mod)			
            end
            -- for each existing vehicle in the garage group
            for k,v in pairs(mods) do
              local price = math.max(v[2],0)
			  if v[4] then
                subsubmenu[v[1]] = {ch_mod,lang.garage.buy.item({vRP.getItemName(v[4]),price,v[3]})}
			  else
                subsubmenu[v[1]] = {ch_mod,lang.garage.buy.info({price,v[3]})}
			  end
              kitems[v[1]] = k
            end
			tosub = true
            vRP.openMenu(source,subsubmenu)
          end
          submenu[lang.garage.shop.mods.title()] = {ch_mods,lang.garage.shop.mods.info({})}
		  
          local ch_repair = function(player, choice)
		    local price = cfg.price.repair
			local payment = false
			if gpay == "bank" then
              payment = vRP.tryFullPayment(user_id,price)
			elseif gpay == "wallet" then
              payment = vRP.tryPayment(user_id,price)
			end
			if payment then
			  if price > 0 then
                vRPclient.notify(source,lang.money.paid({price}))
			  end
			  Gclient.repairVehicle(source)
			else
              vRPclient.notify(source,lang.money.not_enough())
			end
          end
          submenu[lang.garage.shop.repair.title()] = {ch_repair,lang.garage.shop.repair.info({})}
		  
          vRP.openMenu(source,submenu)
		  Gclient.protectVehicle(source,true)
        end
      end,lang.garage.shop.description()}
	end
  end
  
  
  vRP.openMenu(source,menu)
end

local function build_client_garages(source)
  local user_id = vRP.getUserId(source)
  local address = vRP.getUserAddress(user_id)
  if user_id then
    for k,v in pairs(cfg.garages) do
      local gid,x,y,z = table.unpack(v)
	  local vehicles = cfg.adv_garages[gid]

      if vehicles then
        local gcfg = vehicles._config
		
		if not address then address = {} end
		if not gcfg.ghome or gcfg.ghome == address.home then
          -- enter
          local garage_enter = function(player,area)
            local user_id = vRP.getUserId(source)
            if user_id and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
              vRPg.openGarage(source,gid,{x,y,z})
            end
          end
          
          -- leave
          local garage_leave = function(player,area)
            vRP.closeMenu(source)
            vRP.closeMenu(source)
            vRP.closeMenu(source)
            vRP.closeMenu(source)
            vRP.closeMenu(source)
          end
          
		  if gcfg.blipid then
            vRPclient.addBlip(source,x,y,z,gcfg.blipid,gcfg.blipcolor,lang.garage.title({gid}))
		  end
          vRPclient.addMarker(source,x,y,z-1,1.5,1.5,0.7,0,125,255,125,150)
          
          vRP.setArea(source,"vRP:garage"..k,x,y,z,2,2,garage_enter,garage_leave)
		end
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_client_garages(source)
  end
end)

-- VEHICLE MENU

-- define vehicle actions
-- action => {cb(user_id,player,veh_group,veh_name),desc}
local veh_actions = {}

-- open trunk
veh_actions[lang.vehicle.trunk.title()] = {function(user_id,player,vtype,name)
  local chestname = "u"..user_id.."veh_"..string.lower(name)
  local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

  -- open chest
  Gclient.vc_openDoor(player, vtype,5)
  vRP.openChest(player, chestname, max_weight, function()
    Gclient.vc_closeDoor(player, vtype,5)
  end)
end, lang.vehicle.trunk.description()}

-- detach trailer
veh_actions[lang.vehicle.detach_trailer.title()] = {function(user_id,player,vtype,name)
  Gclient.vc_detachTrailer(player, vtype)
end, lang.vehicle.detach_trailer.description()}

-- detach towtruck
veh_actions[lang.vehicle.detach_towtruck.title()] = {function(user_id,player,vtype,name)
  Gclient.vc_detachTowTruck(player, vtype)
end, lang.vehicle.detach_towtruck.description()}

-- detach cargobob
veh_actions[lang.vehicle.detach_cargobob.title()] = {function(user_id,player,vtype,name)
  Gclient.vc_detachCargobob(player, vtype)
end, lang.vehicle.detach_cargobob.description()}

-- lock/unlock
veh_actions[lang.vehicle.lock.title()] = {function(user_id,player,vtype,name)
  Gclient.vc_toggleLock(player, vtype)
end, lang.vehicle.lock.description()}

-- engine on/off
veh_actions[lang.vehicle.engine.title()] = {function(user_id,player,vtype,name)
  Gclient.vc_toggleEngine(player, vtype)
end, lang.vehicle.engine.description()}

local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id then
    -- build vehicle menu
    -- check vehicle
    local ok,vtype,name = Gclient.getNearestOwnedVehicle(player,7)
    local menu = vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name})
    menu.name=lang.vehicle.title()
    menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

    if ok then
      for k,v in pairs(veh_actions) do
        menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
      end
	end
	
    local ch_keys = function(player,choice)
      local user_id = vRP.getUserId(player)
      if user_id then
    	local kitems = {}
		local tosub = false
        local submenu = {name=lang.garage.keys.title(), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
        submenu.onclose = function()
    	  if not tosub then
            vRP.openMenu(player,menu)
    	  end
    	end
    		  
    	local choose = function(player, choice)
    	  local vehicle = choice
    	  local vname = kitems[vehicle]
          local subsubmenu = {name=lang.garage.keys.key({vehicle}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
    	  subsubmenu.onclose = function()
    		tosub = false
			vRP.openMenu(player,submenu)
    	  end
          
          local ch_sell = function(player, choice)
    		local nplayer = vRPclient.getNearestPlayer(player, 5)
    		if nplayer then
    		  local tuser_id = vRP.getUserId(nplayer)
			  local owned = MySQL.query("vRP/get_vehicle", {user_id = tuser_id, vehicle = vname})
			  if #owned == 0 then
    	        local price = tonumber(sanitizeString(vRP.prompt(player,lang.garage.keys.sell.prompt(),""),"\"[]{}+=?!_()#@%/\\|,.",false))
    		    local ok = vRP.request(nplayer, lang.garage.keys.sell.request({vehicle,price}), 30)
    		    if ok then
    		      if vRP.tryFullPayment(tuser_id,price) then
    			    MySQL.execute("vRP/move_vehicle", {user_id = user_id, tuser_id = tuser_id, vehicle = vname})
    			    local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
    			    local custom = json.decode(data)
    			    vRP.setSData("custom:u"..tuser_id.."veh_"..vname, json.encode(custom))
    			    vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode())
    			    if price > 0 then
					  vRP.giveBankMoney(user_id,price)
                      vRPclient.notify(nplayer,lang.money.paid({price}))
                      vRPclient.notify(player,lang.money.received({price}))
    			    end
				    local vtype, vehicle = Gclient.isOwnedVehicleOut(player, vname)
				    if vtype and vehicle then
				  	if Gclient.despawnGarageVehicle(player,vtype,999999) then
				        if Gclient.spawnGarageVehicle(nplayer,vtype,vname,pos) then
				    	    Gclient.setVehicleMods(nplayer,custom)
				        else
				    	    vRPclient.notify(nplayer,lang.garage.personal.out())
				        end
				  	end
				    else
				    	vRPclient.notify(nplayer,lang.garage.personal.bought())
				    end
				    vRPclient.notify(player,lang.garage.personal.sold())
    			  else
                    vRPclient.notify(player,lang.money.not_enough())
                    vRPclient.notify(nplayer,lang.money.not_enough())
    			  end
    		    else
    		      vRPclient.notify(player,lang.common.request_refused())
    		    end
    		  else
                vRPclient.notify(nplayer,lang.garage.keys.sell.owned())
                vRPclient.notify(player,lang.garage.keys.sell.owned())
    		  end
			else
    		  vRPclient.notify(player,lang.common.no_player_near())
			end
          end
    	  
          subsubmenu[lang.garage.keys.sell.title()] = {ch_sell,lang.garage.keys.sell.description()}
    	  
    	  tosub = true
          vRP.openMenu(player,subsubmenu)
        end
         -- get player owned vehicles (indexed by vehicle type name in lower case)
        local pvehicles = MySQL.query("vRP/get_vehicles", {user_id = user_id})
    	for k,v in pairs(pvehicles) do
		  local vehicle
		  for x,garage in pairs(adv_garages) do
            vehicle = garage[v.vehicle]
		    if vehicle then break end
		  end
		
		  if vehicle then
            submenu[vehicle[1]] = {choose,vehicle[3]}
            kitems[vehicle[1]] = v.vehicle
          end
        end
    
        vRP.openMenu(player,submenu)
      end
    end
	
    menu[lang.garage.keys.title()] = {ch_keys, lang.garage.keys.description()}

    vRP.openMenu(player,menu)
  end
end

-- ask trunk (open other user car chest)
local function ch_asktrunk(player,choice)
  local nplayer = vRPclient.getNearestPlayer(player,10)
  local nuser_id = vRP.getUserId(nplayer)
  if nuser_id then
    vRPclient.notify(player,lang.vehicle.asktrunk.asked())
    if vRP.request(nplayer,lang.vehicle.asktrunk.request(),15) then -- request accepted, open trunk
      local ok,vtype,name = Gclient.getNearestOwnedVehicle(nplayer,7)
      if ok then
        local chestname = "u"..nuser_id.."veh_"..string.lower(name)
        local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

        -- open chest
        local cb_out = function(idname,amount)
          vRPclient.notify(nplayer,lang.inventory.give.given({vRP.getItemName(idname),amount}))
        end

        local cb_in = function(idname,amount)
          vRPclient.notify(nplayer,lang.inventory.give.received({vRP.getItemName(idname),amount}))
        end

        Gclient.vc_openDoor(nplayer, vtype,5)
        vRP.openChest(player, chestname, max_weight, function()
          Gclient.vc_closeDoor(nplayer, vtype,5)
        end,cb_in,cb_out)
      else
        vRPclient.notify(player,lang.vehicle.no_owned_near())
        vRPclient.notify(nplayer,lang.vehicle.no_owned_near())
      end
    else
      vRPclient.notify(player,lang.common.request_refused())
    end
  else
    vRPclient.notify(player,lang.common.no_player_near())
  end
end

Citizen.CreateThread(function()
  vRP.registerMenuBuilder("main", function(add, data)
    Citizen.CreateThread(function()
      local user_id = vRP.getUserId(data.player)
      if user_id then
        -- add vehicle entry
        local choices = {}
        choices[lang.vehicle.title()] = {ch_vehicle}
      
        -- add ask trunk
        choices[lang.vehicle.asktrunk.title()] = {ch_asktrunk}
      
        add(choices)
      end
	end)
  end)
end)