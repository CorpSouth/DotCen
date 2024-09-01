if [ -x "/usr/bin/fastfetch" ]; then
	fastfetch
  elif [ -x "/usr/bin/pfetch" ]; then
        PF_INFO="ascii title de editor host kernel memory os pkgs shell uptime wm palette" pfetch
  else
	uname -a
fi;
