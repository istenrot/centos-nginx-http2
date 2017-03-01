# centos-nginx-http2
Scripts to build Nginx with proper HTTP/2 support for CentOS 6

## Description

These scripts build Nginx web server for CentOS 6 with HTTP/2 compliance. Other public Nginx builds from EPEL or Nginx.org are linked with CentOS provided OpenSSL 1.0.1 which lacks TLS ALPN extension support. These scripts will build Nginx with statically linked OpenSSL 1.0.2 for TLS ALPN extension support. OpenSSL 1.1.0 also brings ChaCha20-Poly1305 cipher suite and X25519 ECDH support. Other improvements the scripts build Nginx will provide are SSE2 opitimizations, TCP Fast Open support, PCRE JIT and libatomic_ops.

See branch el7 for the CentOS 7 derivate.

Read more about Nginx:
http://nginx.org/

## Prebuild Binaries
See [Exove CentOS Yum repository](https://packages.exove.com/) for prebuild binary packages.

## Build Requirements

* Ansible 2.x
* Vagrant + VirtualBox or Docker 1.13+

## Build with Vagrant

Run `./build-with-vagrant.sh` and in the end RPM package files should be copied into *packages* directory.

## Build with Docker

Run `./build-with-docker.sh` and in the end RPM package files should be copied into *packages* directory.

## Disabled OpenSSL features

* DTLS (not needed in web servers)

## Suggested cipher suites

With HTTP/2 you need to make sure your server complies with HTTP/2 TLS cipher suite black list ([RFC 7540 Appendix A](https://tools.ietf.org/html/rfc7540)). To mitigate BEAST vulnerability in TLS you'll need to deprecate TLS 1.0 support. In consequence DHE cipher suites will be deprecated making only ECDHE cipher suites supported.

To get best possible scores on Qualys ssllabs.com server test support only 256 bit strong ciphers. Consider performance penalty and battery drain issues when you disable 128 bit strong ciphers.

```
    ssl_protocols       TLSv1.2;
    ssl_ecdh_curve      auto;
    ssl_prefer_server_ciphers off;
    ssl_ciphers         "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES256-SHA";
```



## Author

Ilari Stenroth (@istenrot)

Thanks to all GitHub project contributors and to my employer [Exove](http://www.exove.com/) for supporting this project!

