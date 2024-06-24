local QBCore = exports['qb-core']:GetCoreObject()
local fishingBait = nil

-- Show the UI for selecting bait
RegisterNetEvent('ss-fishing:openBaitUI')
AddEventHandler('ss-fishing:openBaitUI', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openBaitUI'
    })
end)

-- Close the UI
RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Receive selected bait from UI
RegisterNUICallback('selectBait', function(data, cb)
    fishingBait = data.bait
    SetNuiFocus(false, false)
    QBCore.Functions.Notify("You selected " .. fishingBait, "success")
    cb('ok')
end)

-- Fishing logic
RegisterNetEvent('ss-fishing:startFishing')
AddEventHandler('ss-fishing:startFishing', function(coords)
    if not fishingBait then
        QBCore.Functions.Notify("Select your bait first!", "error")
        return
    end

    if Config.RequireFishingRod then
        local hasRod = QBCore.Functions.HasItem(Config.FishingRodItem)
        if not hasRod then
            QBCore.Functions.Notify(Config.Messages.needRod, "error")
            return
        end
    end

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_STAND_FISHING', 0, true)
    local fishingTime = math.random(Config.FishingTime.minTime, Config.FishingTime.maxTime)
    QBCore.Functions.Progressbar("fishing", Config.Messages.startFishing, fishingTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('ss-fishing:catchFish', coords, fishingBait)
        ClearPedTasks(playerPed)
    end, function()
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify("Fishing cancelled.", "error")
    end)
end)

-- Detect player in fishing zones and open UI on key press
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local isInFishingZone = false

        for _, zone in pairs(Config.FishingLocations) do
            local distance = GetDistanceBetweenCoords(coords, zone.x, zone.y, zone.z, true)
            if distance < zone.radius then
                isInFishingZone = true
                DrawText3D(zone.x, zone.y, zone.z, "[E] Select Bait")
                if IsControlJustReleased(0, 38) then -- E key
                    TriggerEvent('ss-fishing:openBaitUI')
                end
            end
        end

        if not isInFishingZone then
            SetNuiFocus(false, false)
            SendNUIMessage({ action = 'closeBaitUI' })
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 150)
    ClearDrawOrigin()
end
