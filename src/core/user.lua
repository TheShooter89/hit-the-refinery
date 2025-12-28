require("utils.tables")

local class = require("lib.middleclass")

---@class UserOptions
---@field name string
---@field level number
---@field score number
local DEFAULT_USER_OPTS = {
	name = "PLAYER_1",
	level = 0,
	score = 0,
}

---@class User
---@field name string
---@field level number
---@field score number
---@field new fun(opts: UserOptions): self
---@field initialize fun(self: self, opts: UserOptions): self
local User = class("User")

---@param opts UserOptions
function User:initialize(opts)
	local options = merge_tables(DEFAULT_USER_OPTS, opts)

	init_self_fields(self, {
		"name",
		"level",
		"score",
	}, options)
end

return User
