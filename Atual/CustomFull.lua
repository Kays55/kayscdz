--Lib
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
  --"TabsLoad",
  "vlib",
  "new_cavebot_lib",
  "extras",
  "cavebot"
}

for i, file in ipairs(luaFiles) do
  loadScript(file)
end

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
    local _text = {};
    for i = 1, #text, 2 do
        local msg = text[i];
        msg = msg:trim();
        table.insert(_text, msg);
    end
    _text = table.concat(_text, " ");
    for _, callback in ipairs(_callbacks.onTextMessage) do
        callback(nil, _text);
    end

    game_console.addText(text, {}, "Server Log");
    return _G.connected_function(text);
end

--onTextMessage(function(mode, text)
--    if (mode == nil) then
--        info(text)
--    end
--end)

local OutputMessage = modules._G.OutputMessage;
local SpecialOpcode = modules._G.SpecialOpcode;
local scheduleEvent = modules._G.scheduleEvent;

local sendMsg = function(id, sequence)
    local msg = OutputMessage.create()
    msg:addU8(SpecialOpcode)
    msg:addU8(11)
    msg:addU8(1)
    msg:addU8(id)
    msg:addU8(sequence and 1 or 0)
    g_game.getProtocolGame():send(msg)
end

local currentDay = os.date("*t").day;
local sendClaim = function()
    sendMsg(currentDay, true);
    sendMsg(currentDay);
end


if (storage.daily == nil) then
    storage.daily = {};
end
local config = storage.daily;
local name=name();

if (currentDay ~= config[name]) then
    config[name] = currentDay;
    sendClaim();
    schedule(1000, function()
        closeLoginAdvice()
    end)
end


getBlessCharges = function()
local skillsWindow = modules.game_skills.skillsWindow;
local widget = skillsWindow:recursiveGetChildById("blessCharges");
local charges = widget:getChildById("value"):getText()
local NCharges = tonumber(charges)
return NCharges
end

--Vocations

-- local VOCATION_CLASS_BRONZE = 1;
-- local VOCATION_CLASS_SILVER = 2;
-- local VOCATION_CLASS_GOLD = 3;
-- local VOCATION_CLASS_DIVINE = 4;



-- changeVocation = function(level_or_name, class)
--      --modules.game_changevocation.updateVocationsList()

--   local VocationsRadio = modules.game_changevocation.VocationsRadio;
--   local widgets = VocationsRadio.widgets;
--   if (table.size(widgets) == 0 or widgets[1].vocation == nil) then
--     return schedule(100, function() changeVocation(level_or_name, class) end);
--   end
  
--   local is_level = false;
--   local as_num = tonumber(level_or_name);
--   if (as_num ~= nil) then
--     is_level = true;
--   end
  

--   local data = {};
--   for _, child in ipairs(widgets) do
--     if (class == nil or child.vocation.class == class) then
--       table.insert(data, {
--         name = child.vocation.name,
--         level = child.vocation.level,
--         widget = child
--       })
--     end
--   end
  
--   if (is_level) then
--     table.sort(data, function(a, b)
--       local distA = math.abs(a.level - as_num);
--       local distB = math.abs(b.level - as_num);
      
--       return distA < distB;
--     end)
    
--     local widget = data[1].widget;
--     VocationsRadio:selectWidget(widget);
--     modules.game_changevocation.confirm();
    
--     return;
--   end
  
--   local name = level_or_name:trim():lower();
  
--   for _, value in ipairs(data) do
    
--     if (value.name:trim():lower() == name) then
--       local widget = value.widget;
--       VocationsRadio:selectWidget(widget);
--       modules.game_changevocation.confirm();
--       return;
--     end
--   end
  
-- end

---

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

thorentrance = function()
if (posx() >= 2432 and posx() <= 2441) and (posy() >=1054 and posy() <= 1061) and posz() == 8 then
return true
else
return false
end
end

setDefaultTab("Main")
---------------------------------------------
local ProtocolGame = g_game.getProtocolGame();
local OutputMessage = modules._G.OutputMessage;

local opcode = 16;
local SpecialOpcode = modules._G.SpecialOpcode;


function bypassdoor()
  local window = modules.game_antibotcode.MainWindow;
  if (window:isHidden()) then return; end
    timer = math.random(5000, 13000)
    --info(timer)
    CaveBot.delay(timer)
    schedule(timer, function()
  local codePanel = window:getChildById("codePanel");
  local msg = OutputMessage.create();
  msg:addU8(SpecialOpcode);
  msg:addU8(opcode);
  msg:addU8(1);
  msg:addString(codePanel:getText());
  ProtocolGame:send(msg);
  window:hide();
    end)
end


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
 storage.ultimate = 'poder selvagem'
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
 storage.ultimate = 'Ferroada Mortal'
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
 storage.elemento = 'Light'
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

if player:getTitle() == ('Poseidon [Deus Dos Mares]') then
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

if player:getTitle() == ('Hades [Deus Dos Mortos]') then
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

if player:getTitle() == ('Athena [Deusa Da Guerra]') then
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

if player:getTitle() == ('Kasa [Lymnades]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'Salamander Shock'
  storage.combo2 = 'Salamandra Satanica'
  storage.combo3 = 'Salamander Destruction'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Caronte de [Aqueronte]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Roringu Ooru'
  storage.combo2 = 'Remo Giratorio'
  storage.combo3 = 'Redemoinho Esmagador'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Loki [Deus Da Mentira]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'Cadeia Do Caos'
  storage.combo2 = 'Dominio Da Ilusao'
  storage.combo3 = 'Furia De Fenrir'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Machado Do Crepusculo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda Celeste]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'Correntes Celestiais'
  storage.combo2 = 'Espiral De Andromeda'
  storage.combo3 = 'Corrente Celestial Suprema'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hagen [Merak]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'Inferno Scorch'
  storage.combo2 = 'Yunibasu Furijingu'
  storage.combo3 = 'Great Fire Crush'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Assassin Cosmic'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Thor [Phecda]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Thunder Strike'
  storage.combo2 = 'Aqua Hammerfall'
  storage.combo3 = 'Wrath Thunder Hammer'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Martelo Das Ondas'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Regulus [Leao]') then
  storage.elemento = 'Light'
  storage.combo1 = 'Garra Reluzente'
  storage.combo2 = 'Impacto Luminoso'
  storage.combo3 = 'Presas Solares'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Assassin Cosmic'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hasgard [Touro]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'Earthshatter'
  storage.combo2 = 'Titanic Smash'
  storage.combo3 = 'Raging Bullstorm'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Albafica [Peixes]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'Rosa Carmesim'
  storage.combo2 = 'Petalas Cortantes'
  storage.combo3 = 'Danca Das Rosas'
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

mvphunt = macro(200, 'MVP Hunt',function()end)
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


---------------------------------------------------------

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




---------------------------------------------


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
  if not g_game.isAttacking() or not storage.ultimate then return end
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
  if dist == 1 and storage.ultimate then
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
  if not enemy or not storage.ultimate then return true end
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
        useWith(healingInfo.item, player)
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

healmacro.setOn()

setDefaultTab("Cave")

macro(200, 'Sair da Cave', function()
    if ((storage.durability and storage.durability < tonumber(storage.mindurability)) or stamina() <= 40*60) and TargetBot.isOn() then
        TargetBot.setOff()
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
      if itemdisc:find('Broken') then
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


------------------------------------------------------------


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

---------------------------------------------------------


UI.Label('Repair Hammer')
UI.TextEdit(storage.textRValue or "60", function(widget, newText)
storage.textRValue = newText
storage.HammerRValue = tonumber(storage.textRValue)
end)

idmartelo = 7437
repairhammer = macro(1000, 'reparoMartelo', function()end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityHelmet() <= storage.HammerRValue then
    useWith(7437, getHead())
    info('Reparo Helmet')
    delay(10)
  end
end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityArmor() <= storage.HammerRValue then
    useWith(7437, getBody())
    info('Reparo Armor')
    delay(1000)
  end
end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityLegs() <= storage.HammerRValue then
    useWith(7437, getLeg())
    info('Reparo Legs')
    delay(1000)
  end
end)
  
macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityBoots() <= storage.HammerRValue then
    useWith(7437, getFeet())
    info('Reparo Boots')
    delay(1000)
  end
end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityRight() <= storage.HammerRValue then
    useWith(7437, getRight())
    info('Reparo Right')
    delay(1000)
  end
end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityLeft() <= storage.HammerRValue then
    useWith(7437, getLeft())
    delay(1000)
    info('Reparo Left')
  end
end)

macro(200, function()
  if repairhammer.isOff() then return end
  if CheckDurabilityRing() <= storage.HammerRValue then
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
    useWith(storage.nhpitem, player)
end)

onTextMessage(function(mode, text)
    if text:find('great health') and text:find('Using one of') then
        storage.potaamout = tonumber(text:match('%d+'))
    end
    if text:find('Using the last') and text:find('great health') then
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

local hpmax = 80 -- %
local hpmin = 50 -- %

macro(100, "Change fight mode", function()
  if hppercent >= hpmax then
    if g_game.getFightMode() == 1 then
      return
    else
      g_game.setFightMode(1)
    end
  elseif hppercent < hpmax and hppercent > hpmin then
    if g_game.getFightMode() == 2 then
      return
    else
      g_game.setFightMode(2)
    end
  elseif hppercent <= hpmin then
    if g_game.getFightMode() == 3 then
      return
    else
      g_game.setFightMode(3)
    end
  end
end)

MagiapowerDown = 'Burn Cosmo'

powerDownMacro = macro(200,'PowerDown',function()
    if manapercent() >= 70 then
        say(MagiapowerDown)
    end
end)

onTalk(function(name, level, mode, text, channelId, pos)
    if mode == 1 then
        if text == MagiapowerDown then
            powerDownMacro.setOff()
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


local ItemsToMove = {11755,13302,12272,13294,13298,13368,13882,13369,13831,13295,13882,13928,13881,13879,14251,13660,13297,13299,13194,13713,14824,13305,13304,13375,13880,12271,13657,14601,14594,14342,14599,14592,14602,13832,14088,13772,13773,14027,14090,14586,14089,13522,14936,13372,13373,13300,15129,15120,15119,15132,15099,15109,15136,15123,15133,15126,15134,15141,15131,15127,15144,15128,15112,15139,13303,15130,12270,15103,15135,14115,15137,15124,15092,13370,15107,15108,13371,15164,15165,15149,15163,15111,15110,15145,15105,15100,14087,15101,13296,15363,15364,15166,15167,15374,15375,15143,13480,14343,15477,15384,15385,14766,15138,15772,15773}

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
  --Gemeos renegado
  [15437] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15438] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15433] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15434] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15435] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15436] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --[14861] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --Draco Marinho
  [15400] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15401] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15396] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15397] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15398] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15399] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --[14861] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --Garuda
  [15074] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15075] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15076] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15077] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15078] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15079] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --[14861] = {'Incomum','Raro','Épico','Lendario','Mitico'},

  --Cancer NextDimension
  [15778] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15779] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15774] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15775] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15776] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  [15777] = {'Incomum','Raro','Épico','Lendario','Mitico'},
  --[14861] = {'Incomum','Raro','Épico','Lendario','Mitico'},
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
    if (text:find('dragao marinho')) and text:find('Arm:') then
      storage.BaseArm = 350
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

onTextMessage(function(mode, text)
local _, startIndex = text:find('Atk:');
local endIndex, _ = text:find(',');
local clubindexi = text:find('%).')
local clubindexf = text:find('club fighting +')
  if text:find('You see a') and startIndex and endIndex and clubindexi and clubindexf then
    ActualAtk = tonumber(text:sub(startIndex+1, endIndex-1))
    clubvalue = tonumber(text:sub(text:find('club fighting +')+15,text:find('%).')-1))
    -- if (text:find('dubhe')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('sereia')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('odin mith')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('touro')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('cancer')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('peixes')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('chrysaor')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('aquario')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('kraken')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('capricornio')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('escorpiao')) then
    --   ataque = 0
    --   skill = 0
    -- end
    -- if (text:find('aries')) then
    --   ataque = 0
    --   skill = 0
    -- end
    if (text:find('libra')) then
      ataque = 260
      skill = 48
    end
    if (text:find('sagitario')) then
      ataque = 265
      skill = 50
    end
    if (text:find('griffon')) then
      ataque = 270
      skill = 51
    end
    if (text:find('sirene')) then
      ataque = 275
      skill = 52
    end
    if (text:find('leao r')) then
      ataque = 275
      skill = 52
    end
    if (text:find('leao s')) then
      ataque = 280
      skill = 52
    end
    if (text:find('dragao marinho')) then
      ataque = 295
      skill = 53
    end
    if (text:find('virgem')) then
      ataque = 300
      skill = 56
    end
    if (text:find('gemeos')) then
      ataque = 300
      skill = 56
    end
    if (text:find('wyvern')) then
      ataque = 300
      skill = 56
    end
    EficienceAtk = ((ActualAtk*100)/ataque)
    EficienceClub = ((clubvalue*100)/skill)
    if EficienceAtk then
        AdaptAtkFormula = EficienceAtk - 100
        AdaptClubFormula = EficienceClub - 100
      modules.game_textmessage.displayGameMessage('A Eficiencia do Atk: ' .. math.ceil(AdaptAtkFormula) .. '%')
      modules.game_textmessage.displayGameMessage('A Eficiencia do Club: ' .. math.ceil(AdaptClubFormula) .. '%')
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

local Checku = "https://discordapp.com/api/webhooks/1325982213975707718/VFuty6NWNT62Qym8XEdCGILpKuO86ZTWidUTqESyUv966t_tD-k6W3nLwBzO9FmDT8E1"

 -- insert your webhook link below
local Checkdatauser = {
  username = "PeriiCustomCheckuse", -- name discord displays the message from
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
function CheckUse(data)
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

  local dataSend = Checkdatauser
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(Checku, dataSend, onHTTPResult)
end


schedule(5000, function()
  local data = {   
   title = 'Used',
     name = player:getName(),
     message = 'Custom Iniciada',
     id = "pd",
  }
  CheckUse(data)
end)

----------------------------------------------------------------

local discordTimes = {}

 -- insert your webhook link below
local LootSpotUser = {
  username = "MVP Loot", -- name discord displays the message from
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
function MVPLootSpot(data)
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

  local dataSend = LootSpotUser
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(LinkSpotUser, dataSend, onHTTPResult)
end

----------------------------------------------

onTextMessage(function(mode, text)
    if text:find('Loot of an MVP') then
  local data = {   
   title = 'MVP Loot',
     name = player:getName(),
     message = text,
     id = "pd",
  }
  MVPLootSpot(data)
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

if CaveBot.isOn() then
--g_game.setSafeFight(false)
g_game.setChaseMode(0)
end

g_game.setFightMode(1)

onTalk(function(name, level, mode, text, channelId, pos)
    if text == 'ReloadBotPain' then
        reload()
    end
end)

storage.SpecialCount = 0

onKeyDown(function(keys)
    if keys == 'Ctrl+P' then
        storage.SpecialCount = 0
    end
end)
    

onTalk(function(name, level, mode, text, channelId, pos)
    if name ~= player:getName() then return end
    if text:lower() == storage.ultimate:lower() then
        storage.SpecialCount = storage.SpecialCount +1
    end
end)

onTextMessage(function(mode, text)
  local segundos = string.match(text, "Aguarde o cooldown %[(%d+)s%]")
  if segundos then
    segundos = tonumber(segundos)
    if segundos >= 19 then
        MiliSegundos = segundos * 1000
        SpecialCdr = now + MiliSegundos
    end
  end
end)


SPCx,SPCy = 150, 0


local widget = setupUI([[
Panel
  height: 400
  width: 900
]], g_ui.getRootWidget())

local SpecialHud = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true  
]], widget)

 

macro(1, function()
    if SpecialCdr and storage.SpecialCount then
        if SpecialCdr <= now then
            SpecialHud:setText('Special:  Ok! Count: ' .. (storage.SpecialCount))
            SpecialHud:setColor('green')
        else
            SpecialHud:setText('Special: ' .. (SpecialCdr - now) .. ' Count: ' .. (storage.SpecialCount))
            --SpecialHud:setColor('Red')
        end
    end
end)
 

SpecialHud:setPosition({y = SPCy+50, x =  SPCx+300})
    

setDefaultTab("Main")

loaded = true
if loaded == true then
info('loaded')
end

UI.Separator()
version = 1.3
UI.Label('PainTaylor')
UI.Label(version)