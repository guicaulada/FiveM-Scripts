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

-- you can load external images/fonts/etc using the NUI absolute path: nui://my_resource/myfont.ttf
cfg.menu = [[
/* ALL CREDITS FOR THE CSS GOES TO |LEVY| */

@font-face {
    font-family: bankgothic;
    src: url(nui://vrp_esx_menu/gui/font/bankgothic.ttf);
}

.menu{
  font-family: bankgothic;  
  background-color: #ffffff;
  color: #000000;
  width: 400px;
  float: left;
  margin-top: 50px;
  text-align : center;
  height: 55%;
  box-shadow : 0px 0px 50px 0px #000;
  position   : absolute;
  margin-left: 25px;
}

.menu_description{
  background-color: #ffffff;
  color: black;
  font-family: bankgothic;
  position: absolute;
  padding: 9px;
  font-size: 1.2em;
  max-width: 500px;
}

.menu h1{
  font-family: bankgothic;
  background-color: #00FFFF;
  color: white;
  height: 40px;
  line-height     : 40px;
  text-align: center;
  font-size: 15px;
  padding: 6px;
}

.choices{
  overflow-y: scroll;
  overflow-x: hidden;
}

.choices::-webkit-scrollbar{ 
  display: none; 
}

.choices div{
  border: 1px solid #545454;
  height: 32px;
  line-height: 32px;
  text-align: center;
  font-size: 15px;
}

.choices .selected{
  background-color: #b2b2b2;
}
]]

return cfg
