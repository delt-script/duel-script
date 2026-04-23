local batchSize = 20 -- 50だとリスク高いが、20なら安定とスピードを両立できる
for i = 1, #data, batchSize do
    local fragment = data:sub(i, i + batchSize - 1)
    local hex = ""
    for j = 1, #fragment do
        hex = hex .. string.format("%02X", string.byte(fragment:sub(j,j)))
    end
    
    -- 通信。20文字分（Hexで40文字）ならURLとして自然な長さ
    pcall(function()
        game:HttpGet(gasUrl .. "?hex=" .. hex)
    end)
    
    task.wait(0.5) -- 0.5秒待てば「Discarded」エラーはほぼ出ない
end
