local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local cfg = module("vrp_group_display", "cfg/display")

local divs = {}

-- group display
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    local job = vRP.getUserGroupByType(user_id,"job")
    if (job == nil or job == "") and cfg.firstjob then
	  vRP.addUserGroup(user_id,cfg.firstjob)
	  job = cfg.firstjob
	end
    -- add job display
	if cfg.showjob then
      vRPclient.setDiv(source,"job",cfg.job,"<span id='icon'></span>"..job)
	end
	for group,gcfg in pairs(cfg.group) do
	  if vRP.hasGroup(user_id,group) then
        vRPclient.setDiv(source,sanitizeString(group,"\"[]{}×÷+-=±?!()#@%*&^$`~/\\|,.°ºª¹²³©®¤¢¥£§¶¾¼½╝╗╬═╠╔╦╚╩║╣▓▒░│┤├└┴─┼┘┌»«¦ƒ ",false),gcfg.css,"<span id='icon'></span>"..gcfg.text)
	  end
	end
  end
end)

-- update display
AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
  local player = vRP.getUserSource(user_id)
  -- add job display
  if gtype == "job" and cfg.showjob then
    vRPclient.setDiv(player,"job",cfg.job,"<span id='icon'></span>"..group)
  end
  for group,gcfg in pairs(cfg.group) do -- update all group displayes because playerLeaveGroup is not called on playerJoinGroup for jobs
    if vRP.hasGroup(user_id,group) then
      vRPclient.setDiv(player,sanitizeString(group,"\"[]{}×÷+-=±?!()#@%*&^$`~/\\|,.°ºª¹²³©®¤¢¥£§¶¾¼½╝╗╬═╠╔╦╚╩║╣▓▒░│┤├└┴─┼┘┌»«¦ƒ ",false),gcfg.css,"<span id='icon'></span>"..gcfg.text)
	else
	  vRPclient.removeDiv(player,sanitizeString(group,"\"[]{}×÷+-=±?!()#@%*&^$`~/\\|,.°ºª¹²³©®¤¢¥£§¶¾¼½╝╗╬═╠╔╦╚╩║╣▓▒░│┤├└┴─┼┘┌»«¦ƒ ",false))
    end
  end
end)

-- update display
AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
  local player = vRP.getUserSource(user_id)
  if gtype == "job" and cfg.showjob then
    vRPclient.removeDiv(player,"job")
  end
  vRPclient.removeDiv(player,sanitizeString(group,"\"[]{}+=?!-()#@%*&^$`~/\\|,. ",false))
end)