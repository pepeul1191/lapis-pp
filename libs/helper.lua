local http = require "socket.http"
local json = require("json")
local inspect = require('inspect')

local function Helper()
    local self = {
        diccionario = {
            ["key"] = "s53hHaKFQoqXTDU9",
            ["BASE_URL"] = "http://localhost:9090/",
            ["STATICS_URL"] = "http://localhost:8001/dashboard/",
            ["title"] = "Aplicacion con Pythin Pyramid",
            ["accesos"] = "http://127.0.0.1:5001/",
            ["cipher"] = "http://127.0.0.1:5000/"
        }
    }

    function self.menu_beyond()
        menu_json = http.request(self.diccionario["accesos"] .. "item/listar_todos") 
        modulo = json.decode(menu_json)
        rpta = ""

        for key,value in pairs(modulo) do 
            rpta = rpta .. "<li>"
            rpta = rpta .. '<a href="#" class="menu-dropdown"><i class="menu-icon ' .. modulo[key]["icono"] .. '"></i><span class="menu-text"> ' .. modulo[key]['modulo'] .. ' </span><i class="menu-expand"></i></a><ul class="submenu">'
            subtitulos = modulo[key]['subtitulos']
            for key, value in pairs(subtitulos) do
                rpta = rpta .. '<li><a href="#" class="menu-dropdown"><span class="menu-text">' .. subtitulos[key]['subtitulo'] .. '</span><i class="menu-expand"></i></a>'
                items = subtitulos[key]['items']
                for key, value in pairs(items) do 
                    rpta = rpta .. '<ul class="submenu">'
                    rpta = rpta .. '<li><a href="'.. self.diccionario["BASE_URL"] .. items[key]['url'] .. '" class="menu-dropdown"><span class="menu-text">' .. items[key]['nombre'] .. '</span></a></li>'
                    rpta = rpta .. '</ul>'
                end
                rpta = rpta .. "<li>"
            end
            rpta = rpta .. "</ul></li>"
        end

        return rpta
    end

    function self.get(key)
       return self.diccionario[key]
    end

    function self.set(key, value)
       self.diccionario[key] = value
    end

    function self.load_css()
        csss = self.diccionario["csss"]
        rpta = ""
        if csss ~= nil then
            for i, css in ipairs(csss) do
                rpta = rpta .. '<link rel="stylesheet" type="text/css" href="'.. self.diccionario["STATICS_URL"] .. css .. '.css" />'
            end
        end

        return rpta
    end

    function self.load_js()
        jss = self.diccionario["jss"]
        rpta = ""
        if jss ~= nil then
            for i, js in ipairs(jss) do
                rpta = rpta .. '<script src="' .. self.diccionario["STATICS_URL"] .. js .. '.js"></script>'
            end
        end

        return rpta
    end

    return self
end

return Helper()

-- http://lua-users.org/wiki/ObjectOrientationTutorial