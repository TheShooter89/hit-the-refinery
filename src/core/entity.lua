require("utils.tables")

local class = require("lib.middleclass")

---@class EntityOptions
---@field is_visible boolean
---@field x number
---@field y number
---@field width number
---@field height number
local DEFAULT_ENTITY_OPTS = {
	is_visible = true,
	x = 0,
	y = 0,
	width = 0,
	height = 0,
}

---@class Entity
---@field is_visible boolean
---@field x number
---@field y number
---@field width number
---@field height number
---@field new fun(opts: EntityOptions): self
---@field initialize fun(self: self, opts: EntityOptions): self
local Entity = class("Entity")

---@param opts EntityOptions
function Entity:initialize(opts)
	local options = merge_tables(DEFAULT_ENTITY_OPTS, opts)

	init_self_fields(self, {
		"is_visible",
		"x",
		"y",
		"width",
		"height",
	}, options)
end

return Entity
