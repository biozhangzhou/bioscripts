#!/bin/bash
#go.modeltest.sh file.fasta num_threads

java -jar /mnt/lustre/tools/jmodeltest2/dist/jModelTest.jar -d $1 -s 3 -g 4 -f -BIC -a -tr $2 -o $1.modeltest
#-s 11 -i
