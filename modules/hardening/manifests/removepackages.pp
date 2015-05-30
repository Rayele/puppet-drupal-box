
#disabled yet for vagrant 
class hardening::removepackages {
	
	package {"gcc":
		ensure => "absent"
	}

	package {"libgcc":
		ensure => "absent"
	}  
}
