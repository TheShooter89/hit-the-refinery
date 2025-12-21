dofile("setup.lua")

require("love")
class = require("lib.middleclass")

Modes = require("core.modes")
Menu = require("ui.menu")

print("+-------------------+")
print("| HIT THE REFINERY! |")
print("+-------------------+")
print("coded with <3 by tanque")

function love.load()
	game_state = require("core.state")
	print("GAME MODE: " .. game_state.mode)

	menu = require("ui.menu")
end

function love.update(dt)
	if game_state.mode == Modes.START then
		menu:update(dt)
	elseif game_state.mode == Modes.PAUSE then
		menu:update(dt)
	end
end

function love.draw()
	if game_state.mode == Modes.START then
		menu:draw()
	elseif game_state.mode == Modes.PAUSE then
		menu:draw()
	end
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
