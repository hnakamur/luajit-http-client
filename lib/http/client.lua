local ffi = require('ffi')
local curl = require('libcurl')
local header = require('http.client.header')
local request = require('http.client.request')
local response = require('http.client.response')

local _M = {}

local mt = { __index = _M }

--- Creates a http client, which is a wrapper for libcurl.share.
-- @return a http client
function _M.new()
    return setmetatable({
        share = curl.share{
            share = 'cookie'
        }
    }, mt)
end

function _M.new_request(self, opts)
    return request.new(opts)
end

--- Send request synchronously.
-- @param request          request (table).
-- @return response        response (response object or nil).
-- @return err             an error message (string or nil).
-- @return errcode         an error code (number or nil).
function _M.send_request(self, request)
    local status_line
    local header = header.new()
    function headerfunction(data, size)
        local line_size = size - #'\r\n'
        if status_line == nil then
            status_line = ffi.string(data, line_size)
        elseif line_size > 0 then
            header:add_line(ffi.string(data, line_size))
        end
        return size
    end

    local body_chunks = {}
    function writefunction(data, size)
        table.insert(body_chunks, ffi.string(data, size))
        return size
    end

    local readfunction
    if type(request.body) == 'string' then
        local src = ffi.cast('const char *', request.body)
        local rest_len = #request.body
        readfunction = function(dst, size, nitem)
            local len = size * nitem
            if len > rest_len then
                len = rest_len
            end
            ffi.copy(dst, request.body, len)
            src = src + len
            rest_len = rest_len - len
            return len
        end
        request.header:add('Content-Length', #request.body)
    end

    local opts = {
        dns_use_global_cache = true,
        followlocation = false,
        headerfunction = headerfunction,
        httpheader = request.header:to_opt(),
        post = (request.method == 'POST'),
        readfunction = readfunction,
        share = self.share,
        ssl_verifypeer = request.ssl_verifypeer,
        ssl_verifyhost = request.ssl_verifyhost,
        url = request.url,
        writefunction = writefunction,
    }
    local e = curl.easy(opts)
    local _, err, errcode = e:perform()
    local resp
    if err == nil then
        resp = response.new{
            request = request,
            status_code = e:info('response_code'),
            status_line = status_line,
            header = header,
            body = table.concat(body_chunks)
        }
    end
    e:close()
    return resp, err, errcode
end

function _M.free(self)
    self.share:free()
end

return _M
