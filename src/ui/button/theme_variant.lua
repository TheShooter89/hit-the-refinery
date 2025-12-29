require("utils.tables")

local class = require("lib.middleclass")

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
	local options = merge_tables(DEFAULT_BUTTON_THEME_VARIANT_PRIMARY, opts)

	init_self_fields(self, {
		"name",
		"background_color",
		"title_color",
		"mode",
	}, options)
end

return ButtonThemeVariant
