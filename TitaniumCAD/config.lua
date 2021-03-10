Config = {}

---------------------------------------------------------------------
-------------------------Basic Configuration-------------------------
---------------------------------------------------------------------

Config.debug = 0 -- Toggle between 0 (No Logs), 1 (Important Logs), 2 (More logs), 3 (Full logging)

Config.secret = 'xxxxxxxxxxxxxxx' -- This value can be found in the "Manage Servers" pane of the CAD settings.

Config.cooldown911 = 15 -- The amount of time (in seconds) a player must wait before creating another call. Minimum is 15 seconds.







---------------------------------------------------------------------
-----------------------Advanced Configuration------------------------
---------------------------------------------------------------------

function SendChatMessage(message, scope)
    TriggerClientEvent('chat:addMessage', scope, {    ------------------------------------------------------------------------------
           color = { 255, 0, 0},                      --- Have a custom chat plugin? Want to change the text format of messages? ---
           multiline = true,                          --- Edit the TriggerClientEvent() function so it fits your needs!          ---
           args = {"^4[TitaniumCAD] ^0"..message}     ------------------------------------------------------------------------------
    })
end