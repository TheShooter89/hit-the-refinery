local class = require("lib.middleclass")

local Entity = class("Entity")

function Entity:initialize(x, y, width, height)
	self.x, self.y, self.width, self.height = x, y, width, height
end

return Entity
