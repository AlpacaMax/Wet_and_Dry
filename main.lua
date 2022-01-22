function love.load()
	Object = require "classic"
	require "GameObj"
	require "Sponge"

	sponge = Sponge()

	love.mouse.setVisible(false)
end

function love.update(dt)
	sponge:update(dt)
end

function love.draw()
	sponge:draw()
end
