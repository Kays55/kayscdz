setDefaultTab("Dsc")
--text = 'You see a [Épico] aquario glove (Atk:272, club fighting +39).'
-------------------
local discordTimes = {}
 -- insert your webhook link below

local default_data = {
  username = "CDZ Drop", -- name discord displays the message from
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
function sendDiscordWebhook(data)
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

 onTextMessage(function(mode, text) 
  if not text:find('Loot of') then return end
   if text:find('Lendario') or text:find('Mitico') then
   local data = {
     title = 'Drop',
     name = player:getName(),
     message = text .. ' Loc: X: '.. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz(),
     id = "pd",
   }
   sendDiscordWebhook(data)
   end
   epictext = text:find('Épico')
   if epictext then
   -- info('true')
   outtext = text:sub(epictext+6)
  local data = {   
   title = 'Drop',
     name = player:getName(),
     message = '[Epico] '.. outtext .. ' Loc: X: '.. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz(),
     id = "pd",
  }
  sendDiscordWebhook(data)
   end
 end)
-------------------------------------------------------------------------------------------------------------------------

local discordTimes = {}
 -- insert your webhook link below

local dd3 = {
  username = "Player In Cave", -- name discord displays the message from
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



aviso = macro(100, 'aviso guild', function()
  if isinGreciaCity() or isInThermalspot() then return end
    for name, _ in pairs(talkedSpecs) do
        if not getCreatureByName(name) then
            talkedSpecs[name] = nil
        end
    end
    for _, spec in ipairs(getSpectators()) do
        if spec ~= player and spec:isPlayer() then
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

-----------------------------------------------------------------------------------------------

local discordTimes = {}
 -- insert your webhook link below

local dd3 = {
  username = "Player Attack", -- name discord displays the message from
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
function SDW4(data)
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
  HTTP.postJSON(WH2, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------


spotedspecs = {}

onTextMessage(function(mode, text)
  if text:find('attack by an ') then return end
      for pname, _ in pairs(spotedspecs) do
        if not getCreatureByName(pname) then
            spotedspecs[pname] = nil
        end
    end
 for _, p in ipairs(getSpectators(posz())) do
  if p:isPlayer() and text:find(p:getName()) and text:find('attack by') then
    if not spotedspecs[pname] then
    pname = p:getName()
    local data = {
    title = 'Player Attack',
    name = pname,
    message = 'Attacou: ' .. player:getName(),
    id = "pd",
    }
    SDW4(data)
    spotedspecs[pname] = true
  end
 end
end
end)

-------------------------------------------------------------------------------



local discordTimes = {}
 -- insert your webhook link below


local dd5 = {
  username = "Just Frag", -- name discord displays the message from
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
function SDW5(data)
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

  local dataSend = dd5
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(WH1, dataSend, onHTTPResult)
end


 --------------
 -- example --
 --------------


local console = modules.game_console
onTextMessage(function(mode, text)
    if not text:find("The murder of") then return end
    startindex = text:find('of')
    endindex = text:find('was')
    playername = player:getName()
    vitima = text:sub(startindex+3, endindex-2)
    local data = {
    title = 'Fragou',
    name = playername,
    message = 'Matou o Jogador ' .. vitima,
    id = "pd",
    }
    SDW5(data)
 end)

--info('Loaded Discord')
-------------------------------------------------------

setDefaultTab("Dsc")
local discordTimes = {}
 -- insert your webhook link below


local DiscName1 = {
  username = "PMs", -- name discord displays the message from
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

---------------------------------------------------------

local discordTimes = {}


local default_dataeveryone = {
  username = "CapBot",
}

function onHTTPResult(data, err)
  if err then
    info("Erro no Webhook do Discord: " .. err)
  else
    info("Mensagem enviada com sucesso!")
  end
end

function CapHook(data)
  local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (data.delay or 0) 
  end

  local dataSend = {
    username = default_dataeveryone.username,
    content = data.message
  }

  HTTP.postJSON(webhookeveryone, dataSend, onHTTPResult)
end


-----------------------------------------------------




capalart = now
macro(200,function()
if capalart >= now then return end
   if freecap() <= 100 then
    info('Updated')
        local data = {
        message = player:getName() .. ' esta com menos de 100 de cap.',
        id = "pd",
        }
      CapHook(data)
      capalart = now + 60000
   end
end)



---------------------------------------------------------

local discordTimes = {}


local default_dataeveryone = {
  username = "Death Position",
}

function onHTTPResult(data, err)
  if err then
    info("Erro no Webhook do Discord: " .. err)
  else
    info("Mensagem enviada com sucesso!")
  end
end

function deathspot(data)
  local id = data.id
  if id then
    local dTime = discordTimes[id]
    if dTime and os.time() < dTime then return end
    discordTimes[id] = os.time() + (data.delay or 0) 
  end

  local dataSend = {
    username = default_dataeveryone.username,
    content = data.message
  }

  HTTP.postJSON(webhookDeathspot, dataSend, onHTTPResult)
end


-----------------------------------------------------




onTextMessage(function(mode, text)
   if text:find('You are dead.') then
        local data = {
        message = player:getName() .. ' morreu nos Sqm: X: ' .. posx() .. 'Y: ' .. posy() .. 'Z: ' .. posz(),
        id = "pd",
        }
      deathspot(data)
   end
end)


if not g_resources.directoryExists("/screenshots") then
  g_resources.makeDir("/screenshots")
end


onTextMessage(function(mode, text)
    if text:find('You are dead.') then
            doScreenshot("/screenshots/"..player:getName().." "..os.date('%Y-%m-%d-%H-%M-%S')..".png")
    end
end)