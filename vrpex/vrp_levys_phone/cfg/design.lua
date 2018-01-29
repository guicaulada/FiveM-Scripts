cfg = {}

-- you can load external images/fonts/etc using the NUI absolute path: nui://my_resource/myfont.ttf
cfg.phone = [[
.menu{ 
  background-image: url(nui://vrp_levys_phone/gui/img/code.jpg); /*Change the phone wallpaper here. You can use 'grey.jpg' 'red.jpg' 'code.jpg' 'blue.jpg' or add you own in gui/img/--> [Make sure to resize the pic so that the hight is 401px!] */
  font-family: 'Roboto', sans-serif; 
  background-size: cover;
  color: white;
  width: 200px;
  height: 401px;
  font-size: 9px;
  text-align: center;
  margin-left: 60%;
  margin-top: 30%;
  position: absolute;
  float: left;
  border-style: solid; 
  border-width: 30px 9px 30px 9px; 
  border-image: url(nui://vrp_levys_phone/gui/img/menu.png) 30 9 30 9;
  border-radius: 32px;
  box-shadow: -1px -1px 60px -1px rgba(0,0,0,1);
}

.menu_description{
  border-radius: 0px 0px 4px 4px;
  box-shadow: inset -1px -1px 60px 0px rgba(0,0,0,1);
  box-shadow: -1px -1px 60px 0px rgba(0,0,0,1);
  background-color: rgba(0,0,0,0.5);
  font-family: 'Unica One', cursive;
  color: white;
  float: left;
  position: absolute;
  font-weight: bold;
  padding: 9px;
  font-size: 1.2em;
  max-width: 500px;
  max-height: 200px;
}

.menu h1{
  background-color: rgb(44, 189, 247);
  font-family: 'Unica One', cursive;
  color: white;
  text-transform: uppercase;
  text-align: center;
  font-size: 1.6em;
  font-weight: bold;
  padding: 6px;
  border: 1px solid #000000;
  box-shadow: inset -1px -1px 60px 0px rgba(0,0,0,1);
}

.choices{
  overflow-y: scroll;
  overflow-x: hidden;
  max-height: 90%;
}

.choices::-webkit-scrollbar{ 
  display: none; 
}

.choices div{
  padding: 8px;
  border: 1px solid #000000;
  font-size: 15px;
  font-weight: bold;
}
/*
Blue------------------>"background-color: rgba(0, 182, 255,0.90);"
Grey------------------>"background-color: rgba(96, 92, 92,0.90);"
RED------------------> "background-color: rgba(175, 24, 24,0.90);"
Code------------------>"background-color: rgba(58, 160, 53,0.90);"
*/
.choices .selected{
  background-color: rgba(58, 160, 53,0.90);     /*<<<<<<<<<<<---------------Put it on this line!*/
  color: black;
  box-shadow: inset -1px 2px 19px 0px rgba(0,0,0,1);
}
]]

return cfg
