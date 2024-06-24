local QBCore = exports['qb-core']:GetCoreObject()

-- Handle catching fish
RegisterNetEvent('ss-fishing:catchFish')
AddEventHandler('ss-fishing:catchFish', function(coords, bait)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fishCaught = nil

    if Config.ConsumeBait then
        local baitItem = Player.Functions.GetItemByName(bait)
        if baitItem and baitItem.amount > 0 then
            Player.Functions.RemoveItem(bait, Config.BaitUsage)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Messages.noBait, "error")
            return
        end
    end

    local probability = Config.CatchProbabilities[bait]
    local roll = math.random(100)

    for _, fish in ipairs(probability) do
        if roll <= fish.chance then
            fishCaught = fish.fish
            break
        end
        roll = roll - fish.chance
    end

    if fishCaught then
        Player.Functions.AddItem(fishCaught, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[fishCaught], 'add')
        TriggerClientEvent('QBCore:Notify', src, Config.Messages.catchFish .. " " .. fishCaught .. "!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You caught nothing. Try different bait!", "error")
    end
end)
