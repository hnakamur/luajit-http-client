#!/usr/bin/env luajit

local lu = require('luaunit')

TestHttpClient = {}
function TestHttpClient:testRedirectURL()
    local http_client = require('http.client')

    local c = http_client.new()
    local resp, err, errcode

    -- Send first request and receive redirect
    resp, err, errcode = c:send_request(
        c:new_request{
            url = 'https://example.com/redirect',
            ssl_verifypeer = false,
            ssl_verifyhost = false,
        }
    )
    lu.assertEquals(nil, err, 'response#1')
    lu.assertEquals(302, resp.status_code, 'response#1 status_code')
    lu.assertEquals('HTTP/1.1 302 Moved Temporarily', resp.status_line, 'response#1 status_line')
    lu.assertEquals('a=1', resp.header:get('set-cookie'), 'response#1 set-cookie')
    -- print(resp.status_line)
    -- for _, line in ipairs(resp.header) do
    --     print('response#1 header=', line)
    -- end
    local redirect_url = resp:redirect_url()
    lu.assertEquals('https://example.com/hello', redirect_url, 'response#1 redirect_url')

    -- Follow redirect
    resp, err, errcode = c:send_request(
        c:new_request{
            url = redirect_url,
            ssl_verifypeer = false,
            ssl_verifyhost = false,
        }
    )
    lu.assertEquals(nil, err, 'response#2')
    lu.assertEquals(200, resp.status_code, 'response#2 status_code')
    lu.assertEquals('HTTP/1.1 200 OK', resp.status_line, 'response#2 status_line')
    lu.assertEquals(nil, resp:redirect_url(), redirect_url, 'response#2 redirect_url')

    local body = [[hello
goodbye
hohohoho
yayyayyay
!!]]
    resp, err, errcode = c:send_request(
        c:new_request{
            method = 'POST',
            url = 'https://example.com/post',
            body = body,
            ssl_verifypeer = false,
            ssl_verifyhost = false,
        }
    )
    lu.assertEquals(nil, err, 'response#3')
    lu.assertEquals(200, resp.status_code, 'response#3 status_code')
    local want_body = 'body data:\n' .. body
    lu.assertEquals(want_body, resp.body, 'response#3 body')
end

TestURL = {}
function TestURL:testRedirectURL()
    local url = require('http.client.url')
    local cases = {
        { url = 'https://example.com', location = nil, want = nil },
        { url = 'https://foo.example.com', location = 'https://bar.example.com',
          want = 'https://bar.example.com' },
        { url = 'https://foo.example.com', location = '/',
          want = 'https://foo.example.com/' },
        { url = 'https://foo.example.com/foo', location = '/bar',
          want = 'https://foo.example.com/bar' },
        { url = 'https://foo.example.com/foo/bar', location = '/bar',
          want = 'https://foo.example.com/bar' },
        { url = 'https://foo.example.com/foo/bar', location = 'baz',
          want = 'https://foo.example.com/foo/baz' },
        { url = 'https://foo.example.com/foo/bar', location = '/baz?a=1&b=2',
          want = 'https://foo.example.com/baz?a=1&b=2' },
    }
    for i, c in ipairs(cases) do
        local got = url.redirect_url(c.url, c.location)
        lu.assertEquals(c.want, got,
            string.format('case %d: url=%s, location=%s', i, c.url, c.location))
    end
end

os.exit(lu.LuaUnit.run())
