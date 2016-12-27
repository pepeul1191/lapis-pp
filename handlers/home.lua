local M = {}
local config = require("lapis.config")

local function Index(self, config, helper)
    return {
    	before = function(self)
		    if self.session.estado ~= "activo" then
		    	self:write({redirect_to = self:url_for("loginIndex")})
		    end
		end,
		GET = function(self)
			self.config = config
			self.helper = helper
			return { render = "home.index"}
		end
	}
end

M.Index = Index

return M
