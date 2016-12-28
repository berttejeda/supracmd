# cli
function cli.recall() { 
    if [ ! $@ ] ; then 
       echo "Usage: ${FUNCNAME[0]} <PATTERN>" 
       echo "where PATTERN is a part of previously given command" 
    else 
        history | grep $@ |more; 
    fi 
} 

cli.echo.range(){
  [ $# -lt 3 ] && echo "Usage: ranged_output <start_of_range> <end_of_range> <string_prefix> <string_suffix> <num_repetitions>" >&2 && return 1
  [[ -z "$4" ]] && 4=""
  [[ -z "$5" ]] && 5="2"
  for i in `eval echo {$1..$2}`;do echo $3$((1+i*1))$4 | python -c "import sys;line=sys.stdin.readlines()[0];print line*10,";done
}

cli.which()
{
  type -all $1
}

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
 function extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
 }

 # shell
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths