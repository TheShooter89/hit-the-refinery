BUTTON_X = 0
BUTTON_Y = 0
BUTTON_WIDTH = 140
BUTTON_HEIGHT = 50
BUTTON_PADDING = 10
BUTTON_BACKGROUND_COLOR = { love.math.colorFromBytes(255, 215, 0) }
BUTTON_TITLE_COLOR = { love.math.colorFromBytes(0, 87, 183) }

local Button = {
	text = "BUTTON",
	mode = "fill",
	x = BUTTON_X,
	y = BUTTON_Y,
	width = BUTTON_WIDTH,
	height = BUTTON_HEIGHT,
	padding = BUTTON_PADDING,
	background_color = BUTTON_BACKGROUND_COLOR,
	title_color = BUTTON_TITLE_COLOR,
}

function Button.draw(self)
	-- draw the menu
	love.graphics.setColor(self.background_color)
	love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height)

	-- draw the menu title
	local font = love.graphics.newFont("assets/fonts/vaguard.ttf", 32)
	love.graphics.setFont(font)
	-- local font = love.graphics.getFont()
	local title = self.text
	local title_length = font:getWidth(title)
	local title_height = font:getHeight(title)
	title_x = self.x + ((self.width - title_length) / 2)
	title_y = self.y + ((self.height - title_height) / 2)
	love.graphics.setColor(self.title_color)
	love.graphics.print(title, title_x, title_y)
end

function Button.update(self, dt)
	-- print("updating menu")
	local mx, my = love.mouse.getPosition()
	local hot = mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + self.height

	if hot then
		-- self.background_color = { love.math.colorFromBytes(0, 87, 183) }
		self.background_color = { love.math.colorFromBytes(255, 215, 0) }
		self.title_color = { love.math.colorFromBytes(255, 215, 0) }
		self.mode = "line"
	else
		self.background_color = BUTTON_BACKGROUND_COLOR
		self.title_color = BUTTON_TITLE_COLOR
		self.mode = "fill"
	end
end

return Button
