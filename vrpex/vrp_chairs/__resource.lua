
description "vrp_chairs"

dependency 'vrp'

client_scripts {
    '@vrp/lib/utils.lua',
	'client.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
	'server.lua',
}

files{
	'cfg/chairs.lua',
}