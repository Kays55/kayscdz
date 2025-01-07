setDefaultTab("Main")
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

mvphunt = macro(200, 'MVP Hunt', function() end)

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

info('Loaded Quests')