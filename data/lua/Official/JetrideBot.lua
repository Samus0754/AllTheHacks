g_ScriptTitle = "Jetride"

Enable = false

FireLength = 0
Counter = 0

MoveSpeed = 80

MoveUpCounter = 0
MoveDownCounter = 0

MoveUp = false
MoveDown = false

function OnKeyPress(key)
    if key == "j" then
        if Enable then
            Game.Input.Fire = 0
            Enable = false
        else
            Enable = true
        end
    elseif key == "up" then
        MoveUp = true
    elseif key == "down" then
        MoveDown = true
    end
end

function OnKeyRelease(key)
    if key == "up" then
        MoveUp = false
    elseif key == "down" then
        MoveDown = false
    end
end

function OnTick()
    if Enable then
        Game.Input.MouseX = 0
        Game.Input.MouseY = 100

        if MoveUp then
            if MoveUpCounter >= MoveSpeed then
                Game.Input.Fire = 0
                MoveUpCounter = 0
                return
            end
            Game.Input.Fire = 1
            MoveUpCounter = MoveUpCounter + 1
            return
        end

        if Counter >= Game.LocalTee.Vel.y*256 then
            Game.Input.Fire = 0
            Counter = 0
        else
            Counter = Counter + 1
            if MoveDown then
                if MoveDownCounter >= MoveSpeed then
                    Game.Input.Fire = 0
                    MoveDownCounter = 0
                    return
                end
                if Game.Input.Fire == 0 then
                    Game.Input.Fire = 1
                else
                    Game.Input.Fire = 0
                end
                MoveDownCounter = MoveDownCounter + 4
            else
                Game.Input.Fire = 1
            end
        end
    end
end