local HttpService = game:GetService("HttpService")
local GAS_URL = "https://script.google.com/macros/s/AKfycbxYT4hNiAhjnDo9rvAPGknKDhGRWQeg54pZyzSvf0qUk90EGr2fz31FjywzUH8edw4T/exec"

-- Deltaの環境から関数を収集
local functionList = {}
local seen = {}

-- 重複を避けつつ関数を収集する関数
local function collectFrom(env)
    for name, value in pairs(env) do
        if type(value) == "function" and not seen[name] then
            table.insert(functionList, name)
            seen[name] = true
        end
    end
end

-- 各種環境から収集
collectFrom(getgenv())  -- エグゼキューター独自のグローバル
collectFrom(getreg())   -- レジストリ（あれば）
collectFrom(getfenv(0)) -- 標準グローバル

-- GASに送信
local payload = HttpService:JSONEncode({
    functions = functionList
})

print("送信準備完了: " .. #functionList .. "件の関数を送るぜ")

local success, response = pcall(function()
    return HttpService:PostAsync(GAS_URL, payload)
end)

if success then
    print("【着弾成功】: " .. response)
else
    warn("【通信失敗】: " .. tostring(response))
    print("※Googleに繋がらない場合は、回線のフィルタリングかSSLエラーが濃厚だ。")
end
