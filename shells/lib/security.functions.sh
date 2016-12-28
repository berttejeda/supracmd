# security
alias sudo='sudo '
symantec.stop() {
	binary=sep
	if [ which $binary || type -all $binary || [-f $binary ] >/dev/null 2>&1 ]; then 
		echo "This function requires $binary, install with sudo curl https://gist.githubusercontent.com/steve-jansen/61a189b6ab961a517f68/raw/sep -o /usr/local/bin/sep -k"
		return 1
	else
		sep stop
	fi
}

symantec.start() {
	binary=sep
	if [ which $binary || type -all $binary || [-f $binary ] >/dev/null 2>&1 ]; then 
		echo "This function requires $binary, install with sudo curl https://gist.githubusercontent.com/steve-jansen/61a189b6ab961a517f68/raw/sep -o /usr/local/bin/sep -k"
		return 1
	else
		sep start
	fi
}