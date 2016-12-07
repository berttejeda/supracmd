# colors
if [[ "$OSTYPE" =~ .*darwin.* ]]; then
    esc=""
    green='\033[0;32m'
    red='\033[0;31m'
    yellow='\033[0;33m'
    white='\033[0m'
    bold='\033[1;37m'
    reset="${esc}[0m"
fi