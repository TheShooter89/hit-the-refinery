require("utils.tables")

local class = require("lib.middleclass")
local Entity = require("core.entity")

---@class ButtonOptions: EntityOptions
---@field padding number
---@field mode string
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field is_over boolean
---@field hover_background_color {r: number, g: number, b: number}
---@field hover_title_color  {r: number, g: number, b: number}
---@field text string
local DEFAULT_BUTTON_OPTIONS = {
	x = 0,
	y = 0,
	width = 140,
	height = 50,
	padding = 10,
	mode = "fill",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(0, 87, 183) },
	is_over = false,
	hover_background_color = { love.math.colorFromBytes(255, 215, 0) },
	hover_title_color = { love.math.colorFromBytes(255, 215, 0) },
}

---@class Button: Entity
---@field padding number
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field mode string
---@field text string
---@field new fun(opt: ButtonOptions): self
---@field initialize fun(self: self, opt: ButtonOptions): self
local Button = class("Button", Entity)

function Button:initialize(opts)
	options = merge_tables(DEFAULT_BUTTON_OPTIONS, opts)
	Entity.initialize(self, options)

	self.padding = options.padding
	self.background_color = options.background_color
	self.title_color = options.title_color
	self.is_hover = options.is_hover
	self.hover_background_color = options.hover_background_color
	self.hover_title_color = options.hover_title_color
	self.mode = options.mode
	self.text = options.text
end

function Button:draw()
	-- draw the menu
	if self.is_hover then
		love.graphics.setColor(self.hover_background_color)
	else
		love.graphics.setColor(self.background_color)
	end
	love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height)

	-- draw the menu title
	local font = love.graphics.newFont("assets/fonts/vaguard.ttf", 32)
	love.graphics.setFont(font)
	-- local font = love.graphics.getFont()
	local title = self.text
	local title_length = font:getWidth(title)
	local title_height = font:getHeight(title)
	title_x = self.x + ((self.width - title_length) / 2)
	title_y = self.y + ((self.height - title_height) / 2)
	-- love.graphics.setColor(self.title_color)

	if self.is_hover then
		love.graphics.setColor(self.hover_title_color)
	else
		love.graphics.setColor(self.title_color)
	end
	love.graphics.print(title, title_x, title_y)
end

function Button:update(dt)
	-- print("updating menu")
	local mx, my = love.mouse.getPosition()
	local hot = mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + self.height

	if hot then
		self.is_hover = true
		self.mode = "line"
	else
		self.is_hover = false
		self.mode = "fill"
	end
end

return Button
