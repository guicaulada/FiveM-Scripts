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