Drawable = require("core.graphics.drawable")

local test_drawable = {}

function test_drawable:load()
	--
	local render_opts = {
		parent_opts = {},
		children_opts = {
			-- filter = {},
			filter = function(child, parent)
				--
				return child.id == "test_child_2"
			end,
			map = function(child, parent)
				--
				return { test_opt = "[MAPPED CHILD RENDER] test_opt" }
			end,
		},
	}

	local update_opts = {
		parent_opts = {},
		children_opts = {
			-- filter = {},
			filter = function(child, parent)
				--
				return child.id == "test_child_2"
			end,
			map = function(child, parent)
				--
				return { test_opt = "[MAPPED CHILD UPDATE] test_opt" }
			end,
		},
	}

	local external_update_opts = {
		parent_opts = {},
		children_opts = {
			-- filter = {},
			filter = function(child, parent)
				--
				return child.id == "test_child_2"
			end,
			map = function(child, parent)
				--
				return { test_opt = "[MAPPED CHILD UPDATE] EXTERNAL test_opt" }
			end,
		},
	}

	test_drawable = Drawable:new({ render_opts = render_opts, update_opts = update_opts })

	test_child_1 = { id = "test_child_1", is_visible = true }
	function test_child_1:draw(opts, parent)
		print("drawing test child 1")
		if opts.test_opt then
			print("drawing test child 1 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end
	function test_child_1:update(dt, opts, parent)
		print("updating test child 1")
		print("[DEBUG TEST_CHILD UPDATE] opts: " .. inspect(opts))
		if opts.test_opt then
			print("updating test child 1 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end

	test_child_2 = { id = "test_child_2", is_visible = true }
	function test_child_2:draw(opts, parent)
		print("drawing test child 2")
		if opts.test_opt then
			print("drawing test child 2 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end
	function test_child_2:update(dt, opts, parent)
		print("updating test child 2")
		if opts.test_opt then
			print("updating test child 2 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end

	test_child_3 = { id = "test_child_3", is_visible = false }
	function test_child_3:draw(opts, parent)
		print("drawing test child 3")
		if opts.test_opt then
			print("drawing test child 3 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end
	function test_child_3:update(dt, opts, parent)
		print("updating test child 3")
		if opts.test_opt then
			print("updating test child 3 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end

	test_child_4 = { id = "test_child_4", is_visible = true }
	function test_child_4:draw(opts, parent)
		print("drawing test child 4")
		if opts.test_opt then
			print("drawing test child 4 - opts.test_opt: " .. tostring(opts.test_opt))
		end
	end
	function test_child_4:update(dt, opts, parent)
		print("updating test child 4")
		if opts.test_opt then
			print("updating test child 4 - opts.test_opt: " .. tostring(opts.test_opt))
		end
		-- if parent then
		-- 	print("updating test child 4 - parent: " .. inspect(parent))
		-- end
	end

	test_drawable.children = {
		test_child_1,
		test_child_2,
		test_child_3,
		test_child_4,
	}
end

function test_drawable:draw()
	--
	if game_state.mode == Modes.PAUSE then
		test_drawable:render()
	end
end

function test_drawable:update(dt)
	--
	if game_state.mode == Modes.RUNNING then
		test_drawable:update_all(dt, external_update_opts)
	end
end

return test_drawable
