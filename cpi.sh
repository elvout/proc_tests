#! /usr/bin/env bash

printf "%-20s%-10s%-10s\n" "test" "cycles" "CPI"

for i in {01..35}; do printf "-"; done
printf "\n"

for f in *.cycles; do
	if [[ -e "$f" ]]; then
		basename=${f%%.cycles}

		printf "%-20s" "${basename:0:16}"
		printf "%-10d" "$(cat $f)"

		cpi=$(printf "scale=2; %d/(%d-1)\n" "`cat $f`" "`wc -l < ${basename}.hex`" | bc)

		printf "%-10s" "$cpi"

		printf "\n"
	fi
done
