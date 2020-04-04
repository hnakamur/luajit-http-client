FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:hnakamur/openresty-luajit \
 && add-apt-repository -y ppa:hnakamur/libsxg \
 && add-apt-repository -y ppa:hnakamur/nginx \
 && apt-get update \
 && apt-get install -y luajit libluajit-5.1 libluajit-5.1-common nginx \
        libxmlsec1 libxmlsec1-openssl libcurl4 lua-cjson \
 && ln -s $(readlink /lib/x86_64-linux-gnu/libz.so.1) /lib/x86_64-linux-gnu/libz.so \
 && ln -s $(readlink /usr/lib/x86_64-linux-gnu/libxml2.so.2) /usr/lib/x86_64-linux-gnu/libxml2.so \
 && ln -s $(readlink /usr/lib/x86_64-linux-gnu/libxmlsec1.so.1) /usr/lib/x86_64-linux-gnu/libxmlsec1.so \
 && ln -s $(readlink /usr/lib/x86_64-linux-gnu/libxmlsec1-openssl.so.1) /usr/lib/x86_64-linux-gnu/libxmlsec1-openssl.so \
 && ln -s libssl.so.1.1 /usr/lib/x86_64-linux-gnu/libssl.so \
 && ln -s $(readlink /usr/lib/x86_64-linux-gnu/libcurl.so.4) /usr/lib/x86_64-linux-gnu/libcurl.so

COPY tests/etc/nginx/ /etc/nginx/
COPY lib/ vendor/ /usr/local/luajit-http-client/
COPY example.lua /usr/local/work/
COPY tests/docker-entry.sh /usr/local/work/

CMD ["/usr/local/work/docker-entry.sh"]
