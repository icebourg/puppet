This is the puppet repo I use to manage my own personal ajbourg.com server.

Maybe I will have a fleet of servers, who knows? I'll probably slowly expand this over time to Virtual Box and Vagrant VMs, but for now, this is it.

This is mostly to just try to keep up with Puppet best practices and the latest and greatest in the puppet world. I used to use puppet at work all the time, but that was over a year ago, at my new job we use Chef which I don't like nearly as much (although some of the syntax is much nicer) so trying to not get too rusty with puppet.

This repo is designed to run masterless. Overall workflow on a new machine:

Do this once:  
apt-get install rubygems  
gem install puppet librarian-puppet  
git clone git@github.com:icebourg/puppet.git /etc/puppet  

Do this anytime you want to update and apply new puppetry:  
cd /etc/puppet; git pull; librarian-puppet install; puppet apply /etc/puppet/manifests/site.pp  