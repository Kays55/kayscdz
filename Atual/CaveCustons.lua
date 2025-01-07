setDefaultTab("Cave")

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
      if storage.durability == nil then
        storage.durability = 0
      end
      storage.timercheckarmor = now + 6000
    end
  end
end)

UI.TextEdit(storage.mindurability or "80", function(widget, newText)
storage.mindurability = newText
end)

Backincave = macro(200, function()end)
StopTemple = macro(200, 'SafeStop', function()
    if IsInGreeceTemple() then
        CaveBot.setOff()
    end
end)
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


schedule(300, function()
    use(storage.nhpitem)
end)

onTextMessage(function(mode, text)
    if text:find('rainbow') and text:find('Using one of') then
        storage.potaamout = tonumber(text:match('%d+'))
    end
    if text:find('Using the last') and text:find('rainbow') then
        storage.potaamout = 0
    end
end)

Potx,Poty = 100, 0


local widget = setupUI([[
Panel
  height: 400
  width: 900
]], g_ui.getRootWidget())

local ammoutpot = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

 

macro(1, function()
    if storage.potaamout then
    if storage.potaamout and storage.potaamout >= 50 then
        ammoutpot:setColor('green')
    elseif storage.potaamout < 50 then
        ammoutpot:setColor('red')
    end
        ammoutpot:setText('Numero de Pot:  ' .. (storage.potaamout))
    end
end)
 

ammoutpot:setPosition({y = Poty+50, x =  Potx})


macro(200, 'No Pot Stop', function()
    if isInPz() and storage.potaamout == 0 then
        CaveBot.setOff()
    end
end)


--------------------------------------------------------------