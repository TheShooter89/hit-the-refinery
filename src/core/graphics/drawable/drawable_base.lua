require("utils.tables")
require("utils.validation")

local class = require("lib.middleclass")

local DrawableRenderOpts, DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN =
	table.unpack(require("core.graphics.drawable.render_opts"))

local DrawableUpdateOpts, DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN =
	table.unpack(require("core.graphics.drawable.update_opts"))

---@alias DrawableChildrenProps string[]
local DEFAULT_DRAWABLE_CHILDREN_PROPS = {
	"children",
}

---@class DrawableProps
---@field id number
---@field is_visible boolean
---@field render_opts DrawableRenderOpts
---@field update_opts DrawableUpdateOpts
---@field _props_with_children DrawableChildrenProps
local DEFAULT_DRAWABLE_PROPS = {
	id = nil,
	is_visible = true,
	render_opts = DrawableRenderOpts:new(),
	update_opts = DrawableUpdateOpts:new(),
	_props_with_children = DEFAULT_DRAWABLE_CHILDREN_PROPS,
}

---@class Drawable
---@field id number
---@field is_visible boolean
---@field render_opts DrawableRenderOpts
---@field update_opts DrawableUpdateOpts
---@field _props_with_children DrawableChildrenProps
---@field new fun(props: DrawableProps): self
---@field initialize fun(self: self, props: DrawableProps, props_with_children: DrawableChildrenProps): self
local Drawable = class("Drawable")

---@param props DrawableProps
function Drawable:initialize(props, props_with_children)
	local object_props = merge_tables(DEFAULT_DRAWABLE_PROPS, props)

	if not object_props.id then
		object_props.id = uuid.v4()
	end

	object_props._props_with_children = props_with_children or DEFAULT_DRAWABLE_CHILDREN_PROPS

	init_self_fields(self, {
		"id",
		"is_visible",
		"render_opts",
		"update_opts",
		"_props_with_children",
	}, object_props)
end

function Drawable:_draw_children(opts, parent)
	local children_opts = merge_tables(DEFAULT_DRAWABLE_RENDER_OPTS_CHILDREN, opts)

	if not parent then
		parent = self
	end

	for _, child_prop in pairs(self._props_with_children) do
		if self[child_prop] then
			-- INFO: draw each children
			for _, child in pairs(self[child_prop]) do
				-- INFO: if there's a filter function set in the render options for children
				--       call it to exclude current child from rendering if filter match
				if is_function(children_opts.filter) and children_opts.filter(child, parent) then
					print("child filtered out, id: " .. tostring(child.id))
				elseif not child.is_visible then
					print("child is not visible, id: " .. tostring(child.id))
				else
					-- INFO: if there's a function set in the render options for children
					--       call it to get the mapped opts to pass to child draw function
					if is_function(children_opts.map) then
						local c_opts = children_opts.map(child, parent)
						child:draw(c_opts, parent)
					else
						child:draw(opts, parent)
					end
				end
			end
		end
	end
end

function Drawable:draw(options, parent)
	print("drawing entity #" .. self.id)
end

function Drawable:render(options, parent)
	print("[DRAWABLE RENDER] rendering entity #" .. self.id)
	self:draw(self.render_opts.parent_opts, parent)
	self:_draw_children(self.render_opts.children_opts, parent)
end

function Drawable:_update_children(dt, opts, parent)
	local children_opts = merge_tables(DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN, opts)

	if not parent then
		parent = self
	end

	for _, child_prop in pairs(self._props_with_children) do
		if self[child_prop] then
			-- INFO: draw each children
			for _, child in pairs(self[child_prop]) do
				-- INFO: if there's a filter function set in the render options for children
				--       call it to exclude current child from rendering if filter match
				if is_function(children_opts.filter) and children_opts.filter(child, parent) then
					print("child filtered out, id: " .. tostring(child.id))
				elseif not child.is_visible then
					print("child is not visible, id: " .. tostring(child.id))
				else
					-- INFO: if there's a function set in the render options for children
					--       call it to get the mapped opts to pass to child draw function
					if is_function(children_opts.map) then
						local c_opts = children_opts.map(child, parent)
						child:update(dt, c_opts, parent)
					else
						child:update(dt, opts, parent)
					end
				end
			end
		end
	end
end

function Drawable:update(dt, options, parent)
	print("updating entity #" .. self.id)
end

function Drawable:update_all(dt, options, parent)
	print("[DRAWABLE UPDATE] updating entity #" .. self.id)
	print("[DRAWABLE UPDATE ALL] options: " .. inspect(options))
	local parent_instance = parent or self

	-- FIX: options is always nil, WHY?
	-- if options then
	-- 	local children_opts = merge_tables(DEFAULT_DRAWABLE_UPDATE_OPTS_CHILDREN, options)
	-- 	self:update(dt, children_opts.parent_opts, parent_instance)
	-- 	self:_update_children(dt, children_opts.children_opts, parent_instance)
	-- else
	-- 	self:update(dt, self.update_opts.parent_opts, parent_instance)
	-- 	self:_update_children(dt, self.update_opts.children_opts, parent_instance)
	-- end

	self:update(dt, self.update_opts.parent_opts, parent_instance)
	self:_update_children(dt, self.update_opts.children_opts, parent_instance)
end

return Drawable
