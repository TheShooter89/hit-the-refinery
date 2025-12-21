local function Offset(x, y, width, height)
	--
	return {
		x = x,
		y = y,
		width = width,
		height = height,
	}
end

local function Position(x, y, width, height, offset)
	offset = offset or Offset(0, 0, 0, 0)

	return {
		x = x,
		y = y,
		width = width,
		height = height,
		offset = offset,
		update = function(self, dt)
			print("updating menu")
		end,
		draw = function(self)
			print("drawing menu")
		end,
	}
end

return { Position, Offset }
