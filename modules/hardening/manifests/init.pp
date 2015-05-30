#ubuntu hardeding

class hardening {
	#enable network h.
	include hardening::sysctl

	#issue,motd
	include hardening::issue

	#remove packages(disabled due vagrant)
	#include hardening::removepackages 

	#sar enable
	include hardening::sar



	#disable irqbalance for better perfomance in multicore app.
	file {'/etc/default/irqbalance': 
        ensure => file,
		content => 'ENABLED=0',
    }

    #secure shared memory
    file_line {'fstab_secure_shm':
    	path => '/etc/fstab',
    	match => 'tmpfs\s*/run/shm\s*tmpfs\s*defaults,noexec,nosuid\s*0\s*0',
    	line => "tmpfs     /run/shm    tmpfs	defaults,noexec,nosuid	0	0",
    	ensure => present,
    	notify => Exec['remount']
    }


    exec{'remount':
    	refreshonly => true,
    	command => 'mount -a'
    }


    #disable anacron , we expect server is running for 24/7
    ##Define a function for comment line in file
	define augeasnew ($file,$line){
		$exp=regsubst($line[0], '^(un)?comment *(.*)' , '\2')
			case $line[0] {
				/^uncomment/: {
					exec {"/bin/sed -i -e '/${exp}/s/#//g' $file":
					onlyif => "/bin/grep '${exp}' ${file} | /bin/grep '#' ",}
					}

				/^comment/: {
					exec {"/bin/sed -i -e '/${exp}/ s/^/#/' $file":
					onlyif => "/bin/grep '${exp}' ${file} | /bin/grep -v '#' ",}
					}
				default: {
					augeas {'augeas-chg-any':
					context => "/files/${file}",
					changes => $line, }
					}
				}
		}

	#execute the function
	augeasnew {'chg-crontab-file':
		file => '/etc/crontab',
		#Mulitple Augeas commands can be stored in an array
		#However,none-Augeas command (uncomment or comment) can only be stored in first element of an array.
		#line => ["set  1/ipaddr '10.1.1.1'" , "set 2/ipaddr '10.1.1.2'",],
		line => ["comment anacron",],
	}
 
    #secure cron files
	file { [ '/etc/crontab', '/var/spool/cron' ]:
    	owner => 'root',
    	group => 'root',
    	mode => 0500,
  	}	

	file { [ '/etc/cron.d', '/etc/cron.daily', '/etc/cron.weekly', '/etc/cron.monthly' ]:
    	owner => 'root',
    	group => 'root',
    	mode => 0500,
    	recurse => true,
  	}

  	#logging
  	file { '/var/log/btmp':
    	owner => 'root',
    	group => 'root',
    	mode => 0600,
    	ensure => present,
  	}

  	file { [ '/var/log/lastlog', '/var/log/utmp' ]:
    	owner => 'root',
    	group => 'root',
    	mode => 0600,
  	}

  	#man files
  	file { [ '/usr/share/doc', '/usr/local/share/doc', '/usr/local/share/man', '/usr/share/man' ]:
    	mode => 0755,
  	}

  	#passwd and shadow files
  	file { [ '/etc/group', '/etc/passwd' ]:
    	owner => 'root',
    	group => 'root',
    	mode => 0644,
  	}

 	file { [ '/etc/shadow', '/etc/gshadow' ]:
    	owner => 'root',
    	group => 'root',
    	mode => 0400,
 	}


}
