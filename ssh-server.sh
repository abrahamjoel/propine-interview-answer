#!/bin/bash
useradd -m test
echo $user_ssh_public_key >> /home/test/.ssh/authorized_keys
chown -R test. /home/test/.ssh
chmod 700 /home/test/.ssh/authorized_keys