#!/bin/bash

# script used to execute experiments on the created data

[ -z "$DATA_DIR" ] && echo -ne "Please provide data directory:\t" && read DATA_DIR
OUTPUT_DIR="results"
[ -z "$JAR_PATH" ] && echo -ne "Please provide jar location:\t" && read JAR_PATH


DATA_TYPE=$(basename $DATA_DIR | tr '_' '\t' | awk '{print $2}')
DATA_SIZE=$(basename $DATA_DIR | tr '_' '\t' | awk '{print $3}')

mkdir -p ${OUTPUT_DIR}
RESULTS="$OUTPUT_DIR/results_${DATA_TYPE}_${DATA_SIZE}.csv"
touch ${RESULTS}

for i in $(seq 1 5); do 
echo -ne "$i\t" >>${RESULTS}
for ALGO in SMA Swing ESMA; do
    java -cp ${JAR_PATH} gr.ntua.cslab.algorithms.${ALGO} $DATA_DIR/men${i}.txt $DATA_DIR/women${i}.txt 0 >>${RESULTS}
    echo -ne "\t" >>${RESULTS}
done
echo >>${RESULTS}
echo "Iteration $i finished"
done