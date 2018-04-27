#!/bin/sh

################################################
################################  autobleach.sh
## 
## Autobleach                  
## 
## version:0.1
## Author:Fabien Dupont
## https://github.com/fd-lab
## fabd1987@yandex.com
## 
## Creation Date:Jan 07 2018
## 
################################################
################################### description 
## #
## # AUTOBLEACH is just a light bleachbit + a sleep function
## # It cleans bash history, cache, thumbnail, and firefox, every minute.
## # 
## # Not a big thing, but very usefull sometimes when running alongside the web browser.
## # In fact, it was created for a Webapp pentest job with backbox and firefox.
## # It should be compatible with any Debian based OS
## # (Backbox, Bunsenlabs, Kali, Ubuntu, Mint, ect...)
## # 
################################################
################################### information
## #
## # You need to install bleachbit to run this script. 
## #
## # cd to autobleach.sh directory 
## # chmod +x autobleach.sh
## # ./autobleach.sh
## #
## #############################################
################################# links/sources 
## #
## # Some functions of Raffael Forte's backbox anonymous tool
## # were borrowed to create this script, 
## # 
## # Backbox Anonymous : https://github.com/raffaele-forte/backbox-anonymous
## # Bleachbit : https://www.bleachbit.org/
## # Spinner : http://fitnr.com/showing-a-bash-spinner.html
## #
################################################
## autobleach  ## https://github.com/fd-lab
################################################
##
##
spinner()
{	
	local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# List of BleachBit cleaners, separated by spaces
BLEACHBIT_CLEANERS="bash.history deepscan.ds_store deepscan.tmp deepscan.thumbs_db firefox.cache firefox.cookies firefox.dom firefox.download_history firefox.forms firefox.passwords firefox.session_restore firefox.url_history firefox.vacuum system.cache system.clipboard system.recent_documents system.tmp system.trash thumbnails.cache"

#Sleep
to_sleep_a_minute() {
	clear
	(sleep 55) & spinner $!
}

# Loop
run_autobleach() {
	clear
	echo -n "\n * Deleting files... \n"
		(bleachbit -c $BLEACHBIT_CLEANERS >/dev/null) & spinner $!   
	clear
	echo -n "\n * Done ! \n"
	echo -n "\n * Next cleaning in 1 minute...\n"
	
	sleep 5
	to_sleep_a_minute
	run_autobleach
}

# Init
do_start() {
	clear
	run_autobleach
}
do_start
