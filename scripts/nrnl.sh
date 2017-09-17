#!/usr/bin/env bash
# nrnl.sh - displays sys info

# colors
f=3 b=4
for j in f b; do
	for i in {0..7}; do
		printf -v $j$i "%b" "\e[${!j}${i}m"
	done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

# detect
user=$(whoami)
host=$(hostname)
kernel=$(uname -r)
kernel=${kernel%-*}
shell=$(basename $SHELL)
os() {
	os=$(source /etc/os-release && echo $ID)
	os=${os##*/}
	os=${os%-*}
	export os
}
wm() {
	id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
	id=${id##* }
	wm=$(xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t)
	wm=${wm/*_NET_WM_NAME = }
	wm=${wm/\"}
	wm=${wm/\"*}
	wm=${wm,,}
	export wm
}
init() {
	init=$(readlink /sbin/init)
	init=${init##*/}
	init=${init%%-*}
	export init
}

# exec
os
wm
init
cat <<EOF

$user${f1}@${rst}$host

         ${f1}os${rst}:          $os
┌───┐    ${f1}kernel${rst}:      $kernel
│${f1}•˩•${rst}│    ${f1}shell${rst}:       $shell
└───┘    ${f1}init${rst}:        $init
         ${f1}wm${rst}:          $wm

EOF

# blocks
pcs() { for i in {0..7}; do echo -en "\e[${1}$((30+$i))m \u2588\u2588 \e[0m"; done; }
printf "\n%s\n%s\n\n" "$(pcs)" "$(pcs '1;')"
