setDefaultTab("Main")
UI.Separator()

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

info('Loaded Timer')