require("utils.tables")

local class = require("lib.middleclass")

local ButtonThemeVariant = require("ui.button.theme_variant")

local DEFAULT_VARIANT_PRIMARY = ButtonThemeVariant:new({
	name = "primary",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(0, 87, 183) },
	mode = "fill",
})

local DEFAULT_VARIANT_HOVER = ButtonThemeVariant:new({
	name = "hover",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(255, 215, 0) },
	mode = "line",
})

---@class ButtonThemeOptions
---@field current ButtonThemeVariant
---@field primary ButtonThemeVariant
---@field hover ButtonThemeVariant
local DEFAULT_BUTTON_THEME_OPTIONS = {
	current = DEFAULT_VARIANT_PRIMARY,
	primary = DEFAULT_VARIANT_PRIMARY,
	hover = DEFAULT_VARIANT_HOVER,
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

return ButtonTheme
