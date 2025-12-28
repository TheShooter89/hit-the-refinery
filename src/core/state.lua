require("utils.tables")
local class = require("lib.middleclass")

local Modes = require("core.modes")
local User = require("core.user")

---@class StateOptions
---@field mode Modes
---@field user User
local DEFAULT_STATE_OPTIONS = {
	mode = Modes.START,
	user = User:new({ name = "Primeagen" }),
}

---@class State
---@field opts StateOptions
local State = class("State")

function State:initialize(opts)
	local options = merge_tables(DEFAULT_STATE_OPTIONS, opts)

	merge_tables(self, options)
end

return State
