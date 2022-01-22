local SPONGE_COLOR = {
	red		= 252/255,
	green = 243/255,
	blue	= 0/255
}

local SPONGE_SIDE = 30
local SPONGE_SPEED = 150
local SPONGE_JUMP_SPEED = 450
local SPONGE_ACCELERATION = 10

Sponge = GameObj:extend()

function Sponge:new()
	Sponge.super.new(self, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, SPONGE_SIDE, SPONGE_COLOR)

	self.speed_x = 0
	self.speed_y = 0
	
	self.counter = 0
	self.isInAir = false
	self.isInWater = false
end

function Sponge:update(dt)
	self.x = self.x + self.speed_x * dt
	self.y = self.y + self.speed_y * dt

	self.speed_y = self.speed_y + SPONGE_ACCELERATION

	if love.keyboard.isDown("a") then
		self.speed_x = -SPONGE_SPEED
	elseif love.keyboard.isDown("d") then
		self.speed_x = SPONGE_SPEED
	else
		self.speed_x = 0
	end

	if love.keyboard.isDown("w") and not self.isInAir then
		self.speed_y = -SPONGE_JUMP_SPEED
		self.isInAir = true
	end
end

function Sponge:isCollidingPlatform(platform)
	if self.x < platform.x
		and math.abs(self.y - platform.y) < self.side
		and platform.x - self.x <= self.side
		and self.speed_x > 0 then
		self.speed_x = 0
		self.x = platform.x - self.side
	elseif self.x > platform.x
		and math.abs(self.y - platform.y) < self.side
		and self.x - platform.x <= self.side
		and self.speed_x < 0 then
		self.speed_x = 0
		self.x = platform.x + self.side
	elseif self.y < platform.y
		and math.abs(self.x - platform.x) < self.side
		and platform.y - self.y <= self.side
		and self.speed_y > 0 then
		self.speed_y = 0
		self.y = platform.y - self.side
		self.isInAir = false
	elseif self.y > platform.y
		and math.abs(self.x - platform.x) < self.side
		and self.y - platform.y <= self.side
		and self.speed_y < 0 then
		self.speed_y = 0
		self.y = platform.y + self.side
	end
end
