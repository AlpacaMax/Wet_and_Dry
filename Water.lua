local WATER_COLOR = {
	red		= 7/255,
	green = 42/255,
	blue	= 200/255,
	alpha = 0.3
}

local WATER_SIDE = 30

Water = GameObj:extend()

function Water:new(x, y)
	Water.super.new(self, x, y, WATER_SIDE, WATER_COLOR)
end

function Water:draw()
	love.graphics.setColor(
		self.color.red,
		self.color.green,
		self.color.blue,
		self.color.alpha
	)
	love.graphics.rectangle("fill", self.x, self.y, self.side, self.side)
end
