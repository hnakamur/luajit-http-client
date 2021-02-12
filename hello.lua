#!/usr/bin/env luajit

package.path = '?.lua;lib/?.lua;vendor/?.lua;;'

local http_client = require('http.client')

local c = http_client.new()
if c == nil then
    print('cannot create http_client')
else
    local resp, err, errcode
    resp, err, errcode = c:send_request(
        c:new_request{ url = 'http://localhost/hello/world' }
    )
    if err ~= nil then
        print('send_request err=', err, ', errcode=', errcode)
    else
        print('status=', resp.status_code)
        print('status_line=', resp.status_line)
        for _, line in ipairs(resp.header) do
            print('header=', line)
        end
        print('location=', resp.header:get('location'))
        print('request=', resp.request:string())
        print('redirect_url=', resp:redirect_url())
        print('body=', resp.body)
    end
    c:free()
end
