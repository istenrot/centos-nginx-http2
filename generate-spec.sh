#!/bin/sh

echo "Generating Nginx RPM spec for RHEL/CentOS/SL 7...."

vagrant up --no-provision
vagrant provision --provision-with spec
rsync -e "ssh -p2222 -i $HOME/.vagrant.d/insecure_private_key -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" vagrant@127.0.0.1:rpmbuild/SPECS/* specs/
vagrant destroy

