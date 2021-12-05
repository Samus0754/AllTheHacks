g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Run = false

function OnKeyPress(key)
  if key == "mouse1" then
    Run = true
  end
end

function OnKeyRelease(key)
  if key == "mouse1" then
    Run = false
  end
end

function OnTick()
  if Run then
    if Game.Input.Fire == 0 then
      Game.Input.Fire = 1
    else
      Game.Input.Fire = 0
    end
  end
end
