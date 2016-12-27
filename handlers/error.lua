local M = {}
local config = require("lapis.config")

local function NoEncontrado(self, config, helper)
    return {
		GET = function(self)
			self.config = config
			self.helper = helper 
			return { render = "error.404"}
		end
	}
end

local function NoLogueado(self, config, helper)
    return {
		GET = function(self)
			self.config = config
			self.helper = helper 
			return { render = "error.5050"}
		end
	}
end

M.NoEncontrado = NoEncontrado
M.NoLogueado = NoLogueado

return M
