-- config.lua
local config = require("lapis.config")

config("development", {
  	port = 9090,
  	url_statics = "http://localhost:8001/dashboard/"
})