#!/bin/bash

aggregate_file(){
FILE=$1

echo $FILE

COLS=$(head -n 1 $FILE | wc -w)

cat $FILE | awk '{print $1}' | sum

}

aggregate_file ../random/*00100*
exit 0
