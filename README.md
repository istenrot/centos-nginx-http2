# centos-nginx-http2
Scripts to build Nginx with proper HTTP/2 support for CentOS

## Description

These scripts build Nginx web server for CentOS 7 with incerased TLS performance (approximately +25% more transactions) and HTTP/2 compliance. Other public Nginx builds from EPEL or Nginx.org are linked with CentOS provided OpenSSL 1.0.1 which lacks TLS ALPN extension support. These scripts will build Nginx with statically linked OpenSSL 1.0.2 for TLS ALPN extension support. Other improvements the scripts build Nginx will provide are SSE2 opitimizations, TCP Fast Open support, PCRE JIT and libatomic_ops.

## Requirements

* Vagrant
* Ansible
* VirtualBox

## Author

Ilari Stenroth (@istenrot)

