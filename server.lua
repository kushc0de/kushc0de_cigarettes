ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('kushc0de:buyCig')
AddEventHandler('kushc0de:buyCig', function(itemName, itemAmount, itemPrice)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('money').money >= itemPrice then
        if xPlayer.canCarryItem(itemName, itemAmount) then
            xPlayer.removeMoney(itemPrice)
            xPlayer.addInventoryItem(itemName, itemAmount)
            xPlayer.showNotification(_U('success', Config.Currency .. itemPrice))
        else
            xPlayer.showNotification(_U('not_enough_space'))
        end
    else
        xPlayer.showNotification(_U('not_enough_money'))
    end
end)