local HttpService = game:GetService("HttpService")
local GAS_URL = "https://script.google.com/macros/s/AKfycbyeHXL7T7sIu4a28URoUzEmjBtV2namGFPIsJjy-CwPKSD7DL2oE7I7VqH0wJRxPpry/exec"

local functionList = {}
local seen = {}

-- 関数だけを抽出する安全なフィルター
local function collectValidFunctions(targetTable)
    if type(targetTable) ~= "table" then return end
    for name, value in pairs(targetTable) do
        -- 1. 名前が文字列 2. 値が関数 3. まだ登録してない
        if type(name) == "string" and type(value) == "function" and not seen[name] then
            table.insert(functionList, name)
            seen[name] = true
        end
    end
end

-- 取得対象を「本当に使える場所」に限定
collectValidFunctions(getgenv())  -- Delta独自の便利関数 (getrawmetatableとか)
collectValidFunctions(getfenv(0)) -- 標準のLua関数 (printとか)

-- 多すぎるとGASが死ぬので、念のため名前順でソートして整理
table.sort(functionList)

print("厳選完了！使える関数は " .. #functionList .. " 個だぜ")

local payload = HttpService:JSONEncode({
    functions = functionList
})

local success, response = pcall(function()
    return HttpService:PostAsync(GAS_URL, payload)
end)

if success then
    print("【着弾成功】: " .. response)
else
    warn("【送信失敗】: " .. tostring(response))
end
