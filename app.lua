local lapis = require("lapis")
local app = lapis.Application()
local config = require("lapis.config").get()
local respond_to = require("lapis.application").respond_to
local helper = require("libs.helper")

local error = require "handlers.error"
local test = require "handlers.test"
local demo = require "handlers.demo"

app:enable("etlua")

app:get("/", function(self)
  --return "Welcome to Lapis " .. require("lapis.version")
  self.config = config
	return { render = "index"}
end)

app:match("error404", "/error/access/404", respond_to(error.NoEncontrado(self, config, helper)))
app:match("/test/:edad", respond_to(test))
app:match("/demo/:edad", respond_to(demo.ListarTodosHandler(self)))
app:match("/demo", respond_to(demo.Renderizado(self, config, helper)))

app.handle_404 = function(self)
  	return {redirect_to = self:url_for("error404")}
end

--app:match("/edad/:edad", respond_to(test))

return app
