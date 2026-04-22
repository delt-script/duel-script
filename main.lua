-- [[ 16進数ゲリラ通信：Delta側 ]]
local data = "日本語テスト：成功への一歩" 
local url = "お前のGASのURL"

-- 文字列を16進数に変換する関数
local function toHex(str)
    return (str:gsub('.', function(c)
        return string.format('%02X', string.byte(c))
    end))
end

local hexData = toHex(data)

for i = 1, #hexData, 2 do -- 2文字（1バイト分）ずつ送る
    local hexPair = hexData:sub(i, i+1)
    local finalUrl = url .. "?mode=stream&hex=" .. hexPair .. "&user=" .. game.Players.LocalPlayer.Name
    
    pcall(function() game:HttpGet(finalUrl) end)
    task.wait(0.2)
end
