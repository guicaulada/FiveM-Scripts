dependency 'vrp'

ui_page 'html/index.html'

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

client_script {
	'@vrp/lib/utils.lua',
	'client.lua'
}

files {
	'html/index.html',
	'html/css/form.css',
	'html/js/script.js',
	'html/img/cursor.png',
	'html/js/validation.js',
	'html/js/debounce.min.js'
}