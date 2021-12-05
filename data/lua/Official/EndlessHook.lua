g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Import("twutils")

Run = false
Hook = false
LastHooked = -1
Tried = false
Init = false
LastX = 0
LastY = 0
Reset = false
Permantent = false

function OnKeyPress(key)
  if key == "mouse2" then
    Run = true
  elseif key == "k" then
    if Permantent then
      Permantent = false
    else
      Permantent = true
    end
  end
end

function CanHook(ID)
  Val = 60
  --Angle1 = GetAngle(Game.Players(ID).Tee.Pos.x - Game.LocalTee.Pos.x, Game.Players(ID).Tee.Pos.y - Game.LocalTee.Pos.y)
  Angle2 = GetAngle(Game.Players(ID).Tee.Pos)
end

function OnKeyRelease(key)
  if key == "mouse2" and not Permantent then
    Run = false
  end
end

function OnTick()
  if Game.LocalTee.HookedPlayer ~= -1 then
    LastHooked = Game.LocalTee.HookedPlayer
  end
  if not Run then
    LastHooked = -1
  end
  if LastHooked == -1 then
    Init = true
    return
  end
  if LastHooked ~= -1 and Game.Collision:IntersectLine(Game.LocalTee.Pos, Game.Players(LastHooked).Tee.Pos, nil, nil, false) ~= 0 then
    Init = true
    return
  end
  if Run and Game.LocalTee.HookedPlayer ~= -1 then
    Init = true
  end
  if Reset then
    Game.Input.MouseX = LastX
    Game.Input.MouseY = LastY
    Reset = false
  end
  if Hook then
    LastX = Game.Input.TargetX
    LastY = Game.Input.TargetY
    Game.Input.MouseX = Game.Players(LastHooked).Tee.Pos.x - Game.LocalTee.Pos.x
    Game.Input.MouseY = Game.Players(LastHooked).Tee.Pos.y - Game.LocalTee.Pos.y
    Game.Input.Hook = 1
    --Init = true
    Hook = false
    Reset = true
  elseif Run and Game.LocalTee.HookedPlayer ~= LastHooked then
    if Init then
      Game.Input.Hook = 0
      Init = false
    end
    local dist = Game.Collision:Distance(Game.LocalTee.Pos, Game.Players(LastHooked).Tee.Pos)
		if dist < 380 then
      Hook = true
    end
  end
end
