local PLATFORM_COLOR = {
	red		= 1,
	green	= 1,
	blue	= 1
}

local PLATFORM_SIDE = 30

Platform = GameObj:extend()

function Platform:new(x, y)
	Platform.super.new(self, x, y, PLATFORM_SIDE, PLATFORM_COLOR)
end
