require("utils.tables")
require("utils.validation")

local class = require("lib.middleclass")

---@class DrawableUpdateOptsParent
local DEFAULT_DRAWABLE_UPDATE_OPTS_PARENT = {}

---@class DrawableUpdateMapObject

---@type DrawableUpdateMapFunction fun(child, parent): DrawableUpdateMapObject

---@type DrawableUpdateFilterFunction fun(child, parent): boolean

---@class DrawableUpdateOptsChildren
---@field map DrawableUpdateMapObject | DrawableUpdateMapFunction
---@field filter DrawableUpdateFilterFunction
local DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN = {
	map = {},
	filter = {},
}

---@class DrawableUpdateOptsConfig
---@field parent_opts DrawableUpdateOptsParent
---@field children_opts DrawableUpdateOptsChildren
local DEFAULT_DRAWABLE_UPDATE_OPTS_CONFIG = {
	parent_opts = DEFAULT_DRAWABLE_UPDATE_OPTS_PARENT,
	children_opts = DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN,
}

---@class DrawableUpdateOpts
---@field parent_opts DrawableUpdateOptsParent
---@field children_opts DrawableUpdateOptsChildren
---@field new fun(opts: DrawableUpdateOptsConfig): self
---@field initialize fun(self: self, opts: DrawableUpdateOptsConfig): self
local DrawableUpdateOpts = class("DrawableUpdateOpts")

---@param opts DrawableUpdateOpts
function DrawableUpdateOpts:initialize(opts)
	local object_opts = merge_tables(DEFAULT_DRAWABLE_UPDATE_OPTS_CONFIG, opts)

	init_self_fields(self, {
		"parent_opts",
		"children_opts",
	}, object_opts)
end

return {
	DrawableUpdateOpts,
	DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN,
}
