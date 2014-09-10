#!/bin/bash

# script used to create all the acceptable plots for a set of files
# versus the dataset size (number of agents


plot_one_column(){
COLUMN=$1
INPUT_FILE=$2

OUTPUT_FILE="pic_${COLUMN}.eps"

case $COLUMN in
	2)
		TITLE="Number of steps";;
	3)
		TITLE="Execution time (ms)";;
	4)
		TITLE="Regret cost";;
	5)
		TITLE="Egalitarian cost";;
	6)
		TITLE="Sex Equality cost";;
	7)
		TITLE="Gender Inequality cost";;
esac

gnuplot -p << EOF
set grid;

set title '$TITLE vs Dataset size'
set ylabel '$TITLE' 
set xlabel 'Dataset size'

set term postscript eps size 6.0,4.0 enhanced color font "Arial,30" linewidth 5
set output '$OUTPUT_FILE'

plot 	'$INPUT_FILE' using 1:$COLUMN with lp title 'SMA', \
	'$INPUT_FILE' using 1:$[COLUMN+6] with lp title 'Swing', \
	'$INPUT_FILE' using 1:$[COLUMN+12] with lp title 'ESMA'
EOF
epstopdf $OUTPUT_FILE
rm -f $OUTPUT_FILE

}

[ $# -lt 1 ] && echo "I need an input file as a parameter" && exit 1
INPUT_FILE=$1

for i in 2 3 4 5 6 7; do 
plot_one_column $i $1
done

TEMP=$(basename $INPUT_FILE)
OUTPUT_DIR=${TEMP%.*}
mkdir $OUTPUT_DIR
mv pic_{2,3,4,5,6,7}.pdf $OUTPUT_DIR


