local M = {}
local config = require("lapis.config")

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