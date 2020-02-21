#! /bin/bash

set -xe

# Create CA (ozrlz.com)
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
-subj '/O=Ozrlz Inc./CN=ozrlz.com' -keyout ozrlz.com.key -out ozrlz.com.crt

# Create flask.ozrlz.com cert and key
openssl req -out flask.ozrlz.com.csr -newkey rsa:2048 -nodes -keyout flask.ozrlz.com.key \
-subj "/CN=flask.ozrlz.com/O=Flask organization"
openssl x509 -req -days 365 -CA ozrlz.com.crt -CAkey ozrlz.com.key \
-set_serial 0 -in flask.ozrlz.com.csr -out flask.ozrlz.com.crt
