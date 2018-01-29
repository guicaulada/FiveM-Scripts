--bind client tunnel interface
vRPpc = {}
Tunnel.bindInterface("vRP_paycheck",vRPpc)

function vRPpc.notifyPicture(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end