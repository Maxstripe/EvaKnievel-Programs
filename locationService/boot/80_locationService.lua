local component = require("component")
local sides = require("sides")
local locationService = require("locationService")

robot_move = component.robot.move
robot_turn = component.robot.turn

function component.robot.move(side)
	robot_move(side)
	local currentLocation = locationService.getLocation()
	if sides.up == side then
		currentLocation.pos.y = currentLocation.pos.y + 1
	elseif sides.down == side then
		currentLocation.pos.y = currentLocation.pos.y - 1
	elseif sides.forward == side then
		currentLocation.pos.x = currentLocation.pos.x + currentLocation.xDir
		currentLocation.pos.z = currentLocation.pos.z + currentLocation.zDir
	elseif sides.back == side then
		currentLocation.pos.x = currentLocation.pos.x - currentLocation.xDir
		currentLocation.pos.z = currentLocation.pos.z - currentLocation.zDir
	end
	locationService.setLocation(currentLocation)
end

function component.robot.turn(isRight)
	robot_turn(isRight)
	local location = locationService.getLocation()
	if isRight then
		location.xDir, location.zDir = -location.zDir, location.xDir
	else
		location.xDir, location.zDir = location.zDir, -location.xDir
	end
	locationService.setLocation(currentLocation)
end