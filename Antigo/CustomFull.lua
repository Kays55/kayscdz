setDefaultTab("Atk")
macro(100, 'Combo', function()
 if not g_game.isAttacking() or (stop and stop >= now) then return end
  if player:getLevel() >= 250 then
   say(storage.combo4)
end
 if player:getLevel() >= 150 then
   say(storage.combo3)
end
 if player:getLevel() >= 50 then
   say(storage.combo2)
end
 if player:getLevel() >= 1 then
  say(storage.combo1)
end
end)

onKeyPress(function(keys)
    if storage.ultimate == nil or modules.game_console:isChatEnabled() then return end
    if keys == 'R' then
        say(storage.ultimate)
    end
end)

onKeyPress(function(keys)
    if storage.sspell == nil or modules.game_console:isChatEnabled() then return end
    if keys == 'F' then
        say(storage.sspell)
    end
end)

macro(200, "Face Target", function()
    local target = g_game.getAttackingCreature()
    if not target then return end
    local xDiff = target:getPosition().x > posx()
    local yDiff = target:getPosition().y > posy()
    local isXBigger = math.abs(target:getPosition().x - posx()) > math.abs(target:getPosition().y - posy())

    local dir = player:getDirection()
    if xDiff and isXBigger then  
        if dir ~= 1 then turn(1) end
        return
    elseif not xDiff and isXBigger then 
        if dir ~= 3 then turn(3) end
        return
    elseif yDiff and not isXBigger then  
        if dir ~= 2 then turn(2) end
        return
    elseif not yDiff and not isXBigger  then 
        if dir ~= 0 then turn(0) end
        return
    end
end)

storage.excalibur = now
macro(20, 'Excalibur', function()
  if storage.excalibur <= now and g_game.isAttacking() then
    say('excalibur sword')
  end
end)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and channelId == 0 and mode == 44 then
  if text:find('excalibur sword') then
    storage.excalibur = now + 25000
  end
 end
end)

setDefaultTab("Def")

if storage.healspell == nil then
  storage.healspell = 'regeneration'
end

schedule(2000, function()
  if player:getLevel() < 200 then
    storage.healspell = 'regeneration'
  elseif player:getLevel() >= 200 then
    storage.healspell = 'super regeneration'
  end
end)

healmacro = macro(200, 'heal', function()
  if hppercent() < 99 then
    say(storage.healspell)
  end
 end)

UI.Label('Item ID')
UI.TextEdit(storage.hpitem or "3077", function(widget, newText)
storage.hpitem = newText
end)
UI.Label('HP')
UI.TextEdit(storage.hppot or "60", function(widget, newText)
storage.hppot = newText
end)

itemhealmacro = macro(200, 'Item heal', function()
  if hppercent() < tonumber(storage.hppot) then
    use(tonumber(storage.hpitem))
  end
end)

UI.Separator()


UI.Separator()

setDefaultTab("ATK")

UI.Label("Enemys")

macro(1, "Chicletinho 90%", function()

for _,pla in ipairs(getSpectators(posz())) do

attacked = g_game.getAttackingCreature()

if not attacked or attacked:isMonster() or attacked:isPlayer() and pla:getHealthPercent() < attacked:getHealthPercent()*0.6 then
if pla:isPlayer() and pla:getHealthPercent() < 90 and pla:getEmblem() ~= 1 and pla:getSkull() <= 3 then 
g_game.attack(pla)
end
end

end

delay(100)

end)

------------------------------------------------------------------------------------

local friendList = {'toei', 'ryan', 'darknuss', ''}

--- nao editar nada abaixo disso

for index, friendName in ipairs(friendList) do
     friendList[friendName:lower():trim()] = true
    friendList[index] = nil
end





macro(1, 'Chiclete Ryan', function()
  local possibleTarget = false
  for _, creature in ipairs(getSpectators(posz())) do
    local specHP = creature:getHealthPercent()
    if creature:isPlayer() and specHP and specHP > 0 and specHP <= 90 then
      if not friendList[creature:getName():lower()] and creature:getEmblem() ~= 1 then
        if creature:canShoot() then
          if not possibleTarget or possibleTargetHP > specHP or (possibleTargetHP == specHP and possibleTarget:getId() < creature:getId()) then
            possibleTarget = creature
            possibleTargetHP = possibleTarget:getHealthPercent()
          end
        end
      end
    end
  end
  if possibleTarget and g_game.getAttackingCreature() ~= possibleTarget then
    g_game.attack(possibleTarget)
end
end)

----------------------------------------------------------------------------------------

local friendList = {'toei', 'ryan', 'darknuss', ''}

--- nao editar nada abaixo disso

for index, friendName in ipairs(friendList) do
     friendList[friendName:lower():trim()] = true
    friendList[index] = nil
end





macro(1, 'Enemy Full', function()
  local possibleTarget = false
  for _, creature in ipairs(getSpectators(posz())) do
    local specHP = creature:getHealthPercent()
    if creature:isPlayer() and specHP then
      if not friendList[creature:getName():lower()] and creature:getEmblem() ~= 1 then
        if creature:canShoot() then
          if not possibleTarget or possibleTargetHP > specHP or (possibleTargetHP == specHP and possibleTarget:getId() < creature:getId()) then
            possibleTarget = creature
            possibleTargetHP = possibleTarget:getHealthPercent()
          end
        end
      end
    end
  end
  if possibleTarget and g_game.getAttackingCreature() ~= possibleTarget then
    g_game.attack(possibleTarget)
end
end)

--------------------------------------------------------------------------------


UI.TextEdit(storage.ntarget or "Nejia", function(widget, newText)
storage.ntarget = newText
end)

UI.TextEdit(storage.ntarget2 or "Nejia", function(widget, newText)
storage.ntarget2 = newText
end)

atkname = macro(100, 'AttackName', function() 
if g_game.isAttacking() or g_game.isFollowing() then return end
  for _, spec in ipairs(getSpectators()) do
    local specifytarget = spec:getName()
    if (specifytarget == storage.ntarget or specifytarget == storage.ntarget2) and spec:isPlayer()  then
g_game.attack(spec)
    end
  end
end)

-------------------------------------------------------------------------------------



local friendList = {'toei', 'ryan', 'darknuss', ''}

--- nao editar nada abaixo disso

for index, friendName in ipairs(friendList) do
     friendList[friendName:lower():trim()] = true
    friendList[index] = nil
end





macro(1, 'Ant-Caveira', function()
  local possibleTarget = false
  for _, creature in ipairs(getSpectators(posz())) do
    local specHP = creature:getHealthPercent()
    if creature:isPlayer() and specHP then
      if not friendList[creature:getName():lower()] and (creature:getSkull() ~= 0) and (creature:getShield() == 0) and (creature:getEmblem() ~= 1) then
        if creature:canShoot() then
          if not possibleTarget or possibleTargetHP > specHP or (possibleTargetHP == specHP and possibleTarget:getId() < creature:getId()) then
            possibleTarget = creature
            possibleTargetHP = possibleTarget:getHealthPercent()
          end
        end
      end
    end
  end
  if possibleTarget and g_game.getAttackingCreature() ~= possibleTarget then
    g_game.attack(possibleTarget)
end
end)


--onTextMessage(function(mode, text)
 --for _, p in ipairs(getSpectators(posz())) do
 -- if p:isPlayer() and text:find(p:getName()) and text:find('attack by') then
    --CaveBot.setOff()
    --TargetBot.setOff()
 -- end
--end
--end)


local friendList = {'toei', 'ryan', 'darknuss', ''}

--- nao editar nada abaixo disso

for index, friendName in ipairs(friendList) do
     friendList[friendName:lower():trim()] = true
    friendList[index] = nil
end





macro(1, 'Chiclete Ryan Friend', function()
  local possibleTarget = false
  for _, creature in ipairs(getSpectators(posz())) do
    local specHP = creature:getHealthPercent()
    if creature:isPlayer() and specHP and specHP > 0 and specHP <= 90 then
      if (not friendList[creature:getName():lower()] and not isFriend(creature)) and creature:getEmblem() ~= 1 then
        if creature:canShoot() then
          if not possibleTarget or possibleTargetHP > specHP or (possibleTargetHP == specHP and possibleTarget:getId() < creature:getId()) then
            possibleTarget = creature
            possibleTargetHP = possibleTarget:getHealthPercent()
          end
        end
      end
    end
  end
  if possibleTarget and g_game.getAttackingCreature() ~= possibleTarget then
    g_game.attack(possibleTarget)
end
end)

stopbotonattack = macro(200, 'StopBotOnAttack', function()end)
onTextMessage(function(mode, text)
  if stopbotonattack.isOff() then return end
 for _, p in ipairs(getSpectators(posz())) do
  if p:isPlayer() and text:find(p:getName()) and text:find('attack by') then
    CaveBot.setOff()
    TargetBot.setOff()
  end
end
end)

UI.Separator()
UI.Label("Follow")

UI.TextEdit(storage.follow or "Sealed Crystal East", function(widget, newText)
storage.follow = newText
end)

UI.TextEdit(storage.follow2 or "Sealed Crystal West", function(widget, newText)
storage.follow2 = newText
end)

macro(100, 'Follow Name', function() 
if g_game.isAttacking() or g_game.isFollowing() then return end
  for _, spec in ipairs(getSpectators()) do
    if spec:getName() == storage.follow or spec:getName() == storage.follow2 then
g_game.follow(spec)
    end
  end
end)


others = macro(100, 'OthersBot', function() 
if g_game.isAttacking() then return end
  for _, spec in ipairs(getSpectators()) do
    if spec:isMonster() then
   g_game.attack(spec)
    end
  end
end)

UI.Separator()

setDefaultTab("Tools")

storage.holditem = now
onPlayerHealthChange(function(healthPercent)
  if healthPercent < 15 then
    storage.holditem  = now + 3000
  end
end)

  speedartefact = findItem(13788)
  reviveartefact = findItem(13815)
  Damageartefact = findItem(13779)
  LootArtefact = findItem(13694)
  PoisonArtefact = findItem(13727)

macro(200, 'RemovePoison', function()
    if isPoisioned() then
    moveToSlot(13727, 2)
  end
end)

macro(200, 'ArtefactAdapt', function()
  if storage.holditem > now then
    moveToSlot(13815, 2)
  elseif g_game.isAttacking() then
      x = g_game.getAttackingCreature()
     if x:getHealthPercent() <= 10 and x:isMonster() then
      moveToSlot(13694, 2)
      delay(1000)
  else
    moveToSlot(13779, 2)
  end
  else
    moveToSlot(13788, 2)
  end
end)

onContainerOpen(function(container, previousContainer)
  if not container:getName():find('grey bag') then return end
  if container:getName():find('grey bag') then
    ArtefactBpOpen = 'true'
end
end)
onContainerClose(function(container)
if not container:getName():find('grey bag') then return end
if container:getName():find('grey bag') then
ArtefactBpOpen = 'false'
end
end)

macro(1000, 'AbrirBp', function()
if  ArtefactBpOpen == 'false' or ArtefactBpOpen == nil then
g_game.open(findItem(654))
end
end)


UI.Separator()

setDefaultTab("Tools")
local showhp = macro(10000,"- % HP Monstros -", function() end)
onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() or creature == player then return end
    if creature:getPosition() and pos() then
        if getDistanceBetween(pos(), creature:getPosition()) <= 10 then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
        end
    end
end)

local windowUI = setupUI([[
Panel
  id: mainWindow
  anchors.verticalCenter: parent.verticalCenter
  anchors.horizontalCenter: parent.horizontalCenter
  height: 100
  width: 270
  margin-bottom: 150
  phantom: true

  Label
    id: creatureName
    text: Name: Beez
    color: white
    margin-left: 80
    margin-top: 25
    anchors.top: parent.top
    anchors.left: creature.left
    width: 100
    font: verdana-11px-rounded
    text-horizontal-auto-resize: true
  UICreature
    id: creature
    size: 70 70
    margin-bottom: 30
    anchors.bottom: parent.bottom

  MiniWindowContents
    size: 300 300
    margin: 40 22
    id: secondaryWindow
    HealthBar
      id: healthBar
      background-color: green
      height: 12
      anchors.left: parent.left
      text: 100/100
      text-offset: 0 1
      text-align: center
      font: verdana-11px-rounded
      margin-left: 60
      width: 180
      margin-right: 5

]], modules.game_interface.gameMapPanel);

windowUI:hide();

macro(100, 'TargetNaTela', function()
    local target = g_game.getAttackingCreature();

    if target and not target:isNpc() then
        local hp = target:getHealthPercent();
        if(hp >= 76) then
            windowUI.secondaryWindow.healthBar:setBackgroundColor("#14fe17")
        elseif (hp > 50) then
            windowUI.secondaryWindow.healthBar:setBackgroundColor("#ffff29")
        elseif (hp > 25) then
            windowUI.secondaryWindow.healthBar:setBackgroundColor("#ff9b29")
        elseif (hp > 1) then
            windowUI.secondaryWindow.healthBar:setBackgroundColor("#ff2929")
        end
        windowUI.creature:setOutfit(target:getOutfit());
        windowUI.creatureName:setText(target:getName());

        if (windowUI:isHidden()) then
            windowUI:show();
        end
        windowUI.secondaryWindow.healthBar:setValue(hp, 0, 100);
        windowUI.secondaryWindow.healthBar:setText(hp .. "/100");
    elseif (not target and not windowUI:isHidden()) then
        windowUI:hide();
    end
end);

UI.Separator()

setDefaultTab("Tools")
-- config

local keyUp = "="
local keyDown = "-"

-- script

local lockedLevel = pos().z

onPlayerPositionChange(function(newPos, oldPos)
    lockedLevel = pos().z
    modules.game_interface.getMapPanel():unlockVisibleFloor()
end)

onKeyPress(function(keys)
    if keys == keyDown then
        lockedLevel = lockedLevel + 1
        modules.game_interface.getMapPanel():lockVisibleFloor(lockedLevel)
    elseif keys == keyUp then
        lockedLevel = lockedLevel - 1
        modules.game_interface.getMapPanel():lockVisibleFloor(lockedLevel)
    end
end)

setDefaultTab("Tools")
-- Target
local creatureId = nil;
local stopAttackRequested = false;
 
keepTarget = {
  setTarget = function(_creatureId)
    creatureId = _creatureId;
  end,
 
  stopAttack = function()
    stopAttackRequested = true;
  end
};
 
 
 
Target = {
 KeyCancel = 'Escape',
 cancelTime = 0,
 cancel = function()
  Target.Id = nil
  Target.get = nil
  Target.cancelTime = now + 100
  g_game.cancelAttack()
 end
 }
 
hotkey(Target.KeyCancel, function()
 Target.cancel()
end)
 
macro(100, 'Target', function()
 if Target.cancelTime >= now then return end
 if g_game.isAttacking() then
  Target.Id = g_game.getAttackingCreature():getId()
 elseif Target.Id then
  Target.get = getCreatureById(Target.Id)
  if Target.get then
   g_game.attack(Target.get)
  end
 end
end)

local STANCE_MODE_CHASE = 1;
local STANCE_MODE_STAND = 0;
local setStanceMode = g_game.setChaseMode;
local getStanceMode = g_game.getChaseMode;
onKeyDown(function(key)
    if (key ~= "6") then return; end
    local stanceMode = getStanceMode();
    if (stanceMode ~= STANCE_MODE_CHASE) then
        return setStanceMode(STANCE_MODE_CHASE);
    end
    setStanceMode(STANCE_MODE_STAND);
end)



BugLock = {};


local availableKeys = {
  ['W'] = { 0, -5 },
  ['S'] = { 0, 5 },
  ['A'] = { -5, 0 },
  ['D'] = { 5, 0 },
  ['C'] = { 5, 5 },
  ['Z'] = { -5, 5 },
  ['Q'] = { -5, -5 },
  ['E'] = { 5, -5 }
};

BugMap = macro(1, "BugMap", function()
if modules.game_walking.wsadWalking then
  BugLock.logic();
end
end)

function BugLock.logic()
  local playerPos = pos();
  local tile;
  for key, value in pairs(availableKeys) do
    if (modules.corelib.g_keyboard.isKeyPressed(key)) then
      playerPos.x = playerPos.x + value[1];
      playerPos.y = playerPos.y + value[2];
      tile = g_map.getTile(playerPos);
      break;
    end
  end
  if (not tile) then return end;
  g_game.use(tile:getTopUseThing());
end

BugLock.icon = addIcon("Bug Map", {item=10384, text="Bug Map", hotkey="Ctrl+Space"}, function(icon, isOn) 
  BugMap.setOn(isOn); 
end);

BugMap.setOn()


storage.timerhaste = now
macro(20, 'Haste', function()
  if storage.timerhaste <= now then
    say('speed up')
  end
end)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and channelId == 0 and mode == 44 then
  if text:find('speed up') then
    storage.timerhaste = now + 58000
  end
 end
end)

macro(100, "anti paralyze", function() 
  if not isParalyzed() then return end
    say('Speed Up')
end)

say('light')
macro(15000, 'Light', function()
say('light')
end)

UI.Label("Mana training")
if type(storage.manaTrain) ~= "table" then
  storage.manaTrain = {on=false, title="MP%", text="utevo lux", min=80, max=100}
end

local manatrainmacro = macro(1000, function()
  if TargetBot and TargetBot.isActive() then return end -- pause when attacking
  local mana = math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
  if storage.manaTrain.max >= mana and mana >= storage.manaTrain.min then
    say(storage.manaTrain.text)
  end
end)
manatrainmacro.setOn(storage.manaTrain.on)

UI.DualScrollPanel(storage.manaTrain, function(widget, newParams) 
  storage.manaTrain = newParams
  manatrainmacro.setOn(storage.manaTrain.on)
end)

UI.Separator()

local idz = {13328, 13329, 13330, 13331, 13332, 13333, 13334, 13335, 13336, 13337, 13338, 13339, 13340, 13341, 13342, 13428, 14256, 13429, 13427, 13422, 13430, 13424, 13426, 14255, 13431, 13423, 13421, 13425, 14261, 14263}

macro(300, "Ground Collect", function()
    local playerPos = g_game.getLocalPlayer():getPosition()
    local z = playerPos.z 
    local tiles = g_map.getTiles(posz()) 
    for _, tile in ipairs(tiles) do 
        if z ~= playerPos.z then return end 
        if g_game.getAttackingCreature() == nil then
            if getDistanceBetween(pos(), tile:getPosition()) <= 8 then
                local topThing = tile:getTopMoveThing()
                if topThing and table.find(idz, topThing:getId()) then 
                    g_game.move(topThing, {x = 65535, y = SlotAmmo, z = 0}, topThing:getCount()) 
                end
            end
        end
    end
end)

UI.Separator()

if not storage.timers then  storage.timers = {  time = 1 } end
local widgetTC = setupUI([[
Panel
  size: 14 14
  anchors.bottom: parent.bottom
  anchors.left: parent.left
  Label
    id: lblTimer
    color: orange
    font: verdana-11px-rounded
    height: 12
    background-color: #00000040
    opacity: 0.87
    text-auto-resize: true
    !text: tr('00:00:00 Horas')

]], modules.game_interface.getMapPanel())

 doFormatinTime = function(v)
     hours = string.format(v['hour'])
     mins = string.format(v['min'])
     seconds = string.format(v['sec'])
    return hours .. ":" .. mins .. ":" .. seconds .. " Horas"
end
tmrMacro2 = macro(1000, function(widget)
    real_time = os.date('*t', os.time())
-----------------------------
-- CODIGO AQUI
-----------------------------
    schedule(100, function()
        tmrMacro2:setOn()
        widgetTC.lblTimer:setText(doFormatinTime(real_time))
    end)
-----------------------------
        tmrMacro2:setOff()
        return
    widgetTC.lblTimer:setText(doFormatinTime(real_time)) 
end)

onTextMessage(function(mode, text)
 for _, p in ipairs(getSpectators(posz())) do
  if p:isPlayer() and text:find(p:getName()) and text:find('attack by') then
      storage.lastattacker = p:getName()
      storage.timehours = hours
      storage.timemin = mins
      storage.timesec = seconds
  end
 end
end)

onKeyDown(function(keys)
    if keys == 'Tab' and storage.lastattacker and storage.timehours and storage.timemin and storage.timesec then
info(storage.lastattacker)
        info(storage.lastattacker .. storage.timehours .. ':' .. storage.timemin .. ':' .. storage.timesec)
    end
end)


UI.Separator()

-- Cavebot by otclient@otclient.ovh
-- visit http://bot.otclient.ovh/

setDefaultTab("Cave")

macro(200, 'safe hunt', function()
if hppercent() < 50 then
CaveBot.setOff()
end
if hppercent() == 100 and manapercent() == 100 then
CaveBot.setOn()
end
end)

setDefaultTab("Main")

local panelName = "alarms"
local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Alarms')

  Button
    id: alerts
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Edit

]])
ui:setId(panelName)

if not storage[panelName] then
  storage[panelName] = {}
end

local config = storage[panelName]

ui.title:setOn(config.enabled)
ui.title.onClick = function(widget)
  config.enabled = not config.enabled
  widget:setOn(config.enabled)
end

local window = UI.createWindow("AlarmsWindow")
window:hide()

ui.alerts.onClick = function()
  window:show()
  window:raise()
  window:focus()
end

local widgets = 
{
  "AlarmCheckBox", 
  "AlarmCheckBoxAndSpinBox", 
  "AlarmCheckBoxAndTextEdit"
}

local parents = 
{
  window.list, 
  window.settingsList
}


-- type
addAlarm = function(id, title, defaultValue, alarmType, parent, tooltip)
  local widget = UI.createWidget(widgets[alarmType], parents[parent])
  widget:setId(id)

  if type(config[id]) ~= 'table' then
    config[id] = {}
  end

  widget.tick:setText(title)
  widget.tick:setChecked(config[id].enabled)
  widget.tick:setTooltip(tooltip)
  widget.tick.onClick = function()
    config[id].enabled = not config[id].enabled
    widget.tick:setChecked(config[id].enabled)
  end

  if alarmType > 1 and type(config[id].value) == 'nil' then
    config[id].value = defaultValue
  end

  if alarmType == 2 then
    widget.value:setValue(config[id].value)
    widget.value.onValueChange = function(widget, value)
      config[id].value = value
    end
  elseif alarmType == 3 then
    widget.text:setText(config[id].value)
    widget.text.onTextChange = function(widget, newText)
      config[id].value = newText
    end
  end

end

-- settings
addAlarm("ignoreFriends", "Ignore Friends", true, 1, 2)
addAlarm("flashClient", "Flash Client", true, 1, 2)

-- alarm list
addAlarm("damageTaken", "Damage Taken", false, 1, 1)
addAlarm("lowHealth", "Low Health", 20, 2, 1)
addAlarm("lowMana", "Low Mana", 20, 2, 1)
addAlarm("playerAttack", "Player Attack", false, 1, 1)

UI.Separator(window.list)

addAlarm("privateMsg", "Private Message", false, 1, 1)
addAlarm("defaultMsg", "Default Message", false, 1, 1)
addAlarm("customMessage", "Custom Message:", "", 3, 1, "You can add text, that if found in any incoming message will trigger alert.\n You can add many, just separate them by comma.")

UI.Separator(window.list)

addAlarm("creatureDetected", "Creature Detected", false, 1, 1)
addAlarm("playerDetected", "Player Detected", false, 1, 1)
addAlarm("creatureName", "Creature Name:", "", 3, 1, "You can add a name or part of it, that if found in any visible creature name will trigger alert.\nYou can add many, just separate them by comma.")


local lastCall = now
local function alarm(file, windowText)
  if now - lastCall < 2000 then return end -- 2s delay
  lastCall = now

  if not g_resources.fileExists(file) then
    file = "/sounds/alarm.ogg"
    lastCall = now + 4000 -- alarm.ogg length is 6s
  end

  
  if modules.game_bot.g_app.getOs() == "windows" and config.flashClient.enabled then
    g_window.flash()
  end
  g_window.setTitle(player:getName() .. " - " .. windowText)
  playSound(file)
end

-- damage taken & custom message
onTextMessage(function(mode, text)
  if not config.enabled then return end
  if mode == 22 and config.damageTaken.enabled then
    return alarm('/sounds/magnum.ogg', "Damage Received!")
  end

  if config.customMessage.enabled then
    local alertText = config.customMessage.value
    if alertText:len() > 0 then
      text = text:lower()
      local parts = string.split(alertText, ",")

      for i=1,#parts do
        local part = parts[i]
        part = part:trim()
        part = part:lower()

        if text:find(part) then
          return alarm('/sounds/magnum.ogg', "Special Message!")
        end
      end
    end
  end
end)

-- default & private message
onTalk(function(name, level, mode, text, channelId, pos)
  if not config.enabled then return end
  if name == player:getName() then return end -- ignore self messages
  if config.ignoreFriends.enabled and isFriend(name) then return end -- ignore friends if enabled

  if mode == 1 and config.defaultMsg.enabled then
    return alarm("/sounds/magnum.ogg", "Default Message!")
  end

  if mode == 4 and config.privateMsg.enabled then
    return alarm("/sounds/Private_Message.ogg", "Private Message!")
  end
end)

-- health & mana
macro(100, function() 
  if not config.enabled then return end
  if config.lowHealth.enabled then
    if hppercent() < config.lowHealth.value then
      return alarm("/sounds/Low_Health.ogg", "Low Health!")
    end
  end

  if config.lowMana.enabled then
    if hppercent() < config.lowMana.value then
      return alarm("/sounds/Low_Mana.ogg", "Low Mana!")
    end
  end

  for i, spec in ipairs(getSpectators()) do
    if not spec:isLocalPlayer() and not (config.ignoreFriends.enabled and isFriend(spec)) then

      if config.creatureDetected.enabled then
        return alarm("/sounds/magnum.ogg", "Creature Detected!")
      end

      if spec:isPlayer() then 
        if spec:isTimedSquareVisible() and config.playerAttack.enabled then
          return alarm("/sounds/Player_Attack.ogg", "Player Attack!")
        end
        if config.playerDetected.enabled then
          return alarm("/sounds/Player_Detected.ogg", "Player Detected!")
        end
      end

      if config.creatureName.enabled then
        local name = spec:getName():lower()
        local fragments = string.split(config.creatureName.value, ",")
        
        for i=1,#fragments do
          local frag = fragments[i]:trim():lower()

          if name:lower():find(frag) then
            return alarm("/sounds/alarm.ogg", "Special Creature Detected!")
          end
        end
      end
    end
  end
end)

UI.Separator()

--[[
  configuration for check players
  example made on server Gunzodus

  example link for player overview:
  https://www.gunzodus.net/character/show/Sir_Vithrax

  *note that space in character name was replaced with underscore (_) - this character will be important

  in this case:
  link = "https://www.gunzodus.net/character/show/" -- everything with all the characters up to the start of the name
  spacing = "_" -- space replacement in character name
]]

local link = "https://www.gunzodus.net/character/show/"
local spacing = "_"



-- do not edit below
setDefaultTab("Main")
local tabs = {"Friends", "Enemies", "BlackList"}
local panelName = "playerList"
local colors = {"#03C04A", "#fc4c4e", "orange"}

if not storage[panelName] then
    storage[panelName] = {
      enemyList = {},
      friendList = {},
      blackList = {},
      groupMembers = true,
      outfits = false,
      marks = false,
      highlight = false
    }
end

local config = storage[panelName]
local playerTables = {config.friendList, config.enemyList, config.blackList}

-- functions
local function clearCachedPlayers()
  CachedFriends = {}
  CachedEnemies = {}
end

local refreshStatus = function()
    for _, spec in ipairs(getSpectators()) do
      if spec:isPlayer() and not spec:isLocalPlayer() then
        if config.outfits then
          local specOutfit = spec:getOutfit()
          if isFriend(spec:getName()) then
            if config.highlight then
              spec:setMarked('#0000FF')
            end
            specOutfit.head = 88
            specOutfit.body = 88
            specOutfit.legs = 88
            specOutfit.feet = 88
            if storage.BOTserver.outfit then
              local voc = vBot.BotServerMembers[spec:getName()]
              specOutfit.addons = 3 
              if voc == 1 then
                specOutfit.type = 131
              elseif voc == 2 then
                specOutfit.type = 129
              elseif voc == 3 then
                specOutfit.type = 130
              elseif voc == 4 then
                specOutfit.type = 144
              end
            end
            spec:setOutfit(specOutfit)
          elseif isEnemy(spec:getName()) then
            if config.highlight then
              spec:setMarked('#FF0000')
            end
            specOutfit.head = 94
            specOutfit.body = 94
            specOutfit.legs = 94
            specOutfit.feet = 94
            spec:setOutfit(specOutfit)
          end
        end
      end
    end
end
refreshStatus()

local checkStatus = function(creature)
    if not creature:isPlayer() or creature:isLocalPlayer() then return end
  
    local specName = creature:getName()
    local specOutfit = creature:getOutfit()
  
    if isFriend(specName) then
      if config.highlight then
        creature:setMarked('#0000FF')
      end
      if config.outfits then
        specOutfit.head = 88
        specOutfit.body = 88
        specOutfit.legs = 88
        specOutfit.feet = 88
        if storage.BOTserver.outfit then
          local voc = vBot.BotServerMembers[creature:getName()]
          specOutfit.addons = 3 
          if voc == 1 then
            specOutfit.type = 131
          elseif voc == 2 then
            specOutfit.type = 129
          elseif voc == 3 then
            specOutfit.type = 130
          elseif voc == 4 then
            specOutfit.type = 144
          end
        end
        creature:setOutfit(specOutfit)
      end
    elseif isEnemy(specName) then
      if config.highlight then
        creature:setMarked('#FF0000')
      end
      if config.outfits then
        specOutfit.head = 94
        specOutfit.body = 94
        specOutfit.legs = 94
        specOutfit.feet = 94
        creature:setOutfit(specOutfit)
      end
    end
end


rootWidget = g_ui.getRootWidget()
if rootWidget then
    local ListWindow = UI.createWindow('PlayerListWindow', rootWidget)
    ListWindow:hide()

    UI.Button("Player Lists", function() 
        ListWindow:show()
        ListWindow:raise()
        ListWindow:focus()
    end)

    -- settings
    ListWindow.settings.Members:setChecked(config.groupMembers)
    ListWindow.settings.Members.onClick = function(widget)
      config.groupMembers = not config.groupMembers
      if not config.groupMembers then
        clearCachedPlayers()
      end
      refreshStatus()
      widget:setChecked(config.groupMembers)
    end
    ListWindow.settings.Outfit:setChecked(config.outfits)
    ListWindow.settings.Outfit.onClick = function(widget)
      config.outfits = not config.outfits
      widget:setChecked(config.outfits)
      refreshStatus()
    end
    ListWindow.settings.NeutralsAreEnemy:setChecked(config.marks)
    ListWindow.settings.NeutralsAreEnemy.onClick = function(widget)
      config.marks = not config.marks
      widget:setChecked(config.marks)
    end
    ListWindow.settings.Highlight:setChecked(config.highlight)
    ListWindow.settings.Highlight.onClick = function(widget)
      config.highlight = not config.highlight
      widget:setChecked(config.highlight)
    end

    ListWindow.settings.AutoAdd:setChecked(config.autoAdd)
    ListWindow.settings.AutoAdd.onClick = function(widget)
      config.autoAdd = not config.autoAdd
      widget:setChecked(config.autoAdd)
    end

    local TabBar = ListWindow.tmpTabBar
    TabBar:setContentWidget(ListWindow.tmpTabContent)
    local blacklistList

    for v = 1, 3 do
        local listPanel = g_ui.createWidget("tPanel") -- Creates Panel
        local playerList = playerTables[v]
        listPanel:setId(tabs[v].."Tab")
        TabBar:addTab(tabs[v], listPanel)

        -- elements
        local addButton = listPanel.add
        local nameTab = listPanel.name
        local list = listPanel.list
        if v == 3 then
          blacklistList = list
        end

        for i, name in ipairs(playerList) do
            local label = UI.createWidget("PlayerLabel", list)
            label:setText(name)
            label.remove.onClick = function()
                table.remove(playerList, table.find(playerList, name))
                label:destroy()
                clearCachedPlayers()
                refreshStatus()
            end
            label.onMouseRelease = function(widget, mousePos, mouseButton)
              if mouseButton == 2 then
                local child = rootWidget:recursiveGetChildByPos(mousePos)
                if child == widget then
                  local menu = g_ui.createWidget('PopupMenu')
                  menu:setId("blzMenu")
                  menu:setGameMenu(true)
                  menu:addOption('Check Player', function()
                    local name = widget:getText():gsub(" ", spacing)
                    g_platform.openUrl(link..name)
                  end, "")
                  menu:addOption('Copy Name', function()
                    g_window.setClipboardText(widget:getText())
                  end, "")
                  menu:display(mousePos)
                  return true
                end
              end
            end
        end

        local tabButton = TabBar.buttonsPanel:getChildren()[v]

        tabButton.onStyleApply = function(widget)
            if TabBar:getCurrentTab() == widget then
                widget:setColor(colors[v])
            end 
        end

        -- callbacks
        addButton.onClick = function()
            local names = string.split(nameTab:getText(), ",")

            if #names == 0 then
              warn("vBot[PlayerList]: Name is missing!")
              return
            end

            for i=1,#names do
              local name = names[i]:trim()
              if name:len() == 0 then
                  warn("vBot[PlayerList]: Name is missing!")
              else
                  if not table.find(playerList, name) then
                      table.insert(playerList, name)
                      local label = UI.createWidget("PlayerLabel", list)
                      label:setText(name)
                      label.remove.onClick = function()
                          table.remove(playerList, table.find(playerList, name))
                          label:destroy()
                      end
                      label.onMouseRelease = function(widget, mousePos, mouseButton)
                        if mouseButton == 2 then
                          local child = rootWidget:recursiveGetChildByPos(mousePos)
                          if child == widget then
                            local menu = g_ui.createWidget('PopupMenu')
                            menu:setId("blzMenu")
                            menu:setGameMenu(true)
                            menu:addOption('Check Player', function()
                              local name = widget:getText():gsub(" ", "_")
                              local link = "https://www.gunzodus.net/character/show/"
                              g_platform.openUrl(link..name)
                            end, "")
                            menu:addOption('Copy Name', function()
                              g_window.setClipboardText(widget:getText())
                            end, "")
                            menu:display(mousePos)
                            return true
                          end
                        end
                      end
                      nameTab:setText("")
                  else
                      warn("vBot[PlayerList]: Player ".. name .." is already added!")
                      nameTab:setText("")
                  end
                  clearCachedPlayers()
                  refreshStatus()
              end
            end
        end

        nameTab.onKeyPress = function(widget, keyCode, keyboardModifiers)
          if keyCode ~= 5 then
            return false
          end
          addButton.onClick()
          return true
        end
    end

    function addBlackListPlayer(name)
      if table.find(config.blackList, name) then return end

      table.insert(config.blackList, name)
      local label = UI.createWidget("PlayerLabel", blacklistList)
      label:setText(name)
      label.remove.onClick = function()
          table.remove(playerList, table.find(playerList, name))
          label:destroy()
      end
      label.onMouseRelease = function(widget, mousePos, mouseButton)
        if mouseButton == 2 then
          local child = rootWidget:recursiveGetChildByPos(mousePos)
          if child == widget then
            local menu = g_ui.createWidget('PopupMenu')
            menu:setId("blzMenu")
            menu:setGameMenu(true)
            menu:addOption('Check Player', function()
              local name = widget:getText():gsub(" ", "_")
              local link = "https://www.gunzodus.net/character/show/"
              g_platform.openUrl(link..name)
            end, "")
            menu:addOption('Copy Name', function()
              g_window.setClipboardText(widget:getText())
            end, "")
            menu:display(mousePos)
            return true
          end
        end
      end
    end
end

onTextMessage(function(mode,text)
  if not config.autoAdd then return end
  if CaveBot.isOff() or TargetBot.isOff() then return end
  if not text:find("Warning! The murder of") then return end

    text = string.split(text, "Warning! The murder of ")[1]
    text = string.split(text, " was not justified.")[1]

    addBlackListPlayer(text)
end)

onCreatureAppear(function(creature)
    checkStatus(creature)
  end)
  
onPlayerPositionChange(function(x,y)
  if x.z ~= y.z then
    schedule(20, function()
      refreshStatus()
    end)
  end
end)

UI.Separator()

setDefaultTab("Tools")
  ClosestStair = {};
ClosestStair.tile = nil;
ClosestStair.aditionalTiles = { 1067, 595, 5293, 5542,  1648, 1678, 13296, 1646, 5111, 1948, 7771, 8657, 1680, 6264, 1664, 6262, 5291, 6905, 1646, 435 };
ClosestStair.ignoredTiles = { 1949 }
ClosestStair.flags = { ignoreNonPathable = true, precision = 1, ignoreCreatures = false }
ClosestStair.walkTime = now;

local keyToPress = "Space";

ClosestStair.macro = macro(50, 'Escadas', function()
    local tiles = g_map.getTiles(posz());
    local playerPos = pos();
    local closestTile = nil;
    for i, tile in ipairs(tiles) do
        local tilePosition = tile:getPosition();
        local minimapColor = g_map.getMinimapColor(tilePosition);
        local StairColor = minimapColor >= 210 and minimapColor <= 213;
        if (StairColor and not tile:isPathable()) then
            local hasIgnoredTiles = false;
            for index, item in ipairs(tile:getItems()) do
                if (table.find(ClosestStair.ignoredTiles, item:getId())) then
                    hasIgnoredTiles = true;
                    break;
                end
            end
            if (
                not hasIgnoredTiles and
                (closestTile == nil or 
                getDistanceBetween(playerPos, tilePosition) < getDistanceBetween(playerPos, closestTile:getPosition()) or 
                closestTile:getPosition().z ~= posz())
            )  then
                closestTile = tile;
            end
        else
            for index, item in ipairs(tile:getItems()) do
                if (table.find(ClosestStair.aditionalTiles, item:getId())) then
                    if (closestTile == nil or 
                        getDistanceBetween(playerPos, tilePosition) < getDistanceBetween(playerPos, closestTile:getPosition()) or 
                        closestTile:getPosition().z ~= posz()
                    ) then
    
                        closestTile = tile;
    
                        break;
                    end
                end
            end
        end
    end
    
    if (ClosestStair.tile) then
        ClosestStair.tile:setText("");
    end

    ClosestStair.tile = closestTile;

    if (not ClosestStair.tile) then return end;
    
    ClosestStair.tile:setText("Press " .. keyToPress);
end);

onKeyPress(function(keys) 
    if (ClosestStair.macro.isOff()) then return; end
    if (keys ~= keyToPress) then return; end
    if (ClosestStair.tile == nil) then
        return modules.game_textmessage.displayGameMessage('Nenhuma escada/buraco/teleporte');
    end
    local tile = g_map.getTile(ClosestStair.tile:getPosition());
    local tilePosition = tile:getPosition();
    local distance = getDistanceBetween(pos(), tilePosition);

    if (tile:canShoot()) then
        use(tile:getTopUseThing());
    else
        autoWalk(tilePosition, 100, { ignoreNonPathable = true, precision = 1, ignoreCreatures = false, ignoreStairs = true });
    end
    if (ClosestStair.walkTime and ClosestStair.walkTime < now and distance == 1) then
        CaveBot.walkTo(tilePosition, 1, { precision = 1 }); 
        ClosestStair.walkTime = (now + 225);
    end
end)

UI.Separator()