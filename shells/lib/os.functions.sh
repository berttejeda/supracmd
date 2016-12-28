# os

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
os.software.update(){ 
	sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update
}

os.display.screensaver(){ 
	"/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine" -background &
}

## application shortcuts
alias excel="/usr/bin/open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Excel.app/Contents/MacOS/Microsoft\ Excel"
alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app' $1"
alias powerpoint="/usr/bin/open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ PowerPoint.app/Contents/MacOS/Microsoft\ PowerPoint"
alias xmind="/usr/bin/open -a /Applications/Xmind.app/Contents/MacOS/XMind"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias byword="/usr/bin/open -a /Applications/Byword.app/Contents/MacOS/Byword $1"
alias photoshop="/usr/bin/open -a '/Applications/Adobe Photoshop CS5/Adobe Photoshop CS5.app/Contents/MacOS/Adobe Photoshop CS5' $1"
#turn screen off
alias screenoff="xset dpms force off"

## hardware
### pass options to free ## 
alias meminfo='free -m -l -t'
### get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
### get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
### process
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }
### findPid: find out the pid of a specified process
findPid () { lsof -t -c "$@" ; }
### memHogsTop, memHogsPs:  Find memory hogs
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
### cpuHogs:  Find CPU hogs
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias ttop="top -R -F -s 10 -o rsize"
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
## get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
## nfsrestart  - must be root  ##
## Memcached server status  ##
alias mcdstats='/usr/bin/memcached-tool 10.10.27.11:11211 stats'
alias mcdshow='/usr/bin/memcached-tool 10.10.27.11:11211 display'
