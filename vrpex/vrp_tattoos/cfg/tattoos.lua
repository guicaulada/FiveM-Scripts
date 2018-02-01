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

-- list of tattoos for sale
-- for the native name, see the tattoos folder, the native names of the tattoos is in the files with the native name of the it's shop
-- create groups like for the garage config
-- [display_name] = {native_tattoo_name,price,description}

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)
-- https://wiki.gtanet.work/index.php?title=Blips
-- https://wiki.fivem.net/wiki/Controls

cfg.tattoos = {
	["mpbeach_overlays"] = { -- native store name
		_config = {blipid=75,blipcolor=48,title="Beach Tattoos"}, -- you can add permissions like on other vRP features
		[">Clear Tattoos"] = {"CLEAR",500,""},
		["Head Tattoo 1"] = {"MP_Bea_M_Head_000",500,""},
		["Head Tattoo 2"] = {"MP_Bea_M_Head_001",500,""},
		["Head Tattoo 3"] = {"MP_Bea_M_Head_002",500,""},
		["Neck Tattoo 1"] = {"MP_Bea_F_Neck_000",500,""},
		["Neck Tattoo 2"] = {"MP_Bea_M_Neck_000",500,""},
		["Neck Tattoo 3"] = {"MP_Bea_M_Neck_001",500,""},
		["Back Tattoo 1"] = {"MP_Bea_F_Back_000",500,""},
		["Back Tattoo 2"] = {"MP_Bea_F_Back_001",500,""},
		["Back Tattoo 3"] = {"MP_Bea_F_Back_002",500,""},
		["Back Tattoo 4"] = {"MP_Bea_M_Back_000",500,""},
		["Torso Tattoo 1"] = {"MP_Bea_F_Chest_000",500,""},
		["Torso Tattoo 2"] = {"MP_Bea_F_Chest_001",500,""},
		["Torso Tattoo 3"] = {"MP_Bea_F_Chest_002",500,""},
		["Torso Tattoo 4"] = {"MP_Bea_M_Chest_000",500,""},
		["Torso Tattoo 5"] = {"MP_Bea_M_Chest_001",500,""},
		["Torso Tattoo 6"] = {"MP_Bea_F_Stom_000",500,""},
		["Torso Tattoo 7"] = {"MP_Bea_F_Stom_001",500,""},
		["Torso Tattoo 8"] = {"MP_Bea_F_Stom_002",500,""},
		["Torso Tattoo 9"] = {"MP_Bea_M_Stom_000",500,""}, 
		["Torso Tattoo 10"] = {"MP_Bea_M_Stom_001",500,""},
		["Torso Tattoo 11"] = {"MP_Bea_F_RSide_000",500,""},
		["Torso Tattoo 12"] = {"MP_Bea_F_Should_000",500,""},
		["Torso Tattoo 13"] = {"MP_Bea_F_Should_001",500,""},
		["Right Arm Tattoo 1"] = {"MP_Bea_F_RArm_001",500,""},
		["Right Arm Tattoo 2"] = {"MP_Bea_M_RArm_001",500,""},
		["Right Arm Tattoo 3"] = {"MP_Bea_M_RArm_000",500,""},
		["Left Arm Tattoo 1"] = {"MP_Bea_F_LArm_000",500,""},
		["Left Arm Tattoo 2"] = {"MP_Bea_F_LArm_001",500,""},
		["Left Arm Tattoo 3"] = {"MP_Bea_M_LArm_000",500,""}, 
		["Left Leg Tattoo"] = {"MP_Bea_M_Lleg_000",500,""},
		["Right Leg Tattoo"] = {"MP_Bea_F_RLeg_000",500,""}
	},
	["mpbusiness_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="Business Tattoos"},
		[">Clear Tattoos"] = {"CLEAR",500,""},
		["Neck Tattoo 1"] = {"MP_Buis_M_Neck_000",500,""},
		["Neck Tattoo 2"] = {"MP_Buis_M_Neck_001",500,""},
		["Neck Tattoo 3"] = {"MP_Buis_M_Neck_002",500,""},
		["Neck Tattoo 4"] = {"MP_Buis_M_Neck_003",500,""},
		["Left Arm Tattoo 1"] = {"MP_Buis_M_LeftArm_000",500,""},
		["Left Arm Tattoo 2"] = {"MP_Buis_M_LeftArm_001",500,""},
		["Right Arm Tattoo 1"] = {"MP_Buis_M_RightArm_000",500,""},
		["Right Arm Tattoo 2"] = {"MP_Buis_M_RightArm_001",500,""},
		["Stomach Tattoo 1"] = {"MP_Buis_M_Stomach_000",500,""},
		["Chest Tattoo 1"] = {"MP_Buis_M_Chest_000",500,""},
		["Chest Tattoo 2"] = {"MP_Buis_M_Chest_001",500,""},
		["Back Tattoo 1"] = {"MP_Buis_M_Back_000",500,""},
		["Chest Tattoo 3"] = {"MP_Buis_F_Chest_000",500,""},
		["Chest Tattoo 4"] = {"MP_Buis_F_Chest_001",500,""},
		["Chest Tattoo 5"] = {"MP_Buis_F_Chest_002",500,""},
		["Stomach Tattoo 2"] = {"MP_Buis_F_Stom_000",500,""},
		["Stomach Tattoo 3"] = {"MP_Buis_F_Stom_001",500,""},
		["Stomach Tattoo 4"] = {"MP_Buis_F_Stom_002",500,""},
		["Back Tattoo 2"] = {"MP_Buis_F_Back_000",500,""},
		["Back Tattoo 3"] = {"MP_Buis_F_Back_001",500,""},
		["Neck Tattoo 5"] = {"MP_Buis_F_Neck_000",500,""},
		["Neck Tattoo 6"] = {"MP_Buis_F_Neck_001",500,""},
		["Right Arm Tattoo 3"] = {"MP_Buis_F_RArm_000",500,""},
		["Left Arm Tattoo 3"] = {"MP_Buis_F_LArm_000",500,""},
		["Left Leg Tattoo"] = {"MP_Buis_F_LLeg_000",500,""},
		["Right Leg Tattoo"] = {"MP_Buis_F_RLeg_000",500,""}

	},

	["mphipster_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="HipsterTattoos"},
		[">Clear Tattoos"] = {"CLEAR",500,""},
		["HipsterTattoo 1"] = {"FM_Hip_M_Tat_000",500,""},
		["HipsterTattoo 2"] = {"FM_Hip_M_Tat_001",500,""},
		["HipsterTattoo 3"] = {"FM_Hip_M_Tat_002",500,""},
		["HipsterTattoo 4"] = {"FM_Hip_M_Tat_003",500,""},
		["HipsterTattoo 5"] = {"FM_Hip_M_Tat_004",500,""},
		["HipsterTattoo 6"] = {"FM_Hip_M_Tat_005",500,""},
		["HipsterTattoo 7"] = {"FM_Hip_M_Tat_006",500,""},
		["HipsterTattoo 8"] = {"FM_Hip_M_Tat_007",500,""},
		["HipsterTattoo 9"] = {"FM_Hip_M_Tat_008",500,""},
		["HipsterTattoo 10"] = {"FM_Hip_M_Tat_009",500,""},
		["HipsterTattoo 11"] = {"FM_Hip_M_Tat_010",500,""},
		["HipsterTattoo 12"] = {"FM_Hip_M_Tat_011",500,""},
		["HipsterTattoo 13"] = {"FM_Hip_M_Tat_012",500,""},
		["HipsterTattoo 14"] = {"FM_Hip_M_Tat_013",500,""},
		["HipsterTattoo 15"] = {"FM_Hip_M_Tat_014",500,""},
		["HipsterTattoo 16"] = {"FM_Hip_M_Tat_015",500,""},
		["HipsterTattoo 17"] = {"FM_Hip_M_Tat_016",500,""},
		["HipsterTattoo 18"] = {"FM_Hip_M_Tat_017",500,""},
		["HipsterTattoo 19"] = {"FM_Hip_M_Tat_018",500,""},
		["HipsterTattoo 20"] = {"FM_Hip_M_Tat_019",500,""},
		["HipsterTattoo 21"] = {"FM_Hip_M_Tat_020",500,""},
		["HipsterTattoo 22"] = {"FM_Hip_M_Tat_021",500,""},
		["HipsterTattoo 23"] = {"FM_Hip_M_Tat_022",500,""},
		["HipsterTattoo 24"] = {"FM_Hip_M_Tat_023",500,""},
		["HipsterTattoo 25"] = {"FM_Hip_M_Tat_024",500,""},
		["HipsterTattoo 26"] = {"FM_Hip_M_Tat_025",500,""},
		["HipsterTattoo 27"] = {"FM_Hip_M_Tat_026",500,""},
		["HipsterTattoo 28"] = {"FM_Hip_M_Tat_027",500,""},
		["HipsterTattoo 29"] = {"FM_Hip_M_Tat_028",500,""},
		["HipsterTattoo 30"] = {"FM_Hip_M_Tat_029",500,""},
		["HipsterTattoo 31"] = {"FM_Hip_M_Tat_030",500,""},
		["HipsterTattoo 32"] = {"FM_Hip_M_Tat_031",500,""},
		["HipsterTattoo 33"] = {"FM_Hip_M_Tat_032",500,""},
		["HipsterTattoo 34"] = {"FM_Hip_M_Tat_033",500,""},
		["HipsterTattoo 35"] = {"FM_Hip_M_Tat_034",500,""},
		["HipsterTattoo 36"] = {"FM_Hip_M_Tat_035",500,""},
		["HipsterTattoo 37"] = {"FM_Hip_M_Tat_036",500,""},
		["HipsterTattoo 38"] = {"FM_Hip_M_Tat_037",500,""},
		["HipsterTattoo 39"] = {"FM_Hip_M_Tat_038",500,""},
		["HipsterTattoo 40"] = {"FM_Hip_M_Tat_039",500,""},
		["HipsterTattoo 41"] = {"FM_Hip_M_Tat_040",500,""},
		["HipsterTattoo 42"] = {"FM_Hip_M_Tat_041",500,""},
		["HipsterTattoo 43"] = {"FM_Hip_M_Tat_042",500,""},
		["HipsterTattoo 44"] = {"FM_Hip_M_Tat_043",500,""}, 
		["HipsterTattoo 45"] = {"FM_Hip_M_Tat_044",500,""},
		["HipsterTattoo 46"] = {"FM_Hip_M_Tat_045",500,""},
		["HipsterTattoo 47"] = {"FM_Hip_M_Tat_046",500,""},
		["HipsterTattoo 48"] = {"FM_Hip_M_Tat_047",500,""},
		["HipsterTattoo 49"] = {"FM_Hip_M_Tat_048",500,""}
	},
}

-- list of tattooshops positions
cfg.shops = {
  {"mpbeach_overlays", 1322.645,-1651.976,52.275},
  {"mpbeach_overlays", -1153.676,-1425.68,4.954},
  {"mpbusiness_overlays", 322.139,180.467,103.587},
  {"mpbusiness_overlays", -3170.071,1075.059,20.829},
  {"mphipster_overlays", 1864.633,3747.738,33.032},
  {"mphipster_overlays", -293.713,6200.04,31.487}
}

return cfg
