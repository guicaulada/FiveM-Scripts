
description "vrp_adv_garages"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

files{
  "cfg/garages.lua",
  "cfg/lang/en.lua",
  -- add lang file here
}