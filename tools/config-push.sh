#!/usr/bin/env bash

SETLINKS=
NOACTION=
myhosts=(
		'srv'
		)

while [ $# -gt 0 ]; do
	case "$1" in
		"-l")
			SETLINKS=1
			;;
		"-n")
			NOCACTION=1
			;;
		"-h")
			echo "$0 [-l] [host]"
			;;
		*)
			myhosts=("$1")
			;;
	esac
	shift
done

for host in "${myhosts[@]}"; do
	#TODO: Check if host is up (ping -c 1 -w 1 $host; if ($? != 0) ...)
	echo "Pushing to $host:"
	if [ !$NOACTION ]; then
		rsync -av --delete --exclude '/history/' --exclude '/tmp/.vimtmp' --exclude '/tmp/.vimbak' ~/.myconf/ $host:.myconf/
		if [ $SETLINKS ]; then
			ssh $host ".myconf/tools/config-install.sh"
		fi
	fi
	echo
done
