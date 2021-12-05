g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Right = false
Left = false
NeedReset = false

function OnKeyPress(key)
    if key == "right" then
        if not Right then
            Right = true
        end
    elseif key == "left" then
        if not Left then
            Left = true
        end
    end
end

function OnTick()
    if NeedReset then
        Game.Input.Direction = 0
        NeedReset = false
    end

    if Right then
        Game.Input.Direction = 1
        Right = false
        NeedReset = true
    end

    if Left then
        Game.Input.Direction = -1
        Left = false
        NeedReset = true
    end
end
