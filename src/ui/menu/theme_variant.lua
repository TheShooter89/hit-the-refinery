require("utils.tables")

local class = require("lib.middleclass")

local ThemeVariant = require("core.theme.theme_variant")

---@class MenuThemeVariantOptions
---@field name string
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field mode string

local DEFAULT_THEME_VARIANT = {
	name = "primary",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(0, 87, 183) },
	mode = "fill",
}

---@class MenuThemeVariant: ThemeVariant
---@field name string
---@field background_color {r: number, g: number, b: number}
---@field title_color  {r: number, g: number, b: number}
---@field mode string
---@field new fun(opt: MenuThemeVariantOptions): self
---@field initialize fun(self: self, opt: MenuThemeVariantOptions): self
local MenuThemeVariant = class("MenuThemeVariant", ThemeVariant)

function MenuThemeVariant:initialize(opts)
	local options = merge_tables(DEFAULT_THEME_VARIANT, opts)

	ThemeVariant.initialize(self, options)

	init_self_fields(self, {
		-- "name",
		"background_color",
		"title_color",
		"mode",
	}, options)
end

return MenuThemeVariant
