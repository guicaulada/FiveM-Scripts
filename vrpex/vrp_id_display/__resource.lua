
description "vrp_id_display"

dependency "vrp"

client_scripts {
    "@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua"
}

files{
	"cfg/display.lua",
}