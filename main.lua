-- [[ PROJECT: THE LAST RESORT ]]
local player = game:GetService("Players").LocalPlayer
local trueId = tostring(player.UserId)

local targetPath = "Delta/Internals/Secured/disableantiscam"
local content = [[{"WARNING":"STOP","allowed_games":"*","user_id":"]]..trueId..[[","version_num":707}]]

print("🛠️ 最終突破シーケンス開始...")

-- A: フォルダの再構築テスト
pcall(function()
    makefolder("Delta/Internals/Secured") 
    print("📂 folder check/create tried")
end)

-- B: 書き込み（あえてpcallを重ねて実行）
local s, e = pcall(function()
    writefile(targetPath, content)
end)

if s then
    print("✅ Write executed without error.")
else
    print("❌ Write failed: " .. tostring(e))
end

-- C: 物理的な「隙」を作るための待機
task.wait(2)

-- D: 通信解禁の「最終確認」
print("📡 最終通信テスト（HttpGet）...")
local hs, hr = pcall(function()
    return game:HttpGet("https://api.ipify.org")
end)

if hs then
    print("🔥 奇跡が起きた！通信成功: " .. tostring(hr))
else
    print("💀 依然として封鎖中。門番は無敵だ。")
end
