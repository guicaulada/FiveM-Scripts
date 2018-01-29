
description "vRP hotkeys"

dependency "vrp"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "cfg/hotkeys.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

ui_page('html/index.html')

files({
    'html/index.html',
    'html/sounds/lock.ogg',
    'html/sounds/unlock.ogg',
    'html/sounds/demo.ogg'
})