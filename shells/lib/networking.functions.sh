## networking

ip.list () { if [[ "$OSTYPE" =~ .*darwin.* ]]; then ifconfig | grep -vw inet6 | grep -w inet | cut -d: -f2 | cut -d'\' -f1; else ip -4 -o addr | grep -vie '127\|loop';fi ;}
ip.mine () { netstat -rn | grep 'default' | grep 'en0' | /usr/bin/awk '{ print $2 }'; }

host.getip () { 
if [[ "$1" =~ http://* ]];then 
  node=${1#h*//}
  node=${node%/}
  ip=$(dig +short $node;else dig +short $1)
  [[ -z $ip ]] && echo $node | /workspace/py_/_recipes/nipap.py && echo $ip
fi 
}

host.tcp.send()
{
  if [[ -z "$1" ]]; then
    echo "Usage: send host stuff [...]"
    return
  fi
  DEST=$1
  shift
  BYTES=$(du -csb "${@}" | tail -1 | cut -f1)

  tar -cpf - "${@}" | pv -epbrs $BYTES | nc -4q 3 -T throughput $DEST 6502
}

port.scan(){ 
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} <host> <port>" && return 1  
  [ $# == 2 ]  && sudo nmap -p $2 $1
  [ $# -gt 2 ] && nmap -Pn -n -sS -p- -sV --min-hostgroup 255 --min-rtt-timeout 25ms --max-rtt-timeout 100ms --max-retries 1 --max-scan-delay 0 --min-rate 1000 -vvv --open $1
}

alias reset-networking="sudo -s -- 'killall Network\ Connect ; networksetup -setv4off Wi-Fi ; networksetup -setdhcp Wi-Fi'"
alias ports='netstat -tulanp'
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
#Control Home Router
#The curl command can be used to reboot Linksys routers.
# Reboot my home Linksys WAG160N / WAG54 / WAG320 / WAG120N Router / Gateway from *nix.
alias rebootlinksys="curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'"
# Reboot tomato based Asus NT16 wireless bridge 
alias reboottomato="ssh admin@192.168.1.1 /sbin/reboot"
#Resume wget by default
alias wget='wget -c'

## refresh nfs mount / cache etc for Apache ##
alias nfsrestart='sync && sleep 2 && /etc/init.d/httpd stop && umount netapp2:/exports/http && sleep 2 && mount -o rw,sync,rsize=32768,wsize=32768,intr,hard,proto=tcp,fsc natapp2:/exports /http/var/www/html &&  /etc/init.d/httpd start'

#Firewall (iptables)
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
alias allow-tcp=allow-tcp