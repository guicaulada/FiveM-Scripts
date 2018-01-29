local lang = {
  dmv = {
    police = {
	  check = "Check license",
	  take = "Take license",
	  perm_ask = "police.asklc",
	  perm_take = "police.takelc",
	  check_desc = "Check license from the nearest player.",
	  take_desc = "Take the license from the nearest player.",
	  ask = "Asking license...",
	  request = "Do you want to show your license ?",
	  request_hide = "Hide the license card.",
	  confirm = "Are you sure you want to take this license?",
	  license = "<em>Name: </em>{1}<br /><em>First name: </em>{2}<br /><em>Age: </em>{3}<br /><em>Registration n°: </em>{4}<br /><em>Phone: </em>{5}<br /><em>Date: </em>{6}",
	  no_license = "~r~This player has no license!",
	  took_license = "~g~The license has been removed.",
	  license_taken = "~r~Your license has been removed!"
    },
  },
  client = {
    locked = "~r~Locked",
	failed = "You failed\nYou accumulated {1} ~r~Error Points",
	passed = "You passed\nYou accumulated {1} ~r~Error Points",
	proceed = "~b~Test passed, you can now proceed to the driving test",
	try_again = "~r~You failed the test, you might try again another day",
	no_license = "~r~You are driving without a license",
	interact = "Press ~INPUT_CONTEXT~ to interact with ~y~NPC",
	welcome = "~b~Welcome to the ~h~DMV School!",
	menu = {
	  obtain = "Obtain a drivers license",
	  intro = "Introduction    FREE",
	  theory = "Theory test    200$",
	  practical = "Practical test    500$",
	  mreturn = "Return",
	  mclose = "Close",
	},
	control = {
	  enabled = "~y~Cruise Control: ~g~enabled\n~s~MAX speed {1}kmh",
	  disabled = "~y~Cruise Control: ~r~disabled",
	  help = "Adjust your max speed with ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ controls",
	  speed = "Max speed adjusted to {1}kmh",
	  cant_leave = "You cannot leave the vehicle during the test",
	  not_dirving = "You need to be driving to preform this action",
	},
    pnotify = {
      speeding = "You are speeding! <b style='color:#B22222'>Slow down!</b><br /><br />You are driving in a <b style='color:#DAA520'>{1} km/h</b> zone!",
	  damaged = "The vehicle was <b style='color:#B22222'>damaged!</b><br /><br />Watch it!",
	  area = "Area: ~y~{1}\n~s~Speed limit: ~y~{2} km/h\n~s~Error Points: ~y~{3}/{4}",
	},
  },
}

return lang