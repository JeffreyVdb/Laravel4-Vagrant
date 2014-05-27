# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define :laravel4 do |lv4_config|
        lv4_config.vm.box = "precise64"
        lv4_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
        lv4_config.ssh.forward_agent = true
        
        # This will give the machine a static IP uncomment to enable
        # lv4_config.vm.network :private_network, ip: "172.16.12.100"
        lv4_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
        lv4_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
        lv4_config.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true
        lv4_config.vm.hostname = "laravel"

		    # for virtualbox synced directories
        lv4_config.vm.synced_folder "www", "/var/www", {:mount_options => ['dmode=777','fmode=777']}

		    # for nfs shared directories (better performance)
		    # lv4_config.vm.synced_folder "www", "/var/www", type: 'nfs', linux__nfs_options: ["no_root_squash,rw"]

		    # set timezone settings
        lv4_config.vm.provision :shell, :inline => "echo \"Europe/Brussels\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        # run lucid base box optimizations
        lv4_config.vm.provision :shell, :privileged => true,
          :path => "https://gist.githubusercontent.com/JeffreyVdb/3c0a6ec558e0bb921272/raw/bffb23383d4145ff9ed719622f724fbc9d0035e7/optimizations.sh"

		    # set virtual machine settings
        lv4_config.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", "2048"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
        end

        lv4_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end

        lv4_config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
    end
end
