local path = "Internals/Secured/disableantiscam"
local correctId = "93156578936" -- ここをお前が見つけたIDにする

-- 書き換える内容（JSON形式）
local newData = '{\n  "allowed_games": "*",\n  "user_id": "' .. correctId .. '",\n  "version_num": 707\n}'

-- 実行！
local success, err = pcall(function()
    writefile(path, newData)
end)

if success then
    print("✅ 書き換え完了！これでもう名前を戻す必要もねえ。")
    print("一度Robloxを再起動して設定を反映させろ！")
else
    warn("❌ 書き換え失敗: " .. tostring(err))
end
