
description "vrp_chairs"

dependency 'vrp'

client_scripts {
	'lib/Proxy.lua',
	'lib/Tunnel.lua',
	'cfg/chairs.lua',
	'client.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
	'server.lua',
}
