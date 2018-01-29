
description "vRP holdup"

dependency "vrp"

client_scripts{ 
  "cfg/holdup.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "cfg/holdup.lua",
  "server.lua"
}
