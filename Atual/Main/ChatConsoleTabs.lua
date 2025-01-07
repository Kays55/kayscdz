setDefaultTab("Main")
local function add(t, text, color, last)
  table.insert(t, text)
  table.insert(t, color)
  if not last then
    table.insert(t, ", ")
    table.insert(t, "#FFFFFF")
  end
end

local t = {}
local mt = {}

local useLoot = macro(100000, function() end)
local tabName = "Loot"
local console = modules.game_console
local tab = console.getTab(tabName) or console.addTab(tabName, true)

onTextMessage(function(mode, text)
  if useLoot.isOff() then return end
  if not text:find("Loot of") or text:find('nothing') then return end
  local msg = text:split(":")
  add(t, os.date('%H:%M') .. ' ' .. msg[1] .. ": ", "#FFFFFF", true)
  if msg[2]:find("nothing") then
    add(t, msg[2], "red", true)
  else
    add(t, msg[2], "green", true)
  end
  console.addText(text, {
    color = '#00EB00'
   }, tabName, "")
  local panel = console.consoleTabBar:getTabPanel(tab)
  local consoleBuffer = panel:getChildById('consoleBuffer')
  local message = consoleBuffer:getLastChild()
  message:setColoredText(t)
  t = {}
end)

onTextMessage(function(mode, text)
    if not text:find("Loot of") then return end
    if text:find('Lendario') or text:find('Epico') or text:find('Raro') or text:find('Incomum') then
 -- get/create tab and write raw message
    local tabName = "Rare Drops"
    local tab = console.getTab(tabName) or console.addTab(tabName, true)
    console.addText(text, console.SpeakTypesSettings, tabName, "")
    end
 end)

onTextMessage(function(mode, text)
    if not text:find("You lose") then return end
    if text:find('hitpoints due to an attack by') then
 -- get/create tab and write raw message
    local tabName = "Dano Recebido PVP"
    local tab = console.getTab(tabName) or console.addTab(tabName, true)
    console.addText(text, console.SpeakTypesSettings, tabName, "")
    end
 end)

onTextMessage(function(mode, text)
    if not text:find("hitpoints due to your attack") or text:find("An ") then return end
 -- get/create tab and write raw message
    local tabName = "Dano Causado PVP"
    local tab = console.getTab(tabName) or console.addTab(tabName, true)
    console.addText(text, console.SpeakTypesSettings, tabName, "")
 end)


info('Loaded ConsoleChats')
UI.Separator()