# media
## imagemagick
image.split () {
  if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <imagefile>";return 1;fi  
  image=$1
  binary=convert
  if [ which $binary || type -all $binary || [-f $binary ] >/dev/null 2>&1 ]; then 
    echo "This function requires $binary, brew install imagemagick"
    return 1
  else
    convert "${image}" -crop 2x3@ +repage +adjoin "${image%.*}_%d.${image#*.}"
  fi  
}

## music
mp3.play () {
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} <folderofmp3s>" && return 1
  folder=$1
  ls "${folder}"/*.mp3 | while read mp3;do echo playing $mp3;afplay "$mp3";done
}

mp3.play.next () { pkill afplay ;}

youtube.getmp3() {
  if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <url>";return 1;fi
  if [ which $binary || type -all $binary || [-f $binary ] >/dev/null 2>&1 ]; then 
    echo "This function requires $binary, sudo pip install youtube-dl"
    return 1
  else
    youtube-dl --extract-audio --audio-format mp3 "${1}"
  fi
}

mov.convert()
{
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} [file]" && return 1
  media_file=${1%.*}
  ffmpeg -i $1 -vcodec h264 -acodec aac -strict -2 $media_file.mp4
}

mp4.compress()
{
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} [input_file] [output_file]" && return 1
  ffmpeg -y -i $1 -c:v libx264 -preset medium -b:v 555k -pass 1 -c:a libfdk_aac -b:a 128k -f mp4 /dev/null && \
  ffmpeg -i $1 -c:v libx264 -preset medium -b:v 555k -pass 2 -c:a libfdk_aac -b:a 128k $2
}

mp4.thumb() {
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} [input_file] [thumbnail]" && return 1  
  ffmpeg -loglevel panic -ss 00:00:01.500 -i "$1" -frames:v 1 "$2" 
}