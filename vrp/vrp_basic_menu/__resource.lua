
description "vrp_basic_menu"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client.lua",
  "playerblips/client.lua",
  "runcode/client.lua",
  "tptowaypoint/client.lua",
  "drag/client.lua",
  "spikes/client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "runcode/server.lua",
  "server.lua"
}
