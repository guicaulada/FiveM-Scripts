# vrp_lscustoms
fx-server only, requires my vrp_showroom

Support me and my scripts on Patreon:  
[![Support me and my scripts on Patreon](http://i.imgur.com/dyePK6Q.png)](https://www.patreon.com/Sighmir)  
*************************************************************************************************************************
If you get SQL errors it should be because its made to work with databases that accept ADD IF NOT EXISTS.  
To create the tables on your database follow the steps:  

1. Remove every IF NOT EXISTS from server.lua  
2. Run the server once.  
3. Comment out the MySQL.query("vRP/lscustoms_columns") adding -- before it  
4. Restart the server one more time.  
5. You're good to go from now on.  

## License

    FiveM Scripts
    Copyright (C) 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
