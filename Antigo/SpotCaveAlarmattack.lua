setDefaultTab("Main")
local discordTimes = {}
 -- insert your webhook link below
local webhook3 = "https://discord.com/api/webhooks/1229409297155231845/WSYK3iGJ4at3Q8L9dQo4YB2JhTBU9_8vUjXFY9JbUT-bdv0mQp_mdf01Qq9y4hUtvVJL"

local dd3 = {
  username = "MeliantenaCave", -- name discord displays the message from
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
  HTTP.postJSON(webhook3, dataSend, onHTTPResult)
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


spotedspecs = {}

onTextMessage(function(mode, text)
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
    message = 'Attacou' .. player:getName(),
    id = "pd",
    }
    SDW3(data)
    spotedspecs[pname] = true
  end
 end
end
end)