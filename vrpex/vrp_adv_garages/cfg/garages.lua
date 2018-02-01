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


local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition 
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be spawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: gtype, vtype, blipid, blipcolor, ghome, permissions (optional, only users with the permission will have access to the shop)
-- vtype: identifies the "type" of vehicle for the personal garages and vehicles (you can create new ones)
-- gtype: there are 5 gtypes> personal, showroom, shop, store and rental (you cant create new ones, one garage can have many gtypes)
   -- personal: allow you to get any personal vehicle of the same vtype of the garage
   -- showroom: allows you to see the vehicle model before purchasing it
   -- shop: allows you to modify your vehicle
   -- store: allows you to purchase and sell vehicles
   -- rental: allows you to rent vehicles for that session for a part of the price
-- ghome: links the garage with an address, only owners of that address will have see the garage
-- gpay: bank or wallet
-- Car/Mod: [id/model] = {"Display Name", price/amount, "", (optional) item}, -- when charging items, price becomes amount

cfg.lang = "en" -- lenguage file

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.75 -- sell for 75% of the original price

cfg.price = {
  repair = 500, -- value to repair the vehicle
  colour = 100, -- value will be charged 3 times for RGB
  extra = 100, -- value will be charged 3 times for RGB
  neon = 100 -- value will be charged 3 times for RGB
}

-- declare any item used on purchase that doesnt exist yet (name,description,choices,weight}
cfg.items = {
  ["issi2key"] = {"Issi 2 Key","Buys an Issi",nil,0.5} -- example
}

-- configure garage types
cfg.adv_garages = {
  ["Compacts"]  = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["blista"] = {"Blista", 15000, ""},
    ["brioso"] = {"Brioso R/A", 155000, ""},
    ["dilettante"] = {"Dilettante", 25000, ""},
    ["issi2"] = {"Issi", 1, "", "issi2key"}, -- vehicle sold by item as example
    ["panto"] = {"Panto", 85000, ""},
    ["prairie"] = {"Prairie", 30000, ""},
    ["rhapsody"] = {"Rhapsody", 120000, ""}
  },

  ["Coupe"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["cogcabrio"] = {"Cognoscenti Cabrio",180000, ""},
    ["exemplar"] = {"Exemplar", 200000, ""},
    ["f620"] = {"F620", 80000, ""},
    ["felon"] = {"Felon", 90000, ""},
    ["felon2"] = {"Felon GT", 95000, ""},
    ["jackal"] = {"Jackal", 60000, ""},
    ["oracle"] = {"Oracle", 80000, ""},
    ["oracle2"] = {"Oracle XS",82000, ""},
    ["sentinel"] = {"sentinel", 90000, ""},
    ["sentinel2"] = {"Sentinel XS", 60000, ""},
    ["windsor"] = {"Windsor",800000, ""},
    ["windsor2"] = {"Windsor Drop",850000, ""},
    ["zion"] = {"Zion", 60000, ""},
    ["zion2"] = {"Zion Cabrio", 65000, ""}
  },

  ["Sports"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["ninef"] = {"9F",120000, ""},
    ["ninef2"] = {"9F Cabrio",130000, ""},
    ["alpha"] = {"Alpha",150000, ""},
    ["banshee"] = {"Banshee",105000, ""},
    ["bestiagts"] = {"Bestia GTS",610000, ""},
    ["blista"] = {"Blista Compact",42000, ""},
    ["buffalo"] = {"Buffalo",35000, ""},
    ["buffalo2"] = {"Buffalo S",96000, ""},
    ["carbonizzare"] = {"Carbonizzare",195000, ""},
    ["comet2"] = {"Comet",100000, ""},
    ["coquette"] = {"Coquette",138000, ""},
    ["tampa2"] = {"Drift Tampa",995000, ""},
    ["feltzer2"] = {"Feltzer",130000, ""},
    ["furoregt"] = {"Furore GT",448000, ""},
    ["fusilade"] = {"Fusilade",36000, ""},
    ["jester"] = {"Jester",240000, ""},
    ["jester2"] = {"Jester (Racecar)",350000, ""},
    ["kuruma"] = {"Kuruma",95000, ""},
    ["lynx"] = {"Lynx",1735000, ""},
    ["massacro"] = {"Massacro",275000, ""},
    ["massacro2"] = {"Massacro (Racecar)",385000, ""},
    ["omnis"] = {"Omnis",701000, ""},
    ["penumbra"] = {"Penumbra",24000, ""},
    ["rapidgt"] = {"Rapid GT",140000, ""},
    ["rapidgt2"] = {"Rapid GT Convertible",150000, ""},
    ["schafter3"] = {"Schafter V12",140000, ""},
    ["sultan"] = {"Sultan",12000, ""},
    ["surano"] = {"Surano",110000, ""},
    ["tropos"] = {"Tropos",816000, ""},
    ["verlierer2"] = {"Verkierer",695000,""}
  },

  ["Classics"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=5},
    ["casco"] = {"Casco",680000, ""},
    ["coquette2"] = {"Coquette Classic",665000, ""},
    ["jb700"] = {"JB 700",350000, ""},
    ["pigalle"] = {"Pigalle",400000, ""},
    ["stinger"] = {"Stinger",850000, ""},
    ["stingergt"] = {"Stinger GT",875000, ""},
    ["feltzer3"] = {"Stirling",975000, ""},
    ["ztype"] = {"Z-Type",950000,""}
  },

  ["Super Cars"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=5},
    ["adder"] = {"Adder",1000000, ""},
    ["banshee2"] = {"Banshee 900R",565000, ""},
    ["bullet"] = {"Bullet",155000, ""},
    ["cheetah"] = {"Cheetah",650000, ""},
    ["entityxf"] = {"Entity XF",795000, ""},
    ["sheava"] = {"ETR1",199500, "4 - (smaller number better car"},
    ["fmj"] = {"FMJ",1750000, "10 - (smaller number better car"},
    ["infernus"] = {"Infernus",440000, ""},
    ["osiris"] = {"Osiris",1950000, "8 - (smaller number better car"},
    ["le7b"] = {"RE-7B",5075000, "1 - (smaller number better car"},
    ["reaper"] = {"Reaper",1595000, ""},
    ["sultanrs"] = {"Sultan RS",795000, ""},
    ["t20"] = {"T20",2200000,"7 - (smaller number better car"},
    ["turismor"] = {"Turismo R",500000, "9 - (smaller number better car"},
    ["tyrus"] = {"Tyrus",2550000, "5 - (smaller number better car"},
    ["vacca"] = {"Vacca",240000, ""},
    ["voltic"] = {"Voltic",150000, ""},
    ["prototipo"] = {"X80 Proto",2700000, "6 - (smaller number better car"},
    ["zentorno"] = {"Zentorno",725000,"3 - (smaller number better car"}
  },

  ["Muscle Cars"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["blade"] = {"Blade",160000, ""},
    ["buccaneer"] = {"Buccaneer",29000, ""},
    ["Chino"] = {"Chino",225000, ""},
    ["coquette3"] = {"Coquette BlackFin",695000, ""},
    ["dominator"] = {"Dominator",35000, ""},
    ["dukes"] = {"Dukes",62000, ""},
    ["gauntlet"] = {"Gauntlet",32000, ""},
    ["hotknife"] = {"Hotknife",90000, ""},
    ["faction"] = {"Faction",36000, ""},
    ["nightshade"] = {"Nightshade",585000, ""},
    ["picador"] = {"Picador",9000, ""},
    ["sabregt"] = {"Sabre Turbo",15000, ""},
    ["tampa"] = {"Tampa",375000, ""},
    ["virgo"] = {"Virgo",195000, ""},
    ["vigero"] = {"Vigero",21000, ""}
  },

  ["Off-Road"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["bifta"] = {"Bifta",75000, ""},
    ["blazer"] = {"Blazer",8000, ""},
    ["brawler"] = {"Brawler",715000, ""},
    ["dubsta3"] = {"Bubsta 6x6",249000, ""},
    ["dune"] = {"Dune Buggy",20000, ""},
    ["rebel2"] = {"Rebel",22000, ""},
    ["sandking"] = {"Sandking",38000, ""},
    ["monster"] = {"The Liberator",550000, ""},
    ["trophytruck"] = {"Trophy Truck",550000, ""}
  },

  ["SUVs"]  = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["baller"] = {"Baller",90000, ""},
    ["cavalcade"] = {"Cavalcade",60000, ""},
    ["granger"] = {"Grabger",35000, ""},
    ["huntley"] = {"Huntley",195000, ""},
    ["landstalker"] = {"Landstalker",58000, ""},
    ["radi"] = {"Radius",32000, ""},
    ["rocoto"] = {"Rocoto",85000, ""},
    ["seminole"] = {"Seminole",30000, ""},
    ["xls"] = {"XLS",253000, ""}
  },

  ["Vans"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["bison"] = {"Bison",30000, ""},
    ["bobcatxl"] = {"Bobcat XL",23000, ""},
    ["gburrito"] = {"Gang Burrito",65000, ""},
    ["journey"] = {"Journey",15000, ""},
    ["minivan"] = {"Minivan",30000, ""},
    ["paradise"] = {"Paradise",25000, ""},
    ["rumpo"] = {"Rumpo",13000, ""},
    ["surfer"] = {"Surfer",11000, ""},
    ["youga"] = {"Youga",16000, ""}
  },

  ["Sedans"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="car",blipid=50,blipcolor=4},
    ["asea"] = {"Asea",1000000, ""},
    ["asterope"] = {"Asterope",1000000, ""},
    ["cognoscenti"] = {"Cognoscenti",1000000, ""},
    ["cognoscenti2"] = {"Cognoscenti(Armored)",1000000, ""},
    ["cog55"] = {"Cognoscenti 55",1000000, ""},
    ["cog552"] = {"Cognoscenti 55(Armored)",1500000, ""},
    ["fugitive"] = {"Fugitive",24000, ""},
    ["glendale"] = {"Glendale",200000, ""},
    ["ingot"] = {"Ingot",9000, ""},
    ["intruder"] = {"Intruder",16000, ""},
    ["premier"] = {"Premier",10000, ""},
    ["primo"] = {"Primo",9000, ""},
    ["primo2"] = {"Primo Custom",9500, ""},
    ["regina"] = {"Regina",8000, ""},
    ["schafter2"] = {"Schafter",65000, ""},
    ["stanier"] = {"Stanier",10000, ""},
    ["stratum"] = {"Stratum",10000, ""},
    ["stretch"] = {"Stretch",30000, ""},
    ["superd"] = {"Super Diamond",250000, ""},
    ["surge"] = {"Surge",38000, ""},
    ["tailgater"] = {"Tailgater",55000, ""},
    ["warrener"] = {"Warrener",120000, ""},
    ["washington"] = {"Washington",15000, ""}
  },
  
  ["Motorcycles"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental"},vtype="bike",blipid=226,blipcolor=4},
    ["AKUMA"] = {"Akuma",9000, ""},
    ["bagger"] = {"Bagger",5000, ""},
    ["bati"] = {"Bati 801",15000, ""},
    ["bati2"] = {"Bati 801RR",15000, ""},
    ["bf400"] = {"BF400",95000, ""},
    ["carbonrs"] = {"Carbon RS",40000, ""},
    ["cliffhanger"] = {"Cliffhanger",225000, ""},
    ["daemon"] = {"Daemon",5000, ""},
    ["double"] = {"Double T",12000, ""},
    ["enduro"] = {"Enduro",48000, ""},
    ["faggio2"] = {"Faggio",4000, ""},
    ["gargoyle"] = {"Gargoyle",120000, ""},
    ["hakuchou"] = {"Hakuchou",82000, ""},
    ["hexer"] = {"Hexer",15000, ""},
    ["innovation"] = {"Innovation",90000, ""},
    ["lectro"] = {"Lectro",700000, ""},
    ["nemesis"] = {"Nemesis",12000, ""},
    ["pcj"] = {"PCJ-600",9000, ""},
    ["ruffian"] = {"Ruffian",9000, ""},
    ["sanchez"] = {"Sanchez",7000, ""},
    ["sovereign"] = {"Sovereign",90000, ""},
    ["thrust"] = {"Thrust",75000, ""},
    ["vader"] = {"Vader",9000, ""},
    ["vindicator"] = {"Vindicator",600000,""}
  },
  
  ["Industrial"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="industrial",blipid=50,blipcolor=4},
    ["guardian"] = {"Guardian",375000, ""},
    ["bulldozer"] = {"Bulldozer",500000, ""},
    ["cutter"] = {"Cutter",1100000, ""},
    ["dump"] = {"Dump",800000, ""},
    ["rubble"] = {"Rubble",215000, ""},
    ["flatbed"] = {"Flatbed",90000, ""},
    ["handler"] = {"Handler",110000, ""},
    ["mixer"] = {"Mixer",125500, ""},
    ["tiptruck"] = {"Tiptruck",85000, ""}
  },
  
  ["Commercial"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="commercial",blipid=50,blipcolor=4},
    ["benson"] = {"Benson",73000, ""},
    ["biff"] = {"Biff",65000, ""},
    ["hauler"] = {"Hauler",80000, ""},
    ["mule"] = {"Mule",70000, ""},
    ["packer"] = {"Packer",78600, ""},
    ["phantom"] = {"Phantom",115200, ""},
    ["pounder"] = {"Pounder",110000, ""}
  },
  
  ["Emergency"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="emergency",blipid=50,blipcolor=4},
    ["ambulance"] = {"Ambulance",83000, ""},
    ["policet"] = {"Police Transport",110000, ""},
    ["fbi"] = {"FBI",80000, ""},
    ["firetruk"] = {"Firetruck",145200, ""},
    ["lguard"] = {"Lifeguard",96300, ""},
    ["pbus"] = {"Police Bus",60000, ""},
    ["police"] = {"Police Cruiser",87000, ""},
    ["pranger"] = {"Police Ranger",93000, ""},
    ["riot"] = {"Police Riot",425000, ""},
    ["sheriff"] = {"The Sheriff",90200, ""}
  },
  
  ["Service"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="service",blipid=50,blipcolor=4},
    ["bus"] = {"Bus",500000, ""},
    ["coach"] = {"Coach",300000, ""},
    ["airbus"] = {"Airbus",550000, ""},
    ["rentalbus"] = {"Minibus",30000, ""},
    ["taxi"] = {"Taxi",20000, ""},
    ["trash"] = {"Trashmaster",90000, ""},
    ["tourbus"] = {"Tour Bus",45000, ""}
  },
  
  ["Military"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="military",blipid=50,blipcolor=4},
    ["brickade"] = {"Brickade",1110000, ""},
    ["barracks"] = {"Barracks",450000, ""},
    ["crusader"] = {"Crusader",225000, ""},
    ["rhino"] = {"Rhino",3000000, ""}
  },
  
  ["Military Planes"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="mil_plane",blipid=16,blipcolor=4},
    ["besra"] = {"Besra",1150000, ""},
    ["hydra"] = {"Hydra",3990000, ""},
    ["titan"] = {"Titan",2000000, ""},
    ["lazer"] = {"P-996 LAZER",4700000, ""},
    ["cargoplane"] = {"Cargo Plane",2100000, ""}
  },
  
  ["Civilian Planes"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental","personal"},vtype="civ_plane",blipid=307,blipcolor=4},
    ["nimbus"] = {"Nimbus",1900000, ""},
    ["vestra"] = {"Vestra",950000, ""},
    ["miljet"] = {"Miljet",1700000, ""},
    ["dodo"] = {"Dodo",500000, ""},
    ["velum"] = {"Velum",450000, ""},
    ["cuban800"] = {"Cuban 800",240000, ""},
    ["duster"] = {"Duster",275000, ""},
    ["stunt"] = {"Stuntplane",150000, ""},
    ["mammatus"] = {"Mammatus",300000, ""},
    ["jet"] = {"Jet",1500000, ""},
    ["shamal"] = {"Shamal",1150000, ""},
    ["luxor"] = {"Luxor",1625000, ""}
  },
  
  ["Military Helicopters"] = {
    _config = {gpay="wallet",gtype={"rental"},vtype="mil_heli",blipid=64,blipcolor=4},
    ["savage"] = {"Savage",2593500, ""},
    ["valkyrie"] = {"Valkyrie",3790500, ""},
    ["annihilator"] = {"Annihilator",2825000, ""},
    ["buzzard"] = {"Buzzard",900000, ""},
    ["cargobob"] = {"Cargobob",2200000, ""}
  },
  
  ["Civilian Helicopters"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental","personal"},vtype="civ_heli",blipid=43,blipcolor=4},
    ["supervolito"] = {"Super Volito",2113000, ""},
    ["volatus"] = {"Volatus",2295000, ""},
    ["swift"] = {"Swift",1500000, ""},
    ["skylift"] = {"Skylift",1745000, ""},
    ["maverick"] = {"Maverick",780000, ""},
    ["frogger"] = {"Frogger",1300000, ""}
  },
  
  ["Boats"] = {
    _config = {gpay="bank",gtype={"showroom","store","rental","personal"},vtype="boat",blipid=266,blipcolor=4},
    ["tug"] = {"Tug Boat",1250000, ""},
    ["squalo"] = {"Squalo",196621, ""},
    ["marquis"] = {"Marquis",413990, ""},
    ["speeder"] = {"Speeder",325000, ""},
    ["dinghy"] = {"Dinghy",166250, ""},
    ["jetmax"] = {"Jetmax",299000, ""},
    ["predator"] = {"Predator",825710, ""},
    ["tropic"] = {"Tropic",22000, ""},
    ["seashark"] = {"Seashark",16899, ""},
    ["submersible"] = {"Submersible",1150000, ""},
    ["submersible2"] = {"Kraken",1325000, ""},
    ["suntrap"] = {"Suntrap",25160, ""},
    ["toro"] = {"Toro",1750000, ""}
  },
  
  ["Personal"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3},
	-- Vehicles of differenty vtype can be added to the personal garage, adding to one means adding to all of the same vtype
    ["AKUMA"] = {"Akuma",9000, ""},
    ["bagger"] = {"Bagger",5000, ""},
    ["bati"] = {"Bati 801",15000, ""},
    ["bati2"] = {"Bati 801RR",15000, ""},
    ["bf400"] = {"BF400",95000, ""},
    ["carbonrs"] = {"Carbon RS",40000, ""},
    ["cliffhanger"] = {"Cliffhanger",225000, ""},
    ["daemon"] = {"Daemon",5000, ""},
    ["double"] = {"Double T",12000, ""},
    ["enduro"] = {"Enduro",48000, ""},
    ["faggio2"] = {"Faggio",4000, ""},
    ["gargoyle"] = {"Gargoyle",120000, ""},
    ["hakuchou"] = {"Hakuchou",82000, ""},
    ["hexer"] = {"Hexer",15000, ""},
    ["innovation"] = {"Innovation",90000, ""},
    ["lectro"] = {"Lectro",700000, ""},
    ["nemesis"] = {"Nemesis",12000, ""},
    ["pcj"] = {"PCJ-600",9000, ""},
    ["ruffian"] = {"Ruffian",9000, ""},
    ["sanchez"] = {"Sanchez",7000, ""},
    ["sovereign"] = {"Sovereign",90000, ""},
    ["thrust"] = {"Thrust",75000, ""},
    ["vader"] = {"Vader",9000, ""},
    ["vindicator"] = {"Vindicator",600000,""}
  },
  
  ["Ranch Main"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Ranch Main"},
  },
  ["Rich Housing"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Rich Housing"},
  },
  ["Rich Housing 2"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Rich Housing 2"},
  },
  ["Basic Housing 1"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Basic Housing 1"},
  },
  ["Basic Housing 2"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Basic Housing 2"},
  },
  ["Regular House 1"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 1"},
  },
  ["Regular House 2"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 2"},
  },
  ["Regular House 3"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 3"},
  },
  ["Regular House 4"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 4"},
  },
  ["Regular House 5"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 5"},
  },
  ["Regular House 6"]  = {
    _config = {gpay="wallet",gtype={"personal"},vtype="car",blipid=357,blipcolor=3,ghome="Regular House 6"},
  },
  
  ["LS Customs"]  = {
    _config = {gpay="wallet",gtype={"shop"},vtype="car",blipid=72,blipcolor=7},
	_shop = {
	  -- You can make different shops with different modifications for each garage of gtype shop
	  [0] = {"Spoilers",500,""},
	  [1] = {"Front Bumper",500,""},
      [2] = {"Rear Bumper",500,""}, 
      [3] = {"Side Skirt",500,""},  
      [4] = {"Exhaust",500,""},     
      [5] = {"Frame",500,""},       
      [6] = {"Grille",500,""},      
      [7] = {"Hood",500,""},        
      [8] = {"Fender",500,""},      
      [9] = {"Right Fender",500,""},
      [10] = {"Roof",500,""},        
      [11] = {"Engine",500,""},      
      [12] = {"Brakes",500,""},      
      [13] = {"Transmission",500,""},
      [14] = {"Horns",500,""},       
      [15] = {"Suspension",500,""},  
      [16] = {"Armor",500,""},      
      [18] = {"Turbo",500,""},
      [20] = {"Tire Smoke",500,""},
      [22] = {"Xenon Headlights",500,""},
      [23] = {"Wheels",500,"Press enter to change wheel type"},
      [24] = {"Back Wheels (Bike)",500,""}, 
      [25] = {"Plateholders",500,""},
      [27] = {"Trims",500,""},       
      [28] = {"Ornaments",500,""},   
      [29] = {"Dashboards",500,""},  
      [30] = {"Dials",500,""},       
      [31] = {"Door Speakers",500,""},
      [32] = {"Seats",500,""},       
      [33] = {"Steering Wheel",500,""},
      [34] = {"H Shift",500,""},     
      [35] = {"Plates",500,""},      
      [36] = {"Speakers",500,""},    
      [37] = {"Trunks",500,""},      
      [38] = {"Hydraulics",500,""},  
      [39] = {"Engine Block",500,""},
      [40] = {"Air Filter",500,""},  
      [41] = {"Struts",500,""},      
      [42] = {"Arch Covers",500,""}, 
      [43] = {"Arials",500,""},      
      [44] = {"Extra Trims",500,""}, 
      [45] = {"Tanks",500,""},       
      [46] = {"Windows",500,""},     
      [48] = {"Livery",500,""},      
	}
  },
}

-- position garages on the map {garage_type,x,y,z}
cfg.garages = {

  -- default garages
  {"Compacts",-354.988891601563,-115.710586547852,38.6966323852539},
  {"Coupe",698.135375976563,-1130.54235839844,23.348726272583},
  {"SUVs",-1117.03161621094,-2012.15710449219,13.1818408966064},
  {"Supers",2132.22802734375,4780.6083984375,40.9702758789063},
  {"Motorcycles",74.1576232910156,3643.208984375,39.5487213134766},
  {"Motorcycles",981.791748046875,-113.413665771484,74.0816955566406},
  {"Vans",1224.89562988281,2722.58666992188,38.0041313171387},
  {"Sedans",233.66178894043,-789.788513183594,30.5983638763428},
  {"Sports",-2294.12915039063,372.463104248047,174.601791381836},
  {"Muscle Cars",-2186.0439453125,-410.179321289063,13.095627784729},
  {"Off-Road",-81.005973815918,6494.27587890625,31.490894317627},
  {"Emergency",-569.772766113281,-147.19221496582,37.948974609375},
  {"Commercial",1225.87951660156,-3228.38916015625,6.02876377105713},
  {"Industrial",912.464477539063,-1523.63122558594,30.7371978759766},
  {"Service",916.735717773438,-162.684844970703,74.7201614379883},
  {"Military",-2132.3681640625,3263.23583984375,32.8102760314941},
  {"Classics",-205.789, -1308.02, 31.2916},
  
  -- personal garages
  {"Personal",215.124,-791.377,30.646},
  {"Personal",-334.685,289.773,85.705},
  {"Personal",-55.272,-1838.71,26.442},
  {"Personal",126.434,6610.04,31.750},
  
  -- lscustoms
  {"LS Customs",-337.3863,-136.9247,39.0737},
  {"LS Customs",-1155.536,-2007.183,13.244},
  {"LS Customs",731.8163,-1088.822,22.233},
  {"LS Customs",1175.04,2640.216,37.82177},
  {"LS Customs",110.8406,6626.568,32.287},
  
  -- house garages
  {"Ranch Main", 1408.32495117188,1117.44665527344,114.737692260742},
  {"Rich Housing", -751.5107421875,365.883117675781,87.9666687011719},
  {"Rich Housing 2",	-81.860595703125,-809.427734375,36.4030570983887},
  {"Basic Housing 1", -635.4501953125,57.4368324279785,44.8587303161621},
  {"Basic Housing 2", -1448.18701171875,-514.856567382813,31.6881823348999},
  {"Regular House 1", 843.398803710938,-191.063568115234,72.6714935302734},
  {"Regular House 2",  174.276748657227,483.056274414063,142.339096069336},
  {"Regular House 3", -820.590148925781,184.175857543945,72.0921401977539},
  {"Regular House 4", -1858.14965820313,328.570861816406,88.6500091552734},
  {"Regular House 5", -25.002462387085,-1436.29431152344,30.6531391143799},
  {"Regular House 6", -2587,1930.97326660156,167.304656982422},
  
  -- planes and boats
  {"Boats",-849.5, -1368.64, 1.6},
  {"Civilian Planes",1640, 3236, 40.4},
  {"Military Planes",-1348, -2230, 13.9},
  {"Civilian Helicopters",1750, 3260, 41.37},
  {"Military Helicopters",-1233, -2269, 13.9},
  {"Civilian Planes",-1277.59094238281,-3391.39233398438,13.9401473999023},
  {"Military Planes",1066.958984375,3078.87353515625,41.0369453430176},
  {"Civilian Helicopters",-745.37255859375,-1468.43969726563,5.00051975250244},
  {"Military Helicopters",1403.12109375,3002.36987304688,40.5485992431641},
  --{"planes",2123, 4805, 41.19},
  --{"helicopters",-745, -1468, 5},
  --{"boats",1538, 3902, 30.35}
  
}

return cfg
