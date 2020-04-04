#!/usr/bin/env luajit

local http_client = require('http.client')

local c = http_client.new()
local resp, err, errcode
resp, err, errcode = c:send_request(
    c:new_request{ url = 'http://localhost/redirect-to-lua' }
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

    local redirect_url = resp:redirect_url()
    print('redirect_url=', redirect_url)
    if redirect_url ~= nil then
        resp, err, errcode = c:send_request(
            c:new_request{ url = redirect_url }
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
    end
end

resp, err, errcode = c:send_request(
    c:new_request{
        method = 'POST',
        url = 'http://localhost/post',
        body = [[hello
goodbye
hohohoho
yayyayyay
!!]]
    }
)
if err ~= nil then
    print('send_request err=', err, ', errcode=', errcode)
else
    print('send_request status=', resp.status_code)
    print('body=', resp.body)
end

c:free()
