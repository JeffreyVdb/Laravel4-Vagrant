include nodejs

class node_packages {
	
	class { 'nodejs':
	  version => 'stable',
	}

	package { 'bower':
	  provider => npm,
	  ensure => installed
	}

	package { 'grunt-cli':
	  provider => npm,
	  ensure => installed
	}
	
}
