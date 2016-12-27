local M = {}
local json = require("json")

local function Index(self, config, helper)
    return {
    	before = function(self)
		    if self.session.estado ~= "activo" then
		    	self:write({redirect_to = self:url_for("error5050")})
		    end
		end,
		GET = function(self)
			self.config = config
			self.helper = helper
			self.helper.set("csss", {"swp/css/mootools.grid"}) 
			self.helper.set("jss", {"swp/js/mootools.dao", "swp/js/mootools.form", "swp/js/mootools.observer", "swp/js/mootools.grid", "swp/js/mootools.chain", "assets/accesos/permisos/js/index"}) 
			return { render = "accesos.permiso.index", layout = false}
		end
	}
end

local function Listar(self, config, helper, httparty)
    return {
    	before = function(self)
		    if self.session.estado ~= "activo" then
		    	self:write({redirect_to = self:url_for("error5050")})
		    end
		end,
		GET = function(self)
			self.config = config
			self.helper = helper
			permisos = httparty.get(helper.get("accesos") .. "permiso/listar")
			--return { json = json.decode(permisos)}
			return { permisos, layout = false }
		end
	}
end

M.Index = Index
M.Listar = Listar

return M
