local cfgparse = require('configparse')
local file = io.open("/etc/application.conf")
local applicationconf = cfgparse.parse(file:read('*a'))
file:close()
return applicationconf