local fs = require("filesystem")

LOGFOLDER = "/var/log/"


function ensureLogFolderExists()
	if not fs.exists(LOGFOLDER) then
		fs.makeDirectory(LOGFOLDER)
	end
end

local stderr_write = io.stderr.write

function io.stderr:write(str)
  stderr_write(self,str)
  ensureLogFolderExists()
  local file = io.open(LOGFOLDER.."stderr","a")
  file:write(str)
  file:close()
  return self
end