-- グローバル環境(getgenv)の中から「cookie」を含むものを全列挙
local found = false
for i, v in pairs(getgenv()) do
    if type(i) == "string" and i:lower():find("cook") then
        print("【発見】関数名: " .. i .. " (Type: " .. type(v) .. ")")
        found = true
    end
end
if not found then print("cookieを含む関数は見つかりませんでした") end
