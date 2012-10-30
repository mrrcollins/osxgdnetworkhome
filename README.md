Google Drive under OS X with Network Home Directories
=====================================================

To use Google Drive with Network Home Directories and not require administrative access, you need to have the following:
* The Google Drive Icon Helper in the folder /Library/PrivilegedHelperTools with the privileges of 6755, owned by root, group of procmd
* Place the Google Drive preferences folder on the local hard drive, and set up an alias to it from ~/Library/Application Support/Google/Drive
* Create an initial sync_config.db folder with the location of the user's Google Drive folder on the local hard drive
* The Google Drive app in Applications

To deploy Google Drive you will need to push out the Google Drive application to your machines and use the LISetupDrive.sh script as a login in hook.

One caveat, I brute force the creation of the sync_config.db file which holds the location to create the Google Drive folder. There is an entry for the version, which I don't know will work as Google releases new versions of the Google Drive app. This does work with the version 1.5.3449.3345.
