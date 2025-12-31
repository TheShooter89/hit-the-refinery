require("utils.tables")

local class = require("lib.middleclass")
local Theme = require("core.theme")

local MenuThemeVariant = require("ui.menu.theme_variant")

local DEFAULT_VARIANT_PRIMARY = MenuThemeVariant:new({
	name = "primary",
	background_color = { love.math.colorFromBytes(255, 215, 0) },
	title_color = { love.math.colorFromBytes(0, 87, 183) },
	mode = "fill",
})

---@class MenuThemeOptions
---@field current MenuThemeVariant
---@field primary MenuThemeVariant
local DEFAULT_BUTTON_THEME_OPTIONS = {
	current = DEFAULT_VARIANT_PRIMARY,
	primary = DEFAULT_VARIANT_PRIMARY,
}

---@class MenuTheme: Theme
---@field current MenuThemeVariant
---@field primary MenuThemeVariant
---@field new fun(opt: MenuThemeOptions): self
---@field initialize fun(self: self, opt: MenuThemeOptions): self
local MenuTheme = class("MenuTheme", Theme)

function MenuTheme:initialize(opts)
	local options = merge_tables(DEFAULT_BUTTON_THEME_OPTIONS, opts)

	-- if only primary theme is provided,
	-- set it as current theme automatically
	if opts.primary and not opts.current then
		options.current = opts.primary
	end

	Theme.initialize(self, options)

	init_self_fields(self, {
		"current",
		"primary",
	}, options)
end

return MenuTheme
