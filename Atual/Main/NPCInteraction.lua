setDefaultTab("Main")
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

info('Loaded NPCChat')