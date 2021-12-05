g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Import("stringutils")
Import("algorithm")
Import("twutils")

Enable = false
CampX = 0
CampY = 0
Balance = false
Jump = false
NeedReset = false
Fire = false
ToggleFire = false
Right = false
EmoteSeconds = 12
EmoteCounter = 0

function OnChatSend(Team, Message)
	if Message:sub(1, 1) ~= "!" then return end

  Message = Message:sub(2, -1)

  args = StringUnpackArgs(Message)

  local action = args[1]:lower()
  local msg = StringFromTable(range(args, 2))

  if action == "say" then
    Game.Chat:DummySay(0, msg)
  elseif action == "emote" then
    Game.Emote:DummySend(msg)
  elseif action == "kill" then
    Game:KillDummy()
  elseif action == "eyeemote" then
    Game.Emote:DummySendEye(msg)
  elseif action == "setpos" then
    CampX = Game.Dummy().Tee.Pos.x
    CampY = Game.Dummy().Tee.Pos.y
    local x = tostring(math.floor(CampX/32))
    local y = tostring(math.floor(CampY/32))
    Game.Chat:DummySay(0, "Position set: " .. "x: " .. x .. " y: " .. y)
  elseif action == "camp" then
    if Enable then
      Game.Chat:DummySay(0, "Camp: disabled")
      Enable = false
    else
      if CampX == 0 or CampY == 0 then
        Game.Chat:DummySay(0, "No position set!")
        return true
      end
      Game.Chat:DummySay(0, "Camp: enabled")
      Enable = true
    end
  elseif action == "pos" then
    Pos = Game.Dummy().Tee.Pos
    local x = tostring(math.floor(Pos.x/32))
    local y = tostring(math.floor(Pos.y/32))
    Game.Chat:DummySay(0, "x: " .. x .. " y: " .. y)
  elseif action == "balance" then
    if Balance then
      Game.Chat:DummySay(0, "Balance: disabled")
      Balance = false
    else
      Game.Chat:DummySay(0, "Balance: enabled")
      Balance = true
    end
  elseif action == "jump" then
    Jump = true
  elseif action == "fire" then
    Fire = true
  elseif action == "mousex" then
    Game.Input.DummyTargetX = msg
  elseif action == "mousey" then
    Game.Input.DummyTargetY = msg
  elseif action == "aimup" then
    Game.Input.DummyTargetX = 0
    Game.Input.DummyTargetY = -100
  elseif action == "aimdown" then
    Game.Input.DummyTargetX = 0
    Game.Input.DummyTargetY = 100
  elseif action == "aimleft" then
    Game.Input.DummyTargetX = -100
    Game.Input.DummyTargetY = 0
  elseif action == "aimright" then
    Game.Input.DummyTargetX = 100
    Game.Input.DummyTargetY = 0
  elseif action == "right" then
    Right = true
  elseif action == "weapon" then
    Game.Input.DummyWantedWeapon = msg
  elseif action == "war" then
    if GetClosestID() ~= -1 then
      Game.Chat:DummySay(0, Game.Players(GetClosestID()).Name .. ": war")
    end
  elseif action == "love" then
    if GetClosestID() ~= -1 then
      Game.Chat:DummySay(0, Game.Players(GetClosestID()).Name .. ": i luv u!")
    end
  elseif action == "togglefire" then
    if ToggleFire then
      Game.Input.DummyFire = 0
      ToggleFire = false
    else
      ToggleFire = true
    end
  end
  return true
end

function distance(num1, num2)
  if num1 > num2 then
    return num1 - num2
  else
    return num2 - num1
  end
end

function OnTick()
  if NeedReset then
    Game.Input.DummyDirection = 0
    Game.Input.DummyJump = 0
    Game.Input.DummyFire = 0
    NeedReset = false
  end

  if EmoteCounter >= EmoteSeconds*60 then
    Game.Emote:DummySend(2)
    EmoteCounter = 0
  else
    EmoteCounter = EmoteCounter + 1
  end

  if Game.Client.Tick % 140 == 0 then
    local var = {true, false}

    if var[math.random(1, 2)] then
      Game.Input.DummyTargetX = -100
      Game.Input.DummyTargetY = 0
    else
      Game.Input.DummyTargetX = 100
      Game.Input.DummyTargetY = 0
    end
  end

  if Jump then
    Game.Input.DummyJump = 1
    NeedReset = true
    Jump = false
  end

  if Fire then
    Game.Input.DummyFire = 1
    NeedReset = true
    Fire = false
  end

  if Right then
    Game.Input.DummyDirection = 1
    NeedReset = true
    Right = false
  end

  if ToggleFire then
    if Game.Input.DummyFire == 0 then
      Game.Input.DummyFire = 1
    else
      Game.Input.DummyFire = 0
    end
  end

  Pos = Game.Dummy().Tee.Pos

  if Balance then
    LocalPos = Game.Dummy().Tee.Pos
    p = Game.LocalTee.Pos
    --p = Game.Players(GetPlayerID("SanoreX")).Tee.Pos
    --LocalPos = Game.Players(Game:DummyCID()).Tee.Pos
    --p = Game.Players(Game.LocalCID).Tee.Pos
    if p.x > LocalPos.x then
      Game.Input.DummyDirection = 1
      NeedReset = true
    elseif p.x < LocalPos.x then
      Game.Input.DummyDirection = -1
      NeedReset = true
    end
  elseif Enable and distance(Pos.x, CampX) > 30 then
    if Game.Client.Tick % 60 == 0 then
      Game.Emote:DummySend(13)
    end
    if Pos.x > CampX then
      Game.Input.DummyDirection = -1
      NeedReset = true
    elseif Pos.x < CampX then
      Game.Input.DummyDirection = 1
      NeedReset = true
    end
  else
    local var2 = {3, 4}

    Length = var2[math.random(1, 2)]
    local var = {true, false}

    if var[math.random(1, 2)] then
      --Game.Input.DummyDirection = 1
    else
      --Game.Input.DummyDirection = 1
    end
  end
end

function FindRandomPos()

end