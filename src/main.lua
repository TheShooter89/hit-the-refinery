dofile("setup.lua")

require("love")
inspect = require("lib.inspect")
class = require("lib.middleclass")

uuid = require("lib.uuid")
uuid.rng.math_randomseed(tostring(os.time()))
uuid.set_rng(uuid.rng.math_random())

State = require("core.state")
Modes = require("core.modes")
Theme = require("core.theme")
Menu = require("ui.menu")

Tests = require("test")

print("+-------------------+")
print("| HIT THE REFINERY! |")
print("+-------------------+")
print("coded with <3 by tanque")

function love.load()
	game_state = State:new()
	print("GAME MODE: " .. game_state.mode)

	Tests:load()

	-- menu = require("ui.menu")
	menu = Menu:new()
end

function love.update(dt)
	Tests:update(dt)

	if game_state.mode == Modes.START then
		menu:update(dt)
	elseif game_state.mode == Modes.RUNNING then
		-- test_drawable:update_all(dt, external_update_opts)
	elseif game_state.mode == Modes.PAUSE then
		menu:update(dt)
	end
end

function love.draw()
	Tests:draw()

	if game_state.mode == Modes.START then
		menu:draw()
	elseif game_state.mode == Modes.PAUSE then
		menu:draw()
		-- test_drawable:render()
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
