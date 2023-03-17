--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local hardModifier   = 1.3
spawnSquare          = 150       -- size of the chicken spawn square centered on the burrow
spawnSquareIncrement = 1         -- square size increase for each unit spawned
burrowName           = "armlaba"   -- burrow unit name
playerMalus          = 1.2         -- how much harder it becomes for each additional player
maxChicken           = 7000
lagTrigger           = 0.5      -- average cpu usage after which lag prevention mode triggers
triggerTolerance     = 0.05      -- increase if lag prevention mode switches on and off too fast
maxAge               = 5*60      -- chicken die at this age, seconds
queenName            = "superflea"
waveRatio            = 0.7       -- waves are composed by two types of chicken, waveRatio% of one and (1-waveRatio)% of the other
defenderChance       = 0.8       -- amount of turrets spawned per wave, <1 is the probability of spawning a single turret
maxBurrows           = 100        
queenSpawnMult       = 5         -- how many times bigger is a queen hatch than a normal burrow hatch
alwaysVisible        = false     -- chicken are always visible
burrowSpawnRate      = 30        -- higher in games with many players, seconds
chickenSpawnRate     = 59
minBaseDistance      = 700      
maxBaseDistance      = 3000
gracePeriod          = 130       -- no chicken spawn in this period, seconds
burrowEggs           = 50        -- number of eggs each burrow spawns
queenTime            = Spring.GetModOptions().queenspawntime*60 -- time at which the queen appears, seconds

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Copy(original)   -- Warning: circular table references lead to
  local copy = {}               -- an infinite loop.
  for k, v in pairs(original) do
    if (type(v) == "table") then
      copy[k] = Copy(v)
    else
      copy[k] = v
    end
  end
  return copy
end


local function TimeModifier(d, mod)
  for chicken, t in pairs(d) do
    t.time = t.time*mod
    if (t.obsolete) then
      t.obsolete = t.obsolete*mod
    end
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- times in minutes
local chickenTypes = {
  armfleaa  = {time =  0, squadSize = 7, obsolete= 24},
  armfleab	= {time = 10, squadSize = 6, obsolete= 20},
  armfleac	= {time = 10, squadSize = 4,obsolete = 28},
  armfleah = {time = 15,squadSize = 6},
  armflead	= {time = 20, squadSize = 3,obsolete = 40},
  armfleae	= {time = 30, squadSize = 2},
  armfleaf	= {time = 24, squadSize = 2},

}

local defenders = {
  armrla =  {time = 8, squadSize = 1 },
  armllta = {time = 4,squadSize = 1,obsolete = 8},
  armhlta = {time = 18,squadSize = 2,obsolete = 20},
  armclawa = {time = 16,squadSize = 1,obsolete = 26},
  armpba = {time = 24,squadSize = 1},
  armannia = {time = 32,squadSize =1},
  mercurya = {time = 30,squadSize = 1},
  packoa = {time = 10,squadSize = 2},
  armflaka = {time = 26,squadSize =1},
}
    
    
difficulties = {
  ['FLEAS: Very Easy'] = {
    chickenSpawnRate = 70, 
    burrowSpawnRate  = 120,
    firstSpawnSize   = 0.4,
    timeSpawnBonus   = .04,     -- how much each time level increases spawn size
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },
  ['FLEAS: Easy'] = {
    chickenSpawnRate = 60, 
    burrowSpawnRate  = 60,
    firstSpawnSize   = 0.6,
    timeSpawnBonus   = .06,     -- how much each time level increases spawn size
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },

  ['FLEAS: Normal'] = {
    chickenSpawnRate = 50, 
    burrowSpawnRate  = 60,
    firstSpawnSize   = 0.7,
    timeSpawnBonus   = .08,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },

  ['FLEAS: Hard'] = {
    chickenSpawnRate = 45, 
    burrowSpawnRate  = 45,
    firstSpawnSize   = 0.8,
    timeSpawnBonus   = .1,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },
    ['FLEAS: Extreme'] = {
    chickenSpawnRate = 45, 
    burrowSpawnRate  = 35,
    firstSpawnSize   = 1,
    timeSpawnBonus   = .1,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
  },
}



-- minutes to seconds
for _, d in pairs(difficulties) do
  
  d.timeSpawnBonus = d.timeSpawnBonus/60
  local speedmod = 45.0 / queenTime 
  TimeModifier(d.chickenTypes, 60*speedmod)
  TimeModifier(d.defenders, 60*speedmod)
  
  
end


TimeModifier(difficulties['FLEAS: Hard'].chickenTypes, hardModifier)
TimeModifier(difficulties['FLEAS: Hard'].defenders,    hardModifier)
TimeModifier(difficulties['FLEAS: Extreme'].chickenTypes, hardModifier)
TimeModifier(difficulties['FLEAS: Extreme'].defenders,    hardModifier)


difficulties['Chicken Eggs: Very Easy']   = Copy(difficulties['FLEAS: Very Easy'])
difficulties['Chicken Eggs: Easy']   = Copy(difficulties['FLEAS: Easy'])
difficulties['Chicken Eggs: Normal'] = Copy(difficulties['FLEAS: Normal'])
difficulties['Chicken Eggs: Hard']   = Copy(difficulties['FLEAS: Hard'])
difficulties['Chicken Eggs: Extreme']   = Copy(difficulties['FLEAS: Extreme'])

difficulties['Chicken Eggs: Easy'].eggs   = true
difficulties['Chicken Eggs: Normal'].eggs = true
difficulties['Chicken Eggs: Hard'].eggs   = true
difficulties['Chicken Eggs: Extreme'].eggs = true
difficulties['Chicken Eggs: Very Easy'].eggs = true
defaultDifficulty = 'FLEAS: Normal'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
