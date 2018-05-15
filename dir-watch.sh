#!/usr/bin/env bash

# username=$(whoami)
# src="/home/{$username}/Test/"
# dest="/media/storage1/Test/"
src="$1"
dest="$2"

while true; do
        # watch for new files. will return true if a file has
        # been created, modified, deleted, moved, close_written.
        inotifywatch -e create,modify,delete,move,close_write -t 1 "$src" 2>/dev/null

        # rsync files from src to dest
        # -u updates-only
        # -a Archive mode equals -rlptgoD (no -H,-A,-X)
        # --delete-excluded deletes file not present in dst and also deletes files deliberately excluded at src
        rsync -au ${src} ${dest} --delete-excluded
done
