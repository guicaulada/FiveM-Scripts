
local lang = {
  garage = {
    buy = {
	  item = "{2} {1}<br /><br />{3}",
	  request = "Are you sure you want to buy this vehicle?",
	},
    keys = {
	  title = "Keys",
	  key = "Key ({1})",
	  description = "Check your vehicle keys",
	  sell = {
	    title = "Sell",
		prompt = "Offer value:",
	    owned = "Vehicle already owned",
		request = "You accept the offer to buy a {1} for {2}?",
		description = "Offer to sell vehicle to closest player"
	  }
	},
    personal = {
	  client = {
	    locked = "Vehicle locked",
		unlocked = "Vehicle unlocked"
	  },
	  out = "Vehicle of this type already out",
	  bought = "Vehicle sent to your garage",
	  sold = "Vehicle sold",
	  stored = "Vehicle stored",
	  toofar = "Vehicle too far"	  
	},
	showroom = {
	  title = "Showroom",
	  description = "Press right to see the car and enter to buy it"
	},
    shop = {
	  title = "Shop",
	  description = "Scroll through vehicle modifications",
	  client = {
	    nomods = "~r~No modifications of this type for this vehicle",
		maximum = "You've reached the ~y~maximum~w~ value for this modification",
		minimum = "You've reached the ~r~minimum~w~ value for this modification",
	    toggle = {
		  applied = "~g~Modificarion applied",
		  removed = "~r~Modificarion removed"
		}
	  },
	  mods = {
	    title = "Modifications",
		info = "Scroll through modifications",
	  },
	  repair = {
	    title = "Repair",
		info = "Fix your vehicle",
	  },
	  colour = {
	    title = "Color",
		info = "Scroll through vehicle colors",
		primary = "Primary Color",
		secondary = "Secondary Color",
	    extra = {
		  title = "Extra Color",
		  info = "Scroll through extra colors",
	      pearlescent = "Pearlescent Color",
	      wheel = "Wheel Color",
	      smoke = "Smoke Color",
		},
		custom = {
		  primary = "Custom Primary Color",
		  secondary = "Custom Secondary Color",
		},
	  },
	  neon = {
	    title = "Neon Light",
		info = "Change neon lights",
	    front = "Front Neon",
	    back = "Back Neon",
	    left = "Left Neon",
	    right = "Right Neon",
	    colour = "Neon Color"
	  }
	}
  }
}

return lang
