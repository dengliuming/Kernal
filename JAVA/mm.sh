#!/bin/bash

if [ $# -eq 0 ]; then
    echo "no argument"
    exit
fi
Javac_Name=$1
if [ $Javac_Name = 'clean' ]; then
   echo `rm -rf *.class`
   exit
fi
echo `javac $Javac_Name`
Name=${Javac_Name%%.*}
# Begin_Java=$Name.'class'
echo `java $Name`


