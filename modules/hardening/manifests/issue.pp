class hardening::issue {

$company = "ACME"

  file { [ '/etc/issue', '/etc/issue.net', '/etc/motd' ]:
    content => template('hardening/issue.erb'),
    owner => 'root',
    group => 'root',
    mode => '0644',
    ensure => present,
  }
  
  file { '/etc/update-motd.d/51-cloudguest':
  ensure  => absent,
}



file { '/etc/update-motd.d/00-header':
  ensure  => absent,
}

file { '/etc/update-motd.d/10-help-text':
  ensure  => absent,
}


file { '/etc/update-motd.d/91-release-upgrade':
 ensure  => absent,
}
 

 file { '/etc/update-motd.d/50-landscape-sysinfo':
 ensure  => absent,
}

file { '/etc/update-motd.d/90-updates-available':
 ensure  => absent,
}

file { '/etc/update-motd.d/98-fsck-at-reboot':
 ensure  => absent,
}

file { '/etc/update-motd.d/98-reboot-required':
 ensure  => absent,
}
 

}
