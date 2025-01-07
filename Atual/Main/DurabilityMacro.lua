setDefaultTab("Main")
storage.durability = nil
onTextMessage(function(mode, text)
local _, startIndex = text:find('Arm:');
local endIndex, _ = text:find(',');
local _, efistartIndex = text:find('Durability: ');
local efiendIndex, _ = text:find('It');
  if text:find('You see a') and startIndex and endIndex then
    storage.ActualArm = tonumber(text:sub(startIndex+1, endIndex-1))
    if (text:find('dubhe')) and text:find('Arm:') then
      storage.BaseArm = 245
    end
    if (text:find('sereia')) and text:find('Arm:') then
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
    if text:find('Durability') and efiendIndex then
      durabilityPercentage = text:sub(efistartIndex, efiendIndex-4);
      storage.durability = tonumber(durabilityPercentage)
    end
    storage.CalcEficience = (((storage.ActualArm*(100))/storage.BaseArm))
    storage.truearm = ((storage.ActualArm * 100)/storage.durability)
    formula = ((storage.truearm *(100))/storage.BaseArm)
    if storage.CalcEficience and storage.truearm and formula then
      info('Rare: '.. math.floor(formula) .. '%')
      info('ArmorTotal: ' .. math.floor(storage.truearm))
    end
  end
end)

info('Loaded DurabilityMacro')