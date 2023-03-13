ssh-keygen

sudo apt install sshfs
sudo mkdir /mnt/test
sudo sshfs -o allow_other,default_permissions test@$dev_server_ip:~/ /mnt/test