local net_url = require('net.url')

local _M = {}

function _M.redirect_url(request_url, location)
    if location == nil then
        return nil
    end

    local u = net_url.parse(request_url)
    local u2 = u:resolve(location)
    return u2:build()
end

return _M
