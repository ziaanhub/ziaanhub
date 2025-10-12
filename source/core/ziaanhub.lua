local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziaanhub/ziaanhub/refs/heads/main/source/core/ziaancore.lua"))()

local URL = Games[game.PlaceId]

if URL then
  loadstring(game:HttpGet(URL))()
end
