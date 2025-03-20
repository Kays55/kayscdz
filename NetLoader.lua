--LoadMain
setDefaultTab("Main")
setDefaultTab("Atk")
setDefaultTab("Def")
setDefaultTab("Cave")
setDefaultTab("Target")
setDefaultTab("Tools")
setDefaultTab("Dsc")

modules.corelib.HTTP.get('https://raw.githubusercontent.com/Kays55/kayscdz/refs/heads/main/Atual/CustomFull.lua', function(script)
    assert(loadstring(script))()
  end);


--modules.corelib.HTTP.get('https://raw.githubusercontent.com/Kays55/kayscdz/refs/heads/main/Atual/Extras.lua', function(script)
--    assert(loadstring(script))()
--  end);