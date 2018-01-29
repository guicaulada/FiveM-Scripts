
description "Levy's ESX vRP Menu"

dependency "vrp"

server_scripts{
  '@vrp/lib/utils.lua',
  'server.lua'
}

files{
  "gui/font/bankgothic.ttf"
}
