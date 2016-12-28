# date
alias tolocaltime='python -c "import sys;import arrow;print arrow.get('{}'.format(sys.stdin.readlines()[0]), 'YYYY-MM-DDTHH:mm:ss.SSSSSSSS').to('local')"'
