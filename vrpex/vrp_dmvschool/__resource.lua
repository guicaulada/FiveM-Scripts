ui_page 'files/gui/html/ui.html'
dependency 'vrp'
files {
	'files/gui/html/ui.html',
	'files/gui/html/logo.png',
	'files/gui/html/dmv.png',
	'files/gui/html/cursor.png',
	'files/gui/html/styles.css',
	'files/gui/html/questions.js',
	'files/gui/html/scripts.js',
	'files/gui/html/debounce.min.js'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

client_script {
	'@vrp/lib/utils.lua',
	'files/gui/GUI.lua',
	'files/bin/functions.lua',
	'client.lua'
}

files{
  'cfg/dmv.lua',
  'cfg/lang/en.lua'
}