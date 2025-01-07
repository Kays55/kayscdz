setDefaultTab("Main")
local ProtocolGame = g_game.getProtocolGame();
local OutputMessage = modules._G.OutputMessage;

local opcode = 16;
local SpecialOpcode = modules._G.SpecialOpcode;
setDefaultTab("Cave")
bypassdoormacro = macro(100, 'Bypassdoor', function()
  local window = modules.game_antibotcode.MainWindow;
  if (window:isHidden()) then return; end

  local codePanel = window:getChildById("codePanel");
  local msg = OutputMessage.create();
  msg:addU8(SpecialOpcode);
  msg:addU8(opcode);
  msg:addU8(1);
  msg:addString(codePanel:getText());
  ProtocolGame:send(msg);
  window:hide();
end)


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