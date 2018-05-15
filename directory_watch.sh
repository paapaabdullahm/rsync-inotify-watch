#!/usr/bin/env bash

# username=$(whoami)
# src="/home/{$username}/Test/"
# dest="/media/storage1/Test/"
src="$1"
dest="$2"

while true; do
        ## Watch for new files, the grep will return true if a file has
        ## been created, modified, deleted, moved, close_written.
        inotifywatch -e create,modify,delete,move,close_write -t 15 "$src" 2>/dev/null

        # The -u option to cp or rsync causes it to only copy files
        # that are newer in $src than in $dst. Any files
        # not present in $dst will be copied.
        # -v verbose
        # -h human-readable
        # -u updates-only
        # -r recursive
        # -a Archive mode equals -rlptgoD (no -H,-A,-X)
        # --delete-excluded deletes file not present in dst and also
        # deletes files deliberately excluded at src
        # E.g.: cp -vu "$src". "$dest"
        # E.g.: rsync -vhur "$src" "$dest" --delete-excluded 2>/dev/null &&
        rsync -ua ${src} ${dest} "$@"
done
