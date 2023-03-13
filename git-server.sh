#!/bin/bash
useradd -m test
echo $user_ssh_public_key >> /home/test/.ssh/authorized_keys
chown -R test. /home/test/.ssh
chmod 700 /home/test/.ssh/authorized_keys

echo $user_ssh_private_key >> /home/test/.ssh/id_rsa
chmod 400 /home/test/.ssh/id_rsa

git clone $git_repo
cd $repo_name
git checkout develop/test
git pull #repeat this every time to get the recent changes