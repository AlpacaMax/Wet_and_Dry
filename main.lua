local BG_COLOR = {
	red		= 255/255,
	green = 203/255,
	blue	= 23/255
}

function love.load()
	Object = require "classic"
	require "GameObj"
	require "Sponge"
	require "Platform"
	require "Utils"
	require "Water"

	sponge = Sponge()
	platforms = {}
	for i=0,20 do
		platforms[i] = Platform(10 + i*30, love.graphics.getHeight() - 50)
	end
	waters = {}
	for i=0,10 do
		for j=0,10 do
			waters[i*10+j] = Water(10 + i*30, love.graphics.getHeight() - 50 - j*30)
		end
	end

	love.mouse.setVisible(false)
	love.graphics.setBackgroundColor(
		BG_COLOR.red,
		BG_COLOR.green,
		BG_COLOR.blue
	)
end

function love.update(dt)
	sponge:update(dt)

	sponge:isCollidingWaters(waters)
	
	for i,p in ipairs(platforms) do
		sponge:isCollidingPlatform(p)
	end
end

function love.draw()
	sponge:draw()
	for i,p in ipairs(platforms) do
		p:draw()
	end
	for i,w in ipairs(waters) do
		w:draw()
	end
end
