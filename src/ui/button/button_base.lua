require("utils.tables")

local class = require("lib.middleclass")
local Entity = require("core.entity")

local ButtonTheme = require("ui.button.theme")

---@class ButtonOptions: EntityOptions
---@field text string
---@field padding number
---@field theme ButtonTheme
---@field is_clicked boolean
---@field _is_last_clicked boolean
local DEFAULT_BUTTON_OPTIONS = {
	text = "BUTTON",
	x = 0,
	y = 0,
	width = 140,
	height = 50,
	padding = 10,
	theme = ButtonTheme:new(),
	is_clicked = false,
	_is_last_clicked = false,
	on_click = function(dt)
		print("BUTTON CLICKED!")
		-- love.event.quit(0)
	end,
}

---@class Button: Entity
---@field text string
---@field padding number
---@field theme ButtonTheme
---@field on_click fun(self: self, dt: number): void
---@field new fun(opt: ButtonOptions): self
---@field initialize fun(self: self, opt: ButtonOptions): self
local Button = class("Button", Entity)

function Button:initialize(opts)
	options = merge_tables(DEFAULT_BUTTON_OPTIONS, opts)
	Entity.initialize(self, options)

	init_self_fields(self, {
		"text",
		"padding",
		"theme",
		"is_clicked",
		"_is_last_clicked",
		"on_click",
	}, options)
end

function Button:draw()
	love.graphics.setColor(self.theme.current.background_color)
	love.graphics.rectangle(self.theme.current.mode, self.x, self.y, self.width, self.height)

	-- draw the menu title
	local font = love.graphics.newFont("assets/fonts/vaguard.ttf", 32)
	love.graphics.setFont(font)

	local title = self.text
	local title_length = font:getWidth(title)
	local title_height = font:getHeight(title)
	title_x = self.x + ((self.width - title_length) / 2)
	title_y = self.y + ((self.height - title_height) / 2)

	love.graphics.setColor(self.theme.current.title_color)
	love.graphics.print(title, title_x, title_y)
end

function Button:update(dt)
	-- print("updating menu")
	local mx, my = love.mouse.getPosition()
	local hot = mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + self.height

	if hot then
		self.theme:setCurrent("hover")
	else
		self.theme:setCurrent("primary")
	end

	self._is_last_clicked = self.is_clicked

	if love.mouse.isDown(1) and hot then
		self.is_clicked = true
	end

	if self.is_clicked then
		if not self.is_clicked == self._is_last_clicked then
			self.on_click(self, dt)
			self.is_clicked = false
		end
	end
end

return Button
