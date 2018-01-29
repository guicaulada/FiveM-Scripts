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