-- [[ PROJECT: FILE PEEKER ]]
local path = "Delta/Internals/Secured/user_id"

print("🔍 ファイル [user_id] の中身を覗き見中...")

local success, content = pcall(function()
    return readfile(path)
end)

if success then
    print("✅ 読み取り成功！")
    print("-------------------------")
    print(content)
    print("-------------------------")
    print("文字数: " .. #tostring(content))
else
    print("❌ 読み取り失敗 (Access Denied / Not Found)")
    print("エラー内容: " .. tostring(content))
end
