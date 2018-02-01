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
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client.lua",
  "playerblips/client.lua",
  "runcode/client.lua",
  "tptowaypoint/client.lua",
  "drag/client.lua",
  "spikes/client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "runcode/server.lua",
  "server.lua"
}
