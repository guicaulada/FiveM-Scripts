# vrp_fontchange

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
