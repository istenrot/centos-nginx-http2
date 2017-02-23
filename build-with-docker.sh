#!/bin/sh

echo "Building Nginx for RHEL/CentOS/SL 6 with Docker...."

docker pull centos:6
docker run --net=host --name centos6_nginx_builder -it -d centos:6 /bin/bash || docker restart centos6_nginx_builder
ansible-playbook -c docker -i centos6_nginx_builder, -u root build-nginx-openssl.yml || exit 1
docker cp centos6_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-$(sed -e 's/nginx_ver: "\(.*\)-1"/\1/'  -e 'tx' -e 'd' -e ':x' variables.yml)-2.el6.exove.x86_64.rpm packages/
docker cp centos6_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-debuginfo-$(sed -e 's/nginx_ver: "\(.*\)-1"/\1/'  -e 'tx' -e 'd' -e ':x' variables.yml)-2.el6.exove.x86_64.rpm packages/
docker cp centos6_nginx_builder:/root/rpmbuild/SRPMS/nginx-$(sed -e 's/nginx_ver: "\(.*\)-1"/\1/'  -e 'tx' -e 'd' -e ':x' variables.yml)-2.el6.exove.src.rpm packages/
docker stop centos6_nginx_builder
docker rm centos6_nginx_builder

