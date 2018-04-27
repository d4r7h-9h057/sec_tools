#!/bin/sh
# AUTOBLEACH.0.0.1
# A Bleachbit automatic cleaner. 
# I basically extracted some functions from backbox anonymous script
# 
# Author : Darth.Lab
# https://github.com/darthlab
#
################################
# http://fitnr.com/showing-a-bash-spinner.html
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
#
# List of BleachBit cleaners, separated by spaces
BLEACHBIT_CLEANERS="adobe_reader.cache adobe_reader.mru adobe_reader.tmp amsn.cache amsn.chat_logs amule.logs amule.tmp audacious.cache bash.history chromium.cache chromium.cookies chromium.current_session chromium.dom chromium.form_history chromium.history chromium.passwords chromium.search_engines chromium.vacuum d4x.history deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp easytag.history easytag.logs elinks.history emesene.cache emesene.logs epiphany.cache epiphany.cookies epiphany.passwords epiphany.places evolution.cache exaile.cache exaile.downloaded_podcasts exaile.log filezilla.mru firefox.cache firefox.cookies firefox.crash_reports firefox.dom firefox.download_history firefox.forms firefox.passwords firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum flash.cache flash.cookies gedit.recent_documents gftp.cache gftp.logs gimp.tmp gl-117.debug_logs gnome.run gnome.search_history google_chrome.cache google_chrome.cookies google_chrome.dom google_chrome.form_history google_chrome.history google_chrome.passwords google_chrome.search_engines google_chrome.session google_chrome.vacuum google_earth.temporary_files google_toolbar.search_history gpodder.cache gpodder.vacuum gwenview.recent_documents hippo_opensim_viewer.cache hippo_opensim_viewer.logs java.cache kde.cache kde.recent_documents kde.tmp konqueror.cookies konqueror.current_session konqueror.url_history libreoffice.cache libreoffice.history liferea.cache liferea.cookies liferea.vacuum links2.history midnightcommander.history miro.cache miro.logs nautilus.history nexuiz.cache octave.history openofficeorg.cache openofficeorg.recent_documents opera.cache opera.cookies opera.current_session opera.dom opera.download_history opera.search_history opera.url_history pidgin.cache pidgin.logs realplayer.cookies realplayer.history realplayer.logs recoll.index rhythmbox.cache screenlets.logs seamonkey.cache seamonkey.chat_logs seamonkey.cookies seamonkey.download_history seamonkey.history secondlife_viewer.Cache secondlife_viewer.Logs skype.chat_logs sqlite3.history system.cache system.clipboard system.desktop_entry system.memory system.recent_documents system.rotated_logs system.tmp system.trash thumbnails.cache transmission.cache vim.history vlc.mru vuze.backup_files vuze.cache vuze.logs vuze.tmp wine.tmp winetricks.temporary_files x11.debug_logs xchat.logs"

to_sleep_a_minute() {
	clear
	echo 
	echo "\n * Next bleach in 1 minute...\n"
	(sleep 60) & spinner $!
}
# Loop
run_autobleach() {
	clear
	echo -n "\n * Deleting unnecessary files... \n"
		(bleachbit -c $BLEACHBIT_CLEANERS >/dev/null) & spinner $!
	to_sleep_a_minute
	run_autobleach
}
# Make sure that only root can run this script
check_root() {
	if [ "$(id -u)" -ne 0 ]; then
		echo "\n[!] This script must run as root\n" >&2
		exit 1
	fi
}
# Init
do_start() {
#	check_root
	run_autobleach
}


do_start
