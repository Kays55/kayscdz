local discordTimes = {}
 -- insert your webhook link below
local webhook = "https://discord.com/api/webhooks/1227615728144875520/2HPiUc_1uA8_qDiFx4_EY2viUsumn_3ZBl_xs1Ardm4WNMpTNhyz4pu2Lk_Rn0OhpHuV"
local default_data = {
  username = "Olheiro", -- name discord displays the message from
}
local embed = {
  color = 10038562, -- default color - dark red
}
function onHTTPResult(data, err)
  if err then
    print("Discord Webhook Error: ".. err)
  end
end
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
 nivelAnterior = {}
 
 onTextMessage(function(mode, text)
     jogadores = {}
     for _, part in pairs(text:split(', ')) do
        trimmedPart = part:trim()
         nome, nivel = trimmedPart:match("%s?(%a+)%s+%[([^%]]+)%]%s?")
         if nome and nivel then
             nivel = tonumber(nivel)
             if nivelAnterior[nome] then
                 if nivelAnterior[nome] ~= nivel and nivel >= 300 then
                     local data = {
                     title = 'Mudou de Nivel',
                     name = nome,
                     message = " mudou de " .. nivelAnterior[nome] .. " para " .. nivel,
                     id = "pd",
                     }
                     modules.game_textmessage.displayGameMessage("O nível de " .. nome .. " mudou de " .. nivelAnterior[nome] .. " para " .. nivel)
                     sendDiscordWebhook(data)
                 end
             end
             nivelAnterior[nome] = nivel
         end
     end
 end)

 macro(200, 'auto !online',function()
say('!online')
delay(5000)
end)