Location Service
=====

Initial location must be set using the setLocation script in the /usr/bin directory, otherwise location is assumed to be 0, 0, 0 pointing east

This overrides/wraps the methods component.robot.move and component.robot.turn meaning that you can keep track of the current location of the robot

Every time either of these functions are called the file /var/locationService/currentLocation is updated with the current location, you can get the current location from a script as follows

locationService = require("locationService")
location = locationService.getLocation()

print("The current location is:")
print ("X: " .. location.x)
print ("Y: " .. location.y)
print ("Z: " .. location.z)
if location.xDir == 1 then
	print("Direction: East")
elseif location.xDir == -1 then
	print("Direction: West")
elseif location.zDir == 1 then
	print("Direction: South")
else
	print("Direction: North")
end
