setDefaultTab('Cave')
local logoutDeaths = 5  -- numero de mortes
if type(storage["death"]) ~= "table" then storage["death"] = { count = 0 } end
local deathCount = storage["death"].count
UI.Separator()
deathLabel = UI.Label("Death count: " .. deathCount)

if deathCount >= logoutDeaths then
  CaveBot:setOff()
  warn("Death Count Logout")
  schedule(5000, function()
  storage["death"].count = 0
    modules.game_interface.tryLogout(false)
  end)
end

if deathCount >= 4 then
  deathLabel:setColor("red")
elseif deathCount >= 2 then
  deathLabel:setColor("orange")
else
  deathLabel:setColor("green")
end

UI.Button("Reset Deaths", function()
  storage["death"].count = 0
  deathLabel:setText("Death count: " .. storage["death"].count)
  deathLabel:setColor("green")
end )

local macroDeathCount = macro(1000, "Death Counter", function()

for i, rootW in pairs(g_ui.getRootWidget():getChildren()) do
  if rootW:getText() == "You are dead" then
    storage["death"].count = storage["death"].count + 1
    deathLabel:setText("Death count: " .. storage["death"].count)
    modules.client_entergame.CharacterList.doLogin()
    end
  end
end)