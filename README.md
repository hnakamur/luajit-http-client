luajit-http-client
==================

A HTTP client using LuaJIT FFI and libcurl.

It's goal is an easy-to-use HTTP client for testing modules for OpenResty.

It is in very early stage of development and APIs will change in the future.

This library is open source, but closed development (not open to contributions).

## Setup on Ubuntu

Install `libcurl4` and make a symbolic link.

```
apt-get install -y libcurl4 \
 && ln -s libcurl.so.4 /usr/lib/x86_64-linux-gnu/libcurl.so
```

Copy lua files under `lib/` and `vendor/` to your favorite directory and
set lua `package.path` to `'/path/to/copied/?.lua;;'.

## Dependencies

Source files of dependencies are vendored in `vendor/` directory.

* [luapower/libcurl: libcurl ffi binding + binaries & build scripts](https://github.com/luapower/libcurl/tree/729f76bc40a6fe61bf3776a1282c6d031aa652cd)
* [golgote/neturl at 1058a3a23a5580c20bbab85467ab95680f6c7f17](https://github.com/golgote/neturl/tree/1058a3a23a5580c20bbab85467ab95680f6c7f17)
* [bluebird75/luaunit at LUAUNIT_V3_3](https://github.com/bluebird75/luaunit/tree/LUAUNIT_V3_3) (for tests)

Thanks for great libraries!

## Run tests on Docker

```
./tests/build_and_run.sh
```

## License
MIT
