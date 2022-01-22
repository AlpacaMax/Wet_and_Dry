function getDistance(x1, y1, x2, y2)
	return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end

function isColliding(gameObjA, gameObjB)
	return math.abs(gameObjA.x - gameObjB.x) < gameObjA.side
				 and math.abs(gameObjB.y - gameObjB.y) < gameObjA.side
end
