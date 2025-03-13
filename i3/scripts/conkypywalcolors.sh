#!/usr/bin/env bash

dir="/usr/share/conky/pywal_conky"

killall -q conky

head -n 8 ~/.cache/wal/colors | sed 's/^#//' | awk 'BEGIN{i=1} {printf "color%d %s\n", i, $0; i++}' >$dir/latestcolors

cat $dir/latestcolors $dir/conkyseed >$dir/conkyrc &

conky -c $dir/conkyrc

echo "latest colors updated in conkyrc" &
