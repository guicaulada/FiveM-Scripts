
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_basic_mission", "cfg/missions")
local lcfg = module("vrp", "cfg/base")

-- load global and local languages
local Luang = module("vrp", "lib/Luang")
local Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
Lang:loadLocale(lcfg.lang, module("vrp_basic_mission", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Mclient = Tunnel.getInterface("vrp_basic_mission")

function task_mission()
  -- REPAIR
  for k,v in pairs(cfg.repair) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = lang.repair({v.title})
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = lang.repair({v.title}).."<br />"..lang.reward({v.reward}),
              onenter = function(player, area)
                if vRP.tryGetInventoryItem(user_id,"repairkit",1,false) then
                  vRPclient.playAnim(player,false,{task="WORLD_HUMAN_WELDING"},false)
                  SetTimeout(15000, function()
                    vRP.nextMissionStep(player)
					vRP.giveInventoryItem(user_id,"repairkit",1,false)
                    vRPclient.stopAnim(player,false)

                    -- last step
                    if i == v.steps then
                      vRP.giveMoney(user_id,v.reward)
                      vRPclient.notify(player,lang.money.received({v.reward}))
                    end
                  end)
				else
                    vRPclient.notify(player,"~r~You need a repair kit!")
                end
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
        end
      end
    end
  end

  -- DELIVERY
  for k,v in pairs(cfg.delivery) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = lang.delivery.title()

          -- generate items
          local todo = 0
          local delivery_items = {}
          for idname,data in pairs(v.items) do
            local amount = math.random(data[1],data[2]+1)
            if amount > 0 then
              delivery_items[idname] = amount
              todo = todo+1
            end
          end

          local step = {
            text = "",
            onenter = function(player, area)
              for idname,amount in pairs(delivery_items) do
                if amount > 0 then -- check if not done
                  if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
                    local reward = v.items[idname][3]*amount
	                if k == "mission.delivery.pot" then
					  vRP.giveInventoryItem(user_id,"dirty_money",reward,true)
					else
                      vRP.giveMoney(user_id,reward)
                      vRPclient.notify(player,lang.money.received({reward}))
					end
                    todo = todo-1
                    delivery_items[idname] = 0
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep(player)
                    end
                  end
				else
                    vRPclient.notify(player,"~r~Something is missing!")
                end
              end
            end,
            position = v.positions[math.random(1,#v.positions)]
          }

          -- mission display
          for idname,amount in pairs(delivery_items) do
            local name = vRP.getItemName(idname)
            step.text = step.text..lang.delivery.item({name,amount}).."<br />"
          end

          mdata.steps = {step}

          if todo > 0 then
            vRP.startMission(player,mdata)
          end
        end
      end
    end
  end
  
  -- CARJACKER
  for k,v in pairs(cfg.carjack) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
	  local reward = math.random(v.min_reward,v.max_reward)
      local user_id = w
      local player = vRP.getUserSource(user_id)
	  	  
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = v.title
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = lang.carjack().."<br />"..lang.reward({reward}),
              onenter = function(player, area)
			    local in_veh = Mclient.isInAnyVehicle(player)
			      if in_veh then
				    local plate = Mclient.getVehiclePedIsInPlateText(player)
				    local identity = vRP.getUserIdentity(user_id)
                      if string.find(plate, identity.registration) then
                        vRPclient.notify(player,lang.own_veh())
				      else
                        Mclient.freezePedVehicle(player,true)
				        Mclient.deleteVehiclePedIsIn(player)
					    vRP.giveInventoryItem(user_id,"dirty_money",reward,true)
                        vRP.nextMissionStep(player)
					  end
				  else
				    vRPclient.notify(player,lang.no_veh())
				  end
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
		end
	  end
    end
  end
  
  -- GUNRUNNER
  for k,v in pairs(cfg.gunrunner) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      local pistol = math.random(0,2)
	  local shotgun = math.random(-1,2)
	  local smg = math.random(-2,2)
	  	  
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = v.title
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = lang.shipment(),
              onenter = function(player, area)
				if pistol > 0 then
			      vRP.giveInventoryItem(user_id,"pistol_parts",pistol,true)
			      vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL",math.random(50,200)*pistol,true)
				end
				if shotgun > 0 then
			      vRP.giveInventoryItem(user_id,"shotgun_parts",shotgun,true)
			      vRP.giveInventoryItem(user_id,"wammo|WEAPON_PUMPSHOTGUN",math.random(50,100)*shotgun,true)
				end
				if smg > 0 then
			      vRP.giveInventoryItem(user_id,"smg_parts",smg,true)
			      vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG",math.random(100,200)*smg,true)
				end
                vRP.nextMissionStep(player)
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
		end
	  end
    end
  end
  
  -- EMERGENCY
  for k,v in pairs(cfg.emergency) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = v.title
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = lang.transfer().."<br />"..lang.reward({v.reward}),
              onenter = function(player, area)
                if vRP.tryGetInventoryItem(user_id,"medkit",1,false) then
                  Mclient.freezePedVehicle(player,true)
                  vRPclient.notify(player,"Wait for the patient to get in.")
                  SetTimeout(10000, function()
                    vRP.nextMissionStep(player)
					vRP.giveInventoryItem(user_id,"medkit",1,false)
                    Mclient.freezePedVehicle(player,false)

                    -- last step
                    if i == v.steps then
                      vRP.giveBankMoney(user_id,v.reward)
                      vRPclient.notify(player,lang.money.received({v.reward}))
                      vRPclient.notify(player,"That's it for now!")
					else
                      vRPclient.notify(player,"He is in! Take him to the next hospital!")
                    end
                  end)
				else
                    vRPclient.notify(player,"You need a medkit!")
                end
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
        end
      end
    end
  end
  
  -- POLICE
  for k,v in pairs(cfg.police) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = v.title
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = v.text.."<br />"..lang.reward({v.reward}),
              onenter = function(player, area)
                  Mclient.freezePedVehicle(player,true)
                  vRPclient.notify(player,"Wait a few seconds.")
                  SetTimeout(5000, function()
                    vRP.nextMissionStep(player)
					Mclient.freezePedVehicle(player,false)

                    -- last step
                    if i == v.steps then
                      vRP.giveBankMoney(user_id,v.reward)
                      vRPclient.notify(player,lang.money.received({v.reward}))
                      vRPclient.notify(player,"That's it for now!")
					else
                      vRPclient.notify(player,"All good! Go to the next spot!")
                    end
                  end)
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
        end
      end
    end
  end
  
  -- TAXI
  for k,v in pairs(cfg.taxi) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission(k)
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource(user_id)
      if not vRP.hasMission(player) and vRP.hasGroup(user_id,"onservice") then
        if math.random(1,v.chance) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = v.title
          mdata.steps = {}

          -- build steps
          for i=1,v.steps do
            local step = {
              text = v.text.."<br />"..lang.reward({v.reward}),
              onenter = function(player, area)
                  Mclient.freezePedVehicle(player,true)
                  vRPclient.notify(player,"Wait for the passenger.")
                  SetTimeout(5000, function()
                    vRP.nextMissionStep(player)
					Mclient.freezePedVehicle(player,false)

                    -- last step
                    if i == v.steps then
                      vRP.giveMoney(user_id,v.reward)
                      vRPclient.notify(player,lang.money.received({v.reward}))
                      vRPclient.notify(player,"That's it for now!")
					else
                      vRPclient.notify(player,"Take the passenger to it's destination.")
                    end
                  end)
              end,
              position = v.positions[math.random(1,#v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission(player,mdata)
        end
      end
    end
  end
  SetTimeout(60000,task_mission)
end
Citizen.CreateThread(function()
  task_mission()
end)
