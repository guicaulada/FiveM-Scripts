
cfg = {}

cfg.carwash = { -- carwash locations
	{26.5906,  -1392.0261,  29.3634},
	{167.1034,  -1719.4704,  29.2916},
	{-74.5693,  6427.8715,  31.4400},
	{-699.6325,  -932.7043,  19.0139}
}

cfg.blip = {
  id = 100, -- 100 = carwash
  color = 18
}

cfg.price = 5 -- price per dirt level

cfg.lang = {
  title = "Carwash",
  cleaned = "~r~Vehicle already clean",
  goodbye = "~g~Goodbye have a nice day!",
  no_veh = "~r~You are not in a vehicle"
}

return cfg