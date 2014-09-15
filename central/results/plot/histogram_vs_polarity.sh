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
		TITLE="Execution time (sec)";;
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

set ylabel '$TITLE' 
set xlabel 'Polarity'

set xtics ("80%%" 0,"60%%" 1,"40%%" 2 ,"20%%" 3)
if($COLUMN==3) set logscale y

set term postscript eps size 6.4,4.0 enhanced color font "Arial,32" linewidth 5
set pointsize 2.5;
set key right top;
set style data histogram
set style histogram cluster gap 1
set style fill solid

if($COLUMN==5) set key left top


set output '$OUTPUT_FILE'

plot 	'$INPUT_FILE' using $COLUMN title 'SMA' lc rgb '#000088' fs pattern 1, \
	'$INPUT_FILE' using $[COLUMN+6] title 'Swing' lc rgb '#008800' fs pattern 2, \
	'$INPUT_FILE' using $[COLUMN+12] title 'ESMA' lc rgb '#880000' fs pattern 3
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


