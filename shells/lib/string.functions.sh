# grep # sed # awk
strings.grep(){ grep -irwe "${1}.*${2}" --include=*.${3} --include=*.${4} .; }
strings.fields.count () { 
	description="""Count the number of fields in piped input according to specified delimiter
	e.g. echo 1:2:3 | strings.fields.count :
	"""
	usage="${description}\nUsage: ${FUNCNAME[0]} <delimiter>"
	if [[ $# -lt 1 || "$*" =~ .*--help.* ]]; then echo -e "${usage}";return 1;fi  
	numfields=$(delimiter=$1;sed "s/[^$delimiter]//g" | awk '{ print length }')
	echo $((numfields +1))
}

# regex
pygrep() {
  if [ $# -lt 1 ]; then cat << EOF
usage: ${FUNCNAME[0]} <regex pattern>
EOF
return 1; fi
  process="import re;import sys;import os;
def err(message):
  return message
def mmatches(s):
  return all([hasattr(re.search('$1',s),'group'),hasattr(re.search('$2',s),'group')])
lines = map(lambda l: l.rstrip('\r\n'), sys.stdin.readlines());
# print re.search('$1',lines) or err('fail')
matched = [(re.search('$1',l).group(),re.search('$2',l).group()) if mmatches(l) else None for l in lines if re.search('$1',l)] or err(None)
result = matched[0] if matched else None
if result:
  print result[0]
#lines = filter(lambda s:'$1',lines)
# print lines
"
  python -c "$process"
  #   python -c "import re;import sys;import os;lines = map(lambda l: l.rstrip('\r\n'), sys.stdin.readlines());lines = filter(lambda s:"$1",lines);print lines"
}