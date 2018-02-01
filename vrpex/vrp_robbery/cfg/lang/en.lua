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

local lang = {
  blip = "Robbery",
  cops = {
    cant_rob = "~r~Cops are not allowed to rob stores!",
	not_enough = "~r~You need at least {1} cops online"
  },
  robbery = {
	wait = "This has already been robbed recently. Please wait another: ^2{1}^0 seconds.",
	progress = "Robbery in progress at ^2{1}",
	started = "You started a robbery at: ^2{1}^0, do not get too far away from this point!",
	hold = "Hold the fort for ^1{1} ^0minutes and the money is yours!",
	over = "Robbery is over at: ^2{1}^0!",
	canceled = "Robbery was cancelled at: ^2{1}^0!",
	done = "Robbery done, you received: ^2{1}^0!"
  },
  title = {
    robbery = "ROBBERY",
	news = "NEWS",
	system = "SYSTEM"
  },
  client = {
	rob = "Press ~INPUT_RELOAD~ to rob ~b~{1}~w~ beware, the police will be alerted!",
    robbing = "Robbing: ~r~{1}~w~ seconds remaining",
	canceled = "The robbery was cancelled, you will receive nothing."
  }
}

return lang