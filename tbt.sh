#!/bin/bash

NC='\033[0m'        
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'

progress() {
    local val=$1
    local max=$2
    local name=$3
    local width=50
    local percent=$((val * 100 / max))
    local filled=$((width * percent / 100))
    local empty=$((width - filled))

    # Выбор цвета
    local color="$BLUE"
    if [ $percent -ge 75 ]; then
        color="$RED"
    elif [ $percent -ge 50 ]; then
        color="$YELLOW"
    elif [ $percent -ge 25 ]; then
        color="$GREEN"
    fi

    printf "%-7s : " "$name"
    printf "[${color}"
    for ((i = 0; i < filled; i++)); do printf "#"; done
    printf "${NC}"
    for ((i = 0; i < empty; i++)); do printf "."; done
    printf "] %3d%%\n" "$percent"
}

dp() {
    local hour=$(date +%-H)
    local min=$(date +%-M)
    local sec=$(date +%-S)
    local curr=$((hour * 3600 + min * 60 + sec))
    progress "$curr" 86400 " Day   "  # 86400 секунд в дне
}

wp() {
    local dow=$(date +%-u)  # 1-7 (понедельник - воскресенье)
    local hour=$(date +%-H)
    local min=$(date +%-M)
    local sec=$(date +%-S)
    local curr=$(((dow - 1) * 86400 + hour * 3600 + min * 60 + sec))
    progress "$curr" 604800 " Week  "  # 604800 секунд в неделе
}

mp() {
    local day=$(date +%-d)
    local hour=$(date +%-H)
    local min=$(date +%-M)
    local sec=$(date +%-S)
    local days_in_month=$(date -d "$(date +%Y-%m-01) +1 month -1 day" +%-d)
    local curr=$(((day - 1) * 86400 + hour * 3600 + min * 60 + sec))
    local max=$((days_in_month * 86400))
    progress "$curr" "$max" " Month "
}

yp() {
    local doy=$(date +%-j)
    local hour=$(date +%-H)
    local min=$(date +%-M)
    local sec=$(date +%-S)
    local days_in_year=365
    [ "$(date +%L)" = "1" ] && days_in_year=366
    local curr=$(((doy - 1) * 86400 + hour * 3600 + min * 60 + sec))
    local max=$((days_in_year * 86400))
    progress "$curr" "$max" " Year  "
}

case "$1" in
    -d) dp ;;
    -w) wp ;;
    -m) mp ;;
    -y) yp ;;
    *)
        dp
        wp
        mp
        yp
        ;;
esac
