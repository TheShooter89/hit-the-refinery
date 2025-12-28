local class = require("lib.middleclass")

---@class EntityOptions
---@field x number
---@field y number
---@field width number
---@field height number

---@class Entity
---@field x number
---@field y number
---@field width number
---@field height number
---@field new fun(opts: EntityOptions): self
---@field initialize fun(self: self, opts: EntityOptions): self
local Entity = class("Entity")

---@param opts EntityOptions
function Entity:initialize(opts)
	self.x, self.y, self.width, self.height = opts.x, opts.y, opts.width, opts.height
end

return Entity
