#!/bin/bash

# script used to draw a plot from a single file

[ -z "$RESULTS_FILE" ] && echo -ne "RESULTS_FILE:\t" && read RESULTS_FILE
[ -z "$OFFSET" ] && OFFSET=3 && echo "Using default OFFSET 3"

gnuplot  -p << EOF
set term post eps size 16,9 enhanced color font "Courier,30" linewidth 5
set output "results_$OFFSET.eps"
OFFSET=$OFFSET
set xlabel "Number of men/women"
if (OFFSET == 2) {set title "Number of steps vs Size"; set ylabel "Steps"}
if (OFFSET == 3) {set title "Execution time vs Size"; set ylabel "Time (ms)"}
if (OFFSET == 4) {set title "Regret cost vs Size"; set ylabel "Regret cost"}
if (OFFSET == 5) {set title "Egalitarian cost vs Size"; set ylabel "Egalitarian cost"}
if (OFFSET == 6) {set title "Sex equality cost vs Size"; set ylabel "Sex equality"}
if (OFFSET == 7) {set title "Inequality cost vs Size"; set ylabel "Inequality cost"}
set grid

plot    '$RESULTS_FILE' using 1:OFFSET with lines title 'SMA',\
        '$RESULTS_FILE' using 1:OFFSET+6 with lines title 'Swing',\
        '$RESULTS_FILE' using 1:OFFSET+12 with lines title 'ESMA'

EOF