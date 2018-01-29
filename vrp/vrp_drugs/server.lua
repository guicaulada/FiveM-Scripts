-- a basic gunshop implementation
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_drugs")
Dclient = Tunnel.getInterface("vrp_drugs","vrp_drugs")
Tunnel.bindInterface("vrp_drugs",vRPd)

local cfg = module("vrp_drugs", "cfg/drugs")

for k,v in pairs(cfg.drugs) do
  vRP.defInventoryItem({k,v.name,v.desc,v.choices,v.weight})
end