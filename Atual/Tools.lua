setDefaultTab("Tools")

canBeShoot = function(creature, distance)
    local pPos = player:getPosition()
    local cPos = creature:getPosition()
    if type(distance) == 'number' then
        if getDistanceBetween(pPos, cPos) > distance then
            return false
        end
    end
    return g_map.isSightClear(pPos, cPos)
end

UI.Separator()

local ConfigPainel = "Config"
local ui = setupUI([[
ssPanel < Panel
  margin: 10
  layout:
    type: verticalBox
    
Panel
  height: 20
  Button
    id: editspell
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    color: green
    anchors.right: parent.right
    height: 20
    text: - Artefact Config -
]])
ui:setId(ConfigPainel)

local HealingWindow = setupUI([[

MainWindow
  !text: tr('Artefact')
  size: 250 250
  @onEscape: self:hide()

  TabBar
    id: tmpTabBar
    margin-left: 40
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

  Panel
    id: tmpTabContent
    anchors.top: tmpTabBar.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 3
    size: 200 140
    image-source: /data/images/ui/panel_flat
    image-border: 6

  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15
    margin-right: 1  
]], g_ui.getRootWidget())

local rootWidget = g_ui.getRootWidget()
if rootWidget then
    HealingWindow:hide()
    local tabBar = HealingWindow.tmpTabBar
    tabBar:setContentWidget(HealingWindow.tmpTabContent)

    for v = 1, 1 do
        local spellPanel = g_ui.createWidget("ssPanel") -- Creates Panel
        spellPanel:setId("panelButtons") -- sets ID
        tabBar:addTab("Hunt", spellPanel)
        local spellPanel2 = g_ui.createWidget("ssPanel")
        spellPanel2:setId("panelButtons") -- sets ID
        tabBar:addTab("PVP", spellPanel2)
        local spellPanel3 = g_ui.createWidget("ssPanel")
        spellPanel3:setId("panelButtons") -- sets ID
        tabBar:addTab("Defense", spellPanel3)

    UI.Label("Mob Dmg", spellPanel)
    UI.TextEdit(storage.mobdmg or "13794", function(widget, newText)
    storage.mobdmg = newText
    storage.Idmobdmg = tonumber(newText)
    end, spellPanel)
    UI.Label("Mob Loot", spellPanel)
    UI.TextEdit(storage.mobloot or "13694", function(widget, newText)
    storage.mobloot = newText
    storage.Idmobloot = tonumber(newText)
    end, spellPanel)


    UI.Label("PVP Dmg", spellPanel2)
    UI.TextEdit(storage.pvpdmg or "13779", function(widget, newText)
    storage.pvpdmg = newText
    storage.Idpvpdmg = tonumber(newText)
    end, spellPanel2)


    UI.Label("Revive", spellPanel3)
    UI.TextEdit(storage.revive or "13815", function(widget, newText)
    storage.revive = newText
    storage.Idrevive = tonumber(newText)
    end, spellPanel3)

    UI.Label("Speed", spellPanel3)
    UI.TextEdit(storage.speed or "13788", function(widget, newText)
    storage.speed = newText
    storage.Idspeed = tonumber(newText)
    end, spellPanel3)

    UI.Label("PoisonHeal", spellPanel3)
    UI.TextEdit(storage.healpoison or "13727", function(widget, newText)
    storage.healpoison = newText
    storage.Idhealpoison = tonumber(newText)
    end, spellPanel3)

    end


    HealingWindow.closeButton.onClick = function(widget)
        HealingWindow:hide()
    end

    ui.editspell.onClick = function(widget)
        HealingWindow:show()
        HealingWindow:raise()
        HealingWindow:focus()
    end
end

distcalc = function(creature, distance)
    local pPos = player:getPosition()
    local cPos = creature:getPosition()
    if type(distance) == 'number' then
        if getDistanceBetween(pPos, cPos) > distance then
            return false
        else return true
        end
    end
end

storage.holditem = now
onPlayerHealthChange(function(healthPercent)
  if healthPercent < 15 then
    storage.holditem  = now + 3000
  end
end)

macro(200, 'Adapt Master', function()
  if storage.holditem > now then
    moveToSlot(storage.Idrevive, 2)
    --info('Revive Condition')
  end
  if storage.holditem > now then return end
  if g_game.isAttacking() then
    local x = g_game.getAttackingCreature()
    if x:isMonster() then
        if x:getHealthPercent() <= 20 then
          moveToSlot(storage.Idmobloot, 2)
          delay(5000)
          --info('MobLoot Condition')
        else
          moveToSlot(storage.Idmobdmg, 2)
          --info('Mob Dmg Condition')
        end
    end
    if x:isPlayer() then
      if getDistanceBetween(player:getPosition(), x:getPosition()) <= 1 then
        moveToSlot(storage.Idpvpdmg, 2)
        --info('PVP Dmg Condition')
      else
        moveToSlot(storage.Idspeed, 2)
        --info('Speed PVP Condition')
      end
    end
  end
  if not g_game.isAttacking() then
    moveToSlot(storage.Idspeed, 2)
    --info('else condition')
  end
end)

macro(1, 'Troca de Armas', function()
    if storage.holditem > now then
     moveToSlot(13815, 2)
    else
    if not g_game.isAttacking() then return end
    local distance = getDistanceBetween(pos(), g_game.getAttackingCreature():getPosition());
    if distance <= 1 then
        moveToSlot(13788, 2);
    elseif distance > 1 then
        moveToSlot(13779, 2);
    end
    end
end)

UI.Label("Auto Follow Name")
addTextEdit("followleader", storage.followLeader or "player name", function(widget, text)
storage.followLeader = text
end)
--Code
local toFollowPos = {}
local followMacro = macro(20, "Follow", function()
    if g_game.isAttacking() then return end
local target = getCreatureByName(storage.followLeader)
if target then
local tpos = target:getPosition()
toFollowPos[tpos.z] = tpos
end
if player:isWalking() then return end
local p = toFollowPos[posz()]
if not p then return end
if autoWalk(p, 20, {ignoreNonPathable=true, precision=1}) then
delay(100)
end
end)
onCreaturePositionChange(function(creature, oldPos, newPos)
if creature:getName() == storage.followLeader then
toFollowPos[newPos.z] = newPos
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


-- Target



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

local idz = {13328, 13329, 13330, 13331, 13332, 13333, 13334, 13335, 13336, 13337, 13338, 13339, 13340, 13341, 13342, 13428, 14256, 13429, 13427, 13422, 13430, 13424, 13426, 14255, 13431, 13423, 13421, 13425, 14261, 14263, 14126, 14127, 13344, 14128, 14258, 14259, 14344, 14125, 14253, 14252, 14614}

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

setDefaultTab("Tools")
--info('Loaded Tools')


onKeyPress(function(keys)
if keys == 'Ctrl+[' then
say('!rank level, ' .. player:getTitle())
end
if keys == 'Ctrl+]' then
say('!deathlist ' .. player:getName())
end
end)

onTalk(function(name, level, mode, text, channelId, pos)
    if player:getName() ~= name then return end
        startindex = text:find('x!')
        endindex = text:find('!')
    if startindex and endindex then
        targetsense = text:sub(startindex+2, endindex-1)
    end
end)

macro(2000,'Sense Macro', 'F8', function()
    if targetsense ~= nil then
        say(storage.sense .. ' "' .. targetsense)
    end
end)

onKeyDown(function(keys)
    if keys == 'F9' then
        if targetsense == nil then return end
        say(storage.sense .. ' "' .. targetsense)
info(targetsense)
    end
end)


local ItemsToMove = {11755,13302,12272,13294,13298,13368,13882,13369,13831,13295,13882,13928,13881,13879,14251,13660,13297,13299,13194,13713,14824,13305,13304,13375,13880,12271,13657,14601,14594,14342,14599,14592,14602,13832,14088,13772,13773,14027,14090,14586,14089,13522,14936,13372,13373}

local function searchAndMoveItems()
    for _, container in pairs(getContainers()) do
      if container:getName() == 'the backpack' then
        for _, item in pairs(container:getItems()) do
          if table.find(ItemsToMove, item:getId()) then
              g_game.move(item, {x = 65535, y = SlotAmmo, z = 0}, item:getCount())
            return true  
          end
        end
      end
    end
  return false
end

movefragsdrops = macro(1000, "Move Frags", searchAndMoveItems)


local toKeep = {
  -- id / rarity to KEEP
  -- Arma>Shield>Helmet>Armor>Legs>Boots>Ring
  -- Dubhe Set
  [13527] = {'Raro','Épico','Lendario','Mitico'},
  [13760] = {'Raro','Épico','Lendario','Mitico'},
  [13523] = {'Raro','Épico','Lendario','Mitico'},
  [13524] = {'Raro','Épico','Lendario','Mitico'},
  [13525] = {'Raro','Épico','Lendario','Mitico'},
  [13526] = {'Raro','Épico','Lendario','Mitico'},
  [3050] = {'Raro','Épico','Lendario','Mitico'},
  -- Escorpião Set
  [14727] = {'Raro','Épico','Lendario','Mitico'},
  [13760] = {'Raro','Épico','Lendario','Mitico'},
  [13900] = {'Raro','Épico','Lendario','Mitico'},
  [13901] = {'Raro','Épico','Lendario','Mitico'},
  [13902] = {'Raro','Épico','Lendario','Mitico'},
  [13903] = {'Raro','Épico','Lendario','Mitico'},
  [14857] = {'Raro','Épico','Lendario','Mitico'},
  -- Libra Set
  [14014] = {'Raro','Épico','Lendario','Mitico'},
  [14016] = {'Raro','Épico','Lendario','Mitico'},
  [14009] = {'Raro','Épico','Lendario','Mitico'},
  [14010] = {'Raro','Épico','Lendario','Mitico'},
  [14011] = {'Raro','Épico','Lendario','Mitico'},
  [14012] = {'Raro','Épico','Lendario','Mitico'},
  [14015] = {'Raro','Épico','Lendario','Mitico'},
  -- Capricornio Set
  [13897] = {'Raro','Épico','Lendario','Mitico'},
  [13762] = {'Raro','Épico','Lendario','Mitico'},
  [13893] = {'Raro','Épico','Lendario','Mitico'},
  [13894] = {'Raro','Épico','Lendario','Mitico'},
  [13895] = {'Raro','Épico','Lendario','Mitico'},
  [13896] = {'Raro','Épico','Lendario','Mitico'},
  [14865] = {'Raro','Épico','Lendario','Mitico'},
  -- Dark Capricornio Set
  [14228] = {'Raro','Épico','Lendario','Mitico'},
  [14896] = {'Raro','Épico','Lendario','Mitico'},
  [14224] = {'Raro','Épico','Lendario','Mitico'},
  [14225] = {'Raro','Épico','Lendario','Mitico'},
  [14226] = {'Raro','Épico','Lendario','Mitico'},
  [14227] = {'Raro','Épico','Lendario','Mitico'},
  [14897] = {'Raro','Épico','Lendario','Mitico'},
  -- Touro Set
  [11782] = {'Épico','Lendario','Mitico'},
  [13757] = {'Épico','Lendario','Mitico'},
  [11778] = {'Épico','Lendario','Mitico'},
  [11779] = {'Épico','Lendario','Mitico'},
  [11780] = {'Épico','Lendario','Mitico'},
  [11781] = {'Épico','Lendario','Mitico'},
  [14021] = {'Épico','Lendario','Mitico'},
  -- Cavalo Marinho Set
  [14248] = {'Raro','Épico','Lendario','Mitico'},
  [14249] = {'Raro','Épico','Lendario','Mitico'},
  [14244] = {'Raro','Épico','Lendario','Mitico'},
  [14245] = {'Raro','Épico','Lendario','Mitico'},
  [14246] = {'Raro','Épico','Lendario','Mitico'},
  [14247] = {'Raro','Épico','Lendario','Mitico'},
  [14882] = {'Raro','Épico','Lendario','Mitico'},
  -- Sagitario Set
  [14193] = {'Raro','Épico','Lendario','Mitico'},
  --[14016] = {'Raro','Épico','Lendario','Mitico'},
  [14189] = {'Raro','Épico','Lendario','Mitico'},
  [14190] = {'Raro','Épico','Lendario','Mitico'},
  [14191] = {'Raro','Épico','Lendario','Mitico'},
  [14192] = {'Raro','Épico','Lendario','Mitico'},
  [14859] = {'Raro','Épico','Lendario','Mitico'},
  -- LeãoAiolia Set
  [14294] = {'Raro','Épico','Lendario','Mitico'},
  [14295] = {'Raro','Épico','Lendario','Mitico'},
  [14290] = {'Raro','Épico','Lendario','Mitico'},
  [14291] = {'Raro','Épico','Lendario','Mitico'},
  [14292] = {'Raro','Épico','Lendario','Mitico'},
  [14293] = {'Raro','Épico','Lendario','Mitico'},
  [14296] = {'Raro','Épico','Lendario','Mitico'},
  -- Leao Ikki Set
  [14336] = {'Raro','Épico','Lendario','Mitico'},
  [14337] = {'Raro','Épico','Lendario','Mitico'},
  [14332] = {'Raro','Épico','Lendario','Mitico'},
  [14333] = {'Raro','Épico','Lendario','Mitico'},
  [14334] = {'Raro','Épico','Lendario','Mitico'},
  [14335] = {'Raro','Épico','Lendario','Mitico'},
  --[] = {'Raro','Épico','Lendario','Mitico'},
  -- Scylla Set
  [14315] = {'Raro','Épico','Lendario','Mitico'},
  --[14016] = {'Raro','Épico','Lendario','Mitico'},
  [14311] = {'Raro','Épico','Lendario','Mitico'},
  [14312] = {'Raro','Épico','Lendario','Mitico'},
  [14313] = {'Raro','Épico','Lendario','Mitico'},
  [14314] = {'Raro','Épico','Lendario','Mitico'},
  --[14015] = {'Raro','Épico','Lendario','Mitico'},
  -- Chrysaor Set
  [13891] = {'Raro','Épico','Lendario','Mitico'},
  --[14016] = {'Raro','Épico','Lendario','Mitico'},
  [13887] = {'Raro','Épico','Lendario','Mitico'},
  [13888] = {'Raro','Épico','Lendario','Mitico'},
  [13889] = {'Raro','Épico','Lendario','Mitico'},
  [13890] = {'Raro','Épico','Lendario','Mitico'},
  --[14015] = {'Raro','Épico','Lendario','Mitico'},
  -- kraken Set
  [13949] = {'Raro','Épico','Lendario','Mitico'},
  [14016] = {'Raro','Épico','Lendario','Mitico'},
  [13945] = {'Raro','Épico','Lendario','Mitico'},
  [13946] = {'Raro','Épico','Lendario','Mitico'},
  [13947] = {'Raro','Épico','Lendario','Mitico'},
  [13948] = {'Raro','Épico','Lendario','Mitico'},
  --[14015] = {'Raro','Épico','Lendario','Mitico'},
  -- Virgem Set
  [14358] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14357] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14351] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14352] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14353] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14354] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14356] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  -- Aquario Set
  [13842] = {'Épico','Lendario','Mitico'},
  [8079] = {'Épico','Lendario','Mitico'},
  [13838] = {'Épico','Lendario','Mitico'},
  [13839] = {'Épico','Lendario','Mitico'},
  [13840] = {'Épico','Lendario','Mitico'},
  [13841] = {'Épico','Lendario','Mitico'},
  --[14356] = {'Épico','Lendario','Mitico'},
  -- Gemeos Set
  [14721] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14722] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14717] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14718] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14719] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14720] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --[14356] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  -- Griffon Set
  [15071] = {'Raro','Épico','Lendario','Mitico'},
  [15072] = {'Raro','Épico','Lendario','Mitico'},
  [15067] = {'Raro','Épico','Lendario','Mitico'},
  [15068] = {'Raro','Épico','Lendario','Mitico'},
  [15069] = {'Raro','Épico','Lendario','Mitico'},
  [15070] = {'Raro','Épico','Lendario','Mitico'},
  --[14356] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  -- Aries Retro Set
  [14920] = {'Raro','Épico','Lendario','Mitico'},
  [14921] = {'Raro','Épico','Lendario','Mitico'},
  [14916] = {'Raro','Épico','Lendario','Mitico'},
  [14917] = {'Raro','Épico','Lendario','Mitico'},
  [14918] = {'Raro','Épico','Lendario','Mitico'},
  [14919] = {'Raro','Épico','Lendario','Mitico'},
  --[14356] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  -- Aries Renegado Set
  [14927] = {'Raro','Épico','Lendario','Mitico'},
  [14928] = {'Raro','Épico','Lendario','Mitico'},
  [14923] = {'Raro','Épico','Lendario','Mitico'},
  [14924] = {'Raro','Épico','Lendario','Mitico'},
  [14925] = {'Raro','Épico','Lendario','Mitico'},
  [14926] = {'Raro','Épico','Lendario','Mitico'},
  --[14356] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  -- Wyvern Set
  [14913] = {'Raro','Épico','Lendario','Mitico'},
  [14914] = {'Raro','Épico','Lendario','Mitico'},
  [14909] = {'Raro','Épico','Lendario','Mitico'},
  [14910] = {'Raro','Épico','Lendario','Mitico'},
  [14911] = {'Raro','Épico','Lendario','Mitico'},
  [14912] = {'Raro','Épico','Lendario','Mitico'},
  [14861] = {'Incomum','Raro','Épico','Lendario','Mitico'},
}
moveequipsdrops = macro(1000, "Move Rarity", function()
  for _, c in pairs(getContainers()) do
    if c:getName() == 'the backpack' then
    for _, i in ipairs(c:getItems()) do
      local cfg = toKeep[i:getId()]
      if cfg then
        for e, entry in pairs(cfg) do
          if i:getTooltip():find(entry) then
            g_game.move(i, {x = 65535, y = SlotAmmo, z = 0}, i:getCount())
          end
        end
      end
    end
    end
  end
end)