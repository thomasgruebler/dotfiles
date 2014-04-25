#!/bin/bash

while [ $# -gt 0 ]; do
	#TODO: Fix pushing to multiple servers
	myhosts=("$1")
	shift
done

for host in "${myhosts[@]}"; do
	echo "Pushing to $host:"
	rsync -av --delete ~/.myconf/ $host:.myconf/
	ssh $host ".myconf/scripts/createlinks.sh"
done