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

cfg.lang = "en"

-- example of study transformer
local itemtr_study = {
  name="Bookcase", -- menu name
  r=0,g=255,b=0, -- color
  max_units=20,
  units_per_minute=10,
  x=0,y=0,z=0, -- pos (doesn't matter as home component)
  radius=1.1, height=1.5, -- area
  recipes = {
    ["Chemicals book"] = { -- action name
      description="Read a chemicals book", -- action description
      in_money=0, -- money taken per unit
      out_money=0, -- money earned per unit
      reagents={}, -- items taken per unit
      products={}, -- items given per unit
      aptitudes={ -- optional
        ["science.chemicals"] = 1 -- "group.aptitude", give 1 exp per unit
      }
    },
    ["Mathematics book"] = { -- action name
      description="Read a mathematics book", -- action description
      in_money=0, -- money taken per unit
      out_money=0, -- money earned per unit
      reagents={}, -- items taken per unit
      products={}, -- items given per unit
      aptitudes={ -- optional
        ["science.mathematics"] = 1 -- "group.aptitude", give 1 exp per unit
      }
    },
    ["Tachnology book"] = { -- action name
      description="Read a technology book", -- action description
      in_money=0, -- money taken per unit
      out_money=0, -- money earned per unit
      reagents={}, -- items taken per unit
      products={}, -- items given per unit
      aptitudes={ -- optional
        ["science.technology"] = 1 -- "group.aptitude", give 1 exp per unit
      }
    }
  }
}

-- default flats positions from https://github.com/Nadochima/HomeGTAV/blob/master/List

-- define the home slots (each entry coordinate should be unique for ALL types)
-- each slots is a list of home components
--- {component,x,y,z} (optional _config)
--- the entry component is required
cfg.slot_types = {
  ["basic_flat"] = {
    {
      {"entry",-782.171,324.589,223.258},
      {"chest",-773.718078613281,325.144409179688,223.266357421875, _config = {weight=200}},
      {"wardrobe",-760.885437011719,325.457153320313,217.061080932617},
      {"gametable",-755.40185546875,318.263214111328,221.875823974609},
      {"itemtr", _config = itemtr_study, -758.670104980469,315.048156738281,221.854904174805}
    },
    {
      {"entry",-774.171,333.589,207.621},
      {"chest",-782.118591308594,332.147399902344,207.629608154297, _config = {weight=200}},
      {"wardrobe",-795.118469238281,331.631256103516,201.42431640625},
      {"gametable",-800.763427734375,338.574951171875,206.239105224609},
      {"itemtr", _config = itemtr_study, -797.283447265625,342.134338378906,206.21842956543}
    },
    {
      {"entry",-774.171,333.589,159.998},
      {"chest",-782.66015625,332.523284912109,160.010223388672, _config = {weight=200}},
      {"wardrobe",-795.550964355469,332.229614257813,153.804931640625},
      {"gametable",-801.228942871094,339.106231689453,158.619750976563},
      {"itemtr", _config = itemtr_study, -797.896728515625,342.543273925781,158.599044799805}
    },
    {
      {"entry",-596.689,59.139,108.030},
      {"chest",-604.427001953125,57.0807762145996,108.035743713379, _config = {weight=200}},
      {"wardrobe",-617.180358886719,56.9536590576172,101.830520629883},
      {"gametable",-623.078796386719,63.688045501709,106.645317077637},
      {"itemtr", _config = itemtr_study, -619.724853515625,67.1367950439453,106.624366760254}
    },
    {
      {"entry",-1451.557,-523.546,69.556},
      {"chest",-1457.28601074219,-529.699523925781,69.565315246582, _config = {weight=200}},
      {"wardrobe",-1467.07995605469,-536.98583984375,63.3601188659668},
      {"gametable",-1476.12658691406,-534.873474121094,68.1748962402344},
      {"itemtr", _config = itemtr_study, -1475.36840820313,-530.117126464844,68.1540756225586}
    },
    {
      {"entry",-1452.185,-522.640,56.929},
      {"chest",-1457.3740234375,-529.737854003906,56.9376449584961, _config = {weight=200}},
      {"wardrobe",-1467.7158203125,-537.308349609375,50.732494354248},
      {"gametable",-1476.12670898438,-534.895751953125,55.547306060791},
      {"itemtr", _config = itemtr_study, -1475.39453125,-530.135192871094,55.5264129638672}
    },
    {
      {"entry",-907.900,-370.608,109.440},
      {"chest",-914.79296875,-375.26416015625,109.448974609375, _config = {weight=200}},
      {"wardrobe",-926.047912597656,-381.470153808594,103.243774414063},
      {"gametable",-934.216979980469,-378.082336425781,108.05859375},
      {"itemtr", _config = itemtr_study, -932.810302734375,-373.413330078125,108.03776550293}
    },
    {
      {"entry",-921.124,-381.099,85.480},
      {"chest",-915.268737792969,-375.818084716797,85.4891815185547, _config = {weight=200}},
      {"wardrobe",-904.0673828125,-369.910552978516,79.2839508056641},
      {"gametable",-895.890075683594,-373.167846679688,84.0987701416016},
      {"itemtr", _config = itemtr_study, -897.224792480469,-377.828887939453,84.0779266357422}
    },
    {
      {"entry",-464.453,-708.617,77.086},
      {"chest",-466.566558837891,-700.528991699219,77.0956268310547, _config = {weight=200}},
      {"wardrobe",-466.892852783203,-687.88720703125,70.8903503417969},
      {"gametable",-459.870513916016,-682.054565429688,75.7051773071289},
      {"itemtr", _config = itemtr_study, -456.510467529297,-685.274841308594,75.6842498779297}
    },
    {
      {"entry",-470.647,-689.459,53.402},
      {"chest",-469.077453613281,-697.664672851563,53.4144515991211, _config = {weight=200}},
      {"wardrobe",-468.939910888672,-710.398986816406,47.2093048095703},
      {"gametable",-475.543884277344,-716.226867675781,52.0241050720215},
      {"itemtr", _config = itemtr_study, -479.113037109375,-712.874938964844,52.0032043457031}
    }
  },
  ["other_flat"] = {
    {
      {"entry",-784.363,323.792,211.996},
      {"chest",-766.744384765625,328.375,211.396545410156, _config = {weight=500}},
      {"wardrobe",-793.502136230469,326.861846923828,210.796630859375},
      {"gametable",-781.973083496094,338.788482666016,211.231979370117},
      {"itemtr", _config = itemtr_study, -778.560241699219,333.439453125,211.197128295898}
    },
    {
      {"entry",-603.997,58.954,98.200},
      {"chest",-621.323669433594,54.2074241638184,97.5995330810547, _config = {weight=500}},
      {"wardrobe",-594.668823242188,55.5750961303711,96.9996185302734},
      {"gametable",-606.140441894531,43.8849754333496,97.4350128173828},
      {"itemtr", _config = itemtr_study, -608.968322753906,49.1769981384277,97.4001312255859}
    },
    {
      {"entry",-1453.013,-539.629,74.044},
      {"chest",-1466.57763671875,-528.339294433594,73.4436492919922, _config = {weight=500}},
      {"wardrobe",-1449.85034179688,-549.231323242188,72.8437194824219},
      {"gametable",-1466.37182617188,-546.663757324219,73.279052734375},
      {"itemtr", _config = itemtr_study, -1463.84411621094,-541.1962890625,73.2442169189453}
    },
    {
      {"entry",-912.547,-364.706,114.274},
      {"chest",-926.693176269531,-377.596130371094,113.674102783203, _config = {weight=500}},
      {"wardrobe",-903.66650390625,-364.023223876953,113.074157714844},
      {"gametable",-908.407165527344,-379.825714111328,113.509590148926},
      {"itemtr", _config = itemtr_study, -912.547,-364.706,114.274}
    }
  },
  ["ranch_main"] = {
    {
      {"entry",1391.9423828125,1132.10913085938,114.433587646484},
      {"chest",1401.99426269531,1132.26867675781,114.333648681641, _config = {weight=500}},
      {"wardrobe",1397.39868164063,1163.96044921875,114.333587646484},
      {"gametable",1397.07739257813,1132.19274902344,114.333572387695},
      {"itemtr", _config = itemtr_study, 1403.88098144531,1144.57775878906,114.333587646484}
    }
  },
  ["michael"] = {
    {
      {"entry",-815.78173828125,178.653060913086,72.1531295776367},
      {"chest",-809.922241210938,172.898391723633,76.7404251098633, _config = {weight=500}},
      {"wardrobe",-811.834533691406,175.139129638672,76.745361328125},
      {"gametable",-798.123046875,180.058746337891,72.8452529907227},
      {"itemtr", _config = itemtr_study, -806.559509277344,170.90104675293,72.8347549438477}
    }
  },
  ["franklin"] = {
    {
      {"entry",-14.2774753570557,-1440.33703613281,31.1015491485596},
      {"chest",-17.1449108123779,-1430.34619140625,31.1015338897705, _config = {weight=500}},
      {"wardrobe",-18.4449443817139,-1439.01623535156,31.1015453338623},
      {"gametable",-10.9005508422852,-1440.69470214844,31.1015453338623},
      {"itemtr", _config = itemtr_study, -12.4790229797363,-1436.97229003906,31.1015453338623}
    }
  }
}

-- define home clusters
cfg.homes = {
  ["Basic Housing 1"] = {
    slot = "basic_flat",
    entry_point = {-635.665,44.155,42.697},
    buy_price = 100000,
    sell_price = 80000,
    max = 99,
    blipid=40,
    blipcolor=4
  },
  ["Basic Housing 2"] = {
    slot = "basic_flat",
    entry_point = {-1446.769,-538.531,34.740},
    buy_price = 100000,
    sell_price = 80000,
    max = 99,
    blipid=40,
    blipcolor=4
  },
  ["Rich Housing"] = {
    slot = "other_flat",
    entry_point = {-770.921,312.537,85.698},
    buy_price = 500000,
    sell_price = 300000,
    max = 10,
    blipid=40,
    blipcolor=5
  },
  ["Rich Housing 2"] = {
    slot = "other_flat",
    entry_point = {-84.2591705322266,-822.232788085938,36.0280227661133},
    buy_price = 500000,
    sell_price = 300000,
    max = 25,
    blipid=40,
    blipcolor=5
  },
  ["Ranch Main"] = {
    slot = "ranch_main",
    entry_point = {1394.48278808594,1141.74035644531,114.606857299805},
    buy_price = 750000,
    sell_price = 500000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 1"] = {
    slot = "basic_flat",
    entry_point = {840.455139160156,-182.032470703125,74.1880493164063},
    buy_price = 150000,
    sell_price = 120000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 2"] = {
    slot = "basic_flat",
    entry_point = {149.283508300781,475.028900146484,142.504623413086},
    buy_price = 150000,
    sell_price = 120000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 3"] = {
    slot = "michael",
    entry_point = {-817.214721679688,177.902770996094,72.2278060913086},
    buy_price = 750000,
    sell_price = 500000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 4"] = {
    slot = "basic_flat",
    entry_point = {-1861.34899902344,310.284912109375,89.1132278442383},
    buy_price = 300000,
    sell_price = 200000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 5"] = {
    slot = "franklin",
    entry_point = {-14.1632394790649,-1442.03454589844,31.1011180877686},
    buy_price = 120000,
    sell_price = 90000,
    max = 1,
    blipid=40,
    blipcolor=26
  },
  ["Regular House 6"] = {
    slot = "basic_flat",
    entry_point = {-2587.8818359375,1911.06970214844,167.498947143555},
    buy_price = 300000,
    sell_price = 100000,
    max = 1,
    blipid=40,
    blipcolor=26
  }
}

return cfg
