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
-- Configure blip colors at cfg/display.lua
cfg.teams = { -- Only one team for each group, you can set multiple teams, groups on same team will see each other's blips
  ["COPS"] = { -- Team name must be unique
    -- groups
    "police",
    "sheriff"
  },
  -- create more teams here
}

return cfg