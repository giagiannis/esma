#!/bin/bash

# script used to execute experiments on the created data


[ -z "$DATA_DIR" ] && echo -ne "Please provide data directory:\t" && read DATA_DIR
OUTPUT_DIR="results"
[ -z "$JAR_PATH" ] && echo -ne "Please provide jar location:\t" && read JAR_PATH


DATA_TYPE=$(basename $DATA_DIR | tr '_' '\t' | awk '{print $2}')
DATA_SIZE=$(basename $DATA_DIR | tr '_' '\t' | awk '{print $3}')
ESMA_LOOPS=5


function aggregate(){
INPUT=$1
FIELDS=$(awk 'END{print NF}' ${INPUT})
for F in $(seq 1 ${FIELDS}); do
BIN="function abs(x){return (x<0.0? -x : x)}{total += abs(\$$F); count += 1} END {printf \"%5.2f\t\",total/count}";
#echo ${BIN}
awk "${BIN}" ${INPUT}
done

}




mkdir -p ${OUTPUT_DIR}
RESULTS="$OUTPUT_DIR/results_${DATA_TYPE}_${DATA_SIZE}.csv"
touch ${RESULTS}

for i in $(seq 1 5); do 
echo "Iteration $i started"
echo -ne "$i\t" >>${RESULTS}

echo -ne "SMA:\t\t"
java -cp ${JAR_PATH} gr.ntua.cslab.algorithms.SMA $DATA_DIR/men${i}.txt $DATA_DIR/women${i}.txt 0 >>${RESULTS}
echo -ne "\t" >>${RESULTS}

echo -ne "Swing:\t\t"
java -cp ${JAR_PATH} gr.ntua.cslab.algorithms.Swing $DATA_DIR/men${i}.txt $DATA_DIR/women${i}.txt 0 >>${RESULTS}
echo -ne "\t" >>${RESULTS}

TEMP_FILE="temp_ESMA_${DATA_TYPE}_${DATA_SIZE}_${i}.csv"
echo -n > ${TEMP_FILE}
for TURN in $(seq 1 ${ESMA_LOOPS}); do
    echo -ne "ESMA (${TURN}):\t"
    java -cp ${JAR_PATH} gr.ntua.cslab.algorithms.ESMA $DATA_DIR/men${i}.txt $DATA_DIR/women${i}.txt 0 >>${TEMP_FILE}
    echo >>${TEMP_FILE}
done  

aggregate ${TEMP_FILE} >> ${RESULTS}
rm -f ${TEMP_FILE}
echo >>${RESULTS}
echo "Iteration $i finished"
done