--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Chicken Spawner",
    desc      = "Spawns burrows and chickens",
    author    = "quantum - modified by tizbac",
    date      = "April 29, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
-- BEGIN SYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Speed-ups and upvalues
--

local Spring              = Spring
local math                = math
local Game                = Game
local table               = table
local coroutine           = coroutine
local pi                  = math.pi
local cos                 = math.cos
local ipairs              = ipairs
local pairs               = pairs


local queenID
local queens = {}
local killedqueens = 0
local targetCache     
local i = 0
local j = 0
local luaAI  
local chickenTeamID
local chickenAllyID
local burrows             = {}
local burrowSpawnProgress = 0
local commanders          = {}
local maxTries            = 200
local queenOrders         = 50
local computerTeams       = {}
local humanTeams          = {}
local lagging             = false
local cpuUsages           = {}
local chickenBirths       = {}
local kills               = {}
local idleQueue           = {}
local turrets             = {}
local timeOfLastSpawn     = 0    
gameMode                  = 'normal' --Spring.GetModOption("gamemode")
local gracePeriod	  = tonumber(Spring.GetModOptions()["startdelay"])
local tooltipMessage      = "Disabled"
local mexes = {
"armdrag",
"cordrag",
"armfort",
"corfort",
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Teams
--


local modes = {
    [0] = 0,
    [1] = 'FLEAS: Very Easy',
    --[4] = 'FLEAS: NoMex: Very Easy',
    [2] = 'FLEAS: Easy',
    --[5] = 'FLEAS NoMex: Easy',
    [3] = 'FLEAS: Normal',
    --[6] = 'FLEAS NoMex: Normal',
    [4] = 'FLEAS: Hard',
    --[7] = 'FLEAS NoMex: Hard',
    [5] = 'FLEAS: Extreme',
    --[8] = 'FLEAS NoMex: Extreme',
}


for i, v in ipairs(modes) do -- make it bi-directional
  modes[v] = i
end


local function CompareDifficulty(...)
  level = 1
  for _, difficulty in ipairs{...} do
    if (modes[difficulty] > level) then
      level = modes[difficulty]
    end
  end
  return modes[level]
end


if (not gameMode) then -- set human and computer teams
  humanTeams[0]    = true
  computerTeams[1] = true
  chickenTeamID    = 1
  luaAI            = defaultDifficulty
else
  local teams = Spring.GetTeamList()
  local highestLevel = 0
  for allyteamID, teamID in ipairs(teams) do
    local teamLuaAI = Spring.GetTeamLuaAI(teamID)
    if (teamLuaAI and teamLuaAI ~= "") then
      luaAI = teamLuaAI
      highestLevel = CompareDifficulty(teamLuaAI, highestLevel)
      chickenTeamID = teamID
      chickenAllyID = allyteamID
      computerTeams[teamID] = true
    else
      humanTeams[teamID]    = true
    end
  end
  luaAI = highestLevel
end


local gaiaTeamID          = Spring.GetGaiaTeamID()
computerTeams[gaiaTeamID] = nil
humanTeams[gaiaTeamID]    = nil


if (gameMode and luaAI == 0) then
  return false
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Utility
--

local function SetToList(set)
  local list = {}
  for k in pairs(set) do
    table.insert(list, k)
  end
  return list
end


local function SetCount(set)
  local count = 0
  for k in pairs(set) do
    count = count + 1
  end
  return count
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Difficulty
--

do -- load config file
  local CONFIG_FILE = "LuaRules/Configs/spawn_defs.lua"
  local VFSMODE = VFS.RAW_FIRST
  local s = assert(VFS.LoadFile(CONFIG_FILE, VFSMODE))
  local chunk = assert(loadstring(s, file))
  setfenv(chunk, gadget)
  chunk()
end


local function SetGlobals(difficulty)
  for key, value in pairs(gadget.difficulties[difficulty]) do
    gadget[key] = value
  end
  gadget.difficulties = nil
end


SetGlobals(luaAI or defaultDifficulty) -- set difficulty


-- adjust for player and chicken bot count
local malus     = SetCount(humanTeams)^playerMalus
burrowSpawnRate = burrowSpawnRate/malus/SetCount(computerTeams)


local function DisableBuildButtons(unitID, ...)
  for _, unitName in ipairs({...}) do
    local cmdDescID = Spring.FindUnitCmdDesc(unitID, -UnitDefNames[unitName].id)
    if (cmdDescID) then
      local cmdArray = {disabled = true, tooltip = tooltipMessage}
      Spring.EditUnitCmdDesc(unitID, cmdDescID, cmdArray)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Game Rules
--


local function SetupUnit(unitName)
  Spring.SetGameRulesParam(unitName.."Count", 0)
  Spring.SetGameRulesParam(unitName.."Kills", 0)
end


Spring.SetGameRulesParam("lagging",           0)
Spring.SetGameRulesParam("queenTime",        queenTime)

for unitName in pairs(chickenTypes) do
  SetupUnit(unitName)
end

for unitName in pairs(defenders) do
  SetupUnit(unitName)
end

SetupUnit(burrowName)
SetupUnit(queenName)




local difficulty = modes[luaAI or defaultDifficulty]
Spring.SetGameRulesParam("difficulty", difficulty)



local function UpdateUnitCount()
  local teamUnitCounts = Spring.GetTeamUnitsCounts(chickenTeamID)
  for unitDefID, count in pairs(teamUnitCounts) do
    if (unitDefID ~= "n") then
      Spring.SetGameRulesParam(UnitDefs[unitDefID].name.."Count", count)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- CPU Lag Prevention
--

local function DetectCpuLag()
  lagging = false
end


local function KillOldChicken()
  for unitID, birthDate in pairs(chickenBirths) do
    local age = Spring.GetGameSeconds() - birthDate
    if (age > maxAge + math.random(10)) then
      Spring.DestroyUnit(unitID)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Game End Stuff
--

local function KillAllChicken()
  local chickenUnits = Spring.GetTeamUnits(chickenTeamID)
  for _, unitID in ipairs(chickenUnits) do
    Spring.DestroyUnit(unitID)
  end
end


local function KillAllComputerUnits()
  for teamID in pairs(computerTeams) do
    local teamUnits = Spring.GetTeamUnits(teamID)
    for _, unitID in ipairs(teamUnits) do
      Spring.DestroyUnit(unitID)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Spawn Dynamics
--


local function IsPlayerUnitNear(x, z, r)
  for teamID in pairs(humanTeams) do   
    if (#Spring.GetUnitsInCylinder(x, z, r, teamID) > 0) then
      return true
    end
  end
end


local function AttackNearestEnemy(unitID)
  local targetID = Spring.GetUnitNearestEnemy(unitID)
  if (targetID) then
    local tx, ty, tz  = Spring.GetUnitPosition(targetID)
    Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {tx, ty, tz}, {})
  end
end


local function SpawnEggs(x, y, z)
  local choices = {}
  for name in pairs(chickenTypes) do
    if (not chickenTypes[name].noegg and chickenTypes[name].time <= Spring.GetGameSeconds()) then
      table.insert(choices, name)
    end
  end
  for i=1, burrowEggs do
    local choice = choices[math.random(#choices)]
    local rx, rz = math.random(-30, 30), math.random(-30, 30)
    Spring.CreateFeature(choice.."_egg", x+rx, y, z+rz, math.random(-32000, 32000))
  end
end


local function ChooseTarget()
  local humanTeamList = SetToList(humanTeams)
  if (#humanTeamList == 0) then
    return
  end
  local teamID = humanTeamList[math.random(#humanTeamList)]
  local units  = Spring.GetTeamUnits(teamID)
  local unitID = units[math.random(#units)]
  return {Spring.GetUnitPosition(unitID)}
end


local function ChooseChicken(units)
  local s = Spring.GetGameSeconds()
  units = units or chickenTypes
  choices = {}
  for chickenName, c in pairs(units) do
    if (c.time <= s and (c.obsolete or math.huge) > s) then   
      local chance = math.floor((c.initialChance or 1) + 
                                (s-c.time) * (c.chanceIncrease or 0))
      for i=1, chance do
        table.insert(choices, chickenName)
      end
    end
  end
  if (#choices < 1) then
    return
  else
    return choices[math.random(#choices)], choices[math.random(#choices)]
  end
end


local function SpawnChicken(burrowID, spawnNumber, chickenName)
  local x, z
  local bx, by, bz    = Spring.GetUnitPosition(burrowID)
  if (not bx or not by or not bz) then
    return
  end
  local tries         = 0
  local s             = spawnSquare
  
  for i=1, spawnNumber do
    

    repeat
      x = math.random(bx - s, bx + s)
      z = math.random(bz - s, bz + s)
      s = s + spawnSquareIncrement
      tries = tries + 1
    until (not Spring.GetGroundBlocked(x, z) or tries > spawnNumber + maxTries)
    local unitID = Spring.CreateUnit(chickenName, x, 0, z, "n", chickenTeamID)
    --if (targetCache) then
    --  Spring.GiveOrderToUnit(unitID, CMD.FIGHT, targetCache, {})
   -- end
    if (unitID) then
      chickenBirths[unitID] = Spring.GetGameSeconds() 
    end
    
  end
  
end


local function SpawnTurret(burrowID, turret)
  
  if (math.random() > defenderChance and defenderChance < 1 or not turret) then
    return
  end
  
  local x, z
  local bx, by, bz    = Spring.GetUnitPosition(burrowID)
  local tries         = 0
  local s             = spawnSquare
  local spawnNumber   = math.max(math.floor(defenderChance), 1)
  
  for i=1, spawnNumber do
    
    repeat
      x = math.random(bx - s, bx + s)
      z = math.random(bz - s, bz + s)
      s = s + spawnSquareIncrement
      tries = tries + 1
    until (not Spring.GetGroundBlocked(x, z) or tries > spawnNumber + maxTries)
    
    local unitID = Spring.CreateUnit(turret, x, 0, z, "n", chickenTeamID) -- FIXME
    if (unitID) then
      Spring.SetUnitBlocking(unitID, false)
      turrets[unitID] = Spring.GetGameSeconds()
    end
  end
  
end


local function SpawnBurrow(number)
  
  if (queenID) then
    return
  end

  local t     = Spring.GetGameSeconds()
  local unitDefID = UnitDefNames[burrowName].id
    
  for i=1, (number or 1) do
    local x, z
    local tries = 0

  repeat
    if Spring.GetModOptions().spawninbox then
      local _,_,_,_,_,chickallyteam,_,_ = Spring.GetTeamInfo(chickenTeamID)
      local xn, zn, xp, zp = Spring.GetAllyTeamStartBox(chickallyteam)
      x = math.random(xn,xp)		
      z = math.random(zn,zp)
    else
      x = math.random(spawnSquare, Game.mapSizeX - spawnSquare)
      z = math.random(spawnSquare, Game.mapSizeZ - spawnSquare)
    end
    local y = Spring.GetGroundHeight(x, z)
    tries = tries + 1
    local blocking = Spring.TestBuildOrder(UnitDefNames["armlab"].id, x, y, z, 1)
    if (blocking == 2) then
      local proximity = Spring.GetUnitsInCylinder(x, z, minBaseDistance)
      local vicinity = Spring.GetUnitsInCylinder(x, z, maxBaseDistance)
      local humanUnitsInVicinity = false
      local humanUnitsInProximity = false
      for i=1,vicinity['n'],1 do
        if (Spring.GetUnitTeam(vicinity[i]) ~= chickenTeamID) then
          humanUnitsInVicinity = true
          break
        end
      end

      for i=1,proximity['n'],1 do
        if (Spring.GetUnitTeam(proximity[i]) ~= chickenTeamID) then
          humanUnitsInProximity = true
          break
        end
      end

      if (humanUnitsInProximity or not humanUnitsInVicinity) then
        blocking = 1
      end
    end
  until (blocking == 2 or tries > maxTries)
    local unitID = Spring.CreateUnit(burrowName, x, 0, z, "n", chickenTeamID)
    if (unitID) then
      
      burrows[unitID] = true
      Spring.SetUnitBlocking(unitID, false)
    end
  end
  
end


local function SpawnQueen()
  
  local x, z
  local tries = 0
  
  repeat
    x = math.random(0, Game.mapSizeX)
    z = math.random(0, Game.mapSizeZ)
    local y = Spring.GetGroundHeight(x, z)
    tries = tries + 1
    local blocking = Spring.TestBuildOrder(UnitDefNames["corgant"].id, x, y, z, 1)
  until (blocking == 2 or tries > maxTries)
  
  return Spring.CreateUnit(queenName, x, 0, z, "n", chickenTeamID)
 
end


local function Wave()
  
  local t = Spring.GetGameSeconds()
  
  if (Spring.GetTeamUnitCount(chickenTeamID) > maxChicken or lagging or t < gracePeriod) then
    return
  end
  j = 0

  local chicken1Name, chicken2Name = ChooseChicken(chickenTypes)
  local turret = ChooseChicken(defenders)
  local squadNumber = t*timeSpawnBonus+firstSpawnSize
  local chicken1Number = math.ceil(waveRatio * squadNumber * chickenTypes[chicken1Name].squadSize)
  local chicken2Number = math.floor((1-waveRatio) * squadNumber * chickenTypes[chicken2Name].squadSize)
  if (queenID ) then
	if ( not Spring.GetUnitIsDead(queenID)) then  
    SpawnChicken(queenID, chicken1Number*queenSpawnMult, chicken1Name)
    SpawnChicken(queenID, chicken2Number*queenSpawnMult, chicken2Name)
    end
    while ( j < tonumber(Spring.GetModOptions().queens)) do
	   if ( queens[j] ) then
	   if ( not Spring.GetUnitIsDead(queens[j])) then
	        SpawnChicken(queens[j], chicken1Number*queenSpawnMult, chicken1Name)
    SpawnChicken(queens[j], chicken2Number*queenSpawnMult, chicken2Name)
	    end
	   end
	j = j + 1
	    end

    
  else
    for burrowID in pairs(burrows) do
      SpawnChicken(burrowID, chicken1Number, chicken1Name)
      SpawnChicken(burrowID, chicken2Number, chicken2Name)
      SpawnTurret(burrowID, turret)
    end
    return chicken1Name, chicken2Name, chicken1Number, chicken2Number
  end
  
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Get rid of the AI
--

local function DisableUnit(unitID)
  Spring.MoveCtrl.Enable(unitID)
  Spring.MoveCtrl.SetNoBlocking(unitID, true)
  Spring.MoveCtrl.SetPosition(unitID, Game.mapSizeX+4000, 0, Game.mapSizeZ+4000)
  Spring.SetUnitHealth(unitID, {paralyze=99999999})
  Spring.SetUnitNoDraw(unitID, true)
  Spring.SetUnitStealth(unitID, true)
  Spring.SetUnitNoSelect(unitID, true)
  commanders[unitID] = nil
end

local function DisableComputerUnits()
  for teamID in pairs(computerTeams) do
    local teamUnits = Spring.GetTeamUnits(teamID)
    for _, unitID in ipairs(teamUnits) do
      DisableUnit(unitID)
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Call-ins
--

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
  local name = UnitDefs[unitDefID].name
  if (name == "armcom" or
      name == "corcom") then
    commanders[unitID] = true
  end
  if (chickenTeamID == unitTeam and name ~= "armcom" and name ~= "corcom" ) then
    local n = Spring.GetGameRulesParam(name.."Count")
    if (n) then
    Spring.SetGameRulesParam(name.."Count", n+1)
    end
  end
  if (alwaysVisible and unitTeam == chickenTeamID) then
    Spring.SetUnitAlwaysVisible(unitID, true)
  end
 
    DisableBuildButtons(unitID, unpack(mexes))
 
end


function gadget:GameFrame(n)
  local t = Spring.GetGameSeconds()
  
  if (n == 1) then
    DisableComputerUnits()
  end
  
  if ((n+19) % (30 * chickenSpawnRate) < 0.1) then
    local args = {Wave()}
    if (#args > 0) then
      _G.chickenEventArgs = {type="wave", unpack(args)}
      SendToUnsynced("ChickenEvent")
      _G.chickenEventArgs = nil
    end
  end
  
  if ((n+21) % 30 < 0.1) then

    DetectCpuLag()
    KillOldChicken()
    UpdateUnitCount()
    targetCache = ChooseTarget()
  
    for _, unitID in ipairs(Spring.GetTeamUnits(chickenTeamID)) do
      targetCache = ChooseTarget()
      if (targetCache and 
          (not Spring.GetUnitCommands(unitID)
          or #Spring.GetUnitCommands(unitID) < 1)) then
        Spring.GiveOrderToUnit(unitID, CMD.FIGHT, targetCache, {})
      end
    end  


    if (t >= queenTime) then
if (tonumber(Spring.GetModOptions().queens) > 1 and not queenID) then
      while (i < tonumber(Spring.GetModOptions().queens)-1) do
	      queens[i] = SpawnQueen()
	         
	      
	      i = i + 1
      end
	end     
      if (not queenID ) then
        _G.chickenEventArgs = {type="queen"}
        SendToUnsynced("ChickenEvent")
        _G.chickenEventArgs = nil
        queenID = SpawnQueen()
      end
      
       
    end
    
    local burrowCount = SetCount(burrows)
    
    local timeSinceLastSpawn = t - timeOfLastSpawn
    local burrowSpawnTime = burrowSpawnRate*0.25*(burrowCount+1)
    
    if (burrowSpawnTime < timeSinceLastSpawn and 
        not lagging and burrowCount < maxBurrows) then
      SpawnBurrow()
      timeOfLastSpawn = t
      _G.chickenEventArgs = {type="burrowSpawn"}
      SendToUnsynced("ChickenEvent")
      _G.chickenEventArgs = nil
    end
    
  end
  
end
function gadget:UnitTaken(unitID, unitDefID, unitTeam)
gadget:UnitDestroyed(unitID,unitDefID,unitTeam)

end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  chickenBirths[unitID] = nil
  commanders[unitID] = nil
  turrets[unitID] = nil
  local name = UnitDefs[unitDefID].name
  if (unitTeam == chickenTeamID) then
    if (chickenTypes[name] or defenders[name]) then
      local kills = Spring.GetGameRulesParam(name.."Kills")
      Spring.SetGameRulesParam(name.."Kills", kills + 1)
    end
    if (name == queenName) then
      killedqueens = killedqueens + 1
      if (killedqueens >= tonumber(Spring.GetModOptions().queens)) then
      KillAllComputerUnits()
      KillAllChicken()
    end
    end
  end
  if (name == burrowName) then
    burrows[unitID] = nil
    local kills = Spring.GetGameRulesParam(name.."Kills")
    Spring.SetGameRulesParam(name.."Kills", kills + 1)
    if (eggs) then
      SpawnEggs(Spring.GetUnitPosition(unitID))
    end
    SpawnBurrow()
  end
  if (eggs and chickenTypes[name] and not chickenTypes[name].noegg) then
    local x, y, z = Spring.GetUnitPosition(unitID)
    Spring.CreateFeature(name.."_egg", x, y, z, math.random(-32000, 32000))
  end
end


function gadget:TeamDied(teamID)
  humanTeams[teamID] = nil
  computerTeams[teamID] = nil
end


function gadget:AllowCommand(unitID, unitDefID, teamID,
                             cmdID, cmdParams, cmdOptions)
 
    for _, mexName in ipairs(mexes) do
      if (UnitDefNames[mexName].id == -cmdID) then
        return false -- command was used
        end
    end
 
  return true  -- command was not used
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
else
-- END SYNCED
-- BEGIN UNSYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Script = Script
local SYNCED = SYNCED


function WrapToLuaUI()
  if (Script.LuaUI('ChickenEvent')) then
    local chickenEventArgs = {}
    for k, v in spairs(SYNCED.chickenEventArgs) do
      chickenEventArgs[k] = v
    end
    Script.LuaUI.ChickenEvent(chickenEventArgs)
  end
end


function gadget:Initialize()
  gadgetHandler:AddSyncAction('ChickenEvent', WrapToLuaUI)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end
-- END UNSYNCED
--------------------------------------------------------------------------------
