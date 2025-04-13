#!/bin/bash

function luksmount() {
	if [[ $# -ne 2 ]]
	then
		echo "Usage: luksmount blkdev name"
	else
		echo "mounting $1 as $2"
		sudo cryptsetup luksOpen $1 $2
		sudo mount /dev/mapper/$2 /srv/$2
	fi
}

function luksumount() {
	if [[ $# -ne 2 ]]
	then
		then echo "Usage: luksumount blkdev name"
	else
		echo "umounting $1 $2"
		sudo umount /srv/$2
		sudo cryptsetup luksClose /dev/mapper/$2
	dfi
}

function sambamount() {
	if [[ $# -ne 2 ]]
	then
		echo "$0: bad call"
	else
		echo "sambamount $1 $2"
		sudo mount.cifs  $1 $2 -o username=phwl
	fi
}

function mountall() {
	luksmount "/dev/disk/by-uuid/5b5ac122-f46a-4307-8bfd-463bc9ca818a" "wddisk"
	luksmount "/dev/disk/by-uuid/f3bacd55-843f-42c9-af34-b5cb43f73d00" "troutdisk"
}

function umountall() {
	luksumount "/dev/disk/by-uuid/5b5ac122-f46a-4307-8bfd-463bc9ca818a" "wddisk"
	luksumount "/dev/disk/by-uuid/f3bacd55-843f-42c9-af34-b5cb43f73d00" "troutdisk"
}

function mountcod() {
	# sudo mount.cifs  //cod.local/cod-share /srv/coddisk -o username=phwl
	sambamount  "//cod.local/cod-share" "/srv/coddisk"
}
