#ubuntu hardeding

class hardening {
	#enable network h.
	include hardening::sysctl


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
    ##Define a function 
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
 



}
