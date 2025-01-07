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

UI.Separator()

--info('Loaded Def')