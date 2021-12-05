g_ScriptTitle = "bot"
g_ScriptInfo = "BOT"

Import("twdata")

NeedReset = false
LastWeapon = WEAPON_HAMMER

RIGHT=1
LEFT=-1
NONE=0

x = 0
y = 0

Disable = false
Save = false
Run = false

function OnKeyPress(key)
  if key == "mouse3" then
    Disable = true
  end
end

function OnKeyRelease(key)
  if key == "mouse3" then
    Disable = false
  end
end

function IsFreezeTile(x, y)
	local TILE_FREEZE = -1
	local gm = string.lower(Game.ServerInfo.GameMode)
	if(gm == "idd32+" or gm == "ddnet" or string.find(gm, "race") ~= nil) then
		TILE_FREEZE = 9
	elseif(gm == "if|city") then
		TILE_FREEZE = 191
	elseif(gm == "dm" or gm == "tdm" or gm == "ctf") then
		TILE_FREEZE = 2 -- kill
	end	
	return Game.Collision:GetTile(x, y) == TILE_FREEZE or Game.Collision:GetTile(x, y) == 2
end

function checkRightTopCorner()
  if IsFreezeTile(x+32, y-32) then
    avoid(LEFT)
  end
end

function checkRightBottomCorner()
  if IsFreezeTile(x+32, y+32) then
    avoid(LEFT)
  end
end

function checkLeftTopCorner()
  if IsFreezeTile(x-32, y-32) then
    avoid(RIGHT)
  end
end

function checkLeftBottomCorner()
  if IsFreezeTile(x-32, y+32) then
    avoid(RIGHT)
  end
end

function checkRight()
  if IsFreezeTile(x+32, y) or (not IsSolid(x+32, y) and IsFreezeTile(x+64, y)) then
    avoid(LEFT)
  end
end

function checkLeft()
  if IsFreezeTile(x-32, y) or (not IsSolid(x-32, y) and IsFreezeTile(x-64, y)) then
    avoid(RIGHT)
  end
end

function avoid(dir)
  Game.Input.Direction = dir
  NeedReset = true
end

function IsSolid(x, y)
  local c = Game.Collision:GetTile(x, y)
	if (c == 1 or c == 5) then
		return true
	end
	return false
end

function checkTopFreeze()
  Sens = 13
  for i = math.abs(math.floor(Game.LocalTee.Vel.y)),1,-1
  do
    if IsFreezeTile(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-(i*Sens)) then
      return true
    end
  end
  return false
end

function convertWeapon()
  weap = Game.CharSnap(Game.LocalCID).Cur.Weapon
  if weap == 1 then
    return WEAPON_HAMMER
  elseif weap == 2 then
    return WEAPON_SHOTGUN
  elseif weap == 3 then
    return WEAPON_SHOTGUN
  elseif weap == 4 then
    return WEAPON_GRENADE
  elseif weap == 5 then
    return WEAPON_RIFLE
  else
    return WEAPON_NINJA
  end
end

function OnTick()
  if Disable or Game.CharSnap(Game.LocalCID).Cur.Weapon == 5 then
    return
  end

  if NeedReset then
    Game.Input.Direction = 0
    Game.Input.Fire = 0
    --Game.Input.WantedWeapon = LastWeapon
    NeedReset = false
    return
  end

  x = Game.LocalTee.Pos.x
  y = Game.LocalTee.Pos.y
  velx = Game.LocalTee.Vel.x/32
  vely = Game.LocalTee.Vel.y/32
 
  checkLeft()
  checkRight()
  
  if Run then
    Game.Input.Fire = 1
    Run = false
    NeedReset = true
    return
  end
  
  if Save then
    Game.Input.WantedWeapon = 4
    Save = false
    Run = true
    return
  end

  --if checkTopFreeze() then
    --LastWeapon = Game.CharSnap(Game.LocalCID).Cur.Weapon
    --Game.Input.MouseX = 0
    --Game.Input.MouseY = -100
    --Save = true
    --return
  --end

  --checkLeftTopCorner()
  --checkLeftBottomCorner()
  --checkRightTopCorner()
  --checkRightBottomCorner()
end
