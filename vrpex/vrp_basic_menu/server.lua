Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
BMclient = Tunnel.getInterface("vrp_basic_menu")
BSclient = Tunnel.getInterface("vrp_barbershop")
Tunnel.bindInterface("vrp_basic_menu",vRPbm)
Proxy.addInterface("vrp_basic_menu",vRPbm)
lcfg = module("vrp", "cfg/base")
-- load global and local languages
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
Lang:loadLocale(lcfg.lang, module("vrp_basic_menu", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

-- LOG FUNCTION
function vRPbm.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end
