FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:hnakamur/openresty-luajit \
 && add-apt-repository -y ppa:hnakamur/libsxg \
 && add-apt-repository -y ppa:hnakamur/nginx \
 && apt-get update \
 && apt-get install -y luajit libluajit-5.1 libluajit-5.1-common nginx

RUN apt-get install -y libcurl4 \
 && ln -s libcurl.so.4 /usr/lib/x86_64-linux-gnu/libcurl.so

COPY tests/etc/nginx/ /etc/nginx/
COPY lib/ vendor/ /usr/local/luajit-http-client/
COPY tests/test.lua /usr/local/luajit-http-client-test/
COPY tests/docker-entry.sh /usr/local/luajit-http-client-test/

WORKDIR /usr/local/luajit-http-client-test/
CMD ["./docker-entry.sh"]
