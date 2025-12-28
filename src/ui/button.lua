require("utils.tables")

local class = require("lib.middleclass")
local Entity = require("core.entity")

---@class ButtonThemeVariantOptions
---@field name string
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field mode string

local DEFAULT_BUTTON_THEME_VARIANT_PRIMARY = {
	name = "primary",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(0, 87, 183) },
	mode = "fill",
}

local DEFAULT_BUTTON_THEME_VARIANT_HOVER = {
	name = "hover",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(255, 215, 0) },
	mode = "line",
}

---@class ButtonThemeVariant
---@field name string
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field mode string
---@field new fun(opt: ButtonThemeVariantOptions): self
---@field initialize fun(self: self, opt: ButtonThemeVariantOptions): self
local ButtonThemeVariant = class("ButtonThemeVariant")

function ButtonThemeVariant:initialize(opts)
	init_self_fields(self, {
		"name",
		"background_color",
		"title_color",
		"mode",
	}, opts)
end

---@class ButtonThemeOptions
---@field current ButtonThemeVariant
---@field primary ButtonThemeVariant
---@field hover ButtonThemeVariant
local DEFAULT_BUTTON_THEME_OPTIONS = {
	current = DEFAULT_BUTTON_THEME_VARIANT_PRIMARY,
	primary = DEFAULT_BUTTON_THEME_VARIANT_PRIMARY,
	hover = DEFAULT_BUTTON_THEME_VARIANT_HOVER,
}

---@class ButtonTheme
---@field current ButtonThemeVariant
---@field primary ButtonThemeVariant
---@field hover ButtonThemeVariant
---@field new fun(opt: ButtonThemeOptions): self
---@field initialize fun(self: self, opt: ButtonThemeOptions): self
local ButtonTheme = class("ButtonTheme")

function ButtonTheme:initialize(opts)
	local options = merge_tables(DEFAULT_BUTTON_THEME_OPTIONS, opts)

	init_self_fields(self, {
		"current",
		"primary",
		"hover",
	}, options)
end

function ButtonTheme:setCurrent(theme_name)
	self.current = self[theme_name] or self.primary
end

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
