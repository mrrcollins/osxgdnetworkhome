#!/bin/sh

#Check for Google Icon Drive Helper
if [ ! -d "/Library/PrivilegedHelperTools" ]; then
	mkdir -p "/Library/PrivilegedHelperTools"
	chown root:wheel "/Library/PrivilegedHelperTools"
	chmod 1755 "/Library/PrivilegedHelperTools"
fi

if [ ! -e "/Library/PrivilegedHelperTools/Google Drive Icon Helper" ]; then
	if [ -d "/Applications/Google Drive.app" ]; then
		cp "Applications/Google Drive.app/Contents/Resources/Google Drive Icon Helper" "/Library/PrivilegedHelperTools/"
		chown root:procmod "/Library/PrivilegedHelperTools/Google Drive Icon Helper"
		chmod 6755 "/Library/PrivilegedHelperTools/Google Drive Icon Helper"
	else
		echo "Google Drive application not installed"
		exit 1;
	fi
fi

#Set up redirections to /Users/Shared/USERNAME
eval home_loc=~$1
eval localGDprefs="/Users/Shared/$1/Application\ Support/Google/Drive"

if [ ! -d "$localGDprefs" ]; then
	mkdir -p "$localGDprefs"
fi

rm -rf "$home_loc"/Library/Application\ Support/Google/Drive
ln -s "$localGDprefs" "$home_loc"/Library/Application\ Support/Google/Drive

if [ ! -e "$localGDprefs"/sync_config.db ]; then
	/usr/bin/sqlite3 "$localGDprefs"/sync_config.db 'CREATE TABLE data (entry_key TEXT, data_key TEXT, data_value TEXT, UNIQUE (entry_key, data_key, data_value));'
	/usr/bin/sqlite3 "$localGDprefs"/sync_config.db "INSERT OR REPLACE INTO data VALUES(\"upgrade_number\",\"value\",\"11\");"
	/usr/bin/sqlite3 "$localGDprefs"/sync_config.db "INSERT OR REPLACE INTO data VALUES(\"highest_app_version\",\"value\",\"1.5.3449.3345\");"
	/usr/bin/sqlite3 "$localGDprefs"/sync_config.db "INSERT OR REPLACE INTO data VALUES(\"cloud_docs_feed_mode\",\"value\",\"0\");"
	/usr/bin/sqlite3 "$localGDprefs"/sync_config.db "INSERT OR REPLACE INTO data VALUES(\"local_sync_root_path\",\"value\",\"/Users/Shared/${1}/Google Drive\");"
fi

chown -R $1 "/Users/Shared/$1"
chmod 700 "/Users/Shared/$1"
