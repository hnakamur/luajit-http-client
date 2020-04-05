#!/bin/bash

echo '127.0.0.1 example.com' >> /etc/hosts

nginx -g 'daemon off;' &
nginx_pid=$!

export LUA_PATH='/usr/local/luajit-http-client/?.lua;;'
luajit test.lua

kill $nginx_pid
