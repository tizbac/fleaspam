-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Chicken Panel",
    desc      = "Shows stuff",
    author    = "quantum",
    date      = "May 04, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = -9, 
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
string.format("load chicken gui")
if (not Spring.GetGameRulesParam("difficulty")) then
  return false
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Spring          = Spring
local gl, GL          = gl, GL
local widgetHandler   = widgetHandler
local math            = math
local table           = table

local fontHandler     = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local panelFont       = LUAUI_DIRNAME.."Fonts/KOMTXT___16"
local panelTexture    = ":n:"..LUAUI_DIRNAME.."Images/panel.png"
local waveFont        = LUAUI_DIRNAME.."Fonts/Skrawl_40"

local viewSizeX, viewSizeY = widgetHandler:GetViewSizes()
local w               = 345
local h               = 242
local x1              = - w - 50
local y1              = - h - 50
local panelMarginX    = 30
local panelMarginY    = 40
local panelSpacingY   = 7
local waveSpacingY    = 7
local moving
local capture
local gameInfo        
local lastRulesUpdate = Spring.GetTimer()
local waveY           = 800
local waveSpeed       = 0.2
local waveCount       = 0
local waveTime
local enabled


local red             = "\255\255\001\001"
local white           = "\255\255\255\255"
local yellow	      = "\255\255\255\001"
local green	      = "\255\001\255\001"
local difficulties = {
    [1] = 'Very Easy',
    [2] = 'Easy',
    [3] = 'Normal',
    [4] = 'Hard',
    [5] = 'Very Hard',
    [6] = 'Insane',
    [7] = 'Custom',
    [8] = 'Survival',
}

local rules = {
  "queenTime",
  "lagging",
  "difficulty",  
  "armfleaaCount",
  "armfleabCount",
  "armfleacCount",
  "armfleadCount",
  "armfleaeCount",
  "armfleafCount",
  "armlabaCount",
  "armfleaaKills",
  "armfleabKills",
  "armfleacKills",
  "armfleadKills",
  "armfleaeKills",
  "armfleafKills",
  "armlabaKills",
  "queens",
  "gracePeriod",
}

local chickenColors = {
  {"armfleaa",      "\255\100\100\100"},
  {"armfleab",      "\255\255\100\100"},
  {"armfleac",      "\255\100\255\100"},
  {"armflead",      "\255\255\255\100"},
  {"armfleae",      "\255\100\255\255"},
  {"armfleaf",      "\255\100\100\255"},
}

local chickenColorSet = {}
for _, t in ipairs(chickenColors) do
  chickenColorSet[t[1]] = t[2]
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


fontHandler.UseFont(panelFont)
local panelFontSize  = 12
fontHandler.UseFont(waveFont)
local waveFontSize   = 12



local function MakeCountString(type)
  local t = {}
  local total = 0
  for _, colorInfo in ipairs(chickenColors) do
    local subTotal = gameInfo[colorInfo[1]..type]
    table.insert(t, colorInfo[2]..subTotal)
    total = total + subTotal
  end
  local breakDown =  table.concat(t, white.."/")..white
  return string.format("Flea %s: %d (%s)", type, total, breakDown)
end


local function UpdateRules()
  if (not gameInfo) then
    gameInfo = {}
  end
  for _, rule in ipairs(rules) do
    gameInfo[rule] = Spring.GetGameRulesParam(rule)
  end
  gameInfo.unitCounts = MakeCountString("Count")
  gameInfo.unitKills  = MakeCountString("Kills")
end




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local function PanelRow(n)
  return panelMarginX, h-panelMarginY-(n-1)*(panelFontSize+panelSpacingY)
end


local function WaveRow(n)
  return n*(waveFontSize+waveSpacingY)
end


local displayList = gl.CreateList( function()
  gl.Color(1, 1, 1, 1)
  gl.Texture(panelTexture)
  gl.TexRect(0, 0, w, h)

end)


local function Draw()
  if (not enabled or not gameInfo) then
    return
  end
  gl.PushMatrix()
  local x = math.floor(x1)
  local y = math.floor(y1)
  gl.Translate(x, y, 0)
  gl.CallList(displayList)
  fontHandler.DisableCache();

  fontHandler.UseFont(panelFont)
  --fontHanlder.BindTexture()
  local gracerem = gameInfo.gracePeriod-Spring.GetGameSeconds();
  if gracerem < 0 then
    gracerem = 0
  end
  local techLevel = string.format("SuperFlea Anger : %d%% (Grace: %d secs)", Spring.GetGameSeconds()/gameInfo.queenTime*100, gracerem)
  fontHandler.Draw(white..techLevel, PanelRow(1))
  fontHandler.Draw(white..gameInfo.unitCounts, PanelRow(2))
  fontHandler.Draw(white.."Lab Count: "..gameInfo.armlabaCount, PanelRow(3))
  fontHandler.Draw(white..gameInfo.unitKills, PanelRow(4))
  fontHandler.Draw(white.."Lab Kills: "..gameInfo.armlabaKills, PanelRow(5))
  if (gameInfo.lagging == 1) then
    fontHandler.Draw(red.."Anti-Lag Enabled", 120, h-170)
  else
    local s = white.."Mode: "..difficulties[gameInfo.difficulty]..yellow.."    "..tonumber(gameInfo.queens).." SuperFleas"..white
    fontHandler.Draw(s, 30, h-170)
  end
  gl.PopMatrix()
  if (waveMessage)  then
    local t = Spring.GetTimer()
    fontHandler.UseFont(waveFont)
    local waveY = viewSizeY - Spring.DiffTimers(t, waveTime)*waveSpeed*viewSizeY
    if (waveY > 0) then
      for i, message in ipairs(waveMessage) do
        fontHandler.DrawCentered(message, viewSizeX/2, waveY-WaveRow(i))
      end
    else
      waveMessage = nil
      waveY = viewSizeY
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local function MakeLine(chicken, n)
  if (n <= 0) then
    return
  end
  local humanName = UnitDefNames[chicken].humanName
  local color = chickenColorSet[chicken]
  return color..n.." "..humanName.."s"
end

function ChickenEvent(chickenEventArgs)
  if (chickenEventArgs.type == "wave") then
    local chicken1Name       = chickenEventArgs[1]
    local chicken2Name       = chickenEventArgs[2]
    local chicken1Number     = chickenEventArgs[3]
    local chicken2Number     = chickenEventArgs[4]
    if (gameInfo.armlabaCount < 1) then
      return
    end
    waveMessage    = {}
    waveCount      = waveCount + 1
    waveMessage[1] = "Wave "..waveCount 
    if (chicken1Name and chicken2Name and chicken1Name == chicken2Name) then
      if (chicken2Number and chicken2Number) then
        waveMessage[2] = 
          MakeLine(chicken1Name, (chicken2Number+chicken1Number)*gameInfo.armlabaCount)
      else
        waveMessage[2] =
          MakeLine(chicken1Name, chicken1Number*gameInfo.armlabaCount)
      end
    elseif (chicken1Name and chicken2Name) then
      waveMessage[2] = MakeLine(chicken1Name, chicken1Number*gameInfo.armlabaCount)
      waveMessage[3] = MakeLine(chicken2Name, chicken2Number*gameInfo.armlabaCount)
    end
    
    waveTime = Spring.GetTimer()
    
  -- table.foreachi(waveMessage, print)
  -- local t = Spring.GetGameSeconds() 
  -- print(string.format("time %d:%d", t/60, t%60))
  -- print""
  elseif (chickenEventArgs.type == "burrowSpawn") then
    UpdateRules()
  elseif (chickenEventArgs.type == "queen") then
    waveMessage    = {}

    waveMessage[1] = "The SuperFlea is angered!"
    waveTime = Spring.GetTimer()
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()
  widgetHandler:RegisterGlobal("ChickenEvent", ChickenEvent)
end


function widget:Shutdown()
  gl.DeleteList(displayList)
  fontHandler.FreeFonts()
  fontHandler.FreeCache()
  widgetHandler:DeregisterGlobal("ChickenEvent")
end


function widget:Update()
  local t = Spring.GetTimer()
  if (not enabled and Spring.GetGameSeconds() > 0) then
    enabled = true
  end
  if (Spring.DiffTimers(t, lastRulesUpdate) > 1) then
    UpdateRules()
    lastRulesUpdate = t
  end
end


function widget:DrawScreen()
  Draw()
end


function widget:MouseMove(x, y, dx, dy, button)
  if (enabled and moving) then
    x1 = x1 + dx
    y1 = y1 + dy
  end
end


function widget:MousePress(x, y, button)
  if (enabled and 
       x > x1 and x < x1 + w and
       y > y1 and y < y1 + h) then
    capture = true
    moving  = true
  end
  return capture
end

 
function widget:MouseRelease(x, y, button)
  if (not enabled) then
    return
  end
  capture = nil
  moving  = nil
  return capture
end


function widget:ViewResize(vsx, vsy)
  x1 = x1 - viewSizeX
  y1 = y1 - viewSizeY
  viewSizeX, viewSizeY = vsx, vsy
  x1 = viewSizeX + x1
  y1 = viewSizeY + y1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
