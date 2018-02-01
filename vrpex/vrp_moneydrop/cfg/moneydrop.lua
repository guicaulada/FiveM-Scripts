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

cfg = {}

cfg.autoloot = false -- Area loot
cfg.autoloot_key = 38 -- E

cfg.highlight = { -- Highlight money drop (rgba color)
  active = false,
  r = 255,
  g = 0,
  b = 0,
  a = 200
}

-- DONT CHANGE THESE IF YOU DONT KNOW HOW THEY WORK
cfg.basedrop = {
  low = 5, -- Lowest base money value (You may change this to lower the reward overall)
  high = 13, -- Highest base money value (You may change this to increase the reward overall)
  multiplier = 1.0, -- Base multiplier (probably replaced by RNG)
  min = 5, -- Base max amount dropped (probably replaced by RNG)
  max = 6 -- Base min amount dropped (probably replaced by RNG)
}
cfg.dropA = {
  prop = "prop_anim_cash_note", -- prop for this drop
  min_value = 0, -- Min money value to use this prop
  RNG = 0.75, -- If random number <= this, use this multiplier and min max
  multiplier = 0.85, -- finalvalue = basevalue * multiplier
  min = 2, -- min amount dropped
  max = 4 -- max amount dropped
}
cfg.dropB = {
  prop = "prop_anim_cash_pile_01", -- prop for this drop
  min_value = 20, -- Min money value to use this prop
  RNG = 0.45, -- If random number <= this, use this multiplier and min max
  multiplier = 1.1, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}
cfg.dropC = {
  prop = "prop_cash_envelope_01", -- prop for this drop
  min_value = 50, -- Min money value to use this prop
  RNG = 0.35, -- If random number >= this, use this multiplier and min max
  multiplier = 1.3, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}
cfg.dropD = {
  prop = "prop_cash_pile_02", --smaller prop
  min_value = 100, -- Min money value to use this prop
  RNG = 0.20, -- If random number >= this, use this multiplier and min max
  multiplier = 1.6, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}
cfg.dropE = {
  prop = "prop_cash_pile_01", -- bigger wad of cash
  min_value = 250, -- Min money value to use this prop
  RNG = 0.04, -- If random number >= this, use this multiplier and min max
  multiplier = 2.3, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}
cfg.dropF = {
  prop = "prop_money_bag_01", -- prop for this drop
  min_value = 500, -- Min money value to use this prop
  RNG = 0.02, -- If random number >= this, use this multiplier and min max
  multiplier = 4.0, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}
cfg.jackpot = { -- Max drop uses prop from dropF
  RNG = 0.009, -- If random number >= this, use this multiplier and min max
  multiplier = 5.0, -- finalvalue = basevalue * multiplier
  min = 1, -- min amount dropped
  max = 2 -- max amount dropped
}

return cfg