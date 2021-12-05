g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Run = false
Permantent = false

function OnKeyPress(key)
  if key == "space" then
    if Permantent then
      Run = not Run
    else
      Run = true
    end
  end
end

function OnKeyRelease(key)
  if key == "space" and not Permantent then
    Run = false
  elseif key == "m" then
    if Permantent then
      Permantent = false
    else
      Permantent = true
    end
  end
end

function OnTick()
  if Run then
    if Game.Input.Jump == 0 then
      Game.Input.Jump = 1
    else
      Game.Input.Jump = 0
    end
  end
end