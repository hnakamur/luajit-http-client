#!/usr/bin/env luajit

local lu = require('luaunit')

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
-- end of table TestURL

os.exit(lu.LuaUnit.run())
