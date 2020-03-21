ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_mining:getItem')
AddEventHandler('esx_mining:getItem', function()
    local xPlayer, randomItem = ESX.GetPlayerFromId(source), Config.Items[math.random(1, #Config.Items)]
    if math.random(0, 100) <= Config.ChanceToGetItem then
        xPlayer.addInventoryItem(randomItem, 1)
    end
end)

RegisterServerEvent('esx_mining:sell')
AddEventHandler('esx_mining:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(Config.Prices) do
        if xPlayer.getInventoryItem(k).count > 0 then
            local reward = 0
            for i = 1, xPlayer.getInventoryItem(k).count do
                reward = reward + math.random(v[1], v[2])
            end
            xPlayer.addMoney(reward)
            TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward))
            xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
        end
    end
end)