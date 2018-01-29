
description "Levy's Phone"

dependency "vrp"

server_scripts{
  '@vrp/lib/utils.lua',
  'server.lua'
}

files{
  "gui/img/menu.png",
  "gui/img/border.png",
  "gui/img/blue.jpg",
  "gui/img/code.jpg",
  "gui/img/grey.jpg",
  "gui/img/red.jpg"
}
