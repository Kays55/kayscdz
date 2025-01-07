setDefaultTab("Main")
local privateTabs = addSwitch("openPMTabs", "PM Tabs", function(widget) widget:setOn(not widget:isOn()) storage.OpenPrivateTabs = widget:isOn() end, parent)
privateTabs:setOn(storage.OpenPrivateTabs)

onTalk(function(name, level, mode, text, channelId, pos)
    if mode == 4 and privateTabs:isOn() then
        local g_console = modules.game_console
        local privateTab = g_console.getTab(name)
        if privateTab == nil then
            privateTab = g_console.addTab(name, true)
            g_console.addPrivateText(g_console.applyMessagePrefixies(name, level, text), g_console.SpeakTypesSettings['private'], name, false, name)
            playSound("/sounds/Private Message.ogg")
        end
        return
    end
end)

onTextMessage(function(mode, text)
  if text:find('Task') and text:find('Completo') then
    playSound('/sounds/magnum.ogg')
      g_window.setTitle(player:getName() .. " - Task Complete")
  end
end)

onTalk(function(name, level, mode, text, channelId, pos)
if name ~= 'Grande Mestre' then return end
if text:find('Caso queira você pode tentar pegar outra missão') then
  g_window.setTitle("CDZ Gold - " .. player:getName())
end
end)

info('Loaded PMTabs')