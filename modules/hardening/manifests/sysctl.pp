

class hardening::sysctl {

	#disable ipv6 

	exec{'reload_sysctl':
		refreshonly => true,
		command => 'sysctl -p'
	}

	file { '/etc/sysctl.conf': 
		 ensure => present,
	}

	#disable ipv6
	file_line {'net_ipv6_conf_all_disable_ipv6':
		path => '/etc/sysctl.conf',
		line => 'net.ipv6.conf.all.disable_ipv6 = 1',
		ensure => present,
		notify => Exec['reload_sysctl'],
	}

	

	file_line {'net_ipv6_conf_lo_disable_ipv6':
		path => '/etc/sysctl.conf',
		line => 'net.ipv6.conf.lo.disable_ipv6 = 1',
	 	ensure => present,
	 	notify => Exec['reload_sysctl'],
	}

	#lower system swappines for better perfomance

	file_line {'vm_swappiness':
		path => '/etc/sysctl.conf',
		line => 'vm.swappiness = 0',
	 	ensure => present,
	 	notify => Exec['reload_sysctl'],
	}	

	# Controls IP packet forwarding
	file_line {'net_ipv4_ip_forward':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.ip_forward',
			line => 'net.ipv4.ip_forward = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# IP Spoofing protection
	file_line {'net_ipv4_conf_all_rp_filter':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.rp_filter',
			line => 'net.ipv4.conf.all.rp_filter = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_conf_default_rp_filter':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.default.rp_filter',
			line => 'net.ipv4.conf.default.rp_filter = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Ignore ICMP broadcast requests
	file_line {'net_ipv4_icmp_echo_ignore_broadcasts':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.icmp_echo_ignore_broadcasts',
			line => 'net.ipv4.icmp_echo_ignore_broadcasts = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Disable source packet routing
	file_line {'net_ipv4_conf_all_accept_source_route':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.accept_source_route',
			line => 'net.ipv4.conf.all.accept_source_route = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv6_conf_all_accept_source_route':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.all.accept_source_route',
			line => 'net.ipv6.conf.all.accept_source_route = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_conf_default_accept_source_route':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.default.accept_source_route',
			line => 'net.ipv4.conf.default.accept_source_route = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv6_conf_default_accept_source_route':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.accept_source_route',
			line => 'net.ipv6.conf.default.accept_source_route = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Ignore send redirects
	file_line {'net_ipv4_conf_all_send_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.send_redirects',
			line => 'net.ipv4.conf.all.send_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_conf_default_send_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.default.send_redirects',
			line => 'net.ipv4.conf.default.send_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Block SYN attacks
	file_line {'net_ipv4_tcp_syncookies':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.tcp_syncookies',
			line => 'net.ipv4.tcp_syncookies = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_tcp_max_syn_backlog':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.tcp_max_syn_backlog',
			line => 'net.ipv4.tcp_max_syn_backlog = 2048',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_tcp_synack_retries':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.tcp_synack_retries',
			line => 'net.ipv4.tcp_synack_retries = 2',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_tcp_syn_retries':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.tcp_syn_retries',
			line => 'net.ipv4.tcp_syn_retries = 5',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Log Martians
	file_line {'net_ipv4_conf_all_log_martians':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.log_martians',
			line => 'net.ipv4.conf.all.log_martians = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_icmp_ignore_bogus_error_responses':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.icmp_ignore_bogus_error_responses',
			line => 'net.ipv4.icmp_ignore_bogus_error_responses = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Ignore ICMP redirects
	file_line {'net_ipv4_conf_all_accept_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.accept_redirects',
			line => 'net.ipv4.conf.all.accept_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv6_conf_all_accept_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.all.accept_redirects ',
			line => 'net.ipv6.conf.all.accept_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv4_conf_default_accept_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.default.accept_redirects',
			line => 'net.ipv4.conf.default.accept_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	file_line {'net_ipv6_conf_default_accept_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.accept_redirects',
			line => 'net.ipv6.conf.default.accept_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Ignore Directed pings
	file_line {'net_ipv4_icmp_echo_ignore_all':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.icmp_echo_ignore_all',
			line => 'net.ipv4.icmp_echo_ignore_all = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Accept Redirects? No, this is not router
	file_line {'net_ipv4_conf_all_secure_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.all.secure_redirects',
			line => 'net.ipv4.conf.all.secure_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Log packets with impossible addresses to kernel log? yes
	file_line {'net_ipv4_conf_default_secure_redirects':
			path => '/etc/sysctl.conf',
			match => '^net.ipv4.conf.default.secure_redirects',
			line => 'net.ipv4.conf.default.secure_redirects = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	#Enable ExecShield protection
	#file_line {'kernel_exec-shield':
	#		path => '/etc/sysctl.conf',
	#		match => '^kernel.exec-shield',
	#		line => 'kernel.exec-shield = 1',
	#	 	ensure => present,
	#		notify => Exec['reload_sysctl'],
	#}

	file_line {'kernel_randomize_va_space':
			path => '/etc/sysctl.conf',
			match => '^kernel.randomize_va_space',
			line => 'kernel.randomize_va_space = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Number of Router Solicitations to send until assuming no routers are present. This is host and not router
	file_line {'net_ipv6_conf_default_router_solicitations':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.router_solicitations',
			line => 'net.ipv6.conf.default.router_solicitations = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Accept Router Preference in RA?
	file_line {'net_ipv6_conf_default_accept_ra_rtr_pref':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.accept_ra_rtr_pref',
			line => 'net.ipv6.conf.default.accept_ra_rtr_pref = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Learn Prefix Information in Router Advertisement
	file_line {'net_ipv6_conf_default_accept_ra_pinfo':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.accept_ra_pinfo',
			line => 'net.ipv6.conf.default.accept_ra_pinfo = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# Setting controls whether the system will accept Hop Limit settings from a router advertisement
	file_line {'net_ipv6_conf_default_accept_ra_defrtr':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.accept_ra_defrtr',
			line => 'net.ipv6.conf.default.accept_ra_defrtr = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	#router advertisements can cause the system to assign a global unicast address to an interface
	file_line {'net_ipv6_conf_default_autoconf':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.autoconf',
			line => 'net.ipv6.conf.default.autoconf = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	#how many neighbor solicitations to send out per address?
	file_line {'net_ipv6_conf_default_dad_transmits':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.dad_transmits',
			line => 'net.ipv6.conf.default.dad_transmits = 0',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
	}

	# How many global unicast IPv6 addresses can be assigned to each interface?
	file_line {'net_ipv6_conf_default_max_addresses':
			path => '/etc/sysctl.conf',
			match => '^net.ipv6.conf.default.max_addresses',
			line => 'net.ipv6.conf.default.max_addresses = 1',
		 	ensure => present,
			notify => Exec['reload_sysctl'],
}



	}