local M = {}
local config = require("lapis.config")

local function ListarTodosHandler(self)
    return {
		GET = function(self)
			if tonumber(self.params.edad) > 18 then
				return "Mayor de edad " --.. self.user.name
			else
				return "Menor de edad"
			end
		end,
		POST = function(self)
			if tonumber(self.params.edad) > 18 then
				return "MAYOR DE EDAD " --.. self.user.name
			else
				return "MENOR DE EDAD"
			end
		end
	}
end

local function Renderizado(self, config)
    return {
		GET = function(self)
			self.config = config
			return { render = "demo"}
		end
	}
end

M.ListarTodosHandler = ListarTodosHandler
M.Renderizado = Renderizado

return M

