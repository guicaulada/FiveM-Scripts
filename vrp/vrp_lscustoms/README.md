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
