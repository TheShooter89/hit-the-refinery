require("utils.tables")
require("utils.validation")

local class = require("lib.middleclass")

---@class DrawableRenderOptsParent
local DEFAULT_DRAWABLE_RENDER_OPTS_PARENT = {}

---@class DrawableRenderMapObject

---@type DrawableRenderMapFunction fun(child, parent): DrawableRenderMapObject

---@type DrawableRenderFilterFunction fun(child, parent): boolean

---@class DrawableRenderOptsChildren
---@field map DrawableRenderMapObject | DrawableRenderMapFunction
---@field filter DrawableRenderFilterFunction
local DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN = {
	map = {},
	filter = {},
}

---@class DrawableRenderOptsConfig
---@field parent_opts DrawableRenderOptsParent
---@field children_opts DrawableRenderOptsChildren
local DEFAULT_DRAWABLE_RENDER_OPTS_CONFIG = {
	parent_opts = DEFAULT_DRAWABLE_RENDER_OPTS_PARENT,
	children_opts = DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN,
}

---@class DrawableRenderOpts
---@field parent_opts DrawableRenderOptsParent
---@field children_opts DrawableRenderOptsChildren
---@field new fun(opts: DrawableRenderOptsConfig): self
---@field initialize fun(self: self, opts: DrawableRenderOptsConfig): self
local DrawableRenderOpts = class("DrawableRenderOpts")

---@param opts DrawableRenderOpts
function DrawableRenderOpts:initialize(opts)
	local object_opts = merge_tables(DEFAULT_DRAWABLE_RENDER_OPTS_CONFIG, opts)

	init_self_fields(self, {
		"parent_opts",
		"children_opts",
	}, object_opts)
end

return {
	DrawableRenderOpts = DrawableRenderOpts,
	DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN = DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN,
}
