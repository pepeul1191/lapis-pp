local http = require "socket.http"
local json = require("json")
local inspect = require('inspect')

local function Httparty()
    local self = {}

    function self.get(url)
        local rpta = http.request(url) 
        return json.decode(rpta)
    end

    function self.post(url)
        local rpta = http.request(url) 
        return json.decode(rpta)
    end

    return self
end

return Httparty()