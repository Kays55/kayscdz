setDefaultTab("Cave")

storage.timecheck = now

macro(100, 'Check Armor', function()
  if storage.timecheck < now then
  storage.timecheck = now + 60000
  g_game.look(getInventoryItem(SlotBody))
end
end)

UI.TextEdit(storage.mindurability or "80", function(widget, newText)
storage.mindurability = newText
end)

Backincave = macro(200, '100%',function()end)

UI.Separator()

-- Cavebot by otclient@otclient.ovh
-- visit http://bot.otclient.ovh/
