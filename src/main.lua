dofile("setup.lua")

require("love")

Modes = require("core.modes")

print("+-------------------+")
print("| HIT THE REFINERY! |")
print("+-------------------+")
print("coded with <3 by tanque")

function love.load()
	game_state = require("core.state")
	print("GAME MODE: " .. game_state.mode)
end

function love.update(dt)
	--
end

function love.draw()
	--
end

function love.keypressed(key)
	if key == "escape" then
		if game_state.mode == Modes.START then
			print("GAME MODE: " .. game_state.mode)
		elseif game_state.mode == Modes.PAUSE then
			game_state.mode = Modes.RUNNING
			print("GAME MODE: " .. game_state.mode)
		else
			game_state.mode = Modes.PAUSE
			print("GAME MODE: " .. game_state.mode)
		end
	end

	if key == "space" then
		if game_state.mode == Modes.START then
			game_state.mode = Modes.RUNNING
			print("GAME MODE: " .. game_state.mode)
		end
	end
end
