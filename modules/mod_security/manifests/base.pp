class mod_security::base {

  include apache2

  package { 'libapache2-modsecurity':
    alias   => 'mod_security',
    ensure  => installed,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }


apache2::module { 'mod-security':
	ensure => present
  }

}
