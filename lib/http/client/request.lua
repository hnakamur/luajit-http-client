local header = require('http.client.header')

local _M = {}

local mt = { __index = _M }

--- Creates a http request
-- @param opts      options (table)
-- @return a http request
function _M.new(opts)
    return setmetatable({
        method = string.upper(opts.method or 'GET'),
        url = opts.url,
        header = opts.header or header.new(),
        body = opts.body
    }, mt)
end

function _M.string(self)
    return self.method .. ' ' .. self.url
end

return _M
