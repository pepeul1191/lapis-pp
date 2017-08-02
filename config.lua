-- config.lua
local config = require("lapis.config")

config("dev1", {
  	port = tonumber(9090),
  	url_statics = "http://localhost:8001/dashboard/"
})

config("dev2", {
  	port = tonumber(9091),
  	url_statics = "http://localhost:8001/dashboard/"
})
