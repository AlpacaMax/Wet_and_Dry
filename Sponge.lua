local SPONGE_COLOR = {
	red		= 252/255,
	green = 243/255,
	blue	= 0/255
}

local SPONGE_SIDE = 30
local SPONGE_SPEED = 150
local SPONGE_WATER_SPEED = 100
local SPONGE_JUMP_SPEED = 450

local SPONGE_WATER_DRAG = 0.02
local SPONGE_ACCELERATION = 1000
local SPONGE_FLOTATION = 1100

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

	self.speed_y = self.speed_y + SPONGE_ACCELERATION * dt

	if self.isInWater then
		print("In Water")
		vx_sq = math.pow(self.speed_x, 2)
		vy_sq = math.pow(self.speed_y, 2)

		vx_drag = SPONGE_WATER_DRAG * vx_sq * dt
		vy_drag = SPONGE_WATER_DRAG * vy_sq * dt

		self.speed_x = self.speed_x > 0
							 and self.speed_x - vx_drag
						 	  or self.speed_x + vx_drag
		self.speed_y = self.speed_y > 0
							 and self.speed_y - vy_drag
							  or self.speed_y + vy_drag

		self.speed_y = self.speed_y - SPONGE_FLOTATION * dt

		if love.keyboard.isDown("a") then
			self.speed_x = -SPONGE_WATER_SPEED
		elseif love.keyboard.isDown("d") then
			self.speed_x = SPONGE_WATER_SPEED
		end

		if love.keyboard.isDown("w") then
			self.speed_y = -SPONGE_WATER_SPEED
		elseif love.keyboard.isDown("s") then
			self.speed_y = SPONGE_WATER_SPEED
		end
	else
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

function Sponge:isCollidingWaters(waters)
	for i,w in ipairs(waters) do
		if isColliding(self, w) then
			self.isInWater = true
			return
		end
	end
	
	self.isInWater = false
end
