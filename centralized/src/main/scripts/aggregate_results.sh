#!/bin/bash

# This script is used to aggregate the experimental results
# the first line is always ignored

[ -z "$RESULTS_DIR" ] && echo -ne "RESULTS_DIR:\t" && read RESULTS_DIR

for RESULT in $RESULTS_DIR/*; do 
FIELDS=$(awk 'END{print NF}' ${RESULT})
SIZE=$(basename ${RESULT%.*} | tr '_' '\t' | awk '{printf "%d", $3}') 

echo -ne "${SIZE}\t"
for i in $(seq 2 ${FIELDS}); do
BIN="function abs(x){return (x<0.0? -x : x)}{total += abs(\$$i); count += 1} END {printf \"%5.2f\t\",total/count}";

awk "$BIN" ${RESULT}
done
echo

done