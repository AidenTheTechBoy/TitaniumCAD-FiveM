Citizen.CreateThread(function()
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        local loc = GetEntityCoords(player)
        local street = GetStreetNameAtCoord(loc.x, loc.y, loc.z)
        local streetName = GetStreetNameFromHashKey(street)
        TriggerServerEvent('titaniumcad:sendLocation', streetName)
        Wait(2500)
    end
end)

local CadOpen = false
Citizen.CreateThread(function()
    while true do

        -- Press to Open Tablet
        if IsControlJustPressed(0, 212) or IsDisabledControlJustPressed(0, 212) and IsInputDisabled(2) then
            SendNUIMessage({action  = 'show'})
            SetNuiFocus(true, true)
            CadOpen = true
        end
        
        Wait(0)
    end
end)

RegisterNUICallback("hide", function(data)
    SendNUIMessage({action  = 'hide'})
    SetNuiFocus(false, false)
    CadOpen = false
end)