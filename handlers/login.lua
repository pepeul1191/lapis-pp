local M = {}
local config = require("lapis.config")
local inspect = require('inspect')

local function Index(self, config, helper)
    return {
    	before = function(self)
		    if self.session.estado == "activo" then
		    	self:write({redirect_to = self:url_for("homeIndex")})
		    end
		end,
		GET = function(self)
			self.config = config
			self.helper = helper
			self.helper.set("csss", {"assets/login/css/index"}) 
			return { render = "login.index", layout = "layouts.blank"}
		end
	}
end

local function Ver(self)
    return {
		GET = function(self)
			return { json = { usuario = self.session.usuario, tiempo = self.session.tiempo, estado = self.session.estado } }
		end
	}
end

local function Salir(self)
    return {
		GET = function(self)
			self.session.estado = nil
			self.session.tiempo = nil
			self.session.usuario = nil
			self:write({redirect_to = self:url_for("loginIndex")})
		end
	}
end

local function Acceder(self, config, helper, httparty)
    return {
		POST = function(self)
			contrasenia = httparty.post(helper.get("cipher") .. "encode?key=" .. helper.get("key") .. "&texto=" .. self.params["contrasenia"])
			rpta = httparty.post(helper.get("accesos") .. "usuario/validar?usuario=" .. self.params["usuario"] .. "&contrasenia=" .. contrasenia)
	        if rpta == "1" then
				self.config = config
				self.helper = helper 
				self.session.estado = "activo"
				self.session.tiempo = os.date("*t")
				self.session.usuario = self.params["usuario"]
				self:write({redirect_to = self:url_for("homeIndex")})
			else
				self.config = config
				self.helper = helper
				self.helper.set("csss", {"assets/login/css/index"})
				self.helper.set("mensaje", true) 
				return { render = "login.index", layout = "layouts.blank"}
			end
		end
	}
end

M.Index = Index
M.Acceder = Acceder
M.Ver = Ver
M.Salir = Salir

return M