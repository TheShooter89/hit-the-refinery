require("utils.tables")
local class = require("lib.middleclass")

local Modes = require("core.modes")

---@class StateOptions
---@field mode Modes
local DEFAULT_STATE_OPTIONS = {
	mode = Modes.START,
}

---@class State
---@field opts StateOptions
local State = class("State")

function State:initialize(opts)
	local options = merge_tables(DEFAULT_STATE_OPTIONS, opts)

	merge_tables(self, options)
end

return State
