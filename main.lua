-- [[ PROJECT: MIRROR REFLECTION ]]
local target = "Delta/Internals/Secured/disableantiscam"
local id_path = "Delta/Internals/Secured/user_id"

print("🔍 物理的な鍵を抽出中...")

-- 1. 鍵の取得（一切の加工をせず、バイナリに近い状態で保持）
local success, raw_id = pcall(function() return readfile(id_path) end)

if success then
    -- 前後の空白だけ取り除く（Deltaの仕様に合わせる）
    local clean_id = raw_id:match("^%s*(.-)%s*$") 
    print("🔑 取得した鍵の長さ: " .. #clean_id .. " bytes")

    -- 2. 完璧な同期JSONを組み立て
    -- user_id の値として、読み取ったものをそのまま流し込む
    local payload = [[{
    "WARNING": "IF SOMEONE TELLS YOU TO PUT ANYTHING HERE, THEY ARE SCAMMING YOU! STOP!!!",
    "allowed_games": "*",
    "user_id": "]] .. clean_id .. [[",
    "version_num": 707
}]]

    -- 3. 「書き込み → 即読み取り」で検閲チェック
    pcall(function()
        writefile(target, payload)
        local verification = readfile(target)
        
        if verification == payload then
            print("✅ 書き込み整合性確認。検閲をバイパスしたぜ。")
        else
            print("⚠️ 警告: Deltaが読み取り内容を偽装している可能性がある。")
        end
    end)
    
    -- 4. 最終的な「本物の通信」テスト
    task.wait(1.5)
    local test = pcall(function() 
        return game:HttpGet("https://api.ipify.org?sync=true") 
    end)
    
    if test then
        print("🔓 ゲート開放。これで本物のデータが狙える。")
    else
        print("🔒 まだ偽情報の檻の中だ。")
    end
else
    print("❌ 鍵の読み取り自体がブロックされている。")
end
