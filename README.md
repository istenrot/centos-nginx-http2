# centos-nginx-http2
Scripts to build Nginx with proper HTTP/2 support for CentOS

## Description

These scripts build Nginx web server for CentOS 7 with incerased TLS performance (approximately +25% more transactions) and HTTP/2 compliance. Other public Nginx builds from EPEL or Nginx.org are linked with CentOS provided OpenSSL 1.0.1 which lacks TLS ALPN extension support. These scripts will build Nginx with statically linked OpenSSL 1.0.2 for TLS ALPN extension support. Other improvements the scripts build Nginx will provide are SSE2 opitimizations, CloudFlare's CHACHA20-POLY1305 OpenSSL patch, TCP Fast Open support, PCRE JIT and libatomic_ops.

Read more about Nginx:
http://nginx.org/

## Requirements

* Vagrant
* Ansible
* VirtualBox

## Disabled OpenSSL features

* TLS compression
* SSLv2, SSLv3
* RC4 cipher
* DTLS (not needed in web servers)
* Kerberos

## CloudFlare's CHACHA20-POLY1305 OpenSSL patch

The scripts will download a patch from URL:
https://github.com/cloudflare/sslconfig/blob/master/patches/openssl__chacha20_poly1305_cf.patch

Read more about the patch from CloudFlare's blog:
https://blog.cloudflare.com/do-the-chacha-better-mobile-performance-with-cryptography/

## Author

Ilari Stenroth (@istenrot)

