#!/bin/bash

# this script is used to generate datasets
# the datasets are tested with Swing and they are kept if 
# they do not cause stalls to Swing.


create_dataset(){

SIZE=$1
TYPE=$2
JAR=$3


MEN_TEMP_FILE="men_${TYPE}_${SIZE}_temp.txt"
WOMEN_TEMP_FILE="women_${TYPE}_${SIZE}_temp.txt"

java -cp $JAR gr.ntua.cslab.data.gen.${TYPE}DataGenerator $SIZE > ${MEN_TEMP_FILE}
java -cp $JAR gr.ntua.cslab.data.gen.${TYPE}DataGenerator $SIZE > ${WOMEN_TEMP_FILE}

}

[ -z "$JAR_PATH" ] && echo "Please set jar location (JAR_PATH)" && exit 1
[ -z "$DATA_TYPE" ] && echo "Please set data type (DATA_TYPE) one of Discrete,Gauss,Random" && exit 1
[ -z "$DATA_SIZE" ] && echo "Please set dataset size(DATA_SIZE)" && exit 1
[ -z "$TARGET" ] && echo "Please set number of datasets to create (TARGET)" && exit 1

ACHIEVED=0
TOTAL=0
OUTPUT="data_${DATA_TYPE}_${DATA_SIZE}"
mkdir ${OUTPUT}/

while [ "$ACHIEVED" -lt "$TARGET" ]; do
create_dataset $DATA_SIZE $DATA_TYPE $JAR_PATH
LOOP=$(java -cp $JAR_PATH gr.ntua.cslab.algorithms.Swing men.txt women.txt 0 2>/dev/null| grep loop | wc -l)

MEN_TEMP_FILE="men_${DATA_TYPE}_${DATA_SIZE}_temp.txt"
WOMEN_TEMP_FILE="women_${DATA_TYPE}_${DATA_SIZE}_temp.txt"


if [ $LOOP -lt 1 ]; then
    let ACHIEVED=ACHIEVED+1
    mv ${MEN_TEMP_FILE} ${OUTPUT}/men${ACHIEVED}.txt
    mv ${WOMEN_TEMP_FILE} ${OUTPUT}/women${ACHIEVED}.txt
fi
let TOTAL=TOTAL+1
echo "$ACHIEVED good of $TOTAL tries (target is $TARGET)"
done
