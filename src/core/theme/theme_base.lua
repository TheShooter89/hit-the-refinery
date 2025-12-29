require("utils.tables")

local class = require("lib.middleclass")

local ThemeVariant = require("core.theme.theme_variant")

local DEFAULT_VARIANT_PRIMARY = ThemeVariant:new({
	name = "primary",
})

local DEFAULT_VARIANT_HOVER = ThemeVariant:new({
	name = "hover",
})

---@class ThemeOptions
---@field current ThemeVariant
---@field primary ThemeVariant
---@field hover ThemeVariant
local DEFAULT_BUTTON_THEME_OPTIONS = {
	current = DEFAULT_VARIANT_PRIMARY,
}

---@class Theme
---@field current ThemeVariant
---@field new fun(opt: ThemeOptions): self
---@field initialize fun(self: self, opt: ThemeOptions): self
local Theme = class("Theme")

function Theme:initialize(opts)
	local options = merge_tables(DEFAULT_BUTTON_THEME_OPTIONS, opts)

	-- merge_tables(self, options)

	init_self_fields(self, {
		"current",
	}, options)
end

function Theme:setCurrent(theme_name)
	self.current = self[theme_name] or self.current
end

return Theme
