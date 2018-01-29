# vRP-basic-mission
vRP Extension - some basic missions

For https://github.com/ImagicTheCat/vRP, add delivery and repair missions.

Give sometimes a mission to players with the repair/delivery permissions. Good as side task for utility jobs relying on services (drugs delivery for EMS,etc).

## Setup

Missions are assigned using the permissions set in `cfg/missions.lua` by a rate of one minute.

### Repair

Repair missions are triggered sometimes, following the chance option. A chance of 3 will be triggered every 3 minutes (average). For this reason, you can have multiple repair permissions for one player.

### Delivery

Delivery are continuous missions triggered every minute, if not already on a mission. For this reason, only one delivery permission should be used. 
What needs to be delivered is randomly generated using the configuration.