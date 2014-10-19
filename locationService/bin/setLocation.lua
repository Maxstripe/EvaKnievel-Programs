local tArgs = { ... }
local locationService = require("locationService")
if #tArgs ~= 5 then
	print( "Usage: setLocation <x> <y> <z> <xDir> <zDir>" )
	return
end
locationService.setLocationFromArray(tArgs)