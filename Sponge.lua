local SPONGE_COLOR = {
	red		= 252/255,
	green = 243/255,
	blue	= 0/255
}

local SPONGE_SIDE = 30
local SPONGE_SPEED = 150

Sponge = GameObj:extend()

function Sponge:new()
	Sponge.super.new(self, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, SPONGE_SIDE, SPONGE_COLOR)

	self.speed_x = 0
	self.speed_y = 0
end

function Sponge:update(dt)
	if love.keyboard.isDown("a") then
		self.speed_x = -SPONGE_SPEED
	elseif love.keyboard.isDown("d") then
		self.speed_x = SPONGE_SPEED
	else
		self.speed_x = 0
	end

	self.x = self.x + self.speed_x * dt
	self.y = self.y + self.speed_y * dt
end
