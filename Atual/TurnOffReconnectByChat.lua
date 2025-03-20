	function autoReconnectButton.onClick(widget)
		local autoReconnect = not g_settings.getBoolean("autoReconnect", true)

		autoReconnectButton:setOn(autoReconnect)
		g_settings.set("autoReconnect", autoReconnect)
	end

onTalk(function(name, level, mode, text, channelId, pos)
	if text:find('SwitchReconect') and mode = 4 then
		g_ui.getRootWidget():recursiveGetChildById("autoReconnect").onClick(widget)
	end
end)