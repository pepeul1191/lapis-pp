local lapis = require("lapis")
local app = lapis.Application()
local config = require("lapis.config").get()
local respond_to = require("lapis.application").respond_to
local helper = require("libs.helper")
local httparty = require("libs.httparty")

local login = require("handlers.login")
local home = require("handlers.home")
local error = require("handlers.error")

local test = require("handlers.test")
local demo = require("handlers.demo")

app:enable("etlua")

app:match("homeIndex", "/", respond_to(home.Index(self, config, helper)))
app:match("loginIndex", "/login", respond_to(login.Index(self, config, helper)))
app:match("loginAcceder", "/login/acceder", respond_to(login.Acceder(self, config, helper, httparty)))
app:match("loginSalir", "/salir", respond_to(login.Salir(self)))
app:match("loginVer", "/ver", respond_to(login.Ver(self)))
app:match("error404", "/error/access/404", respond_to(error.NoEncontrado(self, config, helper)))
app:match("error5050", "/error/access/5050", respond_to(error.NoLogueado(self, config, helper)))

app:match("/test/:edad", respond_to(test))
app:match("/demo/:edad", respond_to(demo.ListarTodosHandler(self)))
app:match("/demo", respond_to(demo.Renderizado(self, config, helper)))

app.handle_404 = function(self)
  	return {redirect_to = self:url_for("error404")}
end

app:match("/edad/:edad", respond_to(test))

return app