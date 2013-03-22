## Base Vagrantfile from puppet-playground
## Check it out at:
##  https://github.com/example42/puppet-playground

Vagrant::Config.run do |config|
  {
    :Centos6_64 => {
      :box     => 'centos6_64',
      :box_url => 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box',
    },
    :Centos63_64 => {
      :box     => 'centos-6.3-64bit',
      :box_url => 'http://packages.vstone.eu/vagrant-boxes/centos-6.3-64bit-latest.box',
    },
    :Ubuntu1304_64 => {
      :box     => 'raring64',
      :box_url => 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box',
    },
    :Ubuntu1210_64 => {
      :box     => 'quantal64',
      :box_url => 'http://cloud-images.ubuntu.com/vagrant/quantal/current/quantal-server-cloudimg-amd64-vagrant-disk1.box',
    },
    :Ubuntu1204_64 => {
      :box     => 'precise64',
      :box_url => 'http://files.vagrantup.com/precise64.box',
    },
    :Ubuntu1004_64 => {
      :box     => 'lucid64',
      :box_url => 'http://files.vagrantup.com/lucid64.box',
    },
    :Debian7_64_pre => {
      :box     => 'wheezy64_temp',
      :box_url => 'http://dl.dropbox.com/u/937870/VMs/wheezy64.box',
    },
    :Debian6_64 => {
      :box     => 'ergonlogicsqueeze64',
      :box_url => 'http://ergonlogic.com/files/boxes/debian-current.box',
    },
    :minecraft => {
      :box     => 'minimal-debian-wheezy',
      :box_url => 'http://dl.dropbox.com/u/937870/VMs/wheezy64.box',
      :ports   => {'25566' => '25566'}
    }
  }.each do |name,cfg|
    config.vm.define name do |local|
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url]
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.gsub(/_/, '-').concat("dev.ajbourg.com")
      config.vm.provision :shell, :path => "shell/main.sh"
      config.vm.share_folder "puppet", "/tmp/puppet", "./"
      cfg[:ports].each { |local_port, vm_port| config.vm.forward_port vm_port.to_i, local_port.to_i }
    end
  end
end