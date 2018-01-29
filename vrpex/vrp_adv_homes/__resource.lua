
description "vrp_adv_homes"

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
  "cfg/home_components.lua"
}

files{
  "cfg/homes.lua",
  "cfg/lang/en.lua",
  -- add lang file here
}