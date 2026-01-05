local test_drawable = require("test.test_drawable")

local Tests = {}

function Tests:load()
	test_drawable:load()
	--
end

function Tests:draw()
	test_drawable:draw()
	--
end

function Tests:update(dt)
	test_drawable:update(dt)
	--
end

return Tests
