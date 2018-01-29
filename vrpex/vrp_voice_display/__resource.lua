
description "vrp_voice_display"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

files{
  "cfg/display.lua"
}