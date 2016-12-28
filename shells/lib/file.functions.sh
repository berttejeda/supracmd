# file functions
disk.unmount () { sudo diskutil unmountDisk $1 ;}
disk.list () { sudo diskutil list ;}
disk.erase () { if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <VOLName> <disk#>";else sudo diskutil eraseDisk JHFS+ $1 $2;fi ;}
dir.zip () { zip -r ./"$1".zip "$1" ; } # zip up a directory
file.chown(){ sudo -s chown $1 ; }
file.chmod(){ sudo -s chmod $1 $2 ; }
file.chgrp(){ sudo -s chgrp $1 ; }
file.reverse() { tail -r $1; }
file.show () { open --reveal $1; }
file.text.replace () { grep -l $1 $3 | while read file;do sed -i "s/$1/$2/g" $file;done; }
file.line.delete () { sed -i ${2} -e "${1}d" ; } 
find.newest () { find ./ -cmin -$1 ; }
files.organize() {
if [ -n "$1" ];then workspace_folder=$1;else workspace_folder='/workspace/';fi
if ! [ -d $workspace ]; then
echo "Could not find the workspace folder @ ${workspace}!"
return 1; fi
find ./ -type f \( ! -iname ".*" \) -d 1 | while read file;do workspace="${workspace_folder}${file##*.}";if ! [[ -d $workspace ]];then echo "${workspace} does not exist, creating ${workspace}";mkdir $workspace;fi;echo "Moving ${file} to ${workspace}";mv "${file}" $workspace;done
}

files.ren () 
{ 
    if [ $# -lt 1 ]; then
        cat  <<EOF
usage: ${FUNCNAME[0]} [-files:<'filename1|filename2'>] [-search:<'string1|string2'>] [-replace:<'string1|string2'>]
EOF
        return 1;
    fi
    process="import re;import sys;
print [item for item in re.split('\s-',''.join(sys.stdin.read()))]
sys.exit()
arguments = dict(item.strip().replace('-','',1).split(':',1) if re.search('^-',item) else item.strip().split(':',1) for item in re.split('\s-',''.join(sys.stdin.read())))
sys.exit(1)
files=arguments['files'].split(';');
search=arguments['search'].split(';');
repl=arguments['replace'].split(';');
print [file for file in files]
";
    echo $* | python -c "$process"
}

skip.last () { head -n-$1; }
skip.first () { tail -n +$1; }
# spotlight: Search for a file using MacOS Spotlight's metadata
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# Recursively find the largest file in a directory
alias find-largest="find . -type f -print0 | xargs -0 du -s | sort -n | tail -150 | cut -f2 | xargs -I{} du -sh {}"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'" # file tree
alias treesize="ncdu -x"
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)
## refresh nfs mount / cache etc for Apache ##
alias nfsrestart='sync && sleep 2 && /etc/init.d/httpd stop && umount netapp2:/exports/http && sleep 2 && mount -o rw,sync,rsize=32768,wsize=32768,intr,hard,proto=tcp,fsc natapp2:/exports /http/var/www/html &&  /etc/init.d/httpd start'
#rsync
# alias backup="/usr/local/bin/rsync -av --info=progress2 --numeric-ids -E  -axzS $1 $2"
alias sync="rsync -az -R --progress --partial ${1} ${2}"
# alias sync="rsync --Prltvcz -R --progress --partial ${1} ${2}"
alias move="/usr/local/bin/rsync -av --info=progress2 --remove-source-files --numeric-ids -E  -axzS $1 $2"
#mount with columns:
alias mnt='mount |column -t'
# list folders by size in current directory
alias usage="du -h --max-depth=1 | sort -rh"
#Grabs the disk usage in the current directory
alias usage='du -ch 2> /dev/null |tail -1'
#Gets the total disk usage on your machine
alias totalusage='df -hl --total | grep total'
#Shows the individual partition usages without the temporary memory values
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'
#Gives you what is using the most space. Both directories and files. Varies on
#current directory
alias most='du -hsx * | sort -rh | head -10'
#progress bar on file copy. Useful evenlocal.
alias cpProgress="rsync --progress -ravz"
#Show text file without comment (#) lines (Nice alias for /etc files which have tons of comments like /etc/squid.conf)
alias nocomment='grep -Ev '\''^(#|$)'\'''
alias diff='colordiff' #must first install  colordiff package :)