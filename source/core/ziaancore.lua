
local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziaanlabs/ziaanhub/refs/heads/main/source/core/ziaanhub.lua"))()

local URL = Games[game.PlaceId]

if URL then
    loadstring(game:HttpGet(URL))()
else
    warn("Error Bro")
end
