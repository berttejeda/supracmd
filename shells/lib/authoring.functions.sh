# authoring
avim(){
 local _VIM=/usr/bin/vim
 local FILE=$1
 [ -z $FILE ] && { ${_VIM} ; return; }
 local BFILE=$(basename $FILE)
 local BACKUP="$HOME/.backup/vim"
 local NOW=$(date +"d_%m_%Y_%T%P"|sed 's/:/_/g')
 local DEST=${BACKUP}/${BFILE}.${NOW}
 [ ! -d $BACKUP  ] && mkdir -p $BACKUP
 [ -f $FILE ] && /bin/cp $FILE $DEST
 [ ! -z $FILE ] && ${_VIM} ${FILE}
 [ "$AVIM_VERBOSE" != "" ] && echo "Backup file stored to $DEST."
}

screen.capture () {
  directory_name=screen.capture
  filename=shot_`date '+%Y-%m-%d_%H-%M-%S'`.png
  path=/workspace/png/$directoryname/
  binary="/usr/sbin/screencapture"
  args="-o -i $path$filename"
  [[ -d $path ]] || mkdir -p $path
  $binary $args $path$filename
  echo $path$filename | pbcopy
  # open --reveal $path$filename
}

alias vim=avim
alias vi=avim
#To open last edited file
alias lvim="vim -c \"normal '0\""