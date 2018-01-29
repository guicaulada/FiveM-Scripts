ui_page 'html/ui.html'
dependency 'vrp'
files {
	'html/ui.html',
	'html/logo.png',
	'html/dmv.png',
	'html/cursor.png',
	'html/styles.css',
	'html/questions.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

client_script {
	'client.lua',
	'GUI.lua'
}