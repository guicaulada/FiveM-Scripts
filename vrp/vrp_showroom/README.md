# vrp_showroom
fx-server only, requires my vrp_garages

Support me and my scripts on Patreon:  
[![Support me and my scripts on Patreon](http://i.imgur.com/dyePK6Q.png)](https://www.patreon.com/Sighmir) 
***************************************************************************************************************************
If you get SQL errors it should be because its made to work with databases that accept ADD IF NOT EXISTS.  
To create the tables on your database follow the steps:  

1. Remove every IF NOT EXISTS from server.lua  
2. Run the server once.  
3. Comment out the MySQL.query("vRP/showroom_columns") adding -- before it  
4. Restart the server one more time.  
5. You're good to go from now on.  
****************************************************************************************************************************
Replace:
```
		    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vname})

		    vRPclient.notify(player,{lang.money.paid({vehicle[2]})})
```
With:
```
		    TriggerEvent('veh_SR:CheckMoneyForBasicVeh', user_id, vname, vehicle[2] ,veh_type)
```
on lines 111 and 113 of your vrp/modules/basic_garage.lua, above the vRP.closeMenu(player) function, for basic garage compatibility.
