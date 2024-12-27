ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('kushc0de:buyCig')
AddEventHandler('kushc0de:buyCig', function(itemName, itemAmount, itemPrice)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('money').money >= itemPrice then
        if xPlayer.canCarryItem(itemName, itemAmount) then
            xPlayer.removeMoney(itemPrice)
            xPlayer.addInventoryItem(itemName, itemAmount)
            if Config.okokNotify then
                TriggerClientEvent('okokNotify:Alert', source, _U('notify_title'), _U('success', Config.Currency .. itemPrice), Config.okokNotifyTime, 'success') -- success, info, warning, error, phone, neutral
            else
                xPlayer.showNotification(_U('success', Config.Currency .. itemPrice))
            end
        else
            if Config.okokNotify then
                TriggerClientEvent('okokNotify:Alert', source, _U('notify_title'), _U('not_enough_space'), Config.okokNotifyTime, 'error') -- success, info, warning, error, phone, neutral
            else
                xPlayer.showNotification(_U('not_enough_space'))
            end
        end
    else
        if Config.okokNotify then
            TriggerClientEvent('okokNotify:Alert', source, _U('notify_title'), _U('not_enough_money'), Config.okokNotifyTime, 'error') -- success, info, warning, error, phone, neutral
        else
            xPlayer.showNotification(_U('not_enough_money'))
        end
    end
end)