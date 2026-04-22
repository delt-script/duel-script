local data = "TEST123" -- まずは短い文字で
local url = "https://script.google.com/macros/s/AKfycby_TzKrZNOz1gvJ-gy4x4pn509wZcICHHfyAazXT9htKEFhmrcxolVZxZbt4o_sYJE7/exec"

print("--- デバッグ開始 ---")

for i = 1, #data do
    print("📍 ループ " .. i .. " 回目開始")
    
    local char = data:sub(i, i)
    local byteCode = string.byte(char)
    local finalUrl = url .. "?mode=stream&char=" .. tostring(byteCode)
    
    print("🔗 通信準備完了: " .. finalUrl)

    -- pcall の結果を強制的に表示する
    local success, err = pcall(function()
        return game:HttpGet(finalUrl)
    end)

    if success then
        print("✅ 通信成功（応答あり）")
    else
        print("❌ 通信失敗（Deltaに消されたかも）: " .. tostring(err))
    end
    
    task.wait(1) -- あえて1秒待って、様子を見る
end

print("--- デバッグ終了 ---")
