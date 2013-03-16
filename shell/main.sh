#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/etc/puppet/

GIT=/usr/bin/git
APT_GET=/usr/bin/apt-get
YUM=/usr/sbin/yum
if [ ! -x $GIT ]; then
    if [ -x $YUM ]; then
        yum -q -y makecache
        yum -q -y install git rubygems
    elif [ -x $APT_GET ]; then
        apt-get -q -y update
        apt-get -q -y install rubygems git-core
    else
        echo "No package installer available. You may need to install git manually."
    fi
fi

if [ "$(gem search -i puppet)" = "false" ]; then
  gem install puppet --no-ri --no-rdoc
fi


cp -r /tmp/puppet $PUPPET_DIR

if [ "$(gem search -i librarian-puppet)" = "false" ]; then
  gem install librarian-puppet --no-ri --no-rdoc
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi

# now run puppet
puppet apply /etc/puppet/manifests/site.pp --verbose