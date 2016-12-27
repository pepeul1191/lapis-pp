local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local inspect = require('inspect')

local function Httparty()
    local self = {}

    function self.get(url)
        local rq_resp = {}
        res, code, response_headers = http.request{url = url,method = "GET", sink = ltn12.sink.table(rq_resp)}
        return table.concat(rq_resp)
    end

    function self.post(url)
        local rq_resp = {}
        res, code, response_headers = http.request{url = url,method = "POST", sink = ltn12.sink.table(rq_resp)}
        return table.concat(rq_resp)
    end

    return self
end

return Httparty()

--http://lua-users.org/lists/lua-l/2008-07/msg00206.html
--http://marc.info/?l=lua-l&m=131947263308232
--http://w3.impa.br/~diego/software/luasocket/ltn12.html 