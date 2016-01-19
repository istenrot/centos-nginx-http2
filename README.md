# centos-nginx-http2
Scripts to build Nginx with proper HTTP/2 support for CentOS 6 and 7

## Description

These scripts build Nginx web server for CentOS 7 with incerased TLS performance (approximately +25% more transactions) and HTTP/2 compliance. Other public Nginx builds from EPEL or Nginx.org are linked with CentOS provided OpenSSL 1.0.1 which lacks TLS ALPN extension support. These scripts will build Nginx with statically linked OpenSSL 1.0.2 for TLS ALPN extension support. Other improvements the scripts build Nginx will provide are SSE2 opitimizations, CloudFlare's CHACHA20-POLY1305 OpenSSL patch, TCP Fast Open support, PCRE JIT and libatomic_ops.

See branch el6 for the CentOS 6 derivate.

Read more about Nginx:
http://nginx.org/

## Prebuild Binaries
See [the releases](https://github.com/istenrot/centos-nginx-http2/releases) page for prebuild binary packages.

## Build Requirements

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

## Suggested cipher suites

### For ECDSA keys

```
    ssl_ecdh_curve      secp384r1;
    ssl_prefer_server_ciphers on;
    ssl_ciphers         "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA";
```

### For RSA keys

```
        ssl_ecdh_curve      secp384r1;
        ssl_prefer_server_ciphers on;
        ssl_ciphers         "ECDHE-RSA-CHACHA20-POLY1305:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:DHE-RSA-AES128-SHA";
```

You'll also need to define OpenSSL dhaprams file for DHE key exchange suites.

```
        ssl_dhparam         /etc/pki/tls/misc/dhparam.pem;
```

I strongly recommend using primes defined in [RFC 3526](http://tools.ietf.org/html/rfc3526). Here's 2048-bit MODP Group:

```
-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEA///////////JD9qiIWjCNMTGYouA3BzRKQJOCIpnzHQCC76mOxOb
IlFKCHmONATd75UZs806QxswKwpt8l8UN0/hNW1tUcJF5IW1dmJefsb0TELppjft
awv/XLb0Brft7jhr+1qJn6WunyQRfEsf5kkoZlHs5Fs9wgB8uKFjvwWY2kg2HFXT
mmkWP6j9JM9fg2VdI9yjrZYcYvNWIIVSu57VKQdwlpZtZww1Tkq8mATxdGwIyhgh
fDKQXkYuNs474553LBgOhgObJ4Oi7Aeij7XFXfBvTFLJ3ivL9pVYFxg5lUl86pVq
5RXSJhiY+gUQFXKOWoqsqmj//////////wIBAg==
-----END DH PARAMETERS-----
```


## Author

Ilari Stenroth (@istenrot)

