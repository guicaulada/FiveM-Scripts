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


description "vrp_basic_menu"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua",
  -- load client functions
  "cfg/client/admin.lua",
  "cfg/client/main.lua",
  "cfg/client/player.lua",
  "cfg/client/police.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
  -- load server functions
  "cfg/server/admin.lua",
  "cfg/server/phone.lua",
  "cfg/server/police.lua",
  -- load items and buttons
  "cfg/items.lua",
  "cfg/buttons/main.lua",
  "cfg/buttons/police.lua",
  "cfg/buttons/player.lua",
  "cfg/buttons/phone.lua",
  "cfg/buttons/admin.lua",
  "cfg/buttons/static.lua",
  -- load menus with buttons
  "cfg/menus/main.lua",
  "cfg/menus/police.lua",
  "cfg/menus/player.lua",
  "cfg/menus/phone.lua",
  "cfg/menus/admin.lua",
  "cfg/menus/static.lua"
}

files{
  -- load client lang
  "cfg/lang/en.lua"
}