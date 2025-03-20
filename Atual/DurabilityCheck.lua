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


UI.TextEdit(storage.textRValue or "60", function(widget, newText)
storage.textRValue = newText
storage.HammerRValue = tonumber(storage.textRValue)
end)

idmartelo = 7437
macro(200, 'reparoMartelo', function()
  if CheckDurabilityHelmet() <= storage.HammerRValue then
    useWith(7437, getHead())
    info('Reparo Helmet')
    delay(1000)
  end
  if CheckDurabilityArmor() <= storage.HammerRValue then
    useWith(7437, getBody())
    info('Reparo Armor')
    delay(1000)
  end
  if CheckDurabilityLegs() <= storage.HammerRValue then
    useWith(7437, getLeg())
    info('Reparo Legs')
    delay(1000)
  end
  if CheckDurabilityBoots() <= storage.HammerRValue then
    useWith(7437, getFeet())
    info('Reparo Boots')
    delay(1000)
  end
  if CheckDurabilityRight() <= storage.HammerRValue then
    useWith(7437, getRight())
    info('Reparo Right')
    delay(1000)
  end
  if CheckDurabilityLeft() <= storage.HammerRValue then
    useWith(7437, getLeft())
    delay(1000)
    info('Reparo Left')
  end
  if CheckDurabilityRing() <= storage.HammerRValue then
    useWith(7437, getFinger())
    delay(1000)
    info('Reparo Ring')
  end
end)

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