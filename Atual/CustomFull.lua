--Lib

------------------------
closeLoginAdvice = function()
    for _, widget in pairs(g_ui.getRootWidget():getChildren()) do
        if (widget:getText():find("For Your Information")) then
            widget:destroy();
            break
        end
    end
end

local _G = modules._G;
local game_console = modules.game_console;
local game_textmessage = modules.game_textmessage;

if (_G.connected_function == nil) then
    _G.connected_function = game_textmessage.displayColoredLootMessage;
end

game_textmessage.displayColoredLootMessage = function(text)

    game_console.addText(text, {}, "Server Log");
    return _G.connected_function(text);
end


getBlessCharges = function()
local skillsWindow = modules.game_skills.skillsWindow;
local widget = skillsWindow:recursiveGetChildById("blessCharges");
local charges = widget:getChildById("value"):getText()
local NCharges = tonumber(charges)
return NCharges
end

---


-- Author: Vithrax
-- contains mostly basic function shortcuts and code shorteners

-- initial global variables declaration
vBot = {} -- global namespace for bot variables
vBot.BotServerMembers = {}
vBot.standTime = now
vBot.isUsingPotion = false
vBot.isUsing = false
vBot.customCooldowns = {}

function logInfo(text)
    local timestamp = os.date("%H:%M:%S")
    text = tostring(text)
    local start = timestamp.." [vBot]: "

    return modules.client_terminal.addLine(start..text, "orange") 
end

-- scripts / functions
onPlayerPositionChange(function(x,y)
    vBot.standTime = now
end)

function standTime()
    return now - vBot.standTime
end

function relogOnCharacter(charName)
    local characters = g_ui.getRootWidget().charactersWindow.characters
    for index, child in ipairs(characters:getChildren()) do
        local name = child:getChildren()[1]:getText()
    
        if name:lower():find(charName:lower()) then
            child:focus()
            schedule(100, modules.client_entergame.CharacterList.doLogin)
        end
    end
end

function castSpell(text)
    if canCast(text) then
        say(text)
    end
end

local dmgTable = {}
local lastDmgMessage = now
onTextMessage(function(mode, text)
    if not text:lower():find("you lose") or not text:lower():find("due to") then
        return
    end
    local dmg = string.match(text, "%d+")
    if #dmgTable > 0 then
        for k, v in ipairs(dmgTable) do
            if now - v.t > 3000 then table.remove(dmgTable, k) end
        end
    end
    lastDmgMessage = now
    table.insert(dmgTable, {d = dmg, t = now})
    schedule(3050, function()
        if now - lastDmgMessage > 3000 then dmgTable = {} end
    end)
end)

-- based on data collected by callback calculates per second damage
-- returns number
function burstDamageValue()
    local d = 0
    local time = 0
    if #dmgTable > 1 then
        for i, v in ipairs(dmgTable) do
            if i == 1 then time = v.t end
            d = d + v.d
        end
    end
    return math.ceil(d / ((now - time) / 1000))
end

-- simplified function from modules
-- displays string as white colour message
function whiteInfoMessage(text)
    return modules.game_textmessage.displayGameMessage(text)
end

function statusMessage(text, logInConsole)
    return not logInConsole and modules.game_textmessage.displayFailureMessage(text) or modules.game_textmessage.displayStatusMessage(text)
end

-- same as above but red message
function broadcastMessage(text)
    return modules.game_textmessage.displayBroadcastMessage(text)
end

-- almost every talk action inside cavebot has to be done by using schedule
-- therefore this is simplified function that doesn't require to build a body for schedule function
function scheduleNpcSay(text, delay)
    if not text or not delay then return false end

    return schedule(delay, function() NPC.say(text) end)
end

-- returns first number in string, already formatted as number
-- returns number or nil
function getFirstNumberInText(text)
    local n = nil
    if string.match(text, "%d+") then n = tonumber(string.match(text, "%d+")) end
    return n
end

-- function to search if item of given ID can be found on certain tile
-- first argument is always ID 
-- the rest of aguments can be:
-- - tile
-- - position
-- - or x,y,z coordinates as p1, p2 and p3
-- returns boolean
function isOnTile(id, p1, p2, p3)
    if not id then return end
    local tile
    if type(p1) == "table" then
        tile = g_map.getTile(p1)
    elseif type(p1) ~= "number" then
        tile = p1
    else
        local p = getPos(p1, p2, p3)
        tile = g_map.getTile(p)
    end
    if not tile then return end

    local item = false
    if #tile:getItems() ~= 0 then
        for i, v in ipairs(tile:getItems()) do
            if v:getId() == id then item = true end
        end
    else
        return false
    end

    return item
end

-- position is a special table, impossible to compare with normal one
-- this is translator from x,y,z to proper position value
-- returns position table
function getPos(x, y, z)
    if not x or not y or not z then return nil end
    local pos = pos()
    pos.x = x
    pos.y = y
    pos.z = z

    return pos
end

-- opens purse... that's it
function openPurse()
    return g_game.use(g_game.getLocalPlayer():getInventoryItem(
                          InventorySlotPurse))
end

-- check's whether container is full
-- c has to be container object
-- returns boolean
function containerIsFull(c)
    if not c then return false end

    if c:getCapacity() > #c:getItems() then
        return false
    else
        return true
    end

end

function dropItem(idOrObject)
    if type(idOrObject) == "number" then
        idOrObject = findItem(idOrObject)
    end

    g_game.move(idOrObject, pos(), idOrObject:getCount())
end

-- not perfect function to return whether character has utito tempo buff
-- known to be bugged if received debuff (ie. roshamuul)
-- TODO: simply a better version
-- returns boolean
function isBuffed()
    local var = false
    if not hasPartyBuff() then return var end

    local skillId = 0
    for i = 1, 4 do
        if player:getSkillBaseLevel(i) > player:getSkillBaseLevel(skillId) then
            skillId = i
        end
    end

    local premium = (player:getSkillLevel(skillId) - player:getSkillBaseLevel(skillId))
    local base = player:getSkillBaseLevel(skillId)
    if (premium / 100) * 305 > base then
        var = true
    end
    return var
end

-- if using index as table element, this can be used to properly assign new idex to all values
-- table needs to contain "index" as value
-- if no index in tables, it will create one
function reindexTable(t)
    if not t or type(t) ~= "table" then return end

    local i = 0
    for _, e in pairs(t) do
        i = i + 1
        e.index = i
    end
end

-- supports only new tibia, ver 10+
-- returns how many kills left to get next skull - can be red skull, can be black skull!
-- reutrns number
function killsToRs()
    return math.min(g_game.getUnjustifiedPoints().killsDayRemaining,
                    g_game.getUnjustifiedPoints().killsWeekRemaining,
                    g_game.getUnjustifiedPoints().killsMonthRemaining)
end

-- calculates exhaust for potions based on "Aaaah..." message
-- changes state of vBot variable, can be used in other scripts
-- already used in pushmax, healbot, etc

onTalk(function(name, level, mode, text, channelId, pos)
    if name ~= player:getName() then return end
    if mode ~= 34 then return end

    if text == "Aaaah..." then
        vBot.isUsingPotion = true
        schedule(950, function() vBot.isUsingPotion = false end)
    end
end)

-- [[ canCast and cast functions ]] --
-- callback connected to cast and canCast function
-- detects if a given spell was in fact casted based on player's text messages 
-- Cast text and message text must match
-- checks only spells inserted in SpellCastTable by function cast
SpellCastTable = {}
onTalk(function(name, level, mode, text, channelId, pos)
    if name ~= player:getName() then return end
    text = text:lower()

    if SpellCastTable[text] then SpellCastTable[text].t = now end
end)

-- if delay is nil or delay is lower than 100 then this function will act as a normal say function
-- checks or adds a spell to SpellCastTable and updates cast time if exist
function cast(text, delay)
    text = text:lower()
    if type(text) ~= "string" then return end
    if not delay or delay < 100 then
        return say(text) -- if not added delay or delay is really low then just treat it like casual say
    end
    if not SpellCastTable[text] or SpellCastTable[text].d ~= delay then
        SpellCastTable[text] = {t = now - delay, d = delay}
        return say(text)
    end
    local lastCast = SpellCastTable[text].t
    local spellDelay = SpellCastTable[text].d
    if now - lastCast > spellDelay then return say(text) end
end

-- canCast is a base for AttackBot and HealBot
-- checks if spell is ready to be casted again
-- ignoreRL - if true, aparat from cooldown will also check conditions inside gamelib SpellInfo table
-- ignoreCd - it true, will ignore cooldown
-- returns boolean
local Spells = modules.gamelib.SpellInfo['Default']
function canCast(spell, ignoreRL, ignoreCd)
    if type(spell) ~= "string" then return end
    spell = spell:lower()
    if SpellCastTable[spell] then
        if now - SpellCastTable[spell].t > SpellCastTable[spell].d or ignoreCd then
            return true
        else
            return false
        end
    end
    if getSpellData(spell) then
        if (ignoreCd or not getSpellCoolDown(spell)) and
            (ignoreRL or level() >= getSpellData(spell).level and mana() >=
                getSpellData(spell).mana) then
            return true
        else
            return false
        end
    end
    -- if no data nor spell table then return true
    return true
end

local lastPhrase = ""
onTalk(function(name, level, mode, text, channelId, pos)
    if name == player:getName() then
        lastPhrase = text:lower()
    end
end)

if onSpellCooldown and onGroupSpellCooldown then
    onSpellCooldown(function(iconId, duration)
        schedule(1, function()
            if not vBot.customCooldowns[lastPhrase] then
                vBot.customCooldowns[lastPhrase] = {id = iconId}
            end
        end)
    end)

    onGroupSpellCooldown(function(iconId, duration)
        schedule(2, function()
            if vBot.customCooldowns[lastPhrase] then
                vBot.customCooldowns[lastPhrase] = {id = vBot.customCooldowns[lastPhrase].id, group = {[iconId] = duration}}
            end
        end)
    end)
else
    warn("Outdated OTClient! update to newest version to take benefits from all scripts!")
end

-- exctracts data about spell from gamelib SpellInfo table
-- returns table
-- ie:['Spell Name'] = {id, words, exhaustion, premium, type, icon, mana, level, soul, group, vocations}
-- cooldown detection module
function getSpellData(spell)
    if not spell then return false end
    spell = spell:lower()
    local t = nil
    local c = nil
    for k, v in pairs(Spells) do
        if v.words == spell then
            t = k
            break
        end
    end
    if not t then
        for k, v in pairs(vBot.customCooldowns) do
            if k == spell then
                c = {id = v.id, mana = 1, level = 1, group = v.group}
                break
            end
        end
    end
    if t then
        return Spells[t]
    elseif c then
        return c
    else
        return false
    end
end

-- based on info extracted by getSpellData checks if spell is on cooldown
-- returns boolean
function getSpellCoolDown(text)
    if not text then return nil end
    text = text:lower()
    local data = getSpellData(text)
    if not data then return false end
    local icon = modules.game_cooldown.isCooldownIconActive(data.id)
    local group = false
    for groupId, duration in pairs(data.group) do
        if modules.game_cooldown.isGroupCooldownIconActive(groupId) then
            group = true
            break
        end
    end
    if icon or group then
        return true
    else
        return false
    end
end

-- global var to indicate that player is trying to do something
-- prevents action blocking by scripts
-- below callbacks are triggers to changing the var state
local isUsingTime = now
macro(100, function()
    vBot.isUsing = now < isUsingTime and true or false
end)
onUse(function(pos, itemId, stackPos, subType)
    if pos.x > 65000 then return end
    if getDistanceBetween(player:getPosition(), pos) > 1 then return end
    local tile = g_map.getTile(pos)
    if not tile then return end

    local topThing = tile:getTopUseThing()
    if topThing:isContainer() then return end

    isUsingTime = now + 1000
end)
onUseWith(function(pos, itemId, target, subType)
    if pos.x < 65000 then isUsingTime = now + 1000 end
end)

-- returns first word in string 
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

-- global tables for cached players to prevent unnecesary resource consumption
-- probably still can be improved, TODO in future
-- c can be creature or string
-- if exected then adds name or name and creature to tables
-- returns boolean
CachedFriends = {}
CachedEnemies = {}
function isFriend(c)
    local name = c
    if type(c) ~= "string" then
        if c == player then return true end
        name = c:getName()
    end

    if CachedFriends[c] then return true end
    if CachedEnemies[c] then return false end

    if table.find(storage.playerList.friendList, name) then
        CachedFriends[c] = true
        return true
    elseif vBot.BotServerMembers[name] ~= nil then
        CachedFriends[c] = true
        return true
    elseif storage.playerList.groupMembers then
        local p = c
        if type(c) == "string" then p = getCreatureByName(c, true) end
        if not p then return false end
        if p:isLocalPlayer() then return true end
        if p:isPlayer() then
            if p:isPartyMember() then
                CachedFriends[c] = true
                CachedFriends[p] = true
                return true
            end
        end
    else
        return false
    end
end

-- similar to isFriend but lighter version
-- accepts only name string
-- returns boolean
function isEnemy(c)
    local name = c
    local p
    if type(c) ~= "string" then
        if c == player then return false end
        name = c:getName()
        p = c
    end
    if not name then return false end
    if not p then
        p = getCreatureByName(name, true)
    end
    if not p then return end
    if p:isLocalPlayer() then return end

    if p:isPlayer() and table.find(storage.playerList.enemyList, name) or
        (storage.playerList.marks and not isFriend(name)) or p:getEmblem() == 2 then
        return true
    else
        return false
    end
end

function getPlayerDistribution()
    local friends = {}
    local neutrals = {}
    local enemies = {}
    for i, spec in ipairs(getSpectators()) do
        if spec:isPlayer() and not spec:isLocalPlayer() then
            if isFriend(spec) then
                table.insert(friends, spec)
            elseif isEnemy(spec) then
                table.insert(enemies, spec)
            else
                table.insert(neutrals, spec)
            end
        end
    end

    return friends, neutrals, enemies
end

function getFriends()
    local friends, neutrals, enemies = getPlayerDistribution()

    return friends
end

function getNeutrals()
    local friends, neutrals, enemies = getPlayerDistribution()

    return neutrals
end

function getEnemies()
    local friends, neutrals, enemies = getPlayerDistribution()

    return enemies
end

-- based on first word in string detects if text is a offensive spell
-- returns boolean
function isAttSpell(expr)
    if string.starts(expr, "exori") or string.starts(expr, "exevo") then
        return true
    else
        return false
    end
end

-- returns dressed-up item id based on not dressed id
-- returns number
function getActiveItemId(id)
    if not id then return false end

    if id == 3049 then
        return 3086
    elseif id == 3050 then
        return 3087
    elseif id == 3051 then
        return 3088
    elseif id == 3052 then
        return 3089
    elseif id == 3053 then
        return 3090
    elseif id == 3091 then
        return 3094
    elseif id == 3092 then
        return 3095
    elseif id == 3093 then
        return 3096
    elseif id == 3097 then
        return 3099
    elseif id == 3098 then
        return 3100
    elseif id == 16114 then
        return 16264
    elseif id == 23531 then
        return 23532
    elseif id == 23533 then
        return 23534
    elseif id == 23544 then
        return 23528
    elseif id == 23529 then
        return 23530
    elseif id == 30343 then -- Sleep Shawl
        return 30342
    elseif id == 30344 then -- Enchanted Pendulet
        return 30345
    elseif id == 30403 then -- Enchanted Theurgic Amulet
        return 30402
    elseif id == 31621 then -- Blister Ring
        return 31616
    elseif id == 32621 then -- Ring of Souls
        return 32635
    else
        return id
    end
end

-- returns not dressed item id based on dressed-up id
-- returns number
function getInactiveItemId(id)
    if not id then return false end

    if id == 3086 then
        return 3049
    elseif id == 3087 then
        return 3050
    elseif id == 3088 then
        return 3051
    elseif id == 3089 then
        return 3052
    elseif id == 3090 then
        return 3053
    elseif id == 3094 then
        return 3091
    elseif id == 3095 then
        return 3092
    elseif id == 3096 then
        return 3093
    elseif id == 3099 then
        return 3097
    elseif id == 3100 then
        return 3098
    elseif id == 16264 then
        return 16114
    elseif id == 23532 then
        return 23531
    elseif id == 23534 then
        return 23533
    elseif id == 23530 then
        return 23529
    elseif id == 30342 then -- Sleep Shawl
        return 30343
    elseif id == 30345 then -- Enchanted Pendulet
        return 30344
    elseif id == 30402 then -- Enchanted Theurgic Amulet
        return 30403
    elseif id == 31616 then -- Blister Ring
        return 31621
    elseif id == 32635 then -- Ring of Souls
        return 32621
    else
        return id
    end
end

-- returns amount of monsters within the range of position
-- does not include summons (new tibia)
-- returns number
function getMonstersInRange(pos, range)
    if not pos or not range then return false end
    local monsters = 0
    for i, spec in pairs(getSpectators()) do
        if spec:isMonster() and
            (g_game.getClientVersion() < 960 or spec:getType() < 3) and
            getDistanceBetween(pos, spec:getPosition()) < range then
            monsters = monsters + 1
        end
    end
    return monsters
end

-- shortcut in calculating distance from local player position
-- needs only one argument
-- returns number
function distanceFromPlayer(coords)
    if not coords then return false end
    return getDistanceBetween(pos(), coords)
end

-- returns amount of monsters within the range of local player position
-- does not include summons (new tibia)
-- can also check multiple floors
-- returns number
function getMonsters(range, multifloor)
    if not range then range = 10 end
    local mobs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
        mobs = (g_game.getClientVersion() < 960 or spec:getType() < 3) and
                   spec:isMonster() and distanceFromPlayer(spec:getPosition()) <=
                   range and mobs + 1 or mobs;
    end
    return mobs;
end

-- returns amount of players within the range of local player position
-- does not include party members
-- can also check multiple floors
-- returns number
function getPlayers(range, multifloor)
    if not range then range = 10 end
    local specs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
        if not spec:isLocalPlayer() and spec:isPlayer() and distanceFromPlayer(spec:getPosition()) <= range and not ((spec:getShield() ~= 1 and spec:isPartyMember()) or spec:getEmblem() == 1) then
            specs = specs + 1
        end
    end
    return specs;
end

-- this is multifloor function
-- checks if player added in "Anti RS list" in player list is within the given range
-- returns boolean
function isBlackListedPlayerInRange(range)
    if #storage.playerList.blackList == 0 then return end
    if not range then range = 10 end
    local found = false
    for _, spec in pairs(getSpectators(true)) do
        local specPos = spec:getPosition()
        local pPos = player:getPosition()
        if spec:isPlayer() then
            if math.abs(specPos.z - pPos.z) <= 2 then
                if specPos.z ~= pPos.z then specPos.z = pPos.z end
                if distanceFromPlayer(specPos) < range then
                    if table.find(storage.playerList.blackList, spec:getName()) then
                        found = true
                    end
                end
            end
        end
    end
    return found
end

-- checks if there is non-friend player withing the range
-- padding is only for multifloor
-- returns boolean
function isSafe(range, multifloor, padding)
    local onSame = 0
    local onAnother = 0
    if not multifloor and padding then
        multifloor = false
        padding = false
    end

    for _, spec in pairs(getSpectators(multifloor)) do
        if spec:isPlayer() and not spec:isLocalPlayer() and
            not isFriend(spec:getName()) then
            if spec:getPosition().z == posz() and
                distanceFromPlayer(spec:getPosition()) <= range then
                onSame = onSame + 1
            end
            if multifloor and padding and spec:getPosition().z ~= posz() and
                distanceFromPlayer(spec:getPosition()) <= (range + padding) then
                onAnother = onAnother + 1
            end
        end
    end

    if onSame + onAnother > 0 then
        return false
    else
        return true
    end
end

-- returns amount of players within the range of local player position
-- can also check multiple floors
-- returns number
function getAllPlayers(range, multifloor)
    if not range then range = 10 end
    local specs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
        specs = not spec:isLocalPlayer() and spec:isPlayer() and
                    distanceFromPlayer(spec:getPosition()) <= range and specs +
                    1 or specs;
    end
    return specs;
end

-- returns amount of NPC's within the range of local player position
-- can also check multiple floors
-- returns number
function getNpcs(range, multifloor)
    if not range then range = 10 end
    local npcs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
        npcs =
            spec:isNpc() and distanceFromPlayer(spec:getPosition()) <= range and
                npcs + 1 or npcs;
    end
    return npcs;
end

-- main function for calculatin item amount in all visible containers
-- also considers equipped items
-- returns number
function itemAmount(id)
    return player:getItemsCount(id)
end

-- self explanatory
-- a is item to use on 
-- b is item to use a on
function useOnInvertoryItem(a, b)
    local item = findItem(b)
    if not item then return end

    return useWith(a, item)
end

-- pos can be tile or position
-- returns table of tiles surrounding given POS/tile
function getNearTiles(pos)
    if type(pos) ~= "table" then pos = pos:getPosition() end

    local tiles = {}
    local dirs = {
        {-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}
    }
    for i = 1, #dirs do
        local tile = g_map.getTile({
            x = pos.x - dirs[i][1],
            y = pos.y - dirs[i][2],
            z = pos.z
        })
        if tile then table.insert(tiles, tile) end
    end

    return tiles
end

-- self explanatory
-- use along with delay, it will only call action
function useGroundItem(id)
    if not id then return false end

    local dest = nil
    for i, tile in ipairs(g_map.getTiles(posz())) do
        for j, item in ipairs(tile:getItems()) do
            if item:getId() == id then
                dest = item
                break
            end
        end
    end

    if dest then
        return use(dest)
    else
        return false
    end
end

-- self explanatory
-- use along with delay, it will only call action
function reachGroundItem(id)
    if not id then return false end

    local dest = nil
    for i, tile in ipairs(g_map.getTiles(posz())) do
        for j, item in ipairs(tile:getItems()) do
            local iPos = item:getPosition()
            local iId = item:getId()
            if iId == id then
                if findPath(pos(), iPos, 20,
                            {ignoreNonPathable = true, precision = 1}) then
                    dest = item
                    break
                end
            end
        end
    end

    if dest then
        return autoWalk(iPos, 20, {ignoreNonPathable = true, precision = 1})
    else
        return false
    end
end

-- self explanatory
-- returns object
function findItemOnGround(id)
    for i, tile in ipairs(g_map.getTiles(posz())) do
        for j, item in ipairs(tile:getItems()) do
            if item:getId() == id then return item end
        end
    end
end

-- self explanatory
-- use along with delay, it will only call action
function useOnGroundItem(a, b)
    if not b then return false end
    local item = findItem(a)
    if not item then return false end

    local dest = nil
    for i, tile in ipairs(g_map.getTiles(posz())) do
        for j, item in ipairs(tile:getItems()) do
            if item:getId() == id then
                dest = item
                break
            end
        end
    end

    if dest then
        return useWith(item, dest)
    else
        return false
    end
end

-- returns target creature
function target()
    if not g_game.isAttacking() then
        return
    else
        return g_game.getAttackingCreature()
    end
end

-- returns target creature
function getTarget() return target() end

-- dist is boolean
-- returns target position/distance from player
function targetPos(dist)
    if not g_game.isAttacking() then return end
    if dist then
        return distanceFromPlayer(target():getPosition())
    else
        return target():getPosition()
    end
end

-- for gunzodus/ezodus only
-- it will reopen loot bag, necessary for depositer
function reopenPurse()
    for i, c in pairs(getContainers()) do
        if c:getName():lower() == "loot bag" or c:getName():lower() ==
            "store inbox" then g_game.close(c) end
    end
    schedule(100, function()
        g_game.use(g_game.getLocalPlayer():getInventoryItem(InventorySlotPurse))
    end)
    schedule(1400, function()
        for i, c in pairs(getContainers()) do
            if c:getName():lower() == "store inbox" then
                for _, i in pairs(c:getItems()) do
                    if i:getId() == 23721 then
                        g_game.open(i, c)
                    end
                end
            end
        end
    end)
    return CaveBot.delay(1500)
end

-- getSpectator patterns
-- param1 - pos/creature
-- param2 - pattern
-- param3 - type of return
-- 1 - everyone, 2 - monsters, 3 - players
-- returns number
function getCreaturesInArea(param1, param2, param3)
    local specs = 0
    local monsters = 0
    local players = 0
    for i, spec in pairs(getSpectators(param1, param2)) do
        if spec ~= player then
            specs = specs + 1
            if spec:isMonster() and
                (g_game.getClientVersion() < 960 or spec:getType() < 3) then
                monsters = monsters + 1
            elseif spec:isPlayer() and not isFriend(spec:getName()) then
                players = players + 1
            end
        end
    end

    if param3 == 1 then
        return specs
    elseif param3 == 2 then
        return monsters
    else
        return players
    end
end

-- can be improved
-- TODO in future
-- uses getCreaturesInArea, specType
-- returns number
function getBestTileByPatern(pattern, specType, maxDist, safe)
    if not pattern or not specType then return end
    if not maxDist then maxDist = 4 end

    local bestTile = nil
    local best = nil
    for _, tile in pairs(g_map.getTiles(posz())) do
        if distanceFromPlayer(tile:getPosition()) <= maxDist then
            local minimapColor = g_map.getMinimapColor(tile:getPosition())
            local stairs = (minimapColor >= 210 and minimapColor <= 213)
            if tile:canShoot() and tile:isWalkable() then
                if getCreaturesInArea(tile:getPosition(), pattern, specType) > 0 then
                    if (not safe or
                        getCreaturesInArea(tile:getPosition(), pattern, 3) == 0) then
                        local candidate =
                            {
                                pos = tile,
                                count = getCreaturesInArea(tile:getPosition(),
                                                           pattern, specType)
                            }
                        if not best or best.count <= candidate.count then
                            best = candidate
                        end
                    end
                end
            end
        end
    end

    bestTile = best

    if bestTile then
        return bestTile
    else
        return false
    end
end

-- returns container object based on name
function getContainerByName(name, notFull)
    if type(name) ~= "string" then return nil end

    local d = nil
    for i, c in pairs(getContainers()) do
        if c:getName():lower() == name:lower() and (not notFull or not containerIsFull(c)) then
            d = c
            break
        end
    end
    return d
end

-- returns container object based on container ID
function getContainerByItem(id, notFull)
    if type(id) ~= "number" then return nil end

    local d = nil
    for i, c in pairs(getContainers()) do
        if c:getContainerItem():getId() == id and (not notFull or not containerIsFull(c)) then
            d = c
            break
        end
    end
    return d
end

-- [[ ready to use getSpectators patterns ]] --
LargeUeArea = [[
    0000001000000
    0000011100000
    0000111110000
    0001111111000
    0011111111100
    0111111111110
    1111111111111
    0111111111110
    0011111111100
    0001111111000
    0000111110000
    0000011100000
    0000001000000
]]

NormalUeAreaMs = [[
    00000100000
    00011111000
    00111111100
    01111111110
    01111111110
    11111111111
    01111111110
    01111111110
    00111111100
    00001110000
    00000100000
]]

NormalUeAreaEd = [[
    00000100000
    00001110000
    00011111000
    00111111100
    01111111110
    11111111111
    01111111110
    00111111100
    00011111000
    00001110000
    00000100000
]]

smallUeArea = [[
    0011100
    0111110
    1111111
    1111111
    1111111
    0111110
    0011100
]]

largeRuneArea = [[
    0011100
    0111110
    1111111
    1111111
    1111111
    0111110
    0011100
]]

adjacentArea = [[
    111
    101
    111
]]

longBeamArea = [[
    0000000N0000000
    0000000N0000000
    0000000N0000000
    0000000N0000000
    0000000N0000000
    0000000N0000000
    0000000N0000000
    WWWWWWW0EEEEEEE
    0000000S0000000
    0000000S0000000
    0000000S0000000
    0000000S0000000
    0000000S0000000
    0000000S0000000
    0000000S0000000
]]

shortBeamArea = [[
    00000100000
    00000100000
    00000100000
    00000100000
    00000100000
    EEEEE0WWWWW
    00000S00000
    00000S00000
    00000S00000
    00000S00000
    00000S00000
]]

newWaveArea = [[
    000NNNNN000
    000NNNNN000
    0000NNN0000
    WW00NNN00EE
    WWWW0N0EEEE
    WWWWW0EEEEE
    WWWW0S0EEEE
    WW00SSS00EE
    0000SSS0000
    000SSSSS000
    000SSSSS000
]]

bigWaveArea = [[
    0000NNN0000
    0000NNN0000
    0000NNN0000
    00000N00000
    WWW00N00EEE
    WWWWW0EEEEE
    WWW00S00EEE
    00000S00000
    0000SSS0000
    0000SSS0000
    0000SSS0000
]]

smallWaveArea = [[
    00NNN00
    00NNN00
    WW0N0EE
    WWW0EEE
    WW0S0EE
    00SSS00
    00SSS00
]]

diamondArrowArea = [[
    01110
    11111
    11111
    11111
    01110
]]
--info('Loaded Vlib')

--Pos Libs

cdzgoldstaminarec = function()
    if isInPz() and (posx() >= 857 and posx() <= 876) and (posy() >= 898 and posy() <= 912) and (posz() == 15) then
        return true
    end
end

isinAriesSavepoint = function()
    if isInPz() and (posx() >= 954 and posx() <= 956) and (posy() >= 2300 and posy() <= 2302) then
        return true
    else
        return false
    end
end


isinGreciaSavepoint = function()
  if isInPz() and (posx() >= 1047 and posx() <= 1049) and (posy() >= 1014 and posy() <= 1016) then
        return true
    else
        return false
    end
end

IsInGreeceTemple = function()
    if isInPz() and (posx() >= 1005 and posx() <= 1026) and (posy() >= 999 and posy() <= 1013) then
        return true
    end
end


isinaiolosstart = function()
    if (posx() >= 883 and posx() <= 902) and (posy() >= 1676 and posy() <= 1683) then
        return true
    end
end

isinGreciaCity = function()
    if (posx() >= 983 and posx() <= 1082) and (posy() >= 982 and posy() <= 1060) and (posz() >= 6 and posz() <= 7) then
        return true
    end
end

isInThermalspot = function()
    if isInPz() then
        if (posx() >= 717 and posx() <= 888) and (posy() >= 895 and posy() <= 942) and (posz() == 15) then
            return true
        end
    end
end

AiolosCaveFull = function()
    if (posx() >= 883 and posx() <= 1013) and (posy() <= 1699 and posy() >= 1616) then
        return true
    end
end


sagatrap = function()
    if (posx() >= 1288 and posx() <= 1343) and (posy() <= 1112 and posy() >= 1081) and posz() == 15 then
        return true
    end
end

AtlantisSorento1 = function()
    if (posx() >= 1616 and posx() <= 1667) and (posy() <= 3631 and posy() >= 3579) and (posz() == 6 or posz() == 5) then
        return true
    end
end

entradaLeao = function()
if (posx() >= 1434 and posx() <= 1529) and (posy() <= 715 and posy() >=632) then
return true
end
end

Captchazone = function()
if (posx() >= 1019 and posx() <= 1028) and (posy() <= 1004 and posy() >= 1000) and posz() == 5 then
return true
end
end




setDefaultTab("Main")
---------------------------------------------
local ProtocolGame = g_game.getProtocolGame();
local OutputMessage = modules._G.OutputMessage;

local opcode = 16;
local SpecialOpcode = modules._G.SpecialOpcode;

bypassdoormacro = macro(100, 'Bypassdoor', function()
  local window = modules.game_antibotcode.MainWindow;
  if (window:isHidden()) then return; end

  local codePanel = window:getChildById("codePanel");
  local msg = OutputMessage.create();
  msg:addU8(SpecialOpcode);
  msg:addU8(opcode);
  msg:addU8(1);
  msg:addString(codePanel:getText());
  ProtocolGame:send(msg);
  window:hide();
end)


Stopbypass = macro(200, 'StopByPass',function()end)
onTextMessage(function(mode, text)
  if text:find('attack by an ') or Stopbypass:isOff() then return end
      for pname, _ in pairs(spotedspecs) do
        if not getCreatureByName(pname) then
            spotedspecs[pname] = nil
        end
    end
 for _, p in ipairs(getSpectators(posz())) do
  if p:isPlayer() and text:find(p:getName()) and text:find('attack by') and bypassdoormacro.isOn() then
    bypassdoormacro.setOff()
 end
end
end)

---------------------------------------

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

---------------------------------------

schedule(1000, function()

  if player:getTitle() == ('Seiya [Pegasus]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Meteoro De Pegasus'
 storage.combo2 = 'Cometa De Pegasus'
 storage.combo3 = 'Turbilhao de Pegasus'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
 storage.ultimate = 'ataque de pegasus'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne]') then
  storage.elemento = 'Wind'
 storage.combo1 = 'Po de Diamante'
 storage.combo2 = 'Trovao Aurora Ataque'
 storage.combo3 = 'Execucao Aurora'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne'
 storage.ultimate = 'circulo de gelo celestial'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Colera do Dragao'
 storage.combo2 = 'Dragao Voador'
 storage.combo3 = 'Last Dragon'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragon'
 storage.ultimate = 'life strengthening'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Nebulosa de Andromeda'
 storage.combo2 = 'Onda Relampago'
 storage.combo3 = 'Correnteza Nebulosa'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda'
 storage.ultimate = 'corrente circular'
 storage.sspell = nil
 storage.sense = 'chain sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ave Fenix'
 storage.combo2 = 'Golpe de Fenix'
 storage.combo3 = 'Hoyoku Tensho'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix'
 storage.ultimate = 'golpe fantasma de fenix'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mascara da Morte [Cancer]') then
 storage.elemento = 'Water'
 storage.combo1 = 'akubensu'
 storage.combo2 = 'sekishiki meikai'
 storage.combo3 = 'sekishiki kisoen'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cancer'
 storage.ultimate = 'ondas do inferno'
 storage.sspell = 'yomotsu shield'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mu [Aries]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Rede de Cristal'
 storage.combo2 = 'Extincao Estelar'
 storage.combo3 = 'Revolucao Estelar'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aries'
 storage.sspell = 'create repair hammer'
 storage.ultimate = 'muralha de cristal'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Camus [Aquario]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Esquife de Gelo'
  storage.combo2 = 'circulo de gelo'
  storage.combo3 = 'Daiyamondo Dasuto'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
  storage.sspell = nil
  storage.ultimate = 'Esquife de Gelo Supremo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Camus Renegado [Aquario]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Esquife de Gelo'
  storage.combo2 = 'circulo de gelo'
  storage.combo3 = 'Daiyamondo Dasuto'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
  storage.sspell = nil
  storage.ultimate = 'Esquife de Gelo Supremo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Daichi [Terra]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Suchiiru hariken'
 storage.combo2 = 'Steek Hurricane'
 storage.combo3 = 'Furacao de Aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  terra'
 storage.sspell = nil
 storage.ultimate = 'stone wall'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ushio [Mar]') then
 storage.elemento = 'Water'
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mar'
 storage.sspell = nil
 storage.ultimate = 'cosmo consumption'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sho [Ceu]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ceu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol [Perseu]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  perseu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol Renegado [Perseu]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  perseu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro') then
 storage.combo1 = 'Cosmo Punch'
 storage.combo2 = 'Cosmo Impact'
 storage.combo3 = 'Cosmo Galaxy'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ichi [Hidra]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Presas Venenosas'
 storage.combo2 = 'Chute Maravilhoso de Hydrus'
 storage.combo3 = 'Ataque das Mil Presas de Hydrus'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hidra'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ban [Leao Menor]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ataque Explosivo do Leao'
 storage.combo2 = 'Lionet Bomber'
 storage.combo3 = 'Raionetto Bonba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao menor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jabu [Unicornio]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Galope do Unicornio'
 storage.combo2 = 'Golpe do Unicornio'
 storage.combo3 = 'Fuku Yunikon'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  unicornio'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Nachi [Lobo]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Punho Do Lobo'
 storage.combo2 = 'Uivo Mortal'
 storage.combo3 = 'Shi no toboe'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lobo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Geki [Urso]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'punho de urso'
 storage.combo2 = 'abraco do urso'
 storage.combo3 = 'kuma no hoyo'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  urso'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('June [Camaleao]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Punho De Camaleao'
 storage.combo2 = 'Chicote do Camaleao'
 storage.combo3 = 'Kamereon no muchi'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  camaleao'
 storage.sspell = nil
 storage.ultimate = 'poder curativo "' .. player:getName()
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Guarda Graad') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Graad Punch'
 storage.combo2 = 'Graad Impact'
 storage.combo3 = 'Graad Blast'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  graad'
 storage.sspell = nil
 storage.ultimate = 'last cartridge'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses [Baleia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  baleia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cassius') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Cassius Punch'
 storage.combo2 = 'Cassius Impact'
 storage.combo3 = 'Cassius Comet Punch'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ear'
 storage.sspell = nil
 storage.ultimate = 'stay away'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kenuma [Pegasus Negro]') then
 storage.combo1 = 'meteoro negro'
 storage.combo2 = 'cometa negro'
 storage.combo3 = 'turbilhao negro'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pegasus negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ritahoa [Fenix Negro]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ankoku Houou Genma Ken'
 storage.combo2 = 'Espirito Diabolico do Fenix Negro'
 storage.combo3 = 'Ankoku Houou Hoyoku Tensho'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix negro'
 storage.sspell = nil
 storage.ultimate = 'assalto negro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Umnamed [Andromeda Negro]') then
 storage.combo1 = 'corrente negra'
 storage.combo2 = 'black fang nebula'
 storage.combo3 = 'ankoku fang nebulosa'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jido [Cisne Negro]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante das trevas'
 storage.combo2 = 'nevasca das trevas'
 storage.combo3 = 'burakkuburizodo'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Minos [Griffon]') then
 storage.elemento = 'Dark'
 storage.combo1 = 'papusa cosmica'
 storage.combo2 = 'griffon strike'
 storage.combo3 = 'marionete'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  griffon'
 storage.sspell = nil
 storage.ultimate = 'marionete cosmica'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro [Cristal]') then
 storage.elemento = 'Water'
 storage.combo1 = 'po de cristal'
 storage.combo2 = 'golpe congelante'
 storage.combo3 = 'toketsu ken'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cristal'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ennetsu [Fogo]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'poder do fogo'
 storage.combo2 = 'fire screw'
 storage.combo3 = 'faiya sukuryu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fogo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Serpente Marinha [Fantasma]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Punho da Serpente Marinha'
 storage.combo2 = 'Phantom Sea Serpent'
 storage.combo3 = 'Sea Serpent Eruption'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  serpente marinha'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Docrates [Hydrus]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'poder de hercules'
 storage.combo2 = 'punho de hercules'
 storage.combo3 = 'heracles moo shuu ken'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hydrus'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == 'Shura [Capricornio]' then
 storage.elemento = 'Earth'
 storage.combo1 = 'pedra saltitante'
 storage.combo2 = 'Excalibur'
 storage.combo3 = 'Shinken ekusukariba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  capricornio'
 storage.sspell = nil
 storage.ultimate = 'excalibur sword'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == 'Shura Renegado [Capricornio]' then
 storage.elemento = 'Earth'
 storage.combo1 = 'pedra saltitante'
 storage.combo2 = 'Excalibur'
 storage.combo3 = 'Shinken ekusukariba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  capricornio'
 storage.sspell = nil
 storage.ultimate = 'excalibur sword'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dante [Cerberus]') or player:getTitle() == ('Dante Renegado [Cerberus]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Maca Infernal'
 storage.combo2 = 'Jigoku no Kokyusa'
 storage.combo3 = 'Maca Vital'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cerberus'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Asterion [Caes de Caca]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'ataque de um milhao de fantasmas'
 storage.combo2 = 'mirion gosuto atakku'
 storage.combo3 = 'explosao telepatica'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  caes'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jamian [Corvo]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'pluma negra'
 storage.combo2 = 'black wing shaft'
 storage.combo3 = 'black feather'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  corvo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio [Mosca]') then
  storage.elemento = 'Wind'
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mosca'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolia [Leao]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Capsula do Poder'
 storage.combo2 = 'Lightning Bolt'
 storage.combo3 = 'Relampago de Plasma'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao'
 storage.sspell = nil
 storage.ultimate = 'golpe violento do leao'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aldebaran [Touro]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Grande Chifre'
 storage.combo2 = 'Gureto Hon'
 storage.combo3 = 'Great Horn'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  touro'
 storage.sspell = nil
 storage.ultimate = 'grande chifre de ouro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dohko [Libra]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'rozan shoryuha'
 storage.combo2 = 'rozan hyaku ryu ha'
 storage.combo3 = 'colera dos cem dragoes'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  libra'
 storage.sspell = nil
 storage.ultimate = 'rejuvenescimento'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolos [Sagitario]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Flecha de Sagitario'
 storage.combo2 = 'Trovao Atomico'
 storage.combo3 = 'Atomikku Sandaaboruto'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sagitario'
 storage.sspell = nil
 storage.ultimate = 'flecha de ouro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Milo [Escorpiao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'agulha escarlate'
 storage.combo2 = 'sukaretto nidoru antaresu'
 storage.combo3 = 'agulha escarlate de antares'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  escorpiao'
 storage.sspell = nil
 storage.ultimate = 'ferroada mortal'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses Renegado [Baleia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  baleia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  centauro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel Renegado [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  centauro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shaka [Virgem]') then
 storage.elemento = 'Light'
 storage.combo1 = 'ohm'
 storage.combo2 = 'kahn'
 storage.combo3 = 'rendicao divina'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  virgem'
 storage.sspell = nil
 storage.ultimate = 'tesouro do ceu'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Capella [Auriga]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'discos mortais'
 storage.combo2 = 'saucer kogeki'
 storage.combo3 = 'ripping saucers'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  auriga'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Capella Renegado [Auriga]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'discos mortais'
 storage.combo2 = 'saucer kogeki'
 storage.combo3 = 'ripping saucers'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  auriga'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Shiva [Pavao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'golpe dos mil bracos'
 storage.combo2 = 'senju shinon ken'
 storage.combo3 = 'thousand arms coup'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pavao'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Farao [Esfinge]') then
  storage.elemento = 'Earth'
 storage.combo1 = 'balanca da maldicao'
 storage.combo2 = 'baransu obu kasu'
 storage.combo3 = 'beijo na escuridao'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  esfinge'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio Renegado [Mosca]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mosca'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Misty [Lagarto]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Furacao das Trevas'
 storage.combo2 = 'Mavrou Trypa'
 storage.combo3 = 'Dark Hurricane'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lagarto'
 storage.sspell = nil
 storage.ultimate = 'paredao de ar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Misty Renegado [Lagarto]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Furacao das Trevas'
 storage.combo2 = 'Mavrou Trypa'
 storage.combo3 = 'Dark Hurricane'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lagarto'
 storage.sspell = nil
 storage.ultimate = 'paredao de ar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite Renegado [Peixes]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite [Peixes]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Thetis [Sereia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'cilada de coral'
 storage.combo2 = 'death trap coral'
 storage.combo3 = 'coral deslumbrante'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sereia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth [Hercules]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hercules'
 storage.sspell = nil
 storage.ultimate = 'protecao de hercules'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth Renegado [Hercules]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hercules'
 storage.sspell = nil
 storage.ultimate = 'protecao de hercules'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Marin [Aguia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Meteoro'
 storage.combo2 = 'Lampejo da Aguia'
 storage.combo3 = 'Iguru Tou Furasshu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aguia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shina [Ofiuco]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Garras de Trovao'
 storage.combo2 = 'Sanda Kuron'
 storage.combo3 = 'Venha Cobra'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ofiuco'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Fenrir [Alioth]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'garra do lobo assassino'
 storage.combo2 = 'golpe do lobo imortal'
 storage.combo3 = 'immortal wolf explosion'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  alioth'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Alberich [Megrez]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Couraca Ametista'
 storage.combo2 = 'Espada de Fogo'
 storage.combo3 = 'Unidade da Natureza'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  megrez'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bado [Alcor]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'garras do tigre das sombras'
 storage.combo2 = 'shadow viking tiger claw'
 storage.combo3 = 'Tigre Tiranico das Sombras'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  alcor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shido [Mizar]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Garras do Tigre Negro'
 storage.combo2 = 'Viking Tiger Claw'
 storage.combo3 = 'Impulso Azul'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mizar'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saga [Maligno]') then
 storage.elemento = 'Dark'
 storage.combo1 = 'Outra Dimensao'
 storage.combo2 = 'Sata Imperial'
 storage.combo3 = 'Explosao Galactica'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  maligno'
 storage.sspell = nil
 storage.ultimate = 'dimensao galactica'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mime [Benetnasch]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'requiem de cordas'
 storage.combo2 = 'sutoringa rekuiemu'
 storage.combo3 = 'stringer requiem'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  benetnasch'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Siegfried [Dubhe]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'odin sodo'
 storage.combo2 = 'odin sword'
 storage.combo3 = 'dragon bravest blizzard'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dubhe'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'Po de Diamante Divino'
 storage.combo2 = 'Trovao Aurora Ataque Divino'
 storage.combo3 = 'Divina Execucao Aurora '
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne divino'
 storage.sspell = nil
 storage.ultimate = 'Execucao Aurora Divina'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Odin]') then
 storage.elemento = 'Water'
 storage.combo1 = 'meteoro de odin'
 storage.combo2 = 'cometa de odin'
 storage.combo3 = 'balmung'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  odin'
 storage.sspell = nil
 storage.ultimate = 'balmung reaper'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Aquario]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante'
 storage.combo2 = 'aniquilacao aurora'
 storage.combo3 = 'aurora destruction'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aquario'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Isaak [Kraken]') then
 storage.elemento = 'Water'
 storage.combo1 = 'aurora boreal'
 storage.combo2 = 'aurora borealis'
 storage.combo3 = 'diamond dust'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  kraken'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'ave fenix divina'
 storage.combo2 = 'golpe de fenix divina'
 storage.combo3 = 'hoyoku tensho divina'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix divina'
 storage.sspell = nil
 storage.ultimate = 'lenda fenix'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'colera do dragao divino'
 storage.combo2 = 'divine excalibur'
 storage.combo3 = 'divino colera dos cem dragoes'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragao divino'
 storage.sspell = nil
 storage.ultimate = 'colera dos cem dragoes de rozan'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sorento [Sirene]') then
 storage.elemento = 'Light'
 storage.combo1 = 'sinfonia da morte'
 storage.combo2 = 'sinfonia final da morte'
 storage.combo3 = 'climax final da morte'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sirene'
 storage.sspell = nil
 storage.ultimate = 'canto da sirene'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saori [Athena]') then
 storage.elemento = 'Water'
 storage.combo1 = 'hikari uchu kosen'
 storage.combo2 = 'hikari seiken'
 storage.combo3 = 'hikari cosmo sword'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Sagitario]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'pegasus ryu sei ken'
 storage.combo2 = 'sagittarius ogon no ya'
 storage.combo3 = 'cosmic star arrow'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sagitario'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Celeste]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante celeste'
 storage.combo2 = 'trovao aurora celeste'
 storage.combo3 = 'execucao aurora celeste'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne celeste'
 storage.sspell = nil
 storage.ultimate = 'execucao celeste'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Rock [Golem]') then
storage.elemento = 'Earth'
 storage.combo1 = 'avalanche explosiva'
 storage.combo2 = 'roringu bonba suton'
 storage.combo3 = 'bomber stone'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  golem'
 storage.sspell = nil
 storage.ultimate = 'avalanche devastadora'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kagaho [Benu]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'explosao de coroa solar'
 storage.combo2 = 'sol negro'
 storage.combo3 = 'chamas negras'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  benu'
 storage.sspell = nil
 storage.ultimate = 'explosao da coroa solar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Krishna [Chrysaor]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'flashing lance'
 storage.combo2 = 'maha roshini'
 storage.combo3 = 'lanca relampago'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  chrysaor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bian [Cavalo Marinho]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'assopro divino'
 storage.combo2 = 'goddo buresu'
 storage.combo3 = 'raijingu birouzu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cavalo marinho'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Radamanthys [Wyvern]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'gureitesuto koshon'
  storage.combo2 = 'greatest caution'
  storage.combo3 = 'destruicao maxima'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  wyvern'
  storage.sspell = nil
  storage.ultimate = 'flying wyvern'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda Divino]') then
 storage.elemento = 'Light'
  storage.combo1 = 'nebulosa de andromeda divina'
  storage.combo2 = 'tempestade nebulosa divina'
  storage.combo3 = 'divino correnteza nebulosa'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'chain sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Pegasus Celeste]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'meteoro de pegasus astral'
  storage.combo2 = 'cometa de pegasus astral'
  storage.combo3 = 'turbilhao de pegasus astral'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pegasus celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Zelos [Sapo]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'salto esmagador'
  storage.combo2 = 'pulverizador de veneno'
  storage.combo3 = 'muco assombroso'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sapo'
  storage.sspell = nil
  storage.ultimate = 'jumping smash'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unnamed [Andromeda Negro]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'corrente negra'
  storage.combo2 = 'black fang nebula'
  storage.combo3 = 'ankoku fang nebulosa'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda negro'
  storage.sspell = nil
  storage.ultimate = 'nebulosa negra'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Poseidon [Deus]') then
  storage.elemento = 'Light'
  storage.combo1 = 'vento artico'
  storage.combo2 = 'divine marine destruction'
  storage.combo3 = 'trovao divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  poseidon'
  storage.sspell = nil
  storage.ultimate = 'tsunami devastador'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kanon [Dragao Marinho]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'genromaoken'
  storage.combo2 = 'marine destruction'
  storage.combo3 = 'great marine destruction'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragao marinho'
  storage.sspell = nil
  storage.ultimate = 'triangulo marinho'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unity [Dragao Marinho]') then
  storage.combo1 = 'vento artico'
  storage.combo2 = 'divine marine destruction'
  storage.combo3 = 'trovao divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  poseidon'
  storage.sspell = nil
  storage.ultimate = 'tsunami devastador'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mascara da Morte Renegado [Cancer]') then
  storage.elemento = 'Water'
  storage.combo1 = 'akubensu'
  storage.combo2 = 'sekishiki meikai'
  storage.combo3 = 'sekishiki kisoen'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cancer'
  storage.sspell = 'yomotsu shield'
  storage.ultimate = 'ondas do inferno'
    storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Leao]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'capsula do poder da fenix'
  storage.combo2 = 'golpe de fenix relampago'
  storage.combo3 = 'phoenix lightning plasma'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Golfinho [Fantasma]') then
  storage.combo1 = 'golpe do golfinho'
  storage.combo2 = 'dolphin ryukuchu kaiten'
  storage.combo3 = 'explosive dolphin blow'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  golfinho'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shion [Aries]') then
  storage.elemento = 'Light'
  storage.combo1 = 'kurisutaru woru'
  storage.combo2 = 'sutadasuto reboryushon'
  storage.combo3 = 'destruction of aries'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  shion'
  storage.sspell = nil
  storage.ultimate = 'revolucao divina'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shion Renegado [Aries]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'luz estelar'
  storage.combo2 = 'revolucao da poeira estelar'
  storage.combo3 = 'destruicao maxima de aries'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aries renegado'
  storage.sspell = nil
  storage.ultimate = 'sobrepelis estelar'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix Celeste]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'ave fenix celeste'
  storage.combo2 = 'golpe de fenix celeste'
  storage.combo3 = 'hoyoku tensho celeste'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao Celeste]') then
  storage.elemento = 'Water'
  storage.combo1 = 'colera do dragao celeste'
  storage.combo2 = 'dragao voador celeste'
  storage.combo3 = 'ultimo dragao celeste'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  dragon celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unity [Dragao Marinho]') then
  storage.elemento = 'Light'
  storage.combo1 = 'sancto oricalco'
  storage.combo2 = 'holy pillar'
  storage.combo3 = 'santo pilar'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  unity'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Io [Scylla]') then
  storage.elemento = 'Water'
  storage.combo1 = 'aguia poderosa'
  storage.combo2 = 'furia do lobo'
  storage.combo3 = 'tornado violento'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  scylla'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Thanatos [Deus Da Morte]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'teriburu purobidensu'
  storage.combo2 = 'divine punishment'
  storage.combo3 = 'terrivel providencia'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  morte'
  storage.sspell = nil
  storage.ultimate = 'medo do abismo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Hypnos [Deus Do Sono]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'etanaru doraujinesu'
  storage.combo2 = 'execucao de pesadelo'
  storage.combo3 = 'pesadelo eterno'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  sono'
  storage.sspell = nil
  storage.ultimate = 'sono eterno'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Saga [Gemeos Divino]') then
  storage.elemento = 'light'
  storage.combo1 = 'anaza dimenshon divino'
  storage.combo2 = 'destruicao mental divino'
  storage.combo3 = 'galaxian explosion divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Big Bang'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('El Cid [Capricornio]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Jumping Stone'
  storage.combo2 = 'Seiken Ex'
  storage.combo3 = 'Excalibur Light'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Seiken Excalibur'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolia [Leao Divino]') then
  storage.elemento = 'Light'
  storage.combo1 = 'Capsula Do Poder Divina'
  storage.combo2 = 'Lightning Bolt Divino'
  storage.combo3 = 'Relampago De Plasma Divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Relampago Divino'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiacos [Garuda]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'Voo Da Garuda'
  storage.combo2 = 'Conquistador De Indra'
  storage.combo3 = 'Resplendor Da Morte Galactica'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saga Renegado [Gemeos]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'Anaza Dimenshon'
  storage.combo2 = 'Destruicao Mental'
  storage.combo3 = 'Galaxian Explosion'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Myu [Papillon]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Ugly Eruption'
  storage.combo2 = 'Shirukii Suredo'
  storage.combo3 = 'Encantamento Mortal'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Po Dourado'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Orfeu [Lira]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Acorde Noturno'
  storage.combo2 = 'Serenata Da Viagem Da Morte'
  storage.combo3 = 'Acorde Perfeito'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Tremy [Flecha]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Flechas Fantasmas'
  storage.combo2 = 'Phantom Arrows'
  storage.combo3 = 'Fantomu Aro'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Disparo Mortal'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hades [Deus]') then
    storage.elemento = 'Dark'
  storage.combo1 = 'Yami Raitoningu'
  storage.combo2 = 'Naraku No Seiken'
  storage.combo3 = 'Greatest Eclipse'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Divine Execution'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Athena [Deusa]') then
    storage.elemento = 'Light'
  storage.combo1 = 'Divine Justice'
  storage.combo2 = 'Judgment Of Athena'
  storage.combo3 = 'Sacred Light'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Deusa Da Guerra'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Pegasus Divino]') then
    storage.elemento = 'Light'
  storage.combo1 = 'Divino Meteoro De Pegasus'
  storage.combo2 = 'Divino Cometa De Pegasus'
  storage.combo3 = 'Divino Turbilhao De Pegasus'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Aniquilacao Divina De Pegasus'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Aiolia [Odin]') then
  storage.elemento = 'Light'
  storage.combo1 = 'Raios De Valhalla'
  storage.combo2 = 'Lamina De Sleipnir'
  storage.combo3 = 'Tempestade De Asgard'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Aniquilacao Divina De Pegasus'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sirius [Cao Maior]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'Grande Punho Esmagador'
  storage.combo2 = 'Grande Choque De Montanhas'
  storage.combo3 = 'Great Clash Of Mountains'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Libra]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Presa Do Dragao'
  storage.combo2 = 'Judgment Of Libra'
  storage.combo3 = 'Punho De Dragao'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

  if player:getTitle() == ('Pandora TLC') then
 storage.elemento = 'Dark'
 storage.combo1 = 'Flagelo'
 storage.combo2 = 'Campo Do Vacuo'
 storage.combo3 = 'Alabarda Sombria'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
 storage.ultimate = 'Caixa Do Infortunio'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Degel [Aquario]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Diamond Dust Requiem'
  storage.combo2 = 'Frozen Galaxia'
  storage.combo3 = 'Frostbite Execution'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kardia [Escorpiao]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'Stinger Strike'
  storage.combo2 = 'Crimson Fang'
  storage.combo3 = 'Venomous Barrage'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

end)

configmode = false
onKeyDown(function(keys)
  if keys == 'Ctrl+4' then
    if configmode == false then
      configmode = true
      info('Config: True')
    end
  end
  if keys == 'Ctrl+5' then
    if configmode then
      configmode = false
      info('Config: False')
    end
  end
  if configmode then
    if keys == 'Ctrl+0' then
    say(player:getTitle())
    end
  end
end)

---------------------------------------

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

---------------------------------------------------------------------------------


onTextMessage(function(mode, text)
  if text:find('Completo') then
    if text:find('Graad') then
      storage.quest = 'graad'
    end
    if text:find('Cassius') then
      storage.quest = 'cassios'
    end
    if text:find('Soldier') then
      storage.quest = 'soldier'
    end
    if text:find('Daichi') then
      storage.quest = 'daichi'
    end
    if text:find('Ushio') then
      storage.quest = 'ushio'
    end
    if text:find('Sho') then
      storage.quest = 'sho'
    end
    if text:find('Ichi') then
      storage.quest = 'ichi'
    end
  end
end)



onTalk(function(name, level, mode, text, channelId, pos)
if name == 'Grande Mestre' and text:find('faltam') then
  if text:find('Cassius') then
    storage.actualquest = 'cassios'
  end
  if text:find('Soldiers') then
    storage.actualquest = 'soldier'
  end
  if text:find('Daichi') then
    storage.actualquest = 'daichi'
  end
  if text:find('Graad') then
    storage.actualquest = 'graad'
  end
  if text:find('Ushios') then
    storage.actualquest = 'ushios'
  end
  if text:find('Sho') then
    storage.actualquest = 'sho'
  end
  if text:find('Ichi') then
    storage.actualquest = 'ichi'
  end
end
end)

onTextMessage(function(mode, text)
  if mvphunt.isOff() then return end
  if text:find('MVP') then
    if text:find('Cassius') then
      mvpcassius = 1
    end
    if text:find('Daichi') then
      mvpdaichi = 1
    end
    if text:find('Ushio') then
      mvpushio = 1
    end
    if text:find('Ichi') then
      mvpichi = 1
    end
    if text:find('Ban') then
      mvpban = 1
    end
    if text:find('Geki') then
      mvpgeki = 1
    end
    if text:find('Ritahoa') then
      mvphitahoa = 1
    end
    if text:find('Shiryu') then
      mvpshiryu = 1
    end
    if text:find('Ikki') then
      mvpikki = 1
    end
    if text:find('Hyoga') then
      mvphyoga = 1
    end
    if text:find('Zelos') then
      mvpzelos = 1
    end
    if text:find('Algeth renegado') then
      mvpalgethr = 1
    end
    if text:find('Algeth') then
      mvpalgeth = 1
    end
    if text:find('Thetis') then
      mvpthetis = 1
    end
    if text:find('Aldebaran') then
      mvpaldebaran = 1
    end
    if text:find('Mascara Da Morte') then
      mvpmdm = 1
    end
    if text:find('Mascara Da Mort Renegado') then
      mvpmdmr = 1
    end
    if text:find('Afrodite') then
      mvpafrodite = 1
    end
    if text:find('Aldebaran Divino') then
      mvpaldebarand = 1
    end
  end
end)

UI.Separator()
-- allows to test/edit bot lua scripts ingame, you can have multiple scripts like this, just change storage.ingame_lua
UI.Button("Ingame macro editor", function(newText)
  UI.MultilineEditorWindow(storage.ingame_macros or "", {title="Macro editor", description="You can add your custom macros (or any other lua code) here"}, function(text)
    storage.ingame_macros = text
    reload()
  end)
end)
UI.Button("Ingame hotkey editor", function(newText)
  UI.MultilineEditorWindow(storage.ingame_hotkeys or "", {title="Hotkeys editor", description="You can add your custom hotkeys/singlehotkeys here"}, function(text)
    storage.ingame_hotkeys = text
    reload()
  end)
end)

UI.Separator()


local windowUI = setupUI([[
MainWindow
  id: main
  !text: tr('Minoru Teleport by Kays')
  size: 230 310
  scrollable: true
    
  ScrollablePanel
    id: TpList
    anchors.top: parent.top
    anchors.left: parent.left
    size: 190 225
    vertical-scrollbar: mainScroll

    Button
      !text: tr('Grecia')
      anchors.top: parent.top
      anchors.left: parent.left
      width: 165

    Button
      !text: tr('North City')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Siberia')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('South Forest')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165
      
    Button
      !text: tr('Bugavila')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Medusa')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Queen Death Island')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Asgard')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Canvas')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

  VerticalScrollBar  
    id: mainScroll
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    step: 48
    pixels-scroll: true
    
  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15
    margin-right: 15

]], g_ui.getRootWidget());
windowUI:hide();

TpMinoru = {};
local MainPanel = windowUI.main;
local TpList = windowUI.TpList;

TpMinoru.close = function()
  windowUI:hide()
  schedule(1000, function()
      NPC.say('bye');
end)
end

TpMinoru.show = function()
    windowUI:show();
    windowUI:raise();
    windowUI:focus();
end

windowUI.closeButton.onClick = function()
    TpMinoru.close();
end

TpMinoru.tpToCity = function(city)
    NPC.say(city);
    schedule(500, function()
        NPC.say('yes');
    end);
end


for i, child in pairs(TpList:getChildren()) do
    child.onClick = function()
        TpMinoru.tpToCity(child:getText())
    end
end

onTalk(function(name, level, mode, text, channelId, pos)
  if (name ~= 'Athena Travel') then return; end              
  if (mode ~= 51) then return; end
  if (text:find('Para onde gostaria de ir?')) then 
      TpMinoru.show();
  else
      TpMinoru.close();
  end
end);

onKeyDown(function(keys)
    if (keys == 'Escape' and windowUI:isVisible())  then
        TpMinoru.close();
    end
end);

------------------------------------------------------------------




local ArconteUI = setupUI([[
MainWindow
  id: main
  !text: tr('Minoru Teleport by Kays')
  size: 230 310
  scrollable: true
    
  ScrollablePanel
    id: TpList
    anchors.top: parent.top
    anchors.left: parent.left
    size: 190 225
    vertical-scrollbar: mainScroll

    Button
      !text: tr('Cerberus Pines')
      anchors.top: parent.top
      anchors.left: parent.left
      width: 165

    Button
      !text: tr('Butterfly Mountain')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Wolf Covio')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Aries Secret')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165
      
    Button
      !text: tr('Odrill')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Icy Mountain')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Freezing Pillars')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

    Button
      !text: tr('Sky Forest')
      anchors.top: prev.bottom
      anchors.left: parent.left
      margin-top: 5
      width: 165

  VerticalScrollBar  
    id: mainScroll
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    step: 48
    pixels-scroll: true
    
  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15
    margin-right: 15

]], g_ui.getRootWidget());
ArconteUI:hide();

TPArconte = {};
local MainPanel = ArconteUI.main;
local TpList = ArconteUI.TpList;

TPArconte.close = function()
  ArconteUI:hide()
  schedule(1000, function()
      NPC.say('bye');
end)
end

TPArconte.show = function()
    ArconteUI:show();
    ArconteUI:raise();
    ArconteUI:focus();
end

ArconteUI.closeButton.onClick = function()
    TPArconte.close();
end

TPArconte.tpToCity = function(city)
    NPC.say(city);
    schedule(500, function()
        NPC.say('yes');
    end);
end


for i, child in pairs(TpList:getChildren()) do
    child.onClick = function()
        TPArconte.tpToCity(child:getText())
    end
end

onTalk(function(name, level, mode, text, channelId, pos)
  if (name ~= 'Caronte Travel') then return; end              
  if (mode ~= 51) then return; end
  if (text:find('para onde gostaria de ir')) then 
      TPArconte.show();
  else
      TPArconte.close();
  end
end);

onKeyDown(function(keys)
    if (keys == 'Escape' and ArconteUI:isVisible())  then
        TPArconte.close();
    end
end);

onKeyDown(function(keys)
    if (keys == 'Escape' and ArconteUI:isVisible())  then
        TPArconte.close();
    end
end);


for _, scripts in ipairs({storage.ingame_macros, storage.ingame_hotkeys}) do
  if type(scripts) == "string" and scripts:len() > 3 then
    local status, result = pcall(function()
      assert(load(scripts, "ingame_editor"))()
    end)
    if not status then 
      error("Ingame edior error:\n" .. result)
    end
  end
end




local panelName = "playerList"
  local ui = setupUI([[
Panel
  height: 18

  Button
    id: editList
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    background: #292A2A
    height: 18
    text: Player Lists
  ]], parent)
  ui:setId(panelName)
ui:setId(panelName)
local playerListWindow = setupUI([[
PlayerName < Label
  background-color: alpha
  text-offset: 2 0
  focusable: true
  height: 16

  $focus:
    background-color: #00000055

  Button
    id: remove
    !text: tr('x')
    anchors.right: parent.right
    margin-right: 15
    width: 15
    height: 15

MainWindow
  !text: tr('Player Lists')
  size: 580 350
  @onEscape: self:hide()

  Label
    anchors.left: FriendList.left
    anchors.top: parent.top
    anchors.right: FriendList.right
    text-align: center
    text: Friends List
    margin-right: 3 

  TextList
    id: FriendList
    anchors.top: parent.top
    anchors.left: parent.left
    margin-top: 15
    margin-bottom: 5
    margin-right: 3
    padding: 1
    width: 180
    height: 160
    vertical-scrollbar: FriendListScrollBar

  VerticalScrollBar
    id: FriendListScrollBar
    anchors.top: FriendList.top
    anchors.bottom: FriendList.bottom
    anchors.right: FriendList.right
    step: 14
    pixels-scroll: true

  TextEdit
    id: FriendName
    anchors.right: FriendList.right
    anchors.left: FriendList.left
    anchors.top: FriendList.bottom
    margin-right: 3    
    margin-top: 5

  Button
    id: AddFriend
    !text: tr('Add Friend')
    anchors.right: FriendList.right
    anchors.left: FriendList.left
    anchors.top: prev.bottom
    margin-right: 3    
    margin-top: 3

  Label
    anchors.right: EnemyList.right
    anchors.top: parent.top
    anchors.left: EnemyList.left
    text-align: center
    text: Enemy List
    margin-left: 3     

  TextList
    id: EnemyList
    anchors.top: parent.top
    anchors.left: FriendList.right
    margin-top: 15
    margin-bottom: 5
    margin-left: 3
    padding: 1
    width: 180
    height: 160
    vertical-scrollbar: EnemyListScrollBar

  VerticalScrollBar
    id: EnemyListScrollBar
    anchors.top: EnemyList.top
    anchors.bottom: EnemyList.bottom
    anchors.right: EnemyList.right
    step: 14
    pixels-scroll: true

  TextEdit
    id: EnemyName
    anchors.left: EnemyList.left
    anchors.right: EnemyList.right
    anchors.top: EnemyList.bottom
    margin-left: 3    
    margin-top: 5

  Button
    id: AddEnemy
    !text: tr('Add Enemy')
    anchors.left: EnemyList.left
    anchors.right: EnemyList.right
    anchors.top: prev.bottom
    margin-left: 3    
    margin-top: 3

  Label
    anchors.right: BlackList.right
    anchors.top: parent.top
    anchors.left: BlackList.left
    text-align: center
    text: Anty RS List
    margin-left: 3   

  TextList
    id: BlackList
    anchors.top: parent.top
    anchors.left: EnemyList.right
    margin-top: 15
    margin-bottom: 5
    margin-left: 3
    padding: 1
    width: 180
    height: 160
    vertical-scrollbar: BlackListScrollBar

  VerticalScrollBar
    id: BlackListScrollBar
    anchors.top: BlackList.top
    anchors.bottom: BlackList.bottom
    anchors.right: BlackList.right
    step: 14
    pixels-scroll: true

  TextEdit
    id: BlackName
    anchors.left: BlackList.left
    anchors.right: BlackList.right
    anchors.top: BlackList.bottom
    margin-left: 3    
    margin-top: 5

  Button
    id: AddBlack
    !text: tr('Add Anty-RS')
    anchors.left: BlackList.left
    anchors.right: BlackList.right
    anchors.top: prev.bottom
    margin-left: 3    
    margin-top: 3

  BotSwitch
    id: Members
    anchors.left: parent.left
    anchors.top: AddEnemy.bottom
    margin-top: 15
    width: 135
    text-align: center
    text: Group Members  

  BotSwitch
    id: Outfit
    anchors.bottom: prev.bottom
    anchors.left: prev.right
    margin-left: 3
    width: 135
    text-align: center
    text: Color Outfits

  BotSwitch
    id: Marks
    anchors.bottom: prev.bottom
    anchors.left: prev.right
    width: 135
    margin-left: 3
    text-align: center
    text: Not Ally = Enemy    

  BotSwitch
    id: Highlight    
    anchors.bottom: prev.bottom
    anchors.left: prev.right
    width: 135
    margin-left: 3
    text-align: center
    text: Highlight     

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 8    

  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15
    margin-right: 5    
]], g_ui.getRootWidget())

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
-- for backward compability
if not config.blackList then
  config.blackList = {}
end


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

-- eof

-- UI
rootWidget = g_ui.getRootWidget()
playerListWindow:hide()

playerListWindow.Members:setOn(config.groupMembers)
playerListWindow.Members.onClick = function(widget)
  config.groupMembers = not config.groupMembers
  if not config then
    clearCachedPlayers()
  end
  refreshStatus()
  widget:setOn(config.groupMembers)
end
playerListWindow.Outfit:setOn(config.outfits)
playerListWindow.Outfit.onClick = function(widget)
  config.outfits = not config.outfits
  widget:setOn(config.outfits)
end
playerListWindow.Marks:setOn(config.marks)
playerListWindow.Marks.onClick = function(widget)
  config.marks = not config.marks
  widget:setOn(config.marks)
end
playerListWindow.Highlight:setOn(config.highlight)
playerListWindow.Highlight.onClick = function(widget)
  config.highlight = not config.highlight
  widget:setOn(config.highlight)
end

if config.enemyList and #config.enemyList > 0 then
  for _, name in ipairs(config.enemyList) do
    local label = g_ui.createWidget("PlayerName", playerListWindow.EnemyList)
    label.remove.onClick = function(widget)
      table.removevalue(config.enemyList, label:getText())
      label:destroy()
    end
    label:setText(name)
  end
end

if config.blackList and #config.blackList > 0 then
  for _, name in ipairs(config.blackList) do
    local label = g_ui.createWidget("PlayerName", playerListWindow.BlackList)
    label.remove.onClick = function(widget)
      table.removevalue(config.blackList, label:getText())
      label:destroy()
    end
    label:setText(name)
  end
end

if config.friendList and #config.friendList > 0 then
  for _, name in ipairs(config.friendList) do
    local label = g_ui.createWidget("PlayerName", playerListWindow.FriendList)
    label.remove.onClick = function(widget)
      table.removevalue(config.friendList, label:getText())
      label:destroy()
    end
    label:setText(name)
  end
end

playerListWindow.AddFriend.onClick = function(widget)
  local friendName = playerListWindow.FriendName:getText()
  if friendName:len() > 0 and not table.contains(config.friendList, friendName, true) then
    table.insert(config.friendList, friendName)
    local label = g_ui.createWidget("PlayerName", playerListWindow.FriendList)
    label.remove.onClick = function(widget)
      table.removevalue(config.friendList, label:getText())
      label:destroy()
    end
    label:setText(friendName)
    playerListWindow.FriendName:setText('')
    clearCachedPlayers()
    refreshStatus()
  end
end

playerListWindow.AddEnemy.onClick = function(widget)
  local enemyName = playerListWindow.EnemyName:getText()
  if enemyName:len() > 0 and not table.contains(config.enemyList, enemyName, true) then
    table.insert(config.enemyList, enemyName)
    local label = g_ui.createWidget("PlayerName", playerListWindow.EnemyList)
    label.remove.onClick = function(widget)
      table.removevalue(config.enemyList, label:getText())
      label:destroy()
    end
    label:setText(enemyName)
    playerListWindow.EnemyName:setText('')
    clearCachedPlayers()
    refreshStatus()
  end
end 

playerListWindow.AddBlack.onClick = function(widget)
  local blackName = playerListWindow.BlackName:getText()
  if blackName:len() > 0 and not table.contains(config.blackList, blackName, true) then
    table.insert(config.blackList, blackName)
    local label = g_ui.createWidget("PlayerName", playerListWindow.BlackList)
    label.remove.onClick = function(widget)
      table.removevalue(config.blackList, label:getText())
      label:destroy()
    end
    label:setText(blackName)
    playerListWindow.BlackName:setText('')
    clearCachedPlayers()
    refreshStatus()
  end
end 

ui.editList.onClick = function(widget)
  playerListWindow:show()
  playerListWindow:raise()
  playerListWindow:focus()
end
playerListWindow.closeButton.onClick = function(widget)
  playerListWindow:hide()
end


-- execution

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

--------------------------------------------------------------

--ATK
setDefaultTab("Atk")



---------------------------------------

storage.cdrultimate = now
specialcast = macro(100, 'Spam Special', function()
  if not g_game.isAttacking() then return end
  if storage.cdrultimate <= now then
    say(storage.ultimate)
    storage.cdrultimate = now + 1000
  end
end)

----------------------------------------
macro(250, "Melee Special", function()
  if not g_game.isAttacking() then return end
  local target = g_game.getAttackingCreature()
  local dist = getDistanceBetween(pos(),target:getPosition())
  if dist == 1 then
    say(storage.ultimate)
    delay(1000)
  end
end)

-----------------------------

local max_distance = 5

panelName = "autoWave"
if not storage[panelName] then storage[panelName] = { spell = spell, maxDist = max_distance} end

local config = storage[panelName]

local autoWave = macro(100,"Special Reta", function()
  local maxDist = tonumber(config.maxDist)
  local spell = storage.ultimate
  local enemy = target()
  if not enemy then return true end
  local pos = player:getPosition()
  local cpos = enemy:getPosition()
  if getDistanceBetween(pos,cpos) > maxDist then return true end
  local diffx = cpos.x - pos.x
  local diffy = cpos.y - pos.y
  if diffx > 0 and diffy == 0 then
   turn(1) 
   say(spell)
  elseif diffx < 0 and diffy == 0 then 
   turn(3)
   say(spell)
  elseif diffx == 0 and diffy > 0 then
   turn(2)
   say(spell)
  elseif diffx == 0 and diffy < 0 then
   turn(0)
   say(spell)
  end
end)
--
UI.Separator()
--Combos

comboLevel = function()
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
end
--
combo = function()
   say(storage.combo4)
   say(storage.combo3)
   say(storage.combo2)
  say(storage.combo1)
end
--
macro(100, 'Combo', function()
 if not g_game.isAttacking() then return end
 comboLevel()
end)
--
macro(100, 'ComboS/Level', function()
 if not g_game.isAttacking() then return end
combo()
end)
--
UI.Separator()

local panelName = "killSteal"
local ui = setupUI([[
Panel
  height: 30
  
  BotLabel
    id: help
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    text-align: center
    margin-left: 0

  HorizontalScrollBar
    id: HP
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 0
    minimum: 1
    maximum: 100
    step: 1
    
]], parent)

if not storage[panelName] then
  storage[panelName] = {
      hp = 60
  }
end

updateHpText = function()
    ui.help:setText("Execute: " .. storage[panelName].hp .. "% HP")
end
updateHpText()
ui.HP.onValueChange = function(scroll, value)
  storage[panelName].hp = value
  updateHpText()
end
ui.HP:setValue(storage[panelName].hp)


macro(100, 'Combo C/Execute', function()
 if not g_game.isAttacking() then return end
 Lockin = g_game.getAttackingCreature()
 if Lockin:isPlayer() and Lockin:getHealthPercent() <= storage[panelName].hp then
  say(storage.ultimate)
end
combo()
end)

UI.Separator()
--


onKeyPress(function(keys)
    if storage.ultimate == nil or modules.game_console:isChatEnabled() then return end
    if keys == 'R' then
        say(storage.ultimate)
    end
end)
--
onKeyPress(function(keys)
    if storage.sspell == nil or modules.game_console:isChatEnabled() then return end
    if keys == 'F' then
        say(storage.sspell)
    end
end)
--

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

--



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

----Frags


say('!frags')
TFragdiario = 0
TFragsemanal = 0
TFragMensal = 0
Fragdiario = 0
FragSemanal = 0
FragMensal = 0
FragDiarioServer = 0
FragSemanalServer = 0
FragMensalServer = 0
Fragdlimit = 0
FragSlimit = 0
FragMlimit = 0
Fragdiario = 0
FragSemanal = 0
FragMensal = 0

closeLoginAdvice = function()
    for _, widget in pairs(g_ui.getRootWidget():getChildren()) do
        if (widget:getText():find("For Your Information")) then
            widget:destroy();
            break
        end
    end
end

onLoginAdvice(function(mensage)
  if mensage:find('Seus frags') then
    --info('true1')
    TFragdiario = mensage:sub(24, 27)
        --info(TFragdiario)
    TFragsemanal = mensage:sub(43, 45)
            --say(TFragsemanal)
    TFragMensal = mensage:sub(59, 64)
            --say(TFragMensal)
    Fragdiario = tonumber(TFragdiario:match('%d+'))
            --info(Fragdiario)
    FragSemanal = tonumber(TFragsemanal:match('%d+'))
                --info(FragSemanal)
    FragMensal = tonumber(TFragMensal:match('%d+'))
                --info('fragMensal: ' .. FragMensal)
  end
  if mensage:find('Frags para Red Skull') then
    FragDiarioServer = tonumber(mensage:sub(85, 105):match('%d+'))
    --info('LFragDiario: ' .. FragDiarioServer)
    FragSemanalServer = tonumber(mensage:sub(103, 108):match('%d+'))
    --info('LFragSemanal: ' .. FragSemanalServer)
    FragMensalServer = tonumber(mensage:sub(114, 120):match('%d+'))
    --info('LFragMensal: ' .. FragMensalServer)
    Fragdlimit = FragDiarioServer -1
    FragSlimit = FragSemanalServer - 1
    FragMlimit = FragMensalServer - 1
      closeLoginAdvice()
--info('LimiteD: ' .. Fragdlimit)
--info('LimiteS: ' .. FragSlimit)
--info('LimiteM: ' .. FragMlimit)
  end
end)

onTextMessage(function(mode, text)
  if text:find('The murder of') then
    Fragdiario = Fragdiario + 1
    FragSemanal = FragSemanal + 1
    FragMensal = FragMensal + 1
  end
end)
--
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



------------------------------------------------------------------------------------

local friendList = {'Low Farmer', 'ryan', 'darknuss', ''}

--- nao editar nada abaixo disso

for index, friendName in ipairs(friendList) do
     friendList[friendName:lower():trim()] = true
    friendList[index] = nil
end





macro(1, 'ChicleteNpParty', function()
  local possibleTarget = false
  for _, creature in ipairs(getSpectators(posz())) do
    local specHP = creature:getHealthPercent()
    if creature:isPlayer() and specHP and specHP > 0 and specHP <= 90 then
      if not friendList[creature:getName():lower()] and (creature:getShield() < 3) then
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

--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

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

----

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



----------------------------------------------------------------------------

UI.Label("Revide")

Revidetext = macro(200000, 'Revide PK',function()end)
onTextMessage(function(mode, text)
  if Revidetext.isOff() then return end
    for _, p in ipairs(getSpectators(posz())) do
  if g_game.isAttacking() and p:isPlayer() and t then
    if p:getName() == g_game.getAttackingCreature():getName() then return end
  end
    if p:isPlayer() and text:find(p:getName()) and text:find('attack by') and p:getSkull() ~= 0 then
      TargetBot.setOff()
      holdtarget.setOff()
      Target.Id = nil
      Target.get = nil
      g_game.cancelAttack()
      CaveBot.setOff()
      g_game.setChaseMode(1)
      g_game.setSafeFight(false)
      NameTarget = p:getName()
      g_game.attack(p)
    end
  end
end)

-----------------------------------------------------------

autodesligaratkname = macro(2000, 'Desligar atk name ao fragar', function()end)
onTextMessage(function(mode, text)
  if autodesligaratkname.isOff() then return end
  if text:find('Warning!') and (text:find(storage.ntarget2) or text:find(storage.ntarget)) then
    atkname.setOff()
      if (FragSemanal < FragSlimit) or (Fragdiario < Fragdlimit) or (FragMensal < FragMlimit) then
        schedule(900000, function()
          atkname.setOn()
        end)
      end
    end
  end)

-----------------------------------------------------------

autoatackcave = macro(200000, 'AutoRevide',function()end)
autoatackcave2 = macro(200000, 'AutoATKCave',function()end)


onAttackingCreatureChange(function(creature, oldCreature)
  if autoatackcave2.isOff() then return end
  if creature and creature:isPlayer() then
    TargetBot.setOff()
    CaveBot.setOff()
    g_game.setChaseMode(1)
    g_game.setSafeFight(false)
  end
  if oldCreature and oldCreature:isPlayer() then
    TargetBot.setOn()
    CaveBot.setOn()
    g_game.setChaseMode(0)
    g_game.setSafeFight(true)
  end
end)

onCreatureDisappear(function(creature)
  if autoatackcave.isOff() then return end
  if creature:getName() == NameTarget then
    TargetBot.setOn()
    CaveBot.setOn()
    g_game.setChaseMode(0)
    g_game.setSafeFight(true)
  end
end)
-------------------------------------------------------------

--
UI.Separator()


macro(100, 'Safe Red', function()
  if FragSemanal == nil and FragSlimit == nil then return end
  if (FragSemanal >= FragSlimit) or (Fragdiario >= Fragdlimit) or (FragMensal >= FragMlimit) then
    g_game:setSafeFight(1)
    atkname.setOff()
  end
end)

xfrag = 200
yfrag = 175

local widget = setupUI([[
Panel
  height: 1200
  width: 1200
]], g_ui.getRootWidget())

local timefragdiario = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

 

macro(1, function()
if Fragdiario ~= nil then
    timefragdiario:setText(Fragdiario)
  timefragdiario:setColor('white')
    if Fragdiario == Fragdlimit then
      timefragdiario:setColor('yellow')
    end
    if Fragdiario > Fragdlimit then
      timefragdiario:setColor('red')
    end
end
end)

timefragdiario:setPosition({y = yfrag, x =  xfrag})


local timefragsemanal = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

macro(1, function()
if FragSemanal ~= nil then
    timefragsemanal:setText(FragSemanal)
  timefragsemanal:setColor('white')
    if FragSemanal >= FragSlimit then
      timefragsemanal:setColor('yellow')
    end
    if FragSemanal > FragSlimit then
      timefragsemanal:setColor('red')
    end
end
end)

timefragsemanal:setPosition({y = yfrag+15, x =  xfrag})

local timefragmensal = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

macro(1, function()
if FragMensal ~= nil then
    timefragmensal:setText(FragMensal)
  timefragmensal:setColor('white')
    if FragMensal == FragMlimit then
      timefragmensal:setColor('yellow')
    end
    if FragMensal > FragMlimit then
      timefragmensal:setColor('red')
    end
end
end)

timefragmensal:setPosition({y = yfrag+30, x =  xfrag})

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
 
holdtarget = macro(100, 'Target', function()
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


others = macro(100, 'OthersMob', function() 
if g_game.isAttacking() then return end
  for _, spec in ipairs(getSpectators()) do
    if spec:isMonster() then
   g_game.attack(spec)
    end
  end
end)

---------------------------------------------------------------------


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

UI.Label("CDZ Food Heal")

if type(storage.hpitem1) ~= "table" then
  storage.hpitem1 = { on = true, title = "HP%", item = 7158, min = 0, max = 60 }
end
if type(storage.hpitem2) ~= "table" then
  storage.hpitem2 = { on = false, title = "HP%", item = 3160, min = 25, max = 90 }
end
if type(storage.manaitem1) ~= "table" then
  storage.manaitem1 = { on = true, title = "MP%", item = 7158, min = 0, max = 15 }
end
if type(storage.manaitem2) ~= "table" then
  storage.manaitem2 = { on = false, title = "MP%", item = 3160, min = 0, max = 50 }
end

for i, healingInfo in ipairs({ storage.hpitem1, storage.hpitem2, storage.manaitem1, storage.manaitem2 }) do
  local healingmacro = macro(20, function ()
    local hp = i <= 2 and player:getHealthPercent() or math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
    if healingInfo.max >= hp and hp >= healingInfo.min then
        use(healingInfo.item)
    end
  end)

  healingmacro.setOn(healingInfo.on)

  UI.DualScrollItemPanel(healingInfo, function (widget, newParams)
    healingInfo = newParams
    healingmacro.setOn(healingInfo.on and healingInfo.item > 100)
  end)
end

UI.Separator()

UI.Label('Hp Special')
UI.TextEdit(storage.SpecialHP or "60", function(widget, newText)
storage.SpecialHP = newText
end)

macro(200, 'Special Def', function()
  if hppercent() < tonumber(storage.SpecialHP) then
    say(storage.ultimate)
  end
end)


---------------------------------------------------------------------------------

setDefaultTab("Cave")

onTextMessage(function(mode, text)
    if text:find('Server saved') then
        CaveBot.gotoLabel('gocave')
    end
end)

onTalk(function(name, level, mode, text, channelId, pos)
    if text:find('SwitchReconect') and mode == 4 then
        g_ui.getRootWidget():recursiveGetChildById("autoReconnect").onClick(widget)
    end
end)

travel = function(city)
NPC.say('hi')
NPC.say(city)
NPC.say('yes')
end

travel = function(city)
NPC.say('hi')
NPC.say(city)
NPC.say('yes')
end

modaltravel = function(checkpoint)
local modalpanel = modules.game_modaldialog.modalDialog

if modalpanel then

    local choiceList = modalpanel:getChildById('choiceList')

    if choiceList then

        for i, widget in pairs(choiceList:getChildren()) do

            if (widget:getText() == checkpoint) then

                choiceList:focusChild(widget)

                modalpanel:onEnter()

end

end

end

end

end

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

UI.Label('Reparo Cave')

UI.TextEdit(storage.mindurability or "80", function(widget, newText)
storage.mindurability = newText
end)


-----------------------------------------------------------------------




CheckDurabilityHelmet = function()
  local itemtocheck = getInventoryItem(SlotHead)
    if itemtocheck then
      helmetdisc = itemtocheck:getTooltip()
    end
  if helmetdisc then
    local startIndex = helmetdisc:find('Durability: ')
    local endIndex = helmetdisc:find('It')
    if startIndex and endIndex then
      HdurabilityPercentage = helmetdisc:sub(startIndex+11, endIndex-5)
      Helmdurability = tonumber(HdurabilityPercentage)
    end
    if Helmdurability == nil then
      Helmdurability = 0
    end
    return Helmdurability
  end
end

CheckDurabilityArmor = function()
  local itemtocheck = getInventoryItem(SlotBody)
    if itemtocheck then
      Armordisc = itemtocheck:getTooltip()
    end
  if Armordisc then
    local startIndex = Armordisc:find('Durability: ')
    local endIndex = Armordisc:find('It')
    if startIndex and endIndex then
      AdurabilityPercentage = Armordisc:sub(startIndex+11, endIndex-5)
      Armordurability = tonumber(AdurabilityPercentage)
    end
    if Armordurability == nil then
      Armordurability = 0
    end
    return Armordurability
  end
end

CheckDurabilityLegs = function()
  local itemtocheck = getInventoryItem(SlotLeg)
    if itemtocheck then
    Legsdisc = itemtocheck:getTooltip()
    end
  if Legsdisc then
    local startIndex = Legsdisc:find('Durability: ')
    local endIndex = Legsdisc:find('It')
    if startIndex and endIndex then
      LdurabilityPercentage = Legsdisc:sub(startIndex+11, endIndex-5)
      Legsdurability = tonumber(LdurabilityPercentage)
    end
    if Legsdurability == nil then
      Legsdurability = 0
    end
    return Legsdurability
  end
end

CheckDurabilityBoots = function()
  local itemtocheck = getInventoryItem(SlotFeet)
    if itemtocheck then
      Bootsdisc = itemtocheck:getTooltip()
    end
  if Bootsdisc then
    local startIndex = Bootsdisc:find('Durability: ')
    local endIndex = Bootsdisc:find('It')
    if startIndex and endIndex then
      BdurabilityPercentage = Bootsdisc:sub(startIndex+11, endIndex-5)
      Bootsdurability = tonumber(BdurabilityPercentage)
    end
    if Bootsdurability == nil then
      Bootsdurability = 0
    end
    return Bootsdurability
  end
end

CheckDurabilityRight = function()
  local itemtocheck = getInventoryItem(SlotRight)
    if itemtocheck then
      Rightdisc = itemtocheck:getTooltip()
    end
  if Rightdisc then
    local startIndex = Rightdisc:find('Durability: ')
    local endIndex = Rightdisc:find('It')
    if startIndex and endIndex then
      RdurabilityPercentage = Rightdisc:sub(startIndex+11, endIndex-5)
      Rightdurability = tonumber(RdurabilityPercentage)
    end
    if Rightdurability == nil then
      Rightdurability = 0
    end
    return Rightdurability
  end
end

CheckDurabilityLeft = function()
  local itemtocheck = getInventoryItem(SlotLeft)
    if itemtocheck then
      Leftdisc = itemtocheck:getTooltip()
    end
  if Leftdisc then
    local startIndex = Leftdisc:find('Durability: ')
    local endIndex = Leftdisc:find('It')
    if startIndex and endIndex then
      LEdurabilityPercentage = Leftdisc:sub(startIndex+11, endIndex-5)
      Leftdurability = tonumber(LEdurabilityPercentage)
    end
    if Leftdurability == nil then
      Leftdurability = 0
    end
    return Leftdurability
  end
end

CheckDurabilityRing = function()
  local itemtocheck = getInventoryItem(SlotFinger)
    if itemtocheck then
      Ringdisc = itemtocheck:getTooltip()
    end
  if Ringdisc then
    local startIndex = Ringdisc:find('Durability: ')
    local endIndex = Ringdisc:find('It')
    if startIndex and endIndex then
      RidurabilityPercentage = Ringdisc:sub(startIndex+11, endIndex-5)
      Ringdurability = tonumber(RidurabilityPercentage)
    end
    if Ringdurability == nil then
      Ringdurability = 0
    end
    return Ringdurability
  end
end

UI.Label('Repair Hammer')
UI.TextEdit(storage.textRValue or "60", function(widget, newText)
storage.textRValue = newText
storage.HammerRValue = tonumber(storage.textRValue)
end)

idmartelo = 7437
macro(1000, 'reparoMartelo', function()
  if getInventoryItem(SlotHead) and CheckDurabilityHelmet() <= storage.HammerRValue then
    useWith(7437, getHead())
    info('Reparo Helmet')
    delay(1000)
  end
  if getInventoryItem(SlotArmor) and CheckDurabilityArmor() <= storage.HammerRValue then
    useWith(7437, getBody())
    info('Reparo Armor')
    delay(1000)
  end
  if getInventoryItem(Slotlegs) and CheckDurabilityLegs() <= storage.HammerRValue then
    useWith(7437, getLeg())
    info('Reparo Legs')
    delay(1000)
  end
  if getInventoryItem(SlotFeet) and CheckDurabilityBoots() <= storage.HammerRValue then
    useWith(7437, getFeet())
    info('Reparo Boots')
    delay(1000)
  end
  if getInventoryItem(SlotRight) and CheckDurabilityRight() <= storage.HammerRValue then
    useWith(7437, getRight())
    info('Reparo Right')
    delay(1000)
  end
  if getInventoryItem(SlotLeft) and CheckDurabilityLeft() <= storage.HammerRValue then
    useWith(7437, getLeft())
    delay(1000)
    info('Reparo Left')
  end
  if getInventoryItem(SlotFinger) and CheckDurabilityRing() <= storage.HammerRValue then
    useWith(7437, getFinger())
    delay(1000)
    info('Reparo Ring')
  end
end)

UI.Separator()

--onKeyDown(function(keys)
--  if keys == 'F1' then
--    info(CheckDurabilityHelmet())
--  end
--  if keys == 'F2' then
--    info(CheckDurabilityArmor())
--  end
--  if keys == 'F3' then
--    info(CheckDurabilityLegs())
--  end
--  if keys == 'F4' then
--    info(CheckDurabilityBoots())
--  end
--  if keys == 'F5' then
--    info(CheckDurabilityRight())
--  end
--  if keys == 'F6' then
--    info(CheckDurabilityLeft())
--  end
--  if keys == 'F7' then
--    info(CheckDurabilityRing())
--  end
--end)
----------------------------------------------------------------
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

UI.Button("Reset Deaths", function()
    storage.countdeath = 0
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

------------------------------------------------------------
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

mvphunt = macro(200, 'MVP Hunt', function() end)

----------------------------------------------------



setDefaultTab("Target")

TargetBot = {} -- global namespace
importStyle("/targetbot/looting.otui")
importStyle("/targetbot/target.otui")
importStyle("/targetbot/creature_editor.otui")
dofile("/targetbot/creature.lua")
dofile("/targetbot/creature_attack.lua")
dofile("/targetbot/creature_editor.lua")
dofile("/targetbot/creature_priority.lua")
dofile("/targetbot/looting.lua")
dofile("/targetbot/walking.lua")
-- main targetbot file, must be last
dofile("/targetbot/target.lua")

--info('Loaded Target')


----------------------------------------------------

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

onKeyPress(function(keys)
  if keys == 'X' then
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


local ItemsToMove = {11755,13302,12272,13294,13298,13368,13882,13369,13831,13295,13882,13928,13881,13879,14251,13660,13297,13299,13194,13713,14824,13305,13304,13375,13880,12271,13657,14601,14594,14342,14599,14592,14602,13832,14088,13772,13773,14027,14090,14586,14089,13522,14936,13372,13373,13300,15129,15120,15119,15132,15099,15109,15136,15123,15133,15126,15134,15141,15131,15127,15144,15128,15112,15139,13303,15130,12270,15103,15135,14115,15137,15124,15092,13370,15107,15108,13371,15164,15165,15149,15163,15111,15110,15145,15105,15100,14087,15101,13296}

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
    -- Touro Retro Set
  [15160] = {'Raro','Épico','Lendario','Mitico'},
  [15161] = {'Raro','Épico','Lendario','Mitico'},
  [15156] = {'Raro','Épico','Lendario','Mitico'},
  [15157] = {'Raro','Épico','Lendario','Mitico'},
  [15158] = {'Raro','Épico','Lendario','Mitico'},
  [15159] = {'Raro','Épico','Lendario','Mitico'},
  --[14021] = {'Épico','Lendario','Mitico'},
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
  [15155] = {'Raro','Épico','Lendario','Mitico'},
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
  [14724] = {'Incomum','Raro','Épico','Lendario','Mitico'},
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
  -- Aries Set
  [13956] = {'Raro','Épico','Lendario','Mitico'},
  [13959] = {'Raro','Épico','Lendario','Mitico'},
  [13952] = {'Raro','Épico','Lendario','Mitico'},
  [13953] = {'Raro','Épico','Lendario','Mitico'},
  [13954] = {'Raro','Épico','Lendario','Mitico'},
  [13955] = {'Raro','Épico','Lendario','Mitico'},
  [13958] = {'Raro','Épico','Lendario','Mitico'},
  -- Sirene Set
  [14122] = {'Raro','Épico','Lendario','Mitico'},
  --[13958] = {'Raro','Épico','Lendario','Mitico'},
  [14118] = {'Raro','Épico','Lendario','Mitico'},
  [14119] = {'Raro','Épico','Lendario','Mitico'},
  [14120] = {'Raro','Épico','Lendario','Mitico'},
  [14121] = {'Raro','Épico','Lendario','Mitico'},
  [14855] = {'Raro','Épico','Lendario','Mitico'},
  -- Peixes Set
  [13848] = {'Raro','Épico','Lendario','Mitico'},
  [14908] = {'Raro','Épico','Lendario','Mitico'},
  [13844] = {'Raro','Épico','Lendario','Mitico'},
  [13845] = {'Raro','Épico','Lendario','Mitico'},
  [13846] = {'Raro','Épico','Lendario','Mitico'},
  [13847] = {'Raro','Épico','Lendario','Mitico'},
  --[14855] = {'Raro','Épico','Lendario','Mitico'},
  -- Peixes Sapuris Set
  [14222] = {'Raro','Épico','Lendario','Mitico'},
  [14934] = {'Raro','Épico','Lendario','Mitico'},
  [14218] = {'Raro','Épico','Lendario','Mitico'},
  [14219] = {'Raro','Épico','Lendario','Mitico'},
  [14220] = {'Raro','Épico','Lendario','Mitico'},
  [14221] = {'Raro','Épico','Lendario','Mitico'},
  --[14855] = {'Raro','Épico','Lendario','Mitico'},
  -- Wyvern Set
  [14913] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14914] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14909] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14910] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14911] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [14912] = {'Incomum','Raro','Épico','Lendario','Mitico'},
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


macro(1000, "Move Legendary", function()
  for _, c in pairs(getContainers()) do
    if c:getName() == 'the backpack' then
    for _, i in ipairs(c:getItems()) do
          if i:getTooltip():find('Lendario') or i:getTooltip():find('Mitico') then
            g_game.move(i, {x = 65535, y = SlotAmmo, z = 0}, i:getCount())
          end
        end
    end
  end
end)

----------------------------------------------------
onTextMessage(function(mode, text)
local _, startIndex = text:find('Arm:');
local endIndex, _ = text:find(',');
local _, efistartIndex = text:find('Durability: ');
local efiendIndex, _ = text:find('It');
if text:find('ring') or text:find('glove') or text:find('shield') or text:find('sword') or text:find('reaper') then return end
  if text:find('You see a') and startIndex and endIndex then
    storage.ActualArm = tonumber(text:sub(startIndex+1, endIndex-1))
    if (text:find('dubhe')) and text:find('Arm:') then
      storage.BaseArm = 245
    end
    if (text:find('sereia')) and text:find('Arm:') then
      storage.BaseArm = 265
    end
    if (text:find('odin mith')) and text:find('Arm:') then
      storage.BaseArm = 265
    end
    if (text:find('touro')) and text:find('Arm:') then
      storage.BaseArm = 265
    end
    if (text:find('cancer')) and text:find('Arm:') then
      storage.BaseArm = 270
    end
    if (text:find('peixes')) and text:find('Arm:') then
      storage.BaseArm = 270
    end
    if (text:find('chrysaor')) and text:find('Arm:') then
      storage.BaseArm = 270
    end
    if (text:find('aquario')) and text:find('Arm:') then
      storage.BaseArm = 275
    end
    if (text:find('kraken')) and text:find('Arm:') then
      storage.BaseArm = 280
    end
    if (text:find('capricornio')) and text:find('Arm:') then
      storage.BaseArm = 290
    end
    if (text:find('escorpiao')) and text:find('Arm:') then
      storage.BaseArm = 300
    end
    if (text:find('aries')) and text:find('Arm:') then
      storage.BaseArm = 300
    end
    if (text:find('libra')) and text:find('Arm:') then
      storage.BaseArm = 325
    end
    if (text:find('sagitario')) and text:find('Arm:') then
      storage.BaseArm = 335
    end
    if (text:find('sirene')) and text:find('Arm:') then
      storage.BaseArm = 340
    end
    if (text:find('griffon')) and text:find('Arm:') then
      storage.BaseArm = 340
    end
    if (text:find('leao')) and text:find('Arm:') then
      storage.BaseArm = 345
    end
    if (text:find('virgem')) and text:find('Arm:') then
      storage.BaseArm = 350
    end
    if (text:find('gemeos')) and text:find('Arm:') then
      storage.BaseArm = 350
    end
    if (text:find('wyvern')) and text:find('Arm:') then
      storage.BaseArm = 350
    end
    storage.CalcEficience = (((storage.ActualArm*(100))/storage.BaseArm))
    if storage.CalcEficience then
        adaptformula = storage.CalcEficience - 100
      modules.game_textmessage.displayGameMessage('A Eficiencia da Raridade: ' .. math.ceil(adaptformula) .. '%')
    end
  end
end)

------------------------------------------------------------------------------------------------------

onTalk(function(name, level, mode, text, channelId, pos)
  if (name ~= 'Blessing') then return; end              
  if (mode ~= 51) then return; end
  if (text:find('deseja comprar {bless}?')) then
    schedule(500, function()
      NPC.say('yes')
  end)
  end
  if (text:find('da bless vai ser')) then
    schedule(500, function()
      NPC.say('yes')
  end)
    --info('pass1')
  end
end);



onTalk(function(name, level, mode, text, channelId, pos)
  if (name ~= 'Mu [Durability]') then return; end
  if (mode ~= 51) then return; end
  if (text:find('posso restaurar a durabilidade dos seus itens. Basta me dizer qual slot gostaria de restaurar')) then
    schedule(500, function()
      NPC.say('tudo')
  end)
    schedule(1000, function()
      NPC.say('yes')
  end)
  end
end);

onTalk(function(name, level, mode, text, channelId, pos)
  if (name ~= 'Merchant') then return; end              
  if (mode ~= 51) then return; end
  if (text:find('he')) then
    schedule(500, function()
      NPC.say('trade')
  end)
  end
end);

-----------------------------------------------------------

setDefaultTab("Dsc")
--text = 'You see a [Épico] aquario glove (Atk:272, club fighting +39).'
-------------------
local discordTimes = {}
 -- insert your webhook link below

local default_data = {
  username = "CDZ Drop", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function sendDiscordWebhook(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = default_data
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(webhook, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

 onTextMessage(function(mode, text) 
  if not text:find('Loot of') then return end
   if text:find('Lendario') or text:find('Mitico') then
   local data = {
     title = 'Drop',
     name = player:getName(),
     message = text .. ' Loc: X: '.. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz(),
     id = "pd",
   }
   sendDiscordWebhook(data)
   end
 end)
-------------------------------------------------------------------------------------------------------------------------

local discordTimes = {}
 -- insert your webhook link below

local dd3 = {
  username = "Player In Cave", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function SDW3(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = dd3
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(WH0, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

talkedSpecs = {}



aviso = macro(100, 'aviso guild', function()
  if isinGreciaCity() or isInThermalspot() or isInPz() then return end
    for name, _ in pairs(talkedSpecs) do
        if not getCreatureByName(name) then
            talkedSpecs[name] = nil
        end
    end
    for _, spec in ipairs(getSpectators()) do
        if spec ~= player and spec:isPlayer() then
            if spec:getEmblem() ~= 1 then
                specName = spec:getName()
                if isFriend(specName) then return end
                if not talkedSpecs[specName] then
                local data = {
                title = 'Player in Cave',
                name = specName,
                message = 'Loc: X: '.. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz() .. '. Avistado por: ' .. player:getName(),
                id = "pd",
                }
                SDW3(data)
                    talkedSpecs[specName] = true
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------

local discordTimes = {}
 -- insert your webhook link below

local dd3 = {
  username = "Player Attack", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function SDW4(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = dd3
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(WH2, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------


spotedspecs = {}

onTextMessage(function(mode, text)
  if text:find('attack by an ') then return end
      for pname, _ in pairs(spotedspecs) do
        if not getCreatureByName(pname) then
            spotedspecs[pname] = nil
        end
    end
 for _, p in ipairs(getSpectators(posz())) do
  if p:isPlayer() and text:find(p:getName()) and text:find('attack by') then
    if not spotedspecs[pname] then
    pname = p:getName()
    local data = {
    title = 'Player Attack',
    name = pname,
    message = 'Attacou: ' .. player:getName(),
    id = "pd",
    }
    SDW4(data)
    spotedspecs[pname] = true
  end
 end
end
end)

-------------------------------------------------------------------------------



local discordTimes = {}
 -- insert your webhook link below


local dd5 = {
  username = "Just Frag", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function SDW5(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = dd5
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(WH1, dataSend, onHTTPResult)
end


 --------------
 -- example --
 --------------


local console = modules.game_console
onTextMessage(function(mode, text)
    if not text:find("The murder of") then return end
    startindex = text:find('of')
    endindex = text:find('was')
    playername = player:getName()
    vitima = text:sub(startindex+3, endindex-2)
    local data = {
    title = 'Fragou',
    name = playername,
    message = 'Matou o Jogador ' .. vitima,
    id = "pd",
    }
    SDW5(data)
 end)

--info('Loaded Discord')
-------------------------------------------------------

setDefaultTab("Dsc")
local discordTimes = {}
 -- insert your webhook link below


local DiscName1 = {
  username = "PMs", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function PMWKKS(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = DiscName1
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(pmWK, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

onTalk(function(name, level, mode, text, channelId, pos)
if name == player:getName() then return end
  if mode == 4 then
   local data = {
     title = player:getName(),
     name = name,
     message = text,
     id = "pd",
   }
   PMWKKS(data)
  end
end)

---------------------------------------------------------

local discordTimes = {}


local default_dataeveryone = {
  username = "CapBot",
}

function onHTTPResult(data, err)
  if err then
    info("Erro no Webhook do Discord: " .. err)
  else
    info("Mensagem enviada com sucesso!")
  end
end

function CapHook(data)
  local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (data.delay or 0) 
  end

  local dataSend = {
    username = default_dataeveryone.username,
    content = data.message
  }

  HTTP.postJSON(webhookeveryone, dataSend, onHTTPResult)
end


-----------------------------------------------------




capalart = now
macro(200,function()
if capalart >= now then return end
   if freecap() <= 100 then
    info('Updated')
        local data = {
        message = player:getName() .. ' esta com menos de 100 de cap.',
        id = "pd",
        }
      CapHook(data)
      capalart = now + 60000
   end
end)



---------------------------------------------------------

local discordTimes = {}


local default_dataeveryone = {
  username = "Death Position",
}

function onHTTPResult(data, err)
  if err then
    info("Erro no Webhook do Discord: " .. err)
  else
    info("Mensagem enviada com sucesso!")
  end
end

function deathspot(data)
  local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (data.delay or 0) 
  end

  local dataSend = {
    username = default_dataeveryone.username,
    content = data.message
  }

  HTTP.postJSON(webhookDeathspot, dataSend, onHTTPResult)
end


-----------------------------------------------------




onTextMessage(function(mode, text)
   if text:find('You are dead.') then
        local data = {
        message = player:getName() .. ' morreu nos Sqm: X: ' .. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz(),
        id = "pd",
        }
      deathspot(data)
   end
end)


if not g_resources.directoryExists("/screenshots") then
  g_resources.makeDir("/screenshots")
end


onTextMessage(function(mode, text)
    if text:find('You are dead.') then
            doScreenshot("/screenshots/"..player:getName().." "..os.date('%Y-%m-%d-%H-%M-%S')..".png")
    end
end)


-- load all otui files, order doesn't matter
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

local configFiles = g_resources.listDirectoryFiles("/bot/" .. configName .. "/vBot", true, false)
for i, file in ipairs(configFiles) do
  local ext = file:split(".")
  if ext[#ext]:lower() == "ui" or ext[#ext]:lower() == "otui" then
    g_ui.importStyle(file)
  end
end

local function loadScript(name)
  return dofile("/vBot/" .. name .. ".lua")
end

-- here you can set manually order of scripts
-- libraries should be loaded first
local luaFiles = {
  "items",
  "vlib",
  "new_cavebot_lib",
  "configs", -- do not change this and above
  "cavebot",
  "analyzer",
  "depositer_config",
}

for i, file in ipairs(luaFiles) do
  loadScript(file)
end


info(loaded)

loaded = true
version = 1.4