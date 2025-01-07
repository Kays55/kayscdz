 local discordTimes = {}
 -- insert your webhook link below
local webhook1 = "https://discord.com/api/webhooks/1227451625983971428/4447nDBRonca6MP9Ukcs6klRiOpYW34kb0JTiwoU4CR6ZQ9IYuEkL29z9jqRGDLUKFRg"

local default_data1 = {
  username = "Fogueteiro", -- name discord displays the message from
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
function sendDiscordWh(data)
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

  local dataSend = default_data1
  dataSend.embeds = { dEmbed }
  HTTP.postJSON(webhook1, dataSend, onHTTPResult)
end

 --------------
 -- example --
 --------------
storage.alvo = {}
 onTextMessage(function(mode, text)
  if text:find('sqm') then
    endIndex, _ = text:find("%(");
    procurado = text:sub(1, endIndex - 1);
    new_value = text:match('%d+');

    value = storage.alvo[procurado];
  if (value ~= new_value) then
    if (value ~= nil) then
    local data = {
     title = 'Moving',
     name = procurado,
     message = 'se Movimentou ' .. value .. ' Sqms da Thermal',
     id = "pd",
   }
      info('true')
      sendDiscordWh(data)
    end
    storage.alvo[procurado] = new_value;
  end
 end
end)

tabelasense = {'Anti Playboy', 'Anti Farmer', 'Mago Love Pedro', 'Razor', 'Indexx', 'Noite Sombria', 'Naomeataka Kara'}
  n = 1
macro(200, 'sense', function()
  if soul() == 200 then
say('chain sense "' .. tabelasense[n])
  n = n+1
end
  if n > #tabelasense then
    n = 1
  end
end)

onTalk(function(name, level, mode, text, channelId, pos)
  if text:find(' está hunted.') then
    endIndex = text:find('est')
    addtarget = text:sub(1, endIndex-2)
    table.insert(tabelasense, addtarget)
  end
end)