#!/bin/sh

echo "Building Nginx for RHEL/CentOS/SL 7 with Docker...."

ngx_ver=$(sed -e 's/nginx_ver: "\(.*\)-1"/\1/'  -e 'tx' -e 'd' -e ':x' variables.yml)
rpm_release=$(sed -e 's/rpm_release: "\(.*\)"/\1/'  -e 'tx' -e 'd' -e ':x' variables.yml)

docker pull centos:7
docker run --net=host --name centos7_nginx_builder -it -d centos:7 /bin/bash || docker restart centos7_nginx_builder

ansible-playbook -c docker -i centos7_nginx_builder, -u root build-nginx-openssl.yml || exit 1
docker cp centos7_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-$ngx_ver-$rpm_release.el7.exove.x86_64.rpm packages/
docker cp centos7_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-debuginfo-$ngx_ver-$rpm_release.el7.exove.x86_64.rpm packages/
docker cp centos7_nginx_builder:/root/rpmbuild/SRPMS/nginx-$ngx_ver-$rpm_release.el7.exove.src.rpm packages/

ansible-playbook -c docker -i centos7_nginx_builder, -u root build-nginx-module-geoip.yml || exit 1
docker cp centos7_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-module-geoip-$ngx_ver-$rpm_release.el7.exove.x86_64.rpm packages/
docker cp centos7_nginx_builder:/root/rpmbuild/RPMS/x86_64/nginx-module-geoip-debuginfo-$ngx_ver-$rpm_release.el7.exove.x86_64.rpm packages/
docker cp centos7_nginx_builder:/root/rpmbuild/SRPMS/nginx-module-geoip-$ngx_ver-$rpm_release.el7.exove.src.rpm packages/

docker stop centos7_nginx_builder
docker rm centos7_nginx_builder

