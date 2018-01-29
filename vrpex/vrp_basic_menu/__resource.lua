
description "vrp_basic_menu"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua",
  -- load client functions
  "cfg/client/admin.lua",
  "cfg/client/main.lua",
  "cfg/client/player.lua",
  "cfg/client/police.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
  -- load server functions
  "cfg/server/admin.lua",
  "cfg/server/phone.lua",
  "cfg/server/police.lua",
  -- load items and buttons
  "cfg/items.lua",
  "cfg/buttons/main.lua",
  "cfg/buttons/police.lua",
  "cfg/buttons/player.lua",
  "cfg/buttons/phone.lua",
  "cfg/buttons/admin.lua",
  "cfg/buttons/static.lua",
  -- load menus with buttons
  "cfg/menus/main.lua",
  "cfg/menus/police.lua",
  "cfg/menus/player.lua",
  "cfg/menus/phone.lua",
  "cfg/menus/admin.lua",
  "cfg/menus/static.lua"
}

files{
  -- load client lang
  "cfg/lang/en.lua"
}