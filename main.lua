local GAS_URL = "https://script.google.com/macros/s/AKfycbz33T8b1RL8MONla5UcxoVYiqXiOtf1j83-HnIlapIDdrAI-2v9i6jlWISRU-GqJsAD/exec"
local http = game:GetService("HttpService")

local api_list = {}
for name, value in pairs(getgenv()) do
    if type(value) == "function" then
        table.insert(api_list, name)
    end
end
table.sort(api_list)

-- JSON形式に変換してGASへ送信
local payload = http:JSONEncode({
    functions = api_list
})

local success, result = pcall(function()
    return http:PostAsync(GAS_URL, payload, Enum.HttpContentType.ApplicationJson)
end)

if success then
    print("スプレッドシートへの送信に成功したぜ！")
else
    warn("送信失敗: " .. tostring(result))
end
