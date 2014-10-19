local component = require("component")
local sides = require("sides")
local locationService = require("locationService")

robot_move = component.robot.move
robot_turn = component.robot.turn

function component.robot.move(side)
	local result = robot_move(side)
	if result then
		local currentLocation = locationService.getLocation()
		if sides.up == side then
			currentLocation.y = currentLocation.y + 1
		elseif sides.down == side then
			currentLocation.y = currentLocation.y - 1
		elseif sides.forward == side then
			currentLocation.x = currentLocation.x + currentLocation.xDir
			currentLocation.z = currentLocation.z + currentLocation.zDir
		elseif sides.back == side then
			currentLocation.x = currentLocation.x - currentLocation.xDir
			currentLocation.z = currentLocation.z - currentLocation.zDir
		end
		locationService.setLocation(currentLocation)
	end
	return result
end

function component.robot.turn(isRight)
	local result = robot_turn(isRight)
	if result then
		local currentLocation = locationService.getLocation()
		if isRight then
			currentLocation.xDir, currentLocation.zDir = -currentLocation.zDir, currentLocation.xDir
		else
			currentLocation.xDir, currentLocation.zDir = currentLocation.zDir, -currentLocation.xDir
		end
		locationService.setLocation(currentLocation)
	end
	return result
end