#!/usr/bin/python

FIELD_FOR_ID=2

import sys
import os

from sys import argv
from sys import exit

if len(argv)<2:
    print "I need a file"
    exit(1)


def handle_file(file_name):
    f = open(file_name, 'r')
    content = f.readlines()
    f.close()

    sum_array = [0]*len(content[0].split("\t"))
    
    lines = 0
    lines+=len(content)
    for line in content:
        index = 0
        for value in line.split("\t"):
            try:
                float(value.strip())
                if index>0:
                    sum_array[index] += float(value.strip())/lines
                index+=1
            except ValueError:
                pass
    return sum_array

def print_results(identifier, averages):
    sys.stdout.write("%s\t"%str(identifier))
    index=0
    for i in averages:
        if index<19 and index!=0:
            if index%6==2:
                sys.stdout.write("%.2f\t"%(i/1000.0))
            else:
                sys.stdout.write("%.2f\t"%i)

        index+=1
    sys.stdout.write("\n")


for index in range(1,len(argv)):
    filename = argv[index]
    basename = os.path.basename(filename)
    mainname = os.path.splitext(basename)[0]
    identifier = mainname.split("_")[FIELD_FOR_ID]
    averages = handle_file(filename)
    print_results(int(identifier), averages)

