local M = {}
local config = require("lapis.config")
local inspect = require('inspect')

local function Index(self, config, helper)
    return {
		GET = function(self)
			self.config = config
			self.helper = helper
			self.helper.set("csss", {"assets/login/css/index"}) 
			return { render = "login.index"}
		end
	}
end

local function Acceder(self, config, helper, httparty)
    return {
		POST = function(self)
			contrasenia = httparty.post(helper.get("cipher") .. "encode?key=" .. helper.get("key") .. "&texto=" .. self.params["contrasenia"])
			rpta = httparty.post(helper.get("accesos") .. "usuario/validar?usuario=" .. self.params["usuario"] .. "&contrasenia=" .. contrasenia)
			-- "usuario/validar?usuario=" + usuario + "&contrasenia=" + AesEncryptDecrypt.encryption(contrasenia))
	        if rpta == "1" then
				self.config = config
				self.helper = helper 
				return { render = "demo.index"}
			else
				self.config = config
				self.helper = helper
				self.helper.set("csss", {"assets/login/css/index"}) 

				return { render = "login.index"}
			end
		end
	}
end

M.Index = Index
M.Acceder = Acceder

return M