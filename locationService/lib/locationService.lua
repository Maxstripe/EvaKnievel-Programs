local locationService = {}
local libvec = require("libvec")
local filesystem = require("filesystem")
local serialization = require("serialization")
local currentLocation
local LOCATIONSERVICEPROGRAMDATADIR ="/var/locationService/"
local CURRENTLOCATIONFILENAME = "currentLocation"
local DEFAULTLOCATION = {0,0,0,1,0}

function ensureProgramDataDirExists()
	if not filesystem.exists(LOCATIONSERVICEPROGRAMDATADIR) then
		filesystem.makeDirectory(LOCATIONSERVICEPROGRAMDATADIR)
	end
end

function serializeToFile(object, filename)
	ensureProgramDataDirExists()
	local handle = filesystem.open(LOCATIONSERVICEPROGRAMDATADIR .. filename,"wb")
	local objectString = serialization.serialize(object)
	handle:write(objectString)
	handle:close()
	return true
end
function readFile(file)
    local f = io.open(file, "rb")
	if not f then 
		return
	end
    local content = f:read("*all")
    f:close()
    return content
end

function deserializeFromFile(filename)
	local objectString = readFile(LOCATIONSERVICEPROGRAMDATADIR .. filename)
	if not objectString then
		return
	end
	return serialization.unserialize(objectString)
end
function locationService.getLocationFromArray(array)
	local location = { }
	location.pos = libvec.new(tonumber(array[1]),tonumber(array[2]),tonumber(array[3]))
	location.xDir = tonumber(array[4])
	location.zDir = tonumber(array[5])
	if location.pos.x and location.pos.y and location.pos.z and location.xDir and location.zDir then
		if location.xDir > 1 or location.xDir < -1 or location.zDir > 1 or location.zDir < -1 then
			error("Direction should be between 1 and -1")
			return nil
		else
			return location
		end
	else
		error("Invalid location entered")
		return nil
	end
end

function locationService.getLocation()
	if not currentLocation then
		currentLocation = deserializeFromFile(CURRENTLOCATIONFILENAME)
		if not currentLocation then
			return locationService.getLocationFromArray(DEFAULTLOCATION)
		end
	end
	return currentLocation
end
function locationService.setLocation(location)
	currentLocation = location
	return serializeToFile(location,CURRENTLOCATIONFILENAME)
end

function locationService.setLocationFromArray(array)
	local location = locationService.getLocationFromArray(array)
	if location then
		locationService.setLocation(location)
		return true
	else
		return false
	end
end


return locationService