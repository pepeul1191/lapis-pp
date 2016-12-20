local M = {}
local config = require("lapis.config")

local function Index(self)
    return {
		GET = function(self)
			if tonumber(self.params.edad) > 18 then
				return "Mayor de edad " --.. self.user.name
			else
				return "Menor de edad"
			end
		end
	}
end

local function Acceder(self, config)
    return {
		POST = function(self)
			self.config = config
			return { render = "demo.index"}
		end
	}
end

M.Index = Index
M.Acceder = Acceder

return M