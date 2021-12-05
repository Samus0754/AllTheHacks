SetScriptTitle("bot")

Import("twutils")
Import("math")
Import("types")

local dir = 0

function OnTick()
	if not Active then return end

	ResetInput()

	rawx = Game.LocalTee.Pos.x
	rawy = Game.LocalTee.Pos.y
	x = rawx/32
	y = rawy/32
	velx = Game.LocalTee.Vel.x
	vely = Game.LocalTee.Vel.y

	if x > 451 and x < 472 and y > 74 and y < 85 then
		dir = -1

		if x > 454 and x < 458 then
			Game.Input.Jump = 1
		else
			Game.Input.Jump = 0
		end
	elseif x < 240 and y < 36 then
		if x < 24 and y < 14 and x > 23 then
			s = 1
		elseif x < 25 and y < 14 and x > 24 then
			s = 2
		elseif x < 26 and y < 14 and x > 25 then
			s = 3
		end

		if y > 25 and x > 43 and y < 35 then
			Kill()
			return
		end
		if y > 35 and x < 43 then
			Kill()
			return
		end
		if x < 16 then
			Kill()
			return
		end
		if y > 25 then
			Game.Input.MouseX = 100
			if s == 1 then
				Game.Input.MouseY = -20
			else
				Game.Input.MouseY = 1
			end
			dir = 1
			Game.Input.Hook = 1

			if x > 25 and x < 33 and y > 30 then
				Game.Input.WantedWeapon = 4

				if s == 1 then
					Game.Input.MouseX = 190
					Game.Input.MouseY = 70
				elseif s == 2 then
					Game.Input.MouseX = 190
					Game.Input.MouseY = 70
				elseif s == 3 then
					Game.Input.MouseX = 190
					Game.Input.MouseY = 80
				end

				if x > 31 then
					Game.Input.Jump = 1
					Game.Input.Fire = 1
				end
			end
			if x < 33 and x > 31 and y < 29 then
				Game.Input.Hook = 0
			end
		elseif x > 33 and x < 50 and y > 18 then
			Game.Input.WantedWeapon = 4
			dir = 1
			if x > 33 and x < 42 and y > 20 and y < 25 then
				Emote(14)
			end
			if x < 50 then
				Game.Input.Jump = 1
			end
			if x > 47 and x < 50 and y > 17 then
				dir = -1
			end
		elseif y < 16 and x < 75 and x > 40 then
			dir = 1
			Game.Input.Jump = 0
			if y > 10 and x > 55 and x < 56 then
				Game.Input.Jump = 1
			end
		end
		if y > 15 and x > 55 and x < 65 then
			dir = 1
			if x > 63 then
				Game.Input.Jump = 1
			end
		end
		if y > 20 and y < 25 then
			if x > 67 then
				Game.Input.MouseX = -20
			else
				Game.Input.MouseX = 20
			end
			Game.Input.MouseY = 100
			if x > 69 then
				dir = -1
			end
			if IsGrounded() then
				Game.Input.Jump = 1
			end
			if rawy < 23*32 + 20 and vely < -1.11 then
				Game.Input.Fire = 1
			end
		elseif x > 75 and x < 135 then
			Game.Input.Jump = 0
			dir = 1
			if x > 77 and y > 13 and x < 80 then
				Game.Input.Jump = 1
			end
			if ((x > 80 and x < 90) or (x > 104 and x < 117)) then
				if y < 10 then
					Game.Input.Fire = 1
				end
				if velx > 12 then
					Game.Input.MouseX = -10
				else
					Game.Input.MouseX = -100
				end
				Game.Input.MouseY = -180
			end
			if x > 92 and y > 12.5 then
				Game.Input.MouseX = 100
				Game.Input.MouseY = -100
				Game.Input.Hook = 1
				if y < 14 and x > 100 and x < 110 then
					Game.Input.Hook = 0
				end
			end
			if x > 94 and y > 14.30 then
				Game.Input.MouseX = -100
				Game.Input.MouseY = 100
				Game.Input.Fire = 1
			end
			if x > 127 and x < 138 and velx > 12 and vely < -1.5 then
				Game.Input.Hook = 0
			end
			if x > 120 and y < 13 then
				Game.Input.Hook = 0
			end
		elseif x > 135 and x < 218 then
			Game.Input.WantedWeapon = 4
			dir = 1
			if x < 220 then
				if ((rawy > 12*32 + 10 and vely > 4.1) or (rawy > 12*32 + 30 and vely > -1.1)) then
					if Game.LocalTee.HookState == 4 or Game.LocalTee.HookState == 5 then
						Game.Input.MouseX = -100
						Game.Input.MouseY = 100
						Game.Input.Fire = 1
					else
						Game.Input.MouseX = 100
						Game.Input.MouseY = -200
					end
					Game.Input.Hook = 1
					if y < 12 then
						Game.Input.Hook = 0
					end
					if x > 212 then
						Game.Input.Hook = 1
						Game.Input.MouseX = 100
						Game.Input.MouseY = -75
						Game.Input.Jump = 1
					end
				end
			end
		end
	end

	if dir == 2 then
		Game.Input.Direction = 0
		dir = 0
	end

	if dir == -1 then
		Game.Input.Direction = -1
		dir = 2
	elseif dir == 1 then
		Game.Input.Direction = 1
		dir = 2
	end
end

function OnKeyPress(key)
	if key == "f" and Game.Input:Playing() and Game.GameConsole:IsClosed() then
		ResetInput()
		Game.Input.Direction = 0
		if not Active then
			Active = true
		else
			Active = false
		end
	end
end


function Kill()
	Game.Console:ExecuteLine("kill")
end 

function IsFokko()
	return Game.ServerInfo.Name == "fokkonaut's playground"
end

function ResetInput()
	Game.Input.Direction = 0
	Game.Input.Jump = 0
	Game.Input.Hook = 0
	Game.Input.Fire = 0
end

function Emote(emote)
	Game.Emote:Send(emote)
end