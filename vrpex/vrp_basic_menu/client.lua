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

--bind client tunnel interface
vRPbm = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

Tunnel.bindInterface("vrp_basic_menu",vRPbm)
vRPserver = Tunnel.getInterface("vRP")
HKserver = Tunnel.getInterface("vrp_hotkeys")
BMserver = Tunnel.getInterface("vrp_basic_menu")
Proxy.addInterface("vrp_basic_menu",vRPbm)
vRP = Proxy.getInterface("vRP")

local client_lang = "en" -- change to your lang

lang = module("vrp_basic_menu", "cfg/lang/"..client_lang)