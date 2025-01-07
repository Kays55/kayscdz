setDefaultTab("Cave")
UI.Label('Numero de Voltas')

UI.TextEdit(storage.voltas or "30", function(widget, newText)
storage.voltas = newText
end)

onKeyDown(function(keys)
  if keys == 'F12' then
    if CaveBot.isOn() then
      CaveBot.setOff()
      TargetBot.setOff()
    else
      CaveBot.setOn()
      TargetBot.setOn()
    end
  end
end)

storage.timercheckarmor = now

macro(200, function()
  if storage.timercheckarmor < now then
    itemtocheck = getInventoryItem(SlotBody)
    itemdisc = itemtocheck:getTooltip()
    if itemdisc then
      startIndex = itemdisc:find('Durability: ')
      endIndex = itemdisc:find('It')
      if startIndex and endIndex then
        durabilityPercentage = itemdisc:sub(startIndex+11, endIndex-5)
        storage.durability = tonumber(durabilityPercentage)
      end
      storage.timercheckarmor = now + 6000
    end
  end
end)

--UI.TextEdit(storage.mindurability or "80", function(widget, newText)
--storage.mindurability = newText
--end)

Backincave = macro(200, '100%',function()end)

UI.Separator()
--------------------------------------------------------
safecavebot = macro(2000, 'SafeCavebot', function()end)
CountDeath = function()
    if storage.countdeath == nil then
        storage.countdeath = 0
    end
    storage.countdeath = storage.countdeath + 1
end

cavebotdelay = function(death)
    if storage.countdeath then
        death = storage.countdeath
    end
    delay(300000 * death)
end

onTextMessage(function(mode, text)
    if safecavebot.isOff() then return end
    if text:find("You are dead") then
        CountDeath()
    end
end)

macro(200, function()
    if safecavebot.isOff() or storage.countdeath == nil then return end
    if storage.countdeath >= 5 then
        CaveBot.setOff()
    end
end)

onKeyDown(function(keys)
    if keys == 'Ctrl+0' then
        storage.countdeath = 0
    end
end)

onCreatureAppear(function(creature)
    if isinGreciaCity() then return end
    if isEnemy(creature) then
        safecavebot.setOn()
    end
end)

---------------------------------------

xth = 700
yth = 10

local widget = setupUI([[
Panel
  height: 400
  width: 900
]], g_ui.getRootWidget())

local deaths = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

 

macro(1, function()
    if storage.countdeath then
    deaths:setColor('blue')
    deaths:setText("Deaths: " .. storage.countdeath .. ' ')
    if storage.countdeath == 4 then
    deaths:setColor('yellow')
        elseif storage.countdeath >= 5 then
    deaths:setColor('red')
    deaths:setText("Deaths: " .. storage.countdeath .. ' Press Ctrl + 0 to reset ')
end
end
end)

 

deaths:setPosition({y = yth, x =  xth})

--------------------------------------------------------------

setDefaultTab("Cave")


CaveBot = {} -- global namespace
CaveBot.Extensions = {}
importStyle("/cavebot/cavebot.otui")
importStyle("/cavebot/config.otui")
importStyle("/cavebot/editor.otui")
importStyle("/cavebot/supply.otui")
dofile("/cavebot/actions.lua")
dofile("/cavebot/config.lua")
dofile("/cavebot/editor.lua")
dofile("/cavebot/example_functions.lua")
dofile("/cavebot/recorder.lua")
dofile("/cavebot/walking.lua")
-- in this section you can add extensions, check extension_template.lua
--dofile("/cavebot/extension_template.lua")
dofile("/cavebot/depositer.lua")
dofile("/cavebot/supply.lua")
-- main cavebot file, must be last
dofile("/cavebot/cavebot.lua")


--info('Loaded Cave')