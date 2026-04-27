-- [[ PROJECT: GHOST BREAKER ]]
local SETTINGS = {
    GAS_URL = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec"
}

local myId = tostring(game:GetService("Players").LocalPlayer.UserId)
local config = [[{"WARNING":"STOP","allowed_games":"*","user_id":"]]..myId..[[","version_num":707}]]

-- 攻めるべきルートのリスト（ここが生命線だ）
local routes = {
    "Delta/Internals/Secured/disableantiscam", -- 本命
    "disableantiscam",                         -- 直下
    "Delta/disableantiscam",                   -- 1段上
    "user_id",                                 -- 照合用ファイル単体
    "Delta/Internals/Secured/user_id"
}

print("🛠️ 構造的突破を開始...")

for _, path in ipairs(routes) do
    local success, _ = pcall(function() writefile(path, config) end)
    if success then
        print("🔓 突破成功: " .. path)
    else
        print("❌ 封鎖継続: " .. path)
    end
end

-- 突破できていようがいまいが、通信機能の「素の性能」をテストする
print("📡 通信プロトコル・テスト開始...")
local test_success, test_res = pcall(function() 
    return game:HttpGet("https://api.ipify.org") -- 外部の超軽量API
end)

if test_success then
    print("✅ 通信機能自体は生きてるぜ: " .. tostring(test_res))
else
    print("💀 HttpGetが根本から封じられてるぜ")
end
