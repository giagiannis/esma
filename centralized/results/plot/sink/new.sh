#!/usr/bin/gnuplot

OUTPUT_EPS=convergence.eps
OUTPUT_PDF=convergence.pdf
gnuplot -p -e ' 
set term postscript eps size 6.4,4.0 enhanced color font "Arial,32" linewidth 5; set pointsize 2.5; set output "convergence.eps"; set yrange [-.02:.02] ; set grid;  set xlabel "k (x10^3)"; set ylabel "Deviation"; set nogrid; plot "dat.csv" using ($1/1000.):3 with lines notitle'
epstopdf $OUTPUT_EPS
rm $OUTPUT_EPS
sleep 1
