local Entity = require("core.entity")

MENU_X = 0
MENU_Y = 0
MENU_WIDTH = 360
MENU_HEIGHT = 300
MENU_PADDING = 30
MENU_BACKGROUND_COLOR = { love.math.colorFromBytes(0, 87, 183) }
MENU_TITLE_COLOR = { love.math.colorFromBytes(255, 215, 0) }

local Menu = class("Menu", Entity)

function Menu:initialize()
	Entity.initialize(self, MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT)
	self.padding = MENU_PADDING
	self.background_color = MENU_BACKGROUND_COLOR
	self.title_color = MENU_TITLE_COLOR
end

function Menu:draw()
	local window_width = love.graphics.getWidth()
	local window_height = love.graphics.getHeight()

	-- compute the origin so to have the menu both vertically and horizontally centered
	origin_x = (window_width - self.width) / 2
	origin_y = (window_height - self.height) / 2
	self.x = origin_x
	self.y = origin_y

	-- draw the menu
	love.graphics.setColor(self.background_color)
	love.graphics.rectangle("fill", origin_x, origin_y, self.width, self.height)

	-- draw the menu title
	local font = love.graphics.newFont("assets/fonts/vaguard.ttf", 48)
	love.graphics.setFont(font)
	-- local font = love.graphics.getFont()
	local title = "HIT-THE-REFINERY"
	local title_length = font:getWidth(title)
	title_x = self.x + ((self.width - title_length) / 2)
	title_y = self.y + self.padding
	love.graphics.setColor(self.title_color)
	love.graphics.print(title, title_x, self.y + self.padding)

	-- draw button
	local button = require("ui.button")
	btn_x = ((self.width - button.width) / 2) + self.x
	btn_y = title_y + font:getHeight(title) + (self.padding + 1.5)
	button.x = btn_x
	button.y = btn_y
	button:draw()
end

function Menu:update(dt)
	-- print("updating menu")
	local button = require("ui.button")
	button:update(dt)
end

return Menu
