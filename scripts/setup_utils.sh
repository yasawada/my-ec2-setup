#!/bin/bash

# === Install utilities ===
yum install -y gcc
yum install -y git
yum install -y nmap-ncat

# === Install Python 3 Environment
yum install -y python3

# === Install AWS CLI v2 ===
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# === Install redis-cli
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make distclean  // Ubuntu systems only
make

# === Install memcached-tool
curl "https://raw.githubusercontent.com/memcached/memcached/master/scripts/memcached-tool" -o "memcached-tool"
chmod a+x memcached-tool
mv memcached-tool /usr/bin/memcached-tool

# === Install MySQL Client (mariadb)
yum install -y mysql

# === Install Monitoring Tools
yum install -y sysstat
yum install -y psmisc

# === Insert a function to .bashrc to list Instances in a region ===
# - Install jq package
yum install -y jq
# - Insert as a here-document
cat >> /home/ec2-user/.bashrc << "EOF"
# - User specific aliases and functions. You need jq package to identfy region information.
ec2-instance-list () {
  REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region`
  aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query 'Reservations[*].Instances[*].[LaunchTime,InstanceId,PrivateIpAddress,Tags[?Key==`Name`] | [0].Value]| sort_by(@, &@[0][3])' \
  --region $REGION \
  --output text
}
EOF

