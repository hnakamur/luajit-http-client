#!/bin/bash
nginx -g 'daemon off;' &
nginx_pid=$!

export LUA_PATH='/usr/local/luajit-http-client/?.lua;;'
luajit /usr/local/work/example.lua

kill $nginx_pid
