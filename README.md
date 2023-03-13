# propine-interview-answer


There are multiple ways to edit a remote file. Following are the methods

1. server ssh: In this method, the developers would have access to a bunch of dev servers. Each of the users will have their own linux users which can be maintained by cloud init scripts or AD. Maintaining the users using cloud init scripts could proove to be an overhead. Adding the computer to an AD will be easier. For linux systems, this can be achieved using samba and realm (ref: https://www.redhat.com/sysadmin/linux-active-directory). Once developers gain ssh access to these servers, they can login and edit the files directly on the source. Refer ssh-client.sh and ssh-server.sh

This is a very basic approach to the problem. This could be a little tiring as the development could only continue in vim/nano moving forward. Since the SRE team is too small (poor me), this would also add unnecessary load including patching, user management. Also there would be some challenges while running the development environment since more than one user is there on a single machine, the server could get a little overloaded.

2. sshfs: This is a similar approach to the previous one where instead of the user sshing into the system, they can just mount the remote server disk like a NFS volume that works over ssh. Once the disk is mounted, you can access it like a local filesystem. This provides developers easier ways to edit the files using the editors of their choice. Most sophisticated editors also provide a way to temporarily mount the remote workspace on the local editor (eg: VScode, notepad++). Refer ssh-client.sh and 

This gives some advantages over server ssh but not by much. Though developers can be work in peace, still users have to managed, servers have to be patched and also the sshfs is also limited to the quality of network connection. 

The same goes to other filesystems such as s3fs, gcsfs and also transfer protocols such as ftp, sftp

3. git pull: In this method, the git repo is cloned in each user workspace (local client and  remote server). Changes are made on the local editor, then pushed to remote git server (eg: github, gitlab, bitbucket, gerrit). These changes are then periodically pulled from the remote dev server. Refer git-server.sh and git client.sh

This method could help track files better. But, the shear number of commits would be too high in this method. Still the problems such as patching and user management persist.

4. coder/coder (https://github.com/coder/coder): Considering github codespaces is a managed version of coder, it would make sense for us to move to the hosted version of the same solution. This would make the developers feel comfortable because they have prior experience developing with this setup. Adding users to coder is very simple and can be done from the UI. We need not run multiple development servers all the time, they could be provisioned on-demand. No client end config is required. The editor is simple and can also be connected to the desktop version of the app. Depending on the cost and other aspects, we can run the dev workload in any cloud environment without making it any different to the developers. Editing remote files could not get easier than this. Refer coder-server.sh

Coder server could be a single point of failure. Hence we can run coder in HA mode (https://coder.com/docs/v2/latest/admin/high-availability) with servers in different AZs. Taking frequent backups of the psql db could also help us. Each user workspace is private. This could help the developers work independently without any distraction. Also this has seemless integration with github where the repos are initially hosted. Though coder is an effecient solution, not being able to use spot instances with it is a challenging aspect due to cost savings. The feature of shutting down the dev environment if not used is a welcome addition.

Hence for Megacorp dealing with all their 100 microservices (and the radiation) using coder would be more benefitial than other legacy methods. If they are not as stingy, they might even afford enterprise edition someday :p