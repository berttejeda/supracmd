# productivity
function remindme {
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} \"Submit TPS reports\" $(date +%D' '%H:%M:%S%p )" >&2 && return 1
  osascript - "$1" "$2" "$3" <<END
    on run argv
      set stringedAll to date (item 2 of argv & " " & item 3 of argv)
      tell application "Reminders"
        make new reminder with properties {name:item 1 of argv, due date:stringedAll    }
      end tell
    end run
END
}

word.define () { curl -s -A 'Mozilla/4.0' "http://wordnetweb.princeton.edu/perl/webwn?s=${1}" | html2text -ascii -nobs -style compact -width 500 | grep "*" ; } # look up a word

word.translate()
{
  if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <word> <language, e.g. es>"; return 1; fi
  process="from PyDictionary import PyDictionary;dictionary=PyDictionary();import sys;
args = sys.stdin.readlines()
word = str(args[0]).strip()
language = str(args[1]).strip() if len(args) > 1 else 'es'
print (dictionary.translate(word,language))"
  echo $1 | python -c "$process"
}

