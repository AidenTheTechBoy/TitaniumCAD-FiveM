-----------------------------------------------------------------------------
-- Warning:                                                                 -
-- If you edit the files below, do not request support if something breaks! -
-----------------------------------------------------------------------------

-- API Url
local api = 'https://api.titaniumcad.com' -- Changing this value has a 100% chance of breaking your CAD integration.

-- Cached Data
local activeUnits = {}
local playerLocations = {}

-- Get Current Units
RegisterCommand('units', function(source, args, rawCommand)
    for i in pairs(activeUnits) do
        print(activeUnits[i])
    end
end, false)

-- Send in 911 Call
local cooldown911 = {}
RegisterCommand('911', function(source, args, rawCommand)

    -- Check Cooldown
    for i in pairs(cooldown911) do
        if cooldown911[i]['id'] == source then
            SendChatMessage('Please wait ^4' .. cooldown911[i]['time'] .. ' seconds ^0before sending out another 911 call!', source)
            return
        end
    end

    -- Caller and Message
    local caller = '[' .. source .. '] ' .. GetPlayerName(source)
    local message = string.sub(rawCommand, 4, -1)

    -- Get Location
    local location = 'Unknown'
    for i in pairs(playerLocations) do
        if playerLocations[i]['id'] == source then
            location = playerLocations[i]['location']
        end
    end

    -- Send 911 Call to Database
    PerformHttpRequest(api .. '/cad/911', function(statusCode, response, headers)
        if statusCode == 201 then
            SendChatMessage('Your 911 call has been sent to dispatch!', source)
            printDebug(2, 'Player with id ' .. source .. ' sent a 911 call to dispatch!')
        else
            SendChatMessage('We were unable to forward your call to dispatch!', source)
            printDebug(3, 'Player with id ' .. source .. ' failed to send a call to dispatch!')
        end
    end, 'POST', json.encode({secret = Config.secret, caller = caller, details = message, address = location }), {['Content-Type'] = 'application/json'})

    -- Add to Cooldown (CHANGING THE COOLDOWN OVERRIDE MAY RESULT IN A BLACKLIST FOR API ABUSE)
    if Config.cooldown911 >= 10 then
        table.insert(cooldown911, {id = source, time = Config.cooldown911})
    else
        table.insert(cooldown911, {id = source, time = 10})
    end
    
end, false)

-- End 911 Cooldown
Citizen.CreateThread(function()
    while true do
        ::checkAgain::
        for i in pairs(cooldown911) do
            print('-------------')
            print(cooldown911[i]['id'])
            print(cooldown911[i]['time'])
            local broken = false
            if cooldown911[i]['time'] > 0 then
                -- Remove One Second From Timer
                cooldown911[i]['time'] = cooldown911[i]['time'] - 1
            else
                -- Remove From List
                table.remove(cooldown911, i)
                goto checkAgain
                break
            end
        end
        Wait(1000)
    end
end)

-- CAD Input / Output
Citizen.CreateThread(function ()
    while true do

        local playerCount = GetNumPlayerIndices()

        printDebug(3, '-------------------------------------')

        if playerCount > 0 then

            printDebug(3, 'Making request (' .. playerCount .. ' player(s) in game)')

            -- Make General Request
            PerformHttpRequest(api .. '/cad/integration', function(statusCode, response, headers)
                
                -- Deal With Server Response
                if statusCode == 200 then

                    -- Add Active Units to Table
                    local units = json.decode(response)
                    activeUnits = {}
                    for i in pairs(units) do
                        table.insert(activeUnits, units[i]['ingame_id'])
                    end

                    printDebug(3, 'Successfully recieved response from API!')

                else
                    -- Error Recieving Message
                    printDebug(0, 'Unable to update information from CAD. Returned status code ' .. statusCode)
                end

            end, 'POST', json.encode({

                -- Send Data With Request
                secret = Config.secret, -- Secret
                locations = playerLocations, -- List of Unit Locations

            }), { ['Content-Type'] = 'application/json' })
            
            -- Add Additional Wait if No Units Online
            if #activeUnits == 0 then
                printDebug(3, 'No active units, waiting for longer time!')
                Wait(7500)
            else
                printDebug(3, 'Found ' .. #activeUnits .. ' active unit(s).')
            end

            -- Wait Before Sending Next Request
            printDebug(3, 'Waiting before sending next request!')
            Wait(7500)

        else
            printDebug(3, 'There are not enough in-game players to make a request!')
            Wait(10000)
        end

    end
end)

-- Player Sends Location to CAD
RegisterServerEvent('titaniumcad:sendLocation')
AddEventHandler('titaniumcad:sendLocation', function(location)

    -- Don't Allow Null Location
    if not location then
        location = 'Unknown'
    end
    
    -- Keep Track of Update
    local updated = false

    -- Existing Value
    for i in pairs(playerLocations) do
        if playerLocations[i]['id'] == source then
            playerLocations[i]['location'] = location
            updated = true
        end
    end

    -- New Value
    if not updated then
        table.insert(playerLocations, {id = source, location = location})
    end

end)

function printDebug(level, text)
    if Config.debug >= level then
        print(text)
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end