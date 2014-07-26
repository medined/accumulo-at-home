echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

apt-get update
apt-get upgrade -y
apt-get install -y openssh-server git-core
mkdir -p /root/.ssh
chmod 700 /root/.ssh
ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
cp -v /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
ssh-keygen -t dsa -P '' -f /root/.ssh/id_dsa
ssh-keyscan -t rsa `hostname` >> /root/.ssh/known_hosts
ssh-keyscan -t dsa `hostname` >> /root/.ssh/known_hosts

git clone https://github.com/medined/accumulo-at-home.git
chmod 744 accumulo-at-home
cd accumulo-at-home
chmod 744 1.4.*
cd 1.4.3
./driver-1.4.3.sh

