GameObj = Object:extend()

function GameObj:new(x, y, side, color)
	self.x = x
	self.y = y
	self.side = side
	self.color = color
end

function GameObj:draw()
	love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
	love.graphics.rectangle("fill", self.x, self.y, self.side, self.side)
end
