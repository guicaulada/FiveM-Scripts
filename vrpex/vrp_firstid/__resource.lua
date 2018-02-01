--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

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