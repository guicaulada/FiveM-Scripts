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

--[[ vrp_fontchange

/!\ READ THE INSTRUCTIONS CAREFULLY THIS IS NOT A RESOURCE /!\

/!\ AFTER DOING THIS YOU WILL HAVE TO READJUST FONT SIZES AT vrp/cfg /!\

This is just a guide on how to change your font on vRP.

Add this:
```lua
-- client files
files{
  "gui/fonts/pricedown.ttf"
}
```
to __resource.lua of vRP on the already existing files{}, don't remove what is already inside of it and don't forget any commas!

Do the same for design.css add right under the *{} tag:
```css
@font-face {
    font-family: Pricedown;
    src: url('fonts/pricedown.ttf');
}
```

You can add this in any CSS code on the vrp/cfg files to use the font on that area of vRP
```css
  font-family: Pricedown !important;
  color: white;
  text-shadow: black 0 0 10px;
``` 

Don't forget to move the fonts folder in your vrp/gui folder.
Good luck.
]]