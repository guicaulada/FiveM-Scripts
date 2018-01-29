
description "vRP hotkeys"

dependency "vrp"

ui_page 'html/index.html'

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

files{
    'cfg/hotkeys.lua',
    'html/sounds/lock.ogg',
    'html/sounds/unlock.ogg',
    'html/sounds/demo.ogg'
}