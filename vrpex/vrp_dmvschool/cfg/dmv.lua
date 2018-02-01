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

cfg.lang = "en"

cfg.dmv = {
  warn = false,
  peds = {
    {type=4, hash=0xc99f21c4, x=239.471, y=-1380.96, z=32.74176, h=137.6}
  },
  price = {
    theory = 250,
    practical = 500
  },
  blip = {
    id = 408,
    colour = 11,
	size = 0.8,
    title = "DMV School"
  },
  menu = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "DMV School",
    menu_subtitle = "Vehicle License",
    color_r = 0,
    color_g = 128,
    color_b = 255,
  }
}

cfg.speed = {
  mult = 3.6, -- 3.6 is kmh / 2.25 is mph (don't ask me why)
  control = { -- https://wiki.fivem.net/wiki/Controls
    toggle = 73, -- X
	up = 27, -- UP
	down = 173 -- DOWN
  },
  area = {
    {
      name = "Residential",
	  limit = 50.0
	},
    {
      name = "Town",
	  limit = 80.0
	},
    {
      name = "Freeway",
	  limit = 120.0
	},
  }
}

cfg.intro = {
  {
    pos = {173.01181030273, -1391.4141845703, 29.408880233765},
    msg = "<b style='color:#1E90FF'>DMV Introduction</b> <br /><br />Theory and practice are both important elements of driving instruction.<br />This introduction will cover the basics and ensure you are prepared with enough information and knowledge for your test.<br /><br />The information from your theory lessons combined with the experience from your practical lesson are vital for negotiating the situations and dilemmas you will face on the road.<br /><br />Sit back and enjoy the ride as we start. It is highly recommended that you pay attention to every detail, most of these questions can be existent under your theory test."
  },
  {
    pos = {-428.49026489258, -993.306640625, 46.008815765381},
    msg = "<b style='color:#1E90FF'>Accidents, incidents and environmental concerns</b><br /><br /><b style='color:#87CEFA'>Duty to yield</b><br />All drivers have a duty to obey the rules of the road in order to avoid foreseeable harm to others. Failure to yield the right of way when required by law can lead to liability for any resulting accidents.<br /><br /> When you hear a siren coming, you should yield to the emergency vehicle, simply pull over to your right.<br />You must always stop when a traffic officer tells you to.<br /><br /><b style='color:#87CEFA'>Aggressive Driving</b><br />A car that endangers or is likely to endanger people or property is considered to be aggressive driving.<br />However, aggressive driving, can lead to tragic accidents. It is far wiser to drive defensively and to always be on the lookout for the potential risk of crashes.<br />"
  },
  {
    pos = {-282.55557250977, -282.55557250977, 31.633310317993},
    msg = "<b style='color:#1E90FF'>Residential Area</b> <br /><br /> Maintain an appropriate speed - Never faster than the posted limit, slower if traffic is heavy.<br /><br />Stay centered in your lane. Never drive in the area reserved for parked cars.<br /><br />Maintain a safe following distance - an least 1 car length for every 10 mph.<br /><br />The speed limit in a Residential Area is 50 km/h.<br />"
  },
  {
    pos = {246.35220336914, -1204.3403320313, 43.669715881348},
    msg = "<b style='color:#1E90FF'>Built-Up Areas/Towns</b> <br /><br />The 80 km/h limit usually applies to all traffic on all roads with street lighting unless otherwise specified.<br />Driving at speeds too fast for the road and driving conditions can be dangerous.<br /><br />You should always reduce your speed when:<br /><br />&bull; Sharing the road with pedestrians<br />&bull; Driving at night, as it is more difficult to see other road users<br />&bull; Weather conditions make it safer to do so<br /><br />Remember, large vehicles and motorcycles need a greater distance to stop<br />"
  },
  {
    pos = {-138.413, -2498.53, 52.2765},
    msg = "<b style='color:#1E90FF'>Freeways/Motorways</b> <br /><br />Traffic on motorways usually travels faster than on other roads, so you have less time to react.<br />It is especially important to use your sences earlier and look much further ahead than you would on other roads.<br /><br />Check the traffic on the motorway and match your speed to fit safely into the traffic flow in the left-hand lane.<br /><br />The speed limit in a Freeway/Motorway Area is 120 km/h.<br />"
  },
  {
    pos = {187.465, -1428.82, 43.9302},
    msg = "<b style='color:#1E90FF'>Alcohol</b> <br /><br />Drinking while driving is very dangerous, alcohol and/or drugs impair your judgment. Impaired judgment affects how you react to sounds and what you see. However, the DMV allows a certain amount of alcohol concentration for those driving with a valid drivers license.<br /><br />0.08% is the the legal limit for a driver's blood alcohol concentration (BAC)<br />"
  },
}

cfg.practical = {
  intro = {
	  "<b style='color:#1E90FF'>DMV Instructor:</b> <br /><br /> Use the <b style='color:#DAA520'>Cruise Control</b> feature to avoid <b style='color:#87CEFA'>speeding</b>, activate this during the test by pressing the <b style='color:#20B2AA'>X</b> button on your keyboard.<br /><br /><b style='color:#87CEFA'>Evaluation:</b><br />- Try not to crash the vehicle or go over the posted speed limit. You will receive <b style='color:#A52A2A'>Error Points</b> whenever you fail to follow these rules<br /><br />- Too many <b style='color:#A52A2A'>Error Points</b> accumulated will result in a <b style='color:#A52A2A'>Failed</b> test",
	 "<b style='color:#1E90FF'>DMV Instructor:</b> <br /><br /> We are currently preparing your vehicle for the test, meanwhile you should read a few important lines.<br /><br /><b style='color:#87CEFA'>Speed limit:</b><br />- Pay attention to the traffic, and stay under the <b style='color:#A52A2A'>speed</b> limit<br /><br />- By now, you should know the basics, however we will try to remind you whenever you <b style='color:#DAA520'>enter/exit</b> an area with a posted speed limit",
  },
  max_errors = 5,
  spawn = {249.40971374512,-1407.2303466797,30.409454345703},
  steps = {
    {
	  pos = {255.13990783691,-1400.7319335938,29.5374584198},
	  msg = "Head to the next point !"
	},
    {
	  pos = {271.8747253418,-1370.5744628906,30.932783126831},
	  msg = "Head to the next point !"
	},
    {
	  pos = {234.90780639648,-1345.3854980469, 29.542045593262},
	  stop = "Make a quick ~r~stop~s~ for pedastrian ~y~crossing",
	  msg = "~g~Great!~s~ lets keep moving!"
	},
    {
	  pos = {217.82102966309,-1410.5201416016,28.292112350464},
	  stop = "Do a quick ~r~stop~s~ and watch your ~y~LEFT~s~ before entering traffic",
	  msg = "~g~Great!~s~ now take a ~y~RIGHT~s~ and pick your lane",
	  area = 2
	},
    {
	  pos = {178.55052185059,-1401.7551269531,27.725154876709},
	  msg = "Watch the traffic ~y~lights~s~ !"
	},
    {
	  pos = {113.16044616699,-1365.2762451172,27.725179672241}
	},
    {
	  pos = {-73.542953491211,-1364.3355712891,27.789325714111},
	  msg = "Make sure to stop for passing vehicles !"
	},
    {
	  pos = {-355.14373779297,-1420.2822265625,27.868143081665}
	},
    {
	  pos = {-439.14846801758,-1417.1004638672,27.704095840454}
	},
    {
	  pos = {-453.79092407227,-1444.7265625,27.665870666504},
	  msg = "Time to hit the road, watch your speed and dont crash !",
	  area = 3
	},
    {
	  pos = {-463.23712158203,-1592.1785888672,37.519771575928}
	},
    {
	  pos = {-900.64721679688,-1986.2814941406,26.109502792358}
	},
    {
	  pos = {1225.7598876953,-1948.7922363281,38.718940734863},
	  msg = "Entering town, watch your speed!"
	},
    {
	  pos = {1163.6030273438,-1841.7713623047,35.679168701172},
	  msg = "Good job, now lets head back!",
	  area = 2
	},
    {
	  pos = {235.28327941895,-1398.3292236328,28.921098709106},
	}
  }
}

return cfg