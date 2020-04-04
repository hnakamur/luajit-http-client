local url = require('http.client.url')

local _M = {}

local mt = { __index = _M }

--- Creates a http response
-- @return a http response
function _M.new(opts)
    return setmetatable(opts, mt)
end

--- Return the redirect URL if response has Location header.
-- @return the redirect URL if response has Location header or otherwise.
function _M.redirect_url(self)
    return url.redirect_url(self.request.url, self.header:get('location'))
end

return _M
