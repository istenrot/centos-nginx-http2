#!/bin/sh

echo "Building Nginx for RHEL/CentOS/SL 6...."

vagrant up --no-provision
SSHARGS=`vagrant ssh-config | awk 'NF && !/^Host / {print " -o "$1"="$2}'`
vagrant provision --provision-with build
rsync -e "ssh $SSHARGS" vagrant@127.0.0.1:rpmbuild/RPMS/x86_64/* packages/
rsync -e "ssh $SSHARGS" vagrant@127.0.0.1:rpmbuild/SRPMS/* packages/
vagrant destroy

