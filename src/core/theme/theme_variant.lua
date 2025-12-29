require("utils.tables")

local class = require("lib.middleclass")

---@class ThemeVariantOptions
---@field name string

local DEFAULT_BUTTON_THEME_VARIANT_PRIMARY = {
	name = "primary",
}

local DEFAULT_BUTTON_THEME_VARIANT_HOVER = {
	name = "hover",
}

---@class ThemeVariant
---@field name string
---@field new fun(opt: ThemeVariantOptions): self
---@field initialize fun(self: self, opt: ThemeVariantOptions): self
local ThemeVariant = class("ThemeVariant")

function ThemeVariant:initialize(opts)
	local options = merge_tables(DEFAULT_BUTTON_THEME_VARIANT_PRIMARY, opts)

	init_self_fields(self, {
		"name",
	}, options)
end

return ThemeVariant
