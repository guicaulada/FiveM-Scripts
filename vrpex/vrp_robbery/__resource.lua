
description "vRPex robbery"

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
  "cfg/robbery.lua",
  "cfg/lang/en.lua" -- add your lang here
}