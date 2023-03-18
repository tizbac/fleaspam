--------------------------------------------------------------------------------
--Robot Defense Config
--------------------------------------------------------------------------------

maxChicken           = tonumber(Spring.GetModOptions().mo_maxchicken) or 400
maxBurrows           = 20
gracePeriod          = tonumber(Spring.GetModOptions().mo_graceperiod) or 120  -- no chicken spawn in this period, seconds
queenTime            = (Spring.GetModOptions().mo_queentime or 40) * 60 -- time at which the queen appears, seconds
addQueenAnger        = tonumber(Spring.GetModOptions().mo_queenanger) or 1
burrowSpawnType      = Spring.GetModOptions().mo_chickenstart or "avoid"
queens               = Spring.GetModOptions().queens or 1
spawnSquare          = 90       -- size of the chicken spawn square centered on the burrow
spawnSquareIncrement = 2         -- square size increase for each unit spawned
burrowName           = "armlaba"   -- burrow unit name
maxAge               = 300      -- chicken die at this age, seconds
queenName            = "superflea" 
burrowDef            = UnitDefNames[burrowName].id
defenderChance       = 0.5       -- probability of spawning a single turret
maxTurrets           = 3   		 -- Max Turrets per burrow
queenSpawnMult       = 1         -- how many times bigger is a queen hatch than a normal burrow hatch
burrowSpawnRate      = 60
chickenSpawnRate     = 59
minBaseDistance      = 600      
maxBaseDistance      = 7200
chickensPerPlayer    = 8
spawnChance          = 0.5
bonusTurret          = "armrl" -- Turret that gets spawned when a burrow dies
angerBonus           = 0.25
expStep              = 0.0625
lobberEMPTime        = 4
damageMod            = 1
waves                = {}
newWaveSquad         = {}

local mRandom        = math.random

bonusTurret5a = "armflak"
bonusTurret5b = "arm_big_bertha"
bonusTurret7a = "tlldb"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Copy(original)
  local copy = {} 
  for k, v in pairs(original) do
    if (type(v) == "table") then
      copy[k] = Copy(v)
    else
      copy[k] = v
    end
  end
  return copy
end

local function addWave(wave, unitList)
 if not waves[wave] then waves[wave] = {} end
 table.insert(waves[wave], unitList)
end





   
local chickenTypes = {
  armfleaa  = true,--{time =  0, squadSize = 7, obsolete= 24},
  armfleab	= true,--{time = 10, squadSize = 6, obsolete= 20},
  armfleac	= true,--{time = 10, squadSize = 4,obsolete = 28},
  armfleah = true,--{time = 15,squadSize = 6},
  armflead	= true,--{time = 20, squadSize = 3,obsolete = 40},
  armfleae	= true,--{time = 30, squadSize = 2},
  armfleaf	= true,--{time = 24, squadSize = 2},

}

local defenders = { 
  armrl = true,
  armflak = true,
  arm_big_bertha = true,
  tlldb = true,
}

--t1 only
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
addWave(1,{"3 armfleaa", })
--t1/t1.5
newWaveSquad[2] = {"10 armfleaa", "6 armfleab"}
addWave(2,{"2 armfleac",}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
addWave(2,{}) 
--t1.5 
newWaveSquad[3] = {"5 armfleac", "20 armfleaa", "15 armfleab"}
addWave(3,{}) 
addWave(3,{}) 
addWave(3,{}) 
addWave(3,{}) 
addWave(3,{}) 
addWave(3,{}) 
--t1.5/t2
newWaveSquad[4] = {"5 armfleac", "20 armfleaa", "15 armfleab", "5 armflead"}
addWave(4,{}) 
addWave(4,{}) 
addWave(4,{}) 
addWave(4,{}) 
--t2 --wip beyond
newWaveSquad[5] = {"20 armflead", "20 armfleab", "5 armfleae"}
addWave(5,{}) 
addWave(5,{}) 
addWave(5,{}) 
addWave(5,{}) 
newWaveSquad[6] = {"20 armflead", "20 armfleae", "5 armfleaf"}
addWave(6,{}) 
addWave(6,{}) 
addWave(6,{}) 
addWave(6,{}) 
addWave(6,{}) 
newWaveSquad[7] = {"20 armflead", "20 armfleae", "20 armfleaf"}
addWave(7,{}) 
addWave(7,{}) 
addWave(7,{}) 
addWave(7,{}) 
addWave(7,{}) 
newWaveSquad[8] = {"80 armflead", "80 armfleae", "80 armfleaf"}
addWave(8,{}) 
addWave(8,{}) 
addWave(8,{}) 
addWave(8,{}) 
addWave(8,{}) 
newWaveSquad[9] = {"80 armflead", "80 armfleae", "80 armfleaf"}
addWave(9,{}) 
addWave(9,{}) 
addWave(9,{}) 
addWave(9,{}) 
addWave(9,{}) 

VERYEASY = "Chicken: Very Easy"
EASY = "Chicken: Easy"
NORMAL = "Chicken: Normal"
HARD = "Chicken: Hard"
VERYHARD = "Chicken: Very Hard"
INSANE = "Chicken: Insane"
CUSTOM = "Chicken: Custom"
SURVIVAL = "Chicken: Survival"

difficulties = {
  [VERYEASY] = {
    chickenSpawnRate  = 100, 
    burrowSpawnRate   = 120,
    queenSpawnMult    = 0,
    angerBonus        = 0.05,
    expStep           = 0,
    lobberEMPTime     = 0,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 5,
    spawnChance       = 0.25,
    damageMod         = 0.6,
  },
  [EASY] = {
    chickenSpawnRate  = 100, 
    burrowSpawnRate   = 120,
    queenSpawnMult    = 0,
    angerBonus        = 0.075,
    expStep           = 0.09375,
    lobberEMPTime     = 2.5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 7,
    spawnChance       = 0.33,
    damageMod         = 0.75,
  },

  [NORMAL] = {
    chickenSpawnRate  = 80,
    burrowSpawnRate   = 105,
    queenSpawnMult    = 1,
    angerBonus        = 0.10,
    expStep           = 0.125,
    lobberEMPTime     = 4,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 9,
    spawnChance       = 0.4,
    damageMod         = 1,
  },

  [HARD] = {
    chickenSpawnRate  = 70,
    burrowSpawnRate   = 60,
    queenSpawnMult    = 1,
    angerBonus        = 0.125,
    expStep           = 0.25,
    lobberEMPTime     = 5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 14,
    spawnChance       = 0.5,
    damageMod         = 1.1,
  },


  [VERYHARD] = {
    chickenSpawnRate  = 45,
    burrowSpawnRate   = 40,
    queenSpawnMult    = 3,
    angerBonus        = 0.15,
    expStep           = 0.4,
    lobberEMPTime     = 7.5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 18,
    spawnChance       = 0.6,
    damageMod         = 1.25,
  },
  
  [INSANE] = {
    chickenSpawnRate  = 30,
    burrowSpawnRate   = 28,
    queenSpawnMult    = 4,
    angerBonus        = 0.20,
    expStep           = 0.6,
    lobberEMPTime     = 11,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 24,
    spawnChance       = 0.8,
    damageMod         = 1.5,
  },
  
  
  [CUSTOM] = {
    chickenSpawnRate  = tonumber(Spring.GetModOptions().mo_custom_chickenspawn),
    burrowSpawnRate   = tonumber(Spring.GetModOptions().mo_custom_burrowspawn),
    queenSpawnMult    = tonumber(Spring.GetModOptions().mo_custom_queenspawnmult),
    angerBonus        = tonumber(Spring.GetModOptions().mo_custom_angerbonus),
    expStep           = (tonumber(Spring.GetModOptions().mo_custom_expstep) or 0.6) * -1,
    lobberEMPTime     = tonumber(Spring.GetModOptions().mo_custom_lobberemp),
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = tonumber(Spring.GetModOptions().mo_custom_minchicken),
    spawnChance       = (tonumber(Spring.GetModOptions().mo_custom_spawnchance) or 50) / 100,
    damageMod         = (tonumber(Spring.GetModOptions().mo_custom_damagemod) or 100) / 100,
  },

  [SURVIVAL] = {
    chickenSpawnRate    = 80,
    burrowSpawnRate     = 105,
    queenSpawnMult      = 1,
    angerBonus          = 25,
    expStep             = 0.125,
    lobberEMPTime       = 4,
    chickenTypes        = Copy(chickenTypes),
    defenders           = Copy(defenders),
    chickensPerPlayer   = 9,
    spawnChance         = 0.4,
    damageMod           = 1,
  },
}



defaultDifficulty = 'Chicken: Custom'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
