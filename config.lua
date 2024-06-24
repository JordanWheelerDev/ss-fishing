Config = {}

Config.FishingLocations = {
    {x = 100.0, y = -1000.0, z = 30.0, radius = 10.0},
    {x = 200.0, y = -1100.0, z = 30.0, radius = 15.0}
}

Config.BaitTypes = {
    {name = 'worms', label = 'Worms', chanceMultiplier = 1.0},
    {name = 'small_fish', label = 'Small Fish', chanceMultiplier = 1.5},
    {name = 'bread', label = 'Bread', chanceMultiplier = 2.0}
}

Config.FishTypes = {
    {name = 'small_fish', label = 'Small Fish', rarity = 'common'},
    {name = 'medium_fish', label = 'Medium Fish', rarity = 'uncommon'},
    {name = 'big_fish', label = 'Big Fish', rarity = 'rare'}
}

Config.CatchProbabilities = {
    ['worms'] = {
        {fish = 'small_fish', chance = 80},
        {fish = 'medium_fish', chance = 15},
        {fish = 'big_fish', chance = 5}
    },
    ['small_fish'] = {
        {fish = 'medium_fish', chance = 70},
        {fish = 'big_fish', chance = 30}
    },
    ['bread'] = {
        {fish = 'big_fish', chance = 100}
    }
}

Config.FishingTime = {
    minTime = 5000,
    maxTime = 15000
}

Config.RequireFishingRod = true
Config.FishingRodItem = 'fishing_rod'

Config.ConsumeBait = true
Config.BaitUsage = 1

Config.FishRewards = {
    ['small_fish'] = 50,
    ['medium_fish'] = 100,
    ['big_fish'] = 200
}

Config.TimeRestrictions = {
    enableTimeCheck = false,
    startTime = 6,
    endTime = 20
}

Config.FishingAnimation = {
    dict = 'amb@world_human_stand_fishing@idle_a',
    anim = 'idle_c'
}

Config.UI = {
    backgroundColor = 'rgba(0, 0, 0, 0.8)',
    baitItemSize = {width = 100, height = 100},
    hookAreaSize = {width = 200, height = 200}
}

Config.SuccessRate = 75

Config.Sounds = {
    castSound = 'CAST_SOUND_PATH',
    catchSound = 'CATCH_SOUND_PATH',
    failSound = 'FAIL_SOUND_PATH'
}

Config.Messages = {
    startFishing = 'You start fishing...',
    catchFish = 'You caught a fish!',
    noBait = 'You have no bait left!',
    wrongTime = 'You can only fish between 6 AM and 8 PM.',
    needRod = 'You need a fishing rod to fish.'
}
