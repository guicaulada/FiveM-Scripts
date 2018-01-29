
local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
  ["melees"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_BOTTLE"] = {"Bottle",10000,0,""},
    ["WEAPON_BAT"] = {"Bat",15000,0,""},
    ["WEAPON_KNUCKLE"] = {"Knuckle",15000,0,""},
    ["WEAPON_KNIFE"] = {"Knife",20000,0,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["sidearms"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_MARKSMANPISTOL"] = {"Marksman Pistol",15000,15,""},
    ["WEAPON_SNSPISTOL"] = {"Pistol",25000,15,""},
    ["WEAPON_VINTAGEPISTOL"] = {"Vintage Pistol",25000,15,""},
    ["WEAPON_PISTOL"] = {"Pistol",25000,15,""},
    ["WEAPON_COMBATPISTOL"] = {"Combat Pistol",50000,15,""},
    ["WEAPON_HEAVYPISTOL"] = {"Heavy Pistol",50000,15,""},
    ["WEAPON_REVOLVER"] = {"Heavy Revolver",50000,15,""},
    ["WEAPON_APPISTOL"] = {"Ap Pistol",75000,15,""},
    ["WEAPON_DAGGER"] = {"Dagger",20000,0,""},
    ["WEAPON_HAMMER"] = {"Hammer",25000,0,""},
    ["WEAPON_HATCHET"] = {"Hatchet",30000,0,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["submachineguns"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_MICROSMG"] = {"Mini SMG",150000,25,""},
    ["WEAPON_SMG"] = {"SMG",200000,25,""},
    ["WEAPON_ASSAULTSMG"] = {"Assault SMG",550000,25,""},
    ["WEAPON_COMBATPDW"] = {"Combat PDW",750000,25,""},
    ["WEAPON_MACHINEPISTOL"] = {"Machine Pistol",75000,25,""},
    ["WEAPON_NIGHTSTICK"] = {"Nighstick",30000,0,""},
    ["WEAPON_CROWBAR"] = {"Crowwbar",30000,0,""},
    ["WEAPON_GOLFCLUB"] = {"Golf club",35000,0,""},
    ["WEAPON_SWITCHBLADE"] = {"Blade",40000,0,""},
    ["WEAPON_MACHETE"] = {"Machete",45000,0,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["rifles"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_MARKSMANPISTOL"] = {"Marksman Pistol",15000,15,""},
    ["WEAPON_SNSPISTOL"] = {"Pistol",25000,15,""},
    ["WEAPON_COMPACTRIFLE"] = {"Mini SMG",200000,50,""},
    ["WEAPON_ASSAULTRIFLE"] = {"Assault Rifle",200000,50,""},
    ["WEAPON_CARBINERIFLE"] = {"Carabine Rifle",200000,50,""},
    ["WEAPON_GRENADE"] = {"Grenade",500000,70,""},
    ["WEAPON_MOLOTOV"] = {"Molotv",150000,45,""},
    ["WEAPON_FLARE"] = {"Flare",20000,50,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["heavymachineguns"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_GUSENBERG"] = {"Gusenberg MG",200000,50,""},
    ["WEAPON_MG"] = {"MG",250000,50,""},
    ["WEAPON_COMBATMG"] = {"Combat MG",500000,70,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["snipers"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_MARKSMANPISTOL"] = {"Marksman Pistol",15000,15,""},
    ["WEAPON_SNSPISTOL"] = {"Pistol",25000,15,""},
    ["WEAPON_MARKSMANRIFLE"] = {"Marksman Rifle",150000,45,""},
    ["WEAPON_SNIPERRIFLE"] = {"Sniper Rifle",200000,50,""},
    ["WEAPON_HEAVYSNIPER"] = {"Heavy Rifle",500000,50,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["carabines"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_BULLPUPRIFLE"] = {"Bullpup Rifle",200000,50,""},
    ["WEAPON_ADVANCEDRIFLE"] = {"Carabine",250000,50,""},
    ["WEAPON_SPECIALCARBINE"] = {"Special Carabine",300000,50,""},
    ["WEAPON_GRENADE"] = {"Grenade",500000,70,""},
    ["WEAPON_MOLOTOV"] = {"Molotv",150000,45,""},
    ["WEAPON_FLARE"] = {"Flare",20000,50,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["shotguns"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_SAWNOFFSHOTGUN"] = {"Saw Shotgun",350000,65,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",500000,70,""},
    ["WEAPON_BULLPUPSHOTGUN"] = {"BullUp Shotgun",650000,72,""},
    ["WEAPON_HEAVYSHOTGUN"] = {"Heavy Shotgun",750000,75,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Assault Shotgun",1000000,80,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["explosives"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = {"Grenade Launcher",1000000,100,""},
    ["WEAPON_FIREEXTINGUISHER"] = {"Fire Extinguisher",1000,0,""},
    ["WEAPON_FIREWORK"] = {"Firework",1000000,0,""},
    ["WEAPON_SNOWBALL"] = {"SnowBall",30,0,""},
    ["WEAPON_FLASHLIGHT"] = {"FlashLight",500,0,""},
    ["WEAPON_STUNGUN"] = {"Stungun",10000,0,""},
    ["WEAPON_MUSKET"] = {"Musket",150000,0,""},
    ["WEAPON_FLAREGUN"] = {"Flaregun",50000,0,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  },

  ["basic"] = {
    _config = {blipid=110,blipcolor=75},
    ["WEAPON_MARKSMANPISTOL"] = {"Marksman Pistol",15000,15,""},
    ["WEAPON_SNSPISTOL"] = {"SNS Pistol",25000,15,""},
    ["WEAPON_GRENADE"] = {"Grenade",500000,70,""},
    ["WEAPON_SMOKEGRENADE"] = {"Smoke Grenade",50000,0,""},
    ["WEAPON_PETROLCAN"] = {"Petrol",5000,0,""},
    ["ARMOR"] = {"Body Armor",10000,0,""}
  }
}

-- list of gunshops positions

cfg.gunshops = {
  {"melees", 1692.41, 3758.22, 34.7053},
  {"sidearms", 252.696, -48.2487, 69.941},
  {"carabines", 844.299, -1033.26, 28.1949},
  {"rifles", -331.624, 6082.46, 31.4548},
  {"submachineguns", -664.147, -935.119, 21.8292},
  {"sidearms", -1305.45056152344,-394.0068359375,36.6957740783691},
  {"explosives", -1119.48803710938,2697.08666992188,18.5541591644287},
  {"heavymachineguns", 2569.62, 294.453, 108.735},
  {"snipers", -3172.60375976563,1085.74816894531,20.8387603759766},
  {"shotguns", 21.70, -1107.41, 29.79},
  {"basic", 810.15, -2156.88, 29.61}
}

return cfg
