#!/bin/sh

echo "Generating Nginx RPM spec for RHEL/CentOS/SL 6...."

vagrant up --no-provision
SSHARGS=`vagrant ssh-config | awk 'NF && !/^Host / {print " -o "$1"="$2}'`
vagrant provision --provision-with spec
rsync -e "ssh $SSHARGS" vagrant@127.0.0.1:rpmbuild/SPECS/* specs/
vagrant destroy

