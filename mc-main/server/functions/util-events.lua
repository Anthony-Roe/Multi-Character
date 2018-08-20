RegisterServerEvent('mc:setupUser')
AddEventHandler('mc:setupUser', function()
    local src = source
    MC.Func.LoadUser(src, result)
end)

RegisterServerEvent('mc:requestUserInfo')
AddEventHandler('mc:requestUserInfo', function()
    local src = source
    local data = {
        group = MC.PlayerList[src].group,
        char_current = MC.PlayerList[src].char_current,
        char_data = MC.PlayerList[src].char_data
    }
    TriggerClientEvent('mc:sendUserInfo', data) -- Sends info to the client that was gathered on join. This info is needed for client functions.
end)

RegisterServerEvent('mc:finishChar')
AddEventHandler('mc:finishChar', function(data)
    local src = source
    print(MC.PlayerList[src].char_data)
    table.insert(MC.PlayerList[src].char_data, data)
    local cData = {
        group = MC.PlayerList[src].group,
        char_current = MC.PlayerList[src].char_current,
        char_data = MC.PlayerList[src].char_data
    }
    TriggerClientEvent('mc:finishChar', src, cData)
end)

RegisterServerEvent('mc:updateCurChar')
AddEventHandler('mc:updateCurChar', function(type, data)
    local src = source
    if string.lower(type) == "char_current" then
        MC.PlayerList[src].char_current = data
    elseif string.lower(type) == "char_data" then
        MC.PlayerList[src].char_data = data
    elseif string.lower(type) == "status" then
        MC.PlayerList[src].status[data.statusType] = data.status
    elseif string.lower(type) == "charlocation" then
        MC.PlayerList[src].getCurrentChar().location = data
    end

    local cData = {
        group = MC.PlayerList[src].group,
        char_current = MC.PlayerList[src].char_current,
        char_data = MC.PlayerList[src].char_data
    }
    TriggerClientEvent('mc:sendUserInfo', src, cData)
end)

RegisterServerEvent('mc:buyItem')
AddEventHandler('mc:buyItem', function(name, amount)
    local src = source
    local player = MC.PlayerList[src]
    local item = MC.ItemList[name]
    local cost = item.buyPrice * amount

    -- TO DO: Check if player has enough money
    player.removeMoney(cost)
    player.addInventoryItem(name, amount)
end)

RegisterServerEvent('mc:addInventoryItem')
AddEventHandler('mc:addInventoryItem', function(source, item, amount)
    local player = MC.PlayerList[source]
    print(item, amount)
    player.addInventoryItem(item, amount)
end)

RegisterServerEvent('mc:removeInventoryItem')
AddEventHandler('mc:removeInventoryItem', function(source, item, amount)
    local player = MC.PlayerList[source]
    
    player.removeInventoryItem(item, amount)
end)

print(os.date("%c"))