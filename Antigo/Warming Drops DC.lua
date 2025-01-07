local discordTimes = {}
 -- insert your webhook link below
local webhook = "https://discord.com/api/webhooks/1227437377165725778/Tx5IiNpDtKlAVlo5jl9_3wKoiHNvSknAdMko7kN2NGO144naCKxXMbN149cgVldNepoG"

local default_data = {
  username = "CDZBot", -- name discord displays the message from
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

 local raridade = ''

 onTextMessage(function(mode, text)
  if not text:find('Loot of') then return end
   if text:find('Lendario') then   
   local data = {
     title = 'Drop',
     name = player:getName(),
     message = text,
     id = "pd",
   }
     sendDiscordWebhook(data)
   end
     if text:find('Épico') then
         local data = {
     title = 'Drop',
     name = player:getName(),
     message = text,
     id = "pd",
   }
     sendDiscordWebhook(data)
   end
 end)