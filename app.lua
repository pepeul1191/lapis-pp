local lapis = require("lapis")
local app = lapis.Application()
local config = require("lapis.config").get()
local respond_to = require("lapis.application").respond_to

local test = require "controllers.test"

app:enable("etlua")

app:get("/", function(self)
  --return "Welcome to Lapis " .. require("lapis.version")
  self.config = config
	return { render = "index"}
end)

app:match("/test/:edad", respond_to(test))

--app:match("/edad/:edad", respond_to(test))

return app
